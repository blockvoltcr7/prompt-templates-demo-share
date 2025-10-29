# CREATE Framework Quick Reference for Developers

## When to Use CREATE Framework

✅ **Use CREATE for:**
- Implementing new features from Jira stories
- Fixing complex bugs requiring investigation
- Refactoring legacy code or technical debt
- Making architectural decisions
- Implementing new APIs or services
- Performance optimization tasks
- Security vulnerability fixes

❌ **Don't need CREATE for:**
- Simple syntax questions
- Documentation lookups
- Basic code examples
- Trivial bug fixes (typos, simple logic errors)
- Standard library usage questions

---

## Quick Template Selection

| Task Type | Template to Use | Typical Story Points |
|-----------|----------------|---------------------|
| New API endpoint | `feature-implementation-template.yaml` | 3-8 |
| Bug fix | `bug-fix-template.yaml` | 1-5 |
| Refactoring | `refactoring-template.yaml` | 5-13 |
| Performance issue | `bug-fix-template.yaml` (modified) | 3-8 |
| Security fix | `bug-fix-template.yaml` + security focus | 2-5 |

---

## Minimal CREATE Prompt (Quick Tasks)

For simple tasks, use this lightweight version:

```yaml
# Character
Act as a senior [your_specialty] developer with expertise in [tech_stack].

# Request + Task
[Action verb] [specific component] that [purpose]. Include [requirements].

# Application (Context)
Tech: [key technologies]
Constraints: [main limitations]

# Evaluation
Must include: [tests], [error handling], [documentation]
```

---

## Full CREATE Prompt (Complex Tasks)

For complex features or critical bugs, use all 6 elements:

1. **Character**: Define expertise and specialization
2. **Request**: State clear objective
3. **Examples**: Show code patterns from your codebase
4. **Application**: Provide full tech stack and context
5. **Task**: Break down specific deliverables
6. **Evaluation**: Set quality criteria and success metrics

---

## Common Jira Workflows

### Sprint Planning
```
1. Review Jira story acceptance criteria
2. Create CREATE prompt for complex stories
3. Store in ticket comments or team wiki
4. Use during implementation
```

### Daily Development
```
1. Pick Jira ticket
2. Select appropriate template
3. Fill in specifics from ticket
4. Generate code with AI
5. Review, test, commit with ticket ID
```

### Bug Triage
```
1. Assess bug severity
2. Use bug-fix template
3. Include monitoring/logs in Application
4. Focus on root cause analysis
5. Add regression tests
```

---

## Commit Message Convention

```bash
# Format
<type>(<scope>): <description> [JIRA-ID]

# Examples
feat(auth): implement JWT refresh token rotation [AUTH-123]
fix(api): resolve memory leak in cache service [BUG-456]
refactor(user): extract user service to separate module [TECH-789]
test(orders): add integration tests for order API [TEST-321]
docs(readme): update API documentation [DOC-111]

# Types
feat     - New feature
fix      - Bug fix
refactor - Code refactoring
test     - Adding tests
docs     - Documentation
perf     - Performance improvement
style    - Code style changes
chore    - Maintenance tasks
```

---

## Branch Naming Convention

```bash
# Format
<type>/<JIRA-ID>-<short-description>

# Examples
feature/SHOP-567-order-creation-api
bugfix/BUG-892-memory-leak-cache
refactor/TECH-234-auth-service-cleanup
hotfix/CRIT-999-payment-gateway-down
```

---

## Code Review Checklist

Before requesting review:

- [ ] All acceptance criteria met
- [ ] Tests written and passing
- [ ] Code follows team conventions
- [ ] No hardcoded values or secrets
- [ ] Error handling comprehensive
- [ ] Logging includes context
- [ ] Performance acceptable
- [ ] Security considerations addressed
- [ ] Documentation updated
- [ ] Jira ticket referenced in commits
- [ ] PR description complete

---

## Quality Gates

### Must Have
- ✅ Tests pass in CI/CD
- ✅ Code coverage meets threshold (typically 80%+)
- ✅ Linter/formatter passes
- ✅ No security vulnerabilities
- ✅ Performance benchmarks met

### Should Have
- ✅ Reviewed by 2+ team members
- ✅ Deployed to staging first
- ✅ Monitoring configured
- ✅ Documentation complete

---

## Common Patterns

