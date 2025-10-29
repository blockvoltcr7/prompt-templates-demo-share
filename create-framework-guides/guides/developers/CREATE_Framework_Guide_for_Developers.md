# CREATE Framework Guide for Developers

## Table of Contents
- [Overview](#overview)
- [What is the CREATE Framework?](#what-is-the-create-framework)
- [Framework Components](#framework-components)
- [Implementation Guidelines](#implementation-guidelines)
- [Practical Examples](#practical-examples)
- [Agile & Jira Integration](#agile--jira-integration)
- [Best Practices](#best-practices)
- [Common Pitfalls](#common-pitfalls)
- [Templates and Checklists](#templates-and-checklists)

---

## Overview

This guide provides software developers with a structured approach to crafting effective prompts for AI coding assistants using the CREATE framework. Whether you're implementing new features, refactoring code, debugging issues, or seeking architectural guidance, the CREATE framework helps ensure your prompts yield high-quality, production-ready code.

**Target Audience:** Software Developers, Full-Stack Engineers, Backend/Frontend Developers, Tech Leads

**Prerequisites:** 
- Basic understanding of AI/LLM coding tools (GitHub Copilot, ChatGPT, etc.)
- Experience working in Agile/Scrum teams
- Familiarity with Jira or similar project management tools

---

## What is the CREATE Framework?

The CREATE framework is a prompt engineering methodology specifically optimized for software development tasks. It provides a structured approach to crafting prompts that:

- Generate production-ready, maintainable code
- Align with your team's coding standards and architecture
- Reduce debugging time and code review cycles
- Improve consistency across sprint deliverables
- Integrate seamlessly with agile workflows

### Why CREATE Works for Developers

Unlike generic prompting approaches, CREATE addresses the unique challenges in agile software development:
- **Code Quality:** Generates code that follows team standards and best practices
- **Context Awareness:** Considers existing architecture, tech stack, and dependencies
- **Sprint Efficiency:** Accelerates feature delivery while maintaining quality
- **Team Alignment:** Ensures AI-generated code matches team conventions
- **Technical Debt:** Helps make informed trade-offs between speed and maintainability

---

## Framework Components

### **C - Character**
Define the AI's role, expertise level, and technical specialization.

**Purpose:** Establishes the AI's technical persona and knowledge domain
**Developer Application:** Specify programming languages, frameworks, architectural patterns, seniority level

**Examples:**
```
✅ Good: "Act as a senior full-stack developer with 7+ years in React/Node.js, 
         specializing in microservices architecture and RESTful API design"
❌ Poor: "Act as a programmer"
```

### **R - Request**
Clearly state what you want the AI to accomplish in technical terms.

**Purpose:** Defines the specific development task or technical decision required
**Developer Application:** Feature implementation, code refactoring, bug fixes, architectural decisions

**Examples:**
```
✅ Good: "Implement a scalable authentication middleware using JWT tokens with 
         refresh token rotation for our Express.js API"
❌ Poor: "Help with authentication"
```

### **E - Examples**
Provide code samples, patterns, or reference implementations.

**Purpose:** Illustrates coding style, patterns, and quality standards
**Developer Application:** Existing code snippets, similar implementations, anti-patterns to avoid

**Examples:**
```
✅ Good: "Follow this error handling pattern we use:
         try {
           const result = await service.execute();
           return ResponseHandler.success(result);
         } catch (error) {
           logger.error('Operation failed', { error, context });
           return ResponseHandler.error(error);
         }"
❌ Poor: No code examples provided
```

### **A - Application**
Describe the specific technical context, architecture, and constraints.

**Purpose:** Provides essential technical context for informed implementation
**Developer Application:** Tech stack, architecture patterns, dependencies, performance requirements

**Examples:**
```
✅ Good: "Microservices architecture using Node.js 18, Express 4.x, PostgreSQL 14, 
         Redis for caching, deployed on AWS ECS with Docker containers. 
         System handles 10K req/sec with 99.9% uptime SLA"
❌ Poor: "A Node.js application"
```

### **T - Task**
Specify the exact implementation work with clear scope and acceptance criteria.

**Purpose:** Defines concrete development actions and expected deliverables
**Developer Application:** Feature scope, API endpoints, database changes, test requirements

**Examples:**
```
✅ Good: "Create POST /api/v1/orders endpoint with validation, database persistence, 
         event publishing to Kafka, unit tests (80% coverage), and OpenAPI documentation"
❌ Poor: "Create an endpoint"
```

### **E - Evaluation**
Define technical success criteria, code quality standards, and testing requirements.

**Purpose:** Establishes how to measure code quality and completeness
**Developer Application:** Test coverage, performance benchmarks, security requirements, code review criteria

**Examples:**
```
✅ Good: "Code must include: comprehensive error handling, input validation, 
         unit tests with 80%+ coverage, JSDoc comments, TypeScript strict mode, 
         performance under 200ms response time, security audit passing"
❌ Poor: No evaluation criteria specified
```

---

## Implementation Guidelines

### 1. **Start with Your User Story/Jira Ticket**
Before writing the prompt, review:
- Acceptance criteria from your Jira ticket
- Technical requirements and constraints
- Definition of Done (DoD) from your team
- Related tickets and dependencies

### 2. **Choose Relevant CREATE Elements**
Tailor based on task complexity:
- **Simple bug fix:** Character + Request + Application + Task
- **New feature:** All six elements
- **Refactoring:** Character + Request + Examples + Application + Evaluation
- **Architecture decision:** Character + Request + Application + Examples + Evaluation

### 3. **Order for Developers**
Recommended flow for development tasks:
1. **Character** - Establish technical expertise
2. **Application** - Provide technical context and constraints
3. **Request** - State the development goal
4. **Examples** - Show existing code patterns
5. **Task** - Define specific implementation scope
6. **Evaluation** - Set quality and testing standards

### 4. **Iterative Development**
- Start with a minimal viable implementation
- Refine based on code review feedback
- Build a prompt library for common sprint tasks
- Share successful prompts during retrospectives

---

## Practical Examples

### Example 1: Feature Implementation from Jira Story

```yaml
# Jira Ticket: SHOP-456 - Implement Product Review API
# Sprint: Sprint 24 | Story Points: 5 | Priority: High

prompt: |
  ## Character (C)
  Act as a senior backend developer with 8+ years of experience in Node.js and 
  Express.js development. You specialize in building RESTful APIs, database design, 
  and have deep expertise in e-commerce systems. You follow SOLID principles, 
  clean architecture patterns, and write comprehensive tests for all production code.
  
  ## Request (R)
  Implement a complete product review API endpoint that allows authenticated users 
  to submit reviews with ratings, text, and optional images. The implementation 
  must handle validation, persistence, and trigger notifications to product owners.
  
  ## Examples (E)
  Follow our existing API patterns:
  
  ```javascript
  // Standard controller pattern
  class ReviewController {
    async create(req, res, next) {
      try {
        const validated = await this.validateRequest(req.body);
        const result = await this.reviewService.createReview(validated);
        await this.notificationService.notifyProductOwner(result);
        return res.status(201).json(ResponseFormatter.success(result));
      } catch (error) {
        next(error); // Handled by global error middleware
      }
    }
  }
  
  // Standard service pattern with transaction
  class ReviewService {
    async createReview(data) {
      return await this.db.transaction(async (trx) => {
        const review = await this.reviewRepo.create(data, trx);
        await this.productRepo.updateRating(data.productId, trx);
        return review;
      });
    }
  }
  ```
  
  ## Application (A)
  E-commerce platform built with:
  - **Backend:** Node.js 18, Express 4.18, TypeScript 5.0
  - **Database:** PostgreSQL 14 with Knex.js ORM
  - **Authentication:** JWT with passport-jwt strategy
  - **Validation:** Joi for schema validation
  - **Testing:** Jest + Supertest
  - **File Upload:** AWS S3 for review images
  - **Message Queue:** RabbitMQ for async notifications
  - **Logging:** Winston with structured logging
  - **API Docs:** OpenAPI 3.0 (Swagger)
  
  Current traffic: 5K daily active users, 500 reviews/day average
  
  ## Task (T)
  Implement the following components:
  
  1. **POST /api/v1/products/:productId/reviews**
     - Accept: rating (1-5), title, comment, images[] (optional, max 3)
     - Validate: authenticated user, product exists, user purchased product
     - Business rules: One review per user per product, rating required
  
  2. **Database Schema:**
     ```sql
     CREATE TABLE product_reviews (
       id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
       product_id UUID NOT NULL REFERENCES products(id),
       user_id UUID NOT NULL REFERENCES users(id),
       rating INTEGER NOT NULL CHECK (rating >= 1 AND rating <= 5),
       title VARCHAR(200) NOT NULL,
       comment TEXT,
       images JSONB DEFAULT '[]',
       helpful_count INTEGER DEFAULT 0,
       created_at TIMESTAMP DEFAULT NOW(),
       updated_at TIMESTAMP DEFAULT NOW(),
       UNIQUE(product_id, user_id)
     );
     ```
  
  3. **Required Files:**
     - routes/reviews.routes.ts
     - controllers/review.controller.ts
     - services/review.service.ts
     - repositories/review.repository.ts
     - validators/review.validator.ts
     - __tests__/reviews.test.ts
  
  4. **Integration Requirements:**
     - Upload images to S3 bucket: product-reviews-images
     - Publish event to RabbitMQ: review.created
     - Update product aggregate rating in real-time
     - Log all operations with correlation IDs
  
  ## Evaluation (E)
  Acceptance Criteria (must meet ALL):
  
  **Code Quality:**
  - TypeScript strict mode enabled, no 'any' types
  - All functions have JSDoc comments
  - Follows existing code patterns and project structure
  - Error handling for all async operations
  - Proper separation of concerns (controller/service/repository)
  
  **Testing:**
  - Unit tests for service layer (80%+ coverage)
  - Integration tests for API endpoint
  - Test scenarios: successful creation, validation failures, auth failures
  - Mock external dependencies (S3, RabbitMQ)
  
  **Security:**
  - Input validation using Joi schemas
  - SQL injection prevention (parameterized queries)
  - Rate limiting: 10 reviews per hour per user
  - Image size limit: 5MB per image
  - Sanitize user input to prevent XSS
  
  **Performance:**
  - Response time < 300ms (excluding S3 upload)
  - Database queries optimized with proper indexes
  - Async operations for notifications (non-blocking)
  
  **Documentation:**
  - OpenAPI spec for the endpoint
  - README section with usage examples
  - Inline comments for complex logic
  
  **Jira Integration:**
  - Code references Jira ticket: SHOP-456
  - Commit message follows convention: "feat(reviews): implement product review API [SHOP-456]"

context:
  jira_ticket: "SHOP-456"
  sprint: "Sprint 24"
  story_points: 5
  priority: "High"
  assignee: "current_developer"
  
expected_output:
  format: "complete_implementation"
  files: ["routes", "controllers", "services", "repositories", "validators", "tests"]
  testing: "unit_and_integration"
  documentation: "inline_and_openapi"
```

---

### Example 2: Bug Fix from Jira Bug Ticket

```yaml
# Jira Ticket: BUG-789 - Memory leak in WebSocket connection handler
# Sprint: Sprint 24 | Priority: Critical | Severity: High

prompt: |
  ## Character (C)
  Act as a senior Node.js developer specializing in performance optimization, 
  memory profiling, and debugging production issues. You have extensive experience 
  with WebSocket implementations, event emitters, and memory leak detection using 
  tools like Chrome DevTools and clinic.js.
  
  ## Request (R)
  Investigate and fix a memory leak in our WebSocket connection handler that causes 
  memory to grow continuously over time, eventually leading to application crashes 
  after 24-48 hours of operation.
  
  ## Examples (E)
  Common WebSocket memory leak patterns to check:
  
  ```javascript
  // ❌ Memory Leak: Event listeners not cleaned up
  class BadWebSocketHandler {
    handleConnection(socket) {
      socket.on('message', (data) => {
        this.messageHandler(data); // 'this' creates closure
      });
      // Missing: socket.removeAllListeners on disconnect
    }
  }
  
  // ✅ Good: Proper cleanup
  class GoodWebSocketHandler {
    handleConnection(socket) {
      const messageHandler = this.createMessageHandler(socket);
      socket.on('message', messageHandler);
      
      socket.on('close', () => {
        socket.removeListener('message', messageHandler);
        this.cleanupSocketData(socket.id);
      });
    }
  }
  ```
  
  ## Application (A)
  Real-time chat application:
  - **Runtime:** Node.js 18.x
  - **WebSocket Library:** ws@8.x
  - **Framework:** Express 4.x
  - **Memory:** 512MB container limit on AWS ECS
  - **Load:** 1000+ concurrent connections, 50K messages/hour
  - **Monitoring:** DataDog APM, AWS CloudWatch
  
  Current symptom: Memory grows from 150MB to 480MB over 36 hours
  
  ## Task (T)
  1. Analyze the existing WebSocket handler code (src/websocket/handler.ts)
  2. Identify memory leak sources using heap snapshots
  3. Implement fixes for:
     - Event listener cleanup
     - Connection map management
     - Message buffer handling
  4. Add monitoring for connection lifecycle
  5. Verify fix with memory profiling tests
  
  ## Evaluation (E)
  Success criteria:
  - Memory usage remains stable under 200MB for 48+ hours
  - No memory growth pattern in heap snapshots
  - All WebSocket connections properly cleaned up on disconnect
  - Connection map size matches active connections
  - Added automated tests to prevent regression
  - Performance regression test: response time unchanged

context:
  jira_ticket: "BUG-789"
  severity: "Critical"
  environment: "Production"
  monitoring_tools: ["DataDog", "CloudWatch"]
```

---

### Example 3: Code Refactoring Task

```yaml
# Jira Ticket: TECH-234 - Refactor user authentication service
# Sprint: Sprint 24 | Type: Technical Debt | Story Points: 8

prompt: |
  ## Character (C)
  Act as a senior software architect with expertise in authentication systems, 
  clean architecture, and Node.js best practices. You excel at refactoring legacy 
  code while maintaining backward compatibility and ensuring zero downtime deployments.
  
  ## Request (R)
  Refactor the monolithic user authentication service into a clean, maintainable 
  implementation following SOLID principles and dependency injection patterns. 
  The refactored code must maintain 100% backward compatibility with existing API contracts.
  
  ## Examples (E)
  Target architecture pattern:
  
  ```typescript
  // Clean architecture with dependency injection
  interface IAuthService {
    login(credentials: LoginDto): Promise<AuthResult>;
    refreshToken(token: string): Promise<AuthResult>;
    logout(userId: string): Promise<void>;
  }
  
  interface ITokenService {
    generate(payload: TokenPayload): string;
    verify(token: string): TokenPayload;
    revoke(token: string): Promise<void>;
  }
  
  class AuthService implements IAuthService {
    constructor(
      private userRepo: IUserRepository,
      private tokenService: ITokenService,
      private passwordService: IPasswordService,
      private logger: ILogger
    ) {}
    
    async login(credentials: LoginDto): Promise<AuthResult> {
      // Implementation with proper error handling
    }
  }
  ```
  
  ## Application (A)
  Current state:
  - 800+ line monolithic auth.service.ts file
  - Mixed concerns: validation, business logic, DB access, token generation
  - Hard-coded dependencies, difficult to test
  - No interface contracts
  - Tech stack: Node.js 18, TypeScript 5, Express, PostgreSQL
  
  ## Task (T)
  Refactor into:
  1. **auth.service.ts** - Core business logic only
  2. **token.service.ts** - JWT generation/verification
  3. **password.service.ts** - Hashing/comparison
  4. **auth.validator.ts** - Input validation
  5. **interfaces/** - All service contracts
  6. **di-container.ts** - Dependency injection setup
  7. **__tests__/** - Update all existing tests
  
  Requirements:
  - Maintain existing API endpoints unchanged
  - Add dependency injection using tsyringe or similar
  - Improve testability with interfaces
  - Add comprehensive unit tests (85%+ coverage)
  - Update integration tests to pass
  - Document architecture decisions
  
  ## Evaluation (E)
  Success criteria:
  - All existing tests pass without modification
  - New unit test coverage: 85%+
  - Each class has single responsibility
  - Dependencies injected via constructor
  - Zero breaking changes to API contracts
  - Code review approved by 2+ senior developers
  - Performance benchmarks show no regression
  - Documentation updated with new architecture

context:
  jira_ticket: "TECH-234"
  type: "Technical Debt"
  story_points: 8
  backward_compatibility: "Required"
```

---

## Agile & Jira Integration

### Sprint Planning with CREATE

**During Sprint Planning:**
1. Review acceptance criteria in Jira
2. Create CREATE prompts for complex stories
3. Share prompts with team for alignment
4. Store in team knowledge base

**Daily Standup:**
- Use CREATE for blockers requiring technical guidance
- Quick prompts for tactical decisions

**Sprint Review:**
- Demonstrate AI-assisted implementations
- Share effective prompts that accelerated delivery

**Retrospective:**
- Review prompt effectiveness
- Update team prompt library
- Identify patterns for future sprints

### Jira Integration Best Practices

```yaml
# Template for Jira-Linked Prompts
jira_metadata:
  ticket_id: "PROJ-###"
  sprint: "Sprint XX"
  story_points: X
  priority: "High/Medium/Low"
  type: "Story/Bug/Task/Tech Debt"

commit_convention: |
  feat(scope): description [PROJ-###]
  fix(scope): description [PROJ-###]
  refactor(scope): description [PROJ-###]
  test(scope): description [PROJ-###]

branch_naming: |
  feature/PROJ-###-short-description
  bugfix/PROJ-###-short-description
  refactor/PROJ-###-short-description

pull_request_template: |
  ## Jira Ticket
  [PROJ-###](https://jira.company.com/browse/PROJ-###)
  
  ## CREATE Prompt Used
  [Link to prompt or inline paste]
  
  ## Changes
  - List of changes
  
  ## Testing
  - Test scenarios covered
  
  ## AI Assistance
  - Which parts used AI
  - Manual modifications made
```

---

## Best Practices

### ✅ **Do's**

1. **Be Specific with Character**
   - Include tech stack expertise (React, Node.js, Python, etc.)
   - Specify architectural knowledge (microservices, clean architecture)
   - Match seniority to problem complexity

2. **Provide Rich Technical Context**
   - Include relevant code snippets from your codebase
   - Mention tech stack versions and dependencies
   - Describe architecture patterns in use
   - Share performance and scale requirements

3. **Use Concrete Code Examples**
   - Show existing patterns your team uses
   - Include error handling conventions
   - Demonstrate testing approaches
   - Share anti-patterns to avoid

4. **Link to Jira Context**
   - Reference acceptance criteria
   - Include story points for complexity estimation
   - Note sprint timeline constraints
   - Mention related tickets and dependencies

5. **Define Clear Quality Standards**
   - Specify test coverage requirements
   - Include performance benchmarks
   - Set security requirements
   - Define code review criteria

### ❌ **Don'ts**

1. **Avoid Vague Technical Requests**
   - Don't say "fix the code" → Specify what's broken
   - Don't say "make it faster" → Define performance targets
   - Don't say "add tests" → Specify coverage and scenarios

2. **Skip Architecture Context**
   - Don't omit existing patterns and conventions
   - Avoid missing tech stack details
   - Don't forget deployment constraints

3. **Forget Team Standards**
   - Don't ignore linting rules
   - Avoid skipping code review requirements
   - Don't forget Git commit conventions

4. **Leave Testing Undefined**
   - Don't accept code without tests
   - Avoid unclear coverage requirements
   - Don't skip integration test scenarios

---

## Common Pitfalls

### 1. **Generic Prompts**
**Problem:** "Create a login function"
**Solution:** Include auth strategy, security requirements, existing patterns

### 2. **Missing Constraints**
**Problem:** Generated code doesn't fit existing architecture
**Solution:** Always include Application context with tech stack and patterns

### 3. **No Quality Criteria**
**Problem:** Code works but doesn't meet team standards
**Solution:** Define Evaluation criteria for tests, performance, security

### 4. **Ignoring Existing Code**
**Problem:** AI generates code in different style than codebase
**Solution:** Provide Examples from your actual codebase

### 5. **Sprint Scope Creep**
**Problem:** AI suggests over-engineered solutions
**Solution:** Explicitly state story points, sprint timeline, MVP requirements

---

## Templates and Checklists

### Quick Feature Implementation Template

```yaml
character: |
  Act as a [seniority] [specialty] developer with [X]+ years in [tech_stack],
  specializing in [domain_expertise]. You follow [principles/patterns].

request: |
  Implement [specific_feature] that [business_value] for [user_type].

examples: |
  Follow these existing patterns from our codebase:
  [code_snippet_1]
  [code_snippet_2]

application: |
  Tech Stack:
  - [Language & Version]
  - [Framework & Version]
  - [Database]
  - [Key Libraries]
  
  Architecture: [pattern]
  Scale: [metrics]
  Constraints: [limitations]

task: |
  Implement:
  1. [Component 1]
  2. [Component 2]
  3. [Tests]
  4. [Documentation]
  
  Files to create/modify:
  - [file_path_1]
  - [file_path_2]

evaluation: |
  Must include:
  - [Quality criterion 1]
  - [Quality criterion 2]
  - [Testing requirement]
  - [Performance requirement]
  - [Security requirement]

jira:
  ticket: "PROJ-###"
  sprint: "Sprint XX"
  story_points: X
```

### Pre-Prompt Checklist

- [ ] **Character**: Tech stack expertise and seniority defined?
- [ ] **Request**: Clear development goal stated?
- [ ] **Examples**: Code patterns from codebase included?
- [ ] **Application**: Full tech stack and architecture context?
- [ ] **Task**: Specific files, components, and tests defined?
- [ ] **Evaluation**: Quality, testing, and security criteria set?
- [ ] **Jira**: Ticket reference and sprint context included?

### Code Review Checklist for AI-Generated Code

- [ ] Follows team coding standards and style guide?
- [ ] Matches existing architectural patterns?
- [ ] Includes comprehensive error handling?
- [ ] Has required test coverage?
- [ ] Includes proper logging and monitoring?
- [ ] Security vulnerabilities addressed?
- [ ] Performance requirements met?
- [ ] Documentation complete (inline, API docs)?
- [ ] No hard-coded values or secrets?
- [ ] Proper dependency management?

---

## Conclusion

The CREATE framework provides development teams with a structured, repeatable approach to AI-assisted coding in agile environments. By following this guide, you can:

- Accelerate sprint velocity without sacrificing code quality
- Maintain consistency with team standards and architecture
- Generate production-ready code faster
- Reduce code review cycles and rework
- Build a shared knowledge base of effective prompts
- Improve collaboration between AI tools and agile workflows

**Next Steps:**
1. Try the templates with your next Jira story
2. Share successful prompts in team Confluence/Wiki
3. Add CREATE prompts to your Definition of Ready
4. Review prompt effectiveness in sprint retrospectives
5. Build team-specific prompt library

---

**Document Version:** 1.0  
**Last Updated:** January 2025  
**Maintained by:** Engineering Team  
**Review Schedule:** Quarterly  
**Feedback:** Submit improvements via [your team's feedback channel]
