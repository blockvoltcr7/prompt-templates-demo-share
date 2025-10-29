# API Implementation Example - E-commerce Order Service

## Scenario
You're working on a Jira story to implement a new REST API endpoint for processing orders in an e-commerce platform during Sprint 24.

**Jira Ticket:** SHOP-567 - Implement Order Creation API  
**Story Points:** 5  
**Sprint:** Sprint 24  
**Priority:** High

## User Story
```
As a customer
I want to place an order with multiple items
So that I can purchase products from the platform

Acceptance Criteria:
- Users can submit orders with multiple line items
- Payment method validation is performed
- Inventory is checked before order creation
- Order confirmation email is sent
- Order events are published for downstream services
```

## CREATE Framework Prompt

```yaml
prompt: |
  # SHOP-567: Order Creation API Implementation
  
  ## Character (C)
  Act as a senior backend engineer with 8+ years of experience in Node.js and 
  TypeScript development. You specialize in building scalable REST APIs, e-commerce 
  systems, and event-driven architectures. You have deep expertise in Express.js, 
  PostgreSQL, and microservices patterns. You always write clean, testable code 
  following SOLID principles and include comprehensive error handling.
  
  ## Request (R)
  Implement a robust order creation API endpoint that handles the complete order 
  placement workflow including validation, inventory checking, payment processing, 
  order persistence, event publishing, and email notifications. The implementation 
  must be production-ready with proper error handling, logging, and testing.
  
  ## Examples (E)
  Follow our existing service patterns:
  
  ```typescript
  // Standard controller pattern we use
  export class OrderController {
    constructor(
      private orderService: OrderService,
      private logger: Logger
    ) {}
    
    @ValidateRequest(CreateOrderSchema)
    @Authenticate()
    @RateLimit({ max: 10, window: '1m' })
    async createOrder(req: Request, res: Response, next: NextFunction) {
      const correlationId = req.headers['x-correlation-id'] as string;
      
      try {
        this.logger.info('Creating order', { 
          userId: req.user.id, 
          correlationId 
        });
        
        const order = await this.orderService.createOrder({
          userId: req.user.id,
          items: req.body.items,
          shippingAddress: req.body.shippingAddress,
          paymentMethodId: req.body.paymentMethodId,
          correlationId
        });
        
        return res.status(201).json({
          success: true,
          data: order,
          meta: { correlationId }
        });
      } catch (error) {
        this.logger.error('Order creation failed', { 
          error, 
          userId: req.user.id,
          correlationId 
        });
        next(error); // Global error handler
      }
    }
  }
  
  // Standard service pattern with transaction
  export class OrderService {
    constructor(
      private db: Knex,
      private inventoryService: InventoryService,
      private paymentService: PaymentService,
      private eventBus: EventBus,
      private emailService: EmailService
    ) {}
    
    async createOrder(data: CreateOrderDto): Promise<Order> {
      return await this.db.transaction(async (trx) => {
        // 1. Validate inventory
        await this.inventoryService.checkAvailability(data.items, trx);
        
        // 2. Calculate totals
        const totals = this.calculateOrderTotals(data.items);
        
        // 3. Validate payment method
        await this.paymentService.validatePaymentMethod(
          data.userId, 
          data.paymentMethodId
        );
        
        // 4. Reserve inventory
        await this.inventoryService.reserveItems(data.items, trx);
        
        // 5. Create order
        const order = await this.orderRepository.create({
          userId: data.userId,
          items: data.items,
          shippingAddress: data.shippingAddress,
          paymentMethodId: data.paymentMethodId,
          subtotal: totals.subtotal,
          tax: totals.tax,
          shipping: totals.shipping,
          total: totals.total,
          status: OrderStatus.PENDING
        }, trx);
        
        // 6. Publish events (async, non-blocking)
        await this.eventBus.publish('order.created', {
          orderId: order.id,
          userId: data.userId,
          total: order.total,
          correlationId: data.correlationId
        });
        
        // 7. Send confirmation email (async, non-blocking)
        this.emailService.sendOrderConfirmation(order).catch(err => {
          this.logger.error('Failed to send confirmation email', { 
            error: err, 
            orderId: order.id 
          });
        });
        
        return order;
      });
    }
  }
  ```
  
  Error handling pattern:
  ```typescript
  // Custom error classes we use
  export class InsufficientInventoryError extends AppError {
    constructor(productId: string, requested: number, available: number) {
      super(
        `Insufficient inventory for product ${productId}. ` +
        `Requested: ${requested}, Available: ${available}`,
        400,
        'INSUFFICIENT_INVENTORY'
      );
    }
  }
  
  export class InvalidPaymentMethodError extends AppError {
    constructor(paymentMethodId: string) {
      super(
        `Invalid or expired payment method: ${paymentMethodId}`,
        400,
        'INVALID_PAYMENT_METHOD'
      );
    }
  }
  ```
  
  ## Application (A)
  E-commerce platform serving 50K+ daily active users with 2K+ orders per day:
  
  **Tech Stack:**
  - **Runtime:** Node.js 18.x LTS
  - **Language:** TypeScript 5.0 (strict mode)
  - **Framework:** Express 4.18
  - **Database:** PostgreSQL 14 with Knex.js 2.x
  - **Caching:** Redis 7.x
  - **Message Queue:** RabbitMQ 3.x
  - **Email:** SendGrid API
  - **Logging:** Winston with JSON formatting
  - **Validation:** Joi schemas
  - **Testing:** Jest + Supertest
  - **API Docs:** OpenAPI 3.0
  
  **Architecture:**
  - Microservices architecture
  - RESTful API design
  - Event-driven communication
  - CQRS pattern for orders
  - Circuit breaker for external services
  
  **Infrastructure:**
  - AWS ECS (Docker containers)
  - AWS RDS (PostgreSQL)
  - AWS ElastiCache (Redis)
  - AWS SQS/SNS backup for events
  - CloudWatch for monitoring
  - DataDog APM
  
  **Performance Requirements:**
  - 99.9% uptime SLA
  - < 500ms P95 response time
  - Handle 100 concurrent order requests
  - Database connection pool: 20 connections
  
  ## Task (T)
  Implement the complete order creation workflow with these components:
  
  ### 1. API Endpoint
  **POST /api/v1/orders**
  
  Request body:
  ```typescript
  {
    items: [
      {
        productId: string;
        quantity: number;
        price: number; // For validation
      }
    ];
    shippingAddress: {
      street: string;
      city: string;
      state: string;
      zipCode: string;
      country: string;
    };
    paymentMethodId: string;
  }
  ```
  
  Response (201 Created):
  ```typescript
  {
    success: true;
    data: {
      id: string;
      orderNumber: string;
      userId: string;
      items: OrderItem[];
      shippingAddress: Address;
      subtotal: number;
      tax: number;
      shipping: number;
      total: number;
      status: 'pending';
      createdAt: string;
    };
    meta: {
      correlationId: string;
    }
  }
  ```
  
  ### 2. Files to Create
  ```
  src/
  ├── routes/
  │   └── order.routes.ts          # Route definitions
  ├── controllers/
  │   └── order.controller.ts       # Request handling
  ├── services/
  │   ├── order.service.ts          # Business logic
  │   └── order-calculator.service.ts # Price calculations
  ├── repositories/
  │   └── order.repository.ts       # Database access
  ├── validators/
  │   └── order.validator.ts        # Joi schemas
  ├── events/
  │   └── order.events.ts           # Event definitions
  ├── errors/
  │   └── order.errors.ts           # Custom errors
  ├── types/
  │   └── order.types.ts            # TypeScript interfaces
  └── __tests__/
      ├── unit/
      │   ├── order.service.test.ts
      │   └── order-calculator.test.ts
      └── integration/
          └── order.routes.test.ts
  ```
  
  ### 3. Database Schema
  ```sql
  -- Orders table
  CREATE TABLE orders (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    order_number VARCHAR(50) UNIQUE NOT NULL,
    user_id UUID NOT NULL REFERENCES users(id),
    shipping_address JSONB NOT NULL,
    payment_method_id VARCHAR(100) NOT NULL,
    subtotal DECIMAL(10,2) NOT NULL,
    tax DECIMAL(10,2) NOT NULL,
    shipping DECIMAL(10,2) NOT NULL,
    total DECIMAL(10,2) NOT NULL,
    status VARCHAR(20) NOT NULL DEFAULT 'pending',
    created_at TIMESTAMP DEFAULT NOW(),
    updated_at TIMESTAMP DEFAULT NOW()
  );
  
  -- Order items table
  CREATE TABLE order_items (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    order_id UUID NOT NULL REFERENCES orders(id) ON DELETE CASCADE,
    product_id UUID NOT NULL REFERENCES products(id),
    quantity INTEGER NOT NULL CHECK (quantity > 0),
    unit_price DECIMAL(10,2) NOT NULL,
    total_price DECIMAL(10,2) NOT NULL,
    created_at TIMESTAMP DEFAULT NOW()
  );
  
  -- Indexes
  CREATE INDEX idx_orders_user_id ON orders(user_id);
  CREATE INDEX idx_orders_status ON orders(status);
  CREATE INDEX idx_orders_created_at ON orders(created_at);
  CREATE INDEX idx_order_items_order_id ON order_items(order_id);
  CREATE INDEX idx_order_items_product_id ON order_items(product_id);
  ```
  
  ### 4. Business Rules
  - Minimum order value: $10
  - Maximum 20 items per order
  - Validate product prices match current prices (±$0.01 tolerance)
  - Tax calculation: 8.5% (configurable per state)
  - Shipping: Free over $50, otherwise $5.99
  - Generate unique order number: ORD-{timestamp}-{random}
  - Orders are created in PENDING status
  - Inventory must be available before order creation
  - Payment method must be valid and not expired
  
  ### 5. Error Scenarios to Handle
  - Invalid product IDs
  - Insufficient inventory
  - Invalid payment method
  - Price mismatch (tampering detection)
  - Database transaction failures
  - External service timeouts (inventory, payment)
  - Event publishing failures (should not block order)
  - Email sending failures (should not block order)
  
  ### 6. Integration Points
  - **Inventory Service:** Check availability and reserve items
  - **Payment Service:** Validate payment method
  - **Event Bus:** Publish order.created event to RabbitMQ
  - **Email Service:** Send confirmation email via SendGrid
  - **Analytics:** Log order metrics to DataDog
  
  ## Evaluation (E)
  The implementation must meet ALL of these criteria:
  
  ### Code Quality (Required)
  - ✅ TypeScript strict mode, no `any` types
  - ✅ All functions have JSDoc comments
  - ✅ Follows project structure and naming conventions
  - ✅ Proper separation of concerns (controller/service/repository)
  - ✅ ESLint and Prettier pass with zero warnings
  - ✅ No hardcoded values (use environment variables)
  - ✅ Comprehensive error handling with custom error classes
  - ✅ Structured logging with correlation IDs
  
  ### Testing (Required)
  - ✅ Unit tests for OrderService with 85%+ coverage
  - ✅ Unit tests for OrderCalculatorService with 90%+ coverage
  - ✅ Integration tests for POST /api/v1/orders endpoint
  - ✅ Test scenarios:
    - ✅ Successful order creation
    - ✅ Insufficient inventory error
    - ✅ Invalid payment method error
    - ✅ Price mismatch error
    - ✅ Minimum order value validation
    - ✅ Maximum items validation
    - ✅ Database transaction rollback
  - ✅ Mock external dependencies (inventory, payment, email)
  - ✅ All tests pass in CI/CD pipeline
  
  ### Security (Required)
  - ✅ Authentication required (JWT token)
  - ✅ Rate limiting: 10 requests per minute per user
  - ✅ Input validation using Joi schemas
  - ✅ SQL injection prevention (parameterized queries)
  - ✅ Price tampering detection
  - ✅ CORS configured properly
  - ✅ No sensitive data in logs
  - ✅ Sanitize user inputs
  
  ### Performance (Required)
  - ✅ Response time < 500ms P95 (excluding email)
  - ✅ Database queries optimized with proper indexes
  - ✅ Use database transactions for atomicity
  - ✅ Async operations for non-critical paths (email, events)
  - ✅ Connection pooling configured
  - ✅ Redis caching for product prices (5-minute TTL)
  - ✅ Circuit breaker for external services
  
  ### Documentation (Required)
  - ✅ OpenAPI 3.0 specification for the endpoint
  - ✅ README section with API usage examples
  - ✅ Inline comments for complex business logic
  - ✅ Error response documentation
  - ✅ Database migration scripts
  - ✅ Environment variable documentation
  
  ### Observability (Required)
  - ✅ Structured logging with Winston
  - ✅ Correlation ID propagation
  - ✅ Metrics: order creation rate, success rate, latency
  - ✅ DataDog custom metrics integration
  - ✅ Error tracking with stack traces
  - ✅ Alert on inventory service failures
  
  ### Jira/Git Integration
  - ✅ All commits reference: "feat(orders): <description> [SHOP-567]"
  - ✅ Branch name: feature/SHOP-567-order-creation-api
  - ✅ PR description links to Jira ticket
  - ✅ Acceptance criteria checklist in PR
  - ✅ Code reviewed by 2+ team members
  - ✅ QA sign-off before merge

context:
  jira_ticket: "SHOP-567"
  sprint: "Sprint 24"
  story_points: 5
  priority: "High"
  team: "Platform Team"
  
expected_output:
  format: "complete_production_ready_implementation"
  files: ["routes", "controllers", "services", "repositories", "validators", "tests", "migrations"]
  testing: "unit_and_integration_with_mocks"
  documentation: "inline_comments_and_openapi"
  security: "authentication_validation_rate_limiting"
  observability: "logging_metrics_tracing"
```

## Expected AI Response Structure

The AI should provide:

1. **Complete file implementations** with all required code
2. **Database migration scripts** for schema creation
3. **Unit and integration tests** with comprehensive coverage
4. **OpenAPI documentation** for the endpoint
5. **Environment variable configuration**
6. **Setup instructions** for local development
7. **Deployment considerations**

## Post-Generation Checklist

After receiving the AI-generated code:

- [ ] Review all generated files for completeness
- [ ] Run TypeScript compiler to check for errors
- [ ] Execute unit tests and verify coverage
- [ ] Execute integration tests
- [ ] Test API endpoint with Postman/Insomnia
- [ ] Review security implementation
- [ ] Check error handling scenarios
- [ ] Verify logging and metrics
- [ ] Update Jira ticket with progress
- [ ] Create PR with proper description
- [ ] Request code review from team

## Customization Tips

To adapt this example for your project:

1. **Replace tech stack** with your actual technologies
2. **Update business rules** to match your domain
3. **Modify error scenarios** based on your requirements
4. **Adjust performance targets** for your scale
5. **Include your team's** specific patterns and conventions
6. **Add your** monitoring and observability tools

---

**Example Version:** 1.0  
**Last Updated:** January 2025  
**Use Case:** Feature Implementation from Jira Story
