# CREATE Framework: Role-Specific Applications

## Overview
This document shows how the CREATE framework adapts for different roles while maintaining consistent structure.

---

## Framework Elements Across Roles

| Element | QA Engineers | Product Managers | Developers |
|---------|--------------|------------------|------------|
| **Character** | Test architect, automation expert | Product leader, strategist | Senior developer, tech lead |
| **Request** | Analyze automation suitability | Define product vision | Implement feature/fix bug |
| **Examples** | Testing scenarios, automation patterns | Product successes/failures | Code patterns, anti-patterns |
| **Application** | System under test, tech stack | Market context, user base | Tech stack, architecture |
| **Task** | Features to test, test types | Features to build, roadmap | Code to write, tests to add |
| **Evaluation** | Coverage, ROI, maintainability | Success metrics, KPIs | Code quality, test coverage |

---

## Character Definition Comparison

### QA Engineers
```yaml
Character: |
  Act as a senior QA automation expert and test architect with 10+ years 
  of experience in enterprise-level web application testing. You specialize 
  in automation strategy development, ROI analysis for test automation 
  initiatives, and have extensive experience with complex booking systems 
  in the transportation industry.
```

**Focus:** Testing expertise, domain knowledge, automation experience

### Product Managers
```yaml
Character: |
  Act as a senior product manager with 8+ years of experience in SaaS 
  products and enterprise software. You specialize in product strategy, 
  market analysis, and stakeholder management. You have successfully 
  launched multiple B2B products serving 10K+ users and $50M+ ARR.
```

**Focus:** Business acumen, market knowledge, strategic thinking

### Developers
```yaml
Character: |
  Act as a senior full-stack developer with 8+ years in React/Node.js, 
  specializing in microservices architecture and RESTful API design. 
  You follow SOLID principles, clean architecture patterns, and write 
  comprehensive tests for all production code.
```

**Focus:** Technical expertise, coding standards, architectural knowledge

---

## Request Examples by Role

| Role | Simple Request | Complex Request |
|------|----------------|-----------------|
| **QA** | "Analyze automation feasibility for checkout flow" | "Develop comprehensive test strategy for mobile payment features including risk assessment, resource planning, and ROI analysis" |
| **PM** | "Prioritize features for Q2 roadmap" | "Create product vision and 3-year roadmap for enterprise platform expansion including market analysis, competitive positioning, and go-to-market strategy" |
| **Developer** | "Implement user authentication endpoint" | "Implement scalable authentication system with JWT, refresh tokens, rate limiting, and comprehensive security measures" |

---

## Application Context Differences

### QA Engineers - Application
```yaml
Application: |
  High-traffic online bus booking system for MegaTrans Corporation 
  serving 50+ cities with 10,000+ daily bookings, processing $2M+ 
  daily transactions. System uses:
  - Frontend: React.js, TypeScript, Material-UI, PWA
  - Backend: Node.js, PostgreSQL, Redis, Elasticsearch
  - Cloud: AWS EKS, RDS, CloudFront, ALB
  - Integrations: Stripe, PayPal, Twilio, SendGrid, Google Maps
```

**Focus:** System architecture, integrations, performance scale

### Product Managers - Application
```yaml
Application: |
  B2B SaaS project management platform serving mid-market companies 
  (100-1000 employees). Current state:
  - Users: 5,000 paying customers across 500 companies
  - ARR: $2M with 15% MoM growth
  - Market: Competing with Asana, Monday.com, Jira
  - Team: 15 engineers, 3 designers, 2 PMs
  - Funding: Series A, runway 18 months
```

**Focus:** Business metrics, market position, resources, competition

### Developers - Application
```yaml
Application: |
  E-commerce platform serving 50K+ daily active users with 2K+ orders 
  per day:
  - Backend: Node.js 18, Express 4.18, TypeScript 5.0
  - Database: PostgreSQL 14 with Knex.js ORM
  - Authentication: JWT with passport-jwt strategy
  - Testing: Jest + Supertest
  - Infrastructure: AWS ECS, RDS, ElastiCache
  - Performance: 99.9% uptime SLA, < 500ms P95 response time
```

**Focus:** Technical stack details, infrastructure, performance SLAs

---

## Task Breakdown Comparison

### QA Engineers
```yaml
Task: |
  Evaluate automation suitability for these 8 features:
  1. Real-time seat selection interface
  2. Multi-gateway payment processing
  3. Dynamic route search and filtering
  4. Customer review and rating system
  5. SMS/email notification system
  6. Mobile ticket generation with QR codes
  7. Customer support live chat
  8. Loyalty program management
```

### Product Managers
```yaml
Task: |
  Develop product strategy including:
  1. Market opportunity analysis
  2. Competitive positioning
  3. User persona development
  4. Feature prioritization (MoSCoW)
  5. 3-year product roadmap
  6. Success metrics and KPIs
  7. Go-to-market strategy
  8. Risk assessment and mitigation
```

### Developers
```yaml
Task: |
  Implement the complete order creation workflow:
  1. POST /api/v1/orders endpoint
  2. Database schema (orders, order_items tables)
  3. Controller, service, repository layers
  4. Joi validation schemas
  5. Unit tests (80%+ coverage)
  6. Integration tests
  7. OpenAPI documentation
  8. Error handling and logging
```

---

## Evaluation Criteria Comparison