### Error Handling
```typescript
try {
  const result = await service.execute();
  logger.info('Operation succeeded', { context });
  return result;
} catch (error) {
  logger.error('Operation failed', { error, context });
  throw new CustomError('User-friendly message', { cause: error });
}
```

### Logging with Context
```typescript
logger.info('Processing request', {
  correlationId: req.correlationId,
  userId: req.user?.id,
  endpoint: req.path,
  method: req.method
});
```

### Testing Pattern
```typescript
describe('OrderService', () => {
  describe('createOrder', () => {
    it('should create order successfully', async () => {
      // Arrange
      const mockData = createMockOrder();
      mockRepository.create.mockResolvedValue(mockData);
      
      // Act
      const result = await service.createOrder(mockData);
      
      // Assert
      expect(result).toMatchObject(mockData);
      expect(mockRepository.create).toHaveBeenCalledWith(mockData);
    });
    
    it('should handle insufficient inventory error', async () => {
      // Arrange
      mockInventory.check.mockRejectedValue(new InsufficientInventoryError());
      
      // Act & Assert
      await expect(service.createOrder(mockData))
        .rejects.toThrow(InsufficientInventoryError);
    });
  });
});
```

---

## Performance Targets

| Metric | Target | Method |
|--------|--------|--------|
| API Response Time | P95 < 200ms | Load testing |
| Test Coverage | ≥ 80% | Jest/Coverage tools |
| Build Time | < 5 minutes | CI/CD optimization |
| Database Query | < 100ms | Query optimization |
| Memory Usage | Stable over 24hrs | Profiling |

---

## Security Checklist

- [ ] Input validation with schemas
- [ ] SQL injection prevention (parameterized queries)
- [ ] XSS prevention (sanitize outputs)
- [ ] Authentication on protected endpoints
- [ ] Authorization checks
- [ ] Rate limiting configured
- [ ] Sensitive data encrypted
- [ ] Secrets in environment variables (not code)
- [ ] CORS properly configured
- [ ] Security headers set

---

## Monitoring & Observability

### Key Metrics to Track
```typescript
// Business metrics
metrics.increment('orders.created');
metrics.timing('orders.creation_time', duration);

// Technical metrics  
metrics.gauge('db.connection_pool.size', poolSize);
metrics.increment('api.errors', { endpoint, status });

// Custom metrics
metrics.histogram('order.item_count', orderItems.length);
```

### Structured Logging
```typescript
logger.info('Event occurred', {
  correlationId,
  userId,
  action: 'order_created',
  orderId,
  total: order.total,
  timestamp: new Date().toISOString()
});
```

---

## Troubleshooting Quick Tips

### High Memory Usage
1. Take heap snapshot
2. Look for retained objects
3. Check for event listener leaks
4. Review closure usage
5. Validate connection pooling

### Slow Performance
1. Enable query logging
2. Check N+1 query problems
3. Review cache hit rates
4. Analyze slow query logs
5. Profile CPU usage

### Intermittent Errors
1. Check for race conditions
2. Review async/await usage
3. Validate error handling
4. Check external service timeouts
5. Review retry logic

---

## Resources

### Team Resources
- Wiki: [Link to team wiki]
- Runbooks: [Link to runbooks]
- Style Guide: [Link to style guide]
- Architecture Docs: [Link to architecture]

### Tools
- Jira: [Link to Jira board]
- CI/CD: [Link to CI/CD]
- Monitoring: [Link to DataDog/etc]
- Logs: [Link to log aggregation]

### Learning
- CREATE Framework Guide: `guides/developers/CREATE_Framework_Guide_for_Developers.md`
- Examples: `guides/developers/examples/`
- Templates: `templates/dev-templates/`

---

## Quick Commands

```bash
# Run tests
npm test                    # All tests
npm run test:unit          # Unit tests only
npm run test:integration   # Integration tests
npm run test:coverage      # With coverage

# Linting & Formatting
npm run lint               # Check linting
npm run lint:fix           # Fix linting issues
npm run format             # Format code

# Build & Deploy
npm run build              # Production build
npm run start:dev          # Development mode
npm run start:prod         # Production mode

# Database
npm run migrate:latest     # Run migrations
npm run migrate:rollback   # Rollback migration
npm run seed:run           # Run seeds

# Debugging
node --inspect src/app.js  # Enable debugging
npm run debug              # Debug mode
```

---

**Quick Reference Version:** 1.0  
**Last Updated:** January 2025  
**For:** Software Developers in Agile Teams