### QA Engineers
```yaml
Evaluation:
  - Clear automation suitability rating (High/Medium/Low/Not Suitable)
  - Technical feasibility assessment with specific challenges
  - Business impact and ROI analysis
  - Implementation priority ranking
  - Alternative testing strategies for non-automatable features
  - Maintenance complexity considerations
```

**Focus:** Testability, ROI, maintainability, risk

### Product Managers
```yaml
Evaluation:
  - Clear problem statement with user impact
  - Market opportunity sizing ($XXM TAM/SAM/SOM)
  - Competitive differentiation
  - Success metrics with targets
  - Resource requirements (team, budget, time)
  - Risk assessment with mitigation strategies
  - Executive summary for C-level presentation
```

**Focus:** Business value, market fit, metrics, risks

### Developers
```yaml
Evaluation:
  - TypeScript strict mode, no 'any' types
  - Unit tests with 80%+ coverage
  - Integration tests for API endpoints
  - Security: authentication, validation, rate limiting
  - Performance: < 300ms response time
  - Documentation: OpenAPI spec, inline comments
  - Monitoring: structured logging, metrics
  - Code review by 2+ senior engineers
```

**Focus:** Code quality, testing, security, performance

---

## Common Patterns Across Roles

### All Roles Should Include:

1. **Specific Expertise** (Character)
   - Years of experience
   - Domain specialization
   - Relevant skills

2. **Clear Objective** (Request)
   - What needs to be accomplished
   - Why it matters
   - Expected outcome

3. **Concrete References** (Examples)
   - Real scenarios
   - Success patterns
   - Anti-patterns to avoid

4. **Rich Context** (Application)
   - Scale and scope
   - Constraints
   - Current state

5. **Actionable Scope** (Task)
   - Specific deliverables
   - Clear boundaries
   - Measurable outputs

6. **Quality Standards** (Evaluation)
   - Success criteria
   - Quality gates
   - Validation methods

---

## Integration Points by Role

### QA Engineers
- Test management tools (TestRail, Zephyr)
- CI/CD pipelines
- Bug tracking (Jira)
- Test automation frameworks

### Product Managers
- Product management tools (Aha!, ProductPlan)
- Analytics platforms (Mixpanel, Amplitude)
- Customer feedback tools (UserVoice, Intercom)
- Roadmapping software

### Developers
- Version control (Git)
- Issue tracking (Jira)
- CI/CD systems (GitHub Actions, Jenkins)
- Monitoring tools (DataDog, New Relic)

---

## Team Collaboration

### How Roles Work Together with CREATE

1. **Sprint Planning**
   - PM: Uses CREATE for feature definition and prioritization
   - Developer: Uses CREATE for technical planning
   - QA: Uses CREATE for test strategy planning

2. **Feature Development**
   - PM: Provides acceptance criteria in CREATE format
   - Developer: Implements using CREATE prompts for code generation
   - QA: Creates test cases using CREATE for automation analysis

3. **Release Planning**
   - PM: CREATE prompt for release planning and communication
   - Developer: CREATE prompt for technical readiness
   - QA: CREATE prompt for release testing strategy

---

## Adaptation Guidelines

### When Adapting CREATE for Your Team:

1. **Keep Core Structure**
   - Always use all 6 elements for complex tasks
   - Maintain consistent naming

2. **Customize Content**
   - Adjust Character to match your expertise
   - Tailor Examples to your domain
   - Update Application for your context

3. **Adjust Depth**
   - Simple tasks: fewer details in each section
   - Complex tasks: comprehensive detail
   - Critical tasks: add safety measures

4. **Align with Processes**
   - Reference your tools (Jira, GitHub, etc.)
   - Include your quality standards
   - Match your team conventions

---

## Cross-Role Learning

### What Each Role Can Learn from Others:

**QA → PM**: Business value focus, ROI thinking  
**QA → Dev**: Code patterns, technical architecture  

**PM → QA**: Risk assessment, prioritization frameworks  
**PM → Dev**: User focus, business metrics  

**Dev → QA**: Technical feasibility, implementation challenges  
**Dev → PM**: Technical constraints, effort estimation

---

## Best Practices Across All Roles

1. ✅ **Be Specific**: Avoid vague descriptions
2. ✅ **Provide Context**: Include relevant background
3. ✅ **Use Examples**: Show concrete cases
4. ✅ **Set Standards**: Define success criteria
5. ✅ **Iterate**: Refine prompts based on results
6. ✅ **Share**: Build team prompt library
7. ✅ **Document**: Track what works
8. ✅ **Measure**: Assess effectiveness

---

## Template Selection Guide

| Scenario | QA Template | PM Template | Dev Template |
|----------|-------------|-------------|--------------|
| **New Feature** | Automation Assessment | Feature Definition | Feature Implementation |
| **Planning** | Test Strategy | Roadmap Planning | Architecture Design |
| **Problem** | Bug Reproduction | User Problem | Bug Fix |
| **Improvement** | Test Optimization | Feature Enhancement | Code Refactoring |
| **Assessment** | Coverage Analysis | Market Analysis | Performance Review |

---

## Conclusion

The CREATE framework provides a consistent structure across roles while allowing role-specific adaptation. The key is maintaining the framework's integrity while tailoring content to each role's unique needs and context.

**Remember:**
- Structure is consistent
- Content is role-specific
- Quality standards are high
- Outcomes are actionable

---

**Document Version:** 1.0  
**Last Updated:** January 2025  
**Maintained by:** Cross-Functional Team
