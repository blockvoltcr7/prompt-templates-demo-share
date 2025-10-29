# Bug Fix Example - Memory Leak in Cache Service

## Scenario
A critical production bug has been identified causing memory leaks in the cache service, leading to application crashes every 24-36 hours.

**Jira Ticket:** BUG-892 - Memory leak in Redis cache wrapper causing OOM crashes  
**Priority:** Critical  
**Severity:** P1 - Production Down  
**Sprint:** Sprint 24 (pulled into sprint mid-iteration)  
**Affected Users:** All users (service unavailable during crashes)

## Bug Report Details

```
Environment: Production
Frequency: Every 24-36 hours
Impact: Complete service outage requiring restart
Memory Growth: 200MB → 3.5GB over 30 hours
Last Incident: 2 hours ago (10:23 AM PST)
Monitoring: DataDog shows linear memory growth
```

## CREATE Framework Prompt

```yaml
prompt: |
  # BUG-892: Critical Memory Leak Investigation and Fix
  
  ## Character (C)
  Act as a senior Node.js performance engineer with 10+ years of experience 
  debugging memory leaks, profiling applications, and optimizing production systems. 
  You have deep expertise in:
  - Memory profiling using Chrome DevTools, clinic.js, and node --inspect
  - Redis client implementations and connection management
  - Event emitter patterns and memory leak prevention in Node.js
  - Production debugging under time pressure
  - Root cause analysis and permanent fix implementation
  
  You prioritize identifying the actual root cause over temporary workarounds and 
  always include regression tests to prevent future occurrences.
  
  ## Request (R)
  Investigate and permanently fix a critical memory leak in our Redis cache wrapper 
  service that causes the application to crash with OOM (Out of Memory) errors every 
  24-36 hours in production. The fix must:
  - Identify the exact root cause of the memory leak
  - Implement a permanent solution (not a workaround)
  - Include monitoring to detect similar issues in the future
  - Provide regression tests to prevent reoccurrence
  - Be deployable to production within 4 hours
  
  ## Examples (E)
  Common Node.js memory leak patterns to investigate:
  
  ### Pattern 1: Event Listener Accumulation
  ```typescript
  // ❌ MEMORY LEAK: Event listeners never removed
  class BadCacheService {
    private client: RedisClient;
    private subscribers: Map<string, Function> = new Map();
    
    async subscribe(key: string, callback: Function) {
      // New listener added each time, old ones never removed
      this.client.on(`message:${key}`, callback);
      this.subscribers.set(key, callback);
    }
  }
  
  // ✅ CORRECT: Proper cleanup
  class GoodCacheService {
    private client: RedisClient;
    private subscribers: Map<string, Function> = new Map();
    
    async subscribe(key: string, callback: Function) {
      // Remove old listener if exists
      const oldCallback = this.subscribers.get(key);
      if (oldCallback) {
        this.client.removeListener(`message:${key}`, oldCallback);
      }
      
      this.client.on(`message:${key}`, callback);
      this.subscribers.set(key, callback);
    }
    
    async unsubscribe(key: string) {
      const callback = this.subscribers.get(key);
      if (callback) {
        this.client.removeListener(`message:${key}`, callback);
        this.subscribers.delete(key);
      }
    }
  }
  ```
  
  ### Pattern 2: Closure Memory Retention
  ```typescript
  // ❌ MEMORY LEAK: Closures retain large objects
  class BadCacheManager {
    private cache: Map<string, any> = new Map();
    
    setWithExpiry(key: string, value: any, ttl: number) {
      this.cache.set(key, value);
      
      // setTimeout closure keeps reference to entire 'this' context
      setTimeout(() => {
        this.cache.delete(key);
      }, ttl);
    }
  }
  
  // ✅ CORRECT: Extract method, store timer reference
  class GoodCacheManager {
    private cache: Map<string, any> = new Map();
    private timers: Map<string, NodeJS.Timeout> = new Map();
    
    setWithExpiry(key: string, value: any, ttl: number) {
      // Clear existing timer
      this.clearTimer(key);
      
      this.cache.set(key, value);
      
      // Store timer reference for cleanup
      const timer = setTimeout(() => {
        this.deleteKey(key);
      }, ttl);
      
      this.timers.set(key, timer);
    }
    
    private deleteKey(key: string) {
      this.cache.delete(key);
      this.timers.delete(key);
    }
    
    private clearTimer(key: string) {
      const timer = this.timers.get(key);
      if (timer) {
        clearTimeout(timer);
        this.timers.delete(key);
      }
    }
    
    destroy() {
      // Cleanup all timers
      this.timers.forEach(timer => clearTimeout(timer));
      this.timers.clear();
      this.cache.clear();
    }
  }
  ```
  
  ### Pattern 3: Connection Pool Leaks
  ```typescript
  // ❌ MEMORY LEAK: Connections never returned to pool
  class BadRedisManager {
    private pool: RedisClient[] = [];
    
    async execute(command: string) {
      const client = await this.getConnection();
      const result = await client.exec(command);
      // Connection never returned to pool!
      return result;
    }
  }
  
  // ✅ CORRECT: Always return connections
  class GoodRedisManager {
    private pool: GenericPool<RedisClient>;
    
    async execute(command: string) {
      const client = await this.pool.acquire();
      try {
        return await client.exec(command);
      } finally {
        await this.pool.release(client); // Always return
      }
    }
  }
  ```
  
  ## Application (A)
  **System Context:**
  - **Service:** Cache service wrapper for Redis
  - **Runtime:** Node.js 18.17.0
  - **Redis Client:** ioredis v5.3.2
  - **Memory Limit:** 4GB container on AWS ECS
  - **Current Usage:** Starts at 200MB, grows to 3.5GB before crash
  - **Traffic:** 5K requests/second
  - **Cache Operations:** 50K get/set operations per minute
  
  **Existing Code Structure:**
  ```
  src/
  ├── cache/
  │   ├── cache.service.ts       # Main cache wrapper (suspect file)
  │   ├── redis.client.ts        # Redis client configuration
  │   └── cache.manager.ts       # Cache key management
  └── __tests__/
      └── cache.service.test.ts
  ```
  
  **Monitoring Data:**
  - Heap size grows linearly: ~50MB/hour
  - EventEmitter listener count increases over time
  - Redis connections: stable at 20 (pool size)
  - Process restarts: 15 times in last 7 days
  - No correlation with traffic spikes
  
  **Recent Changes:**
  - 5 days ago: Added pub/sub feature for cache invalidation
  - 3 days ago: Implemented auto-refresh for frequently accessed keys
  - 2 days ago: Memory leak first observed in production
  
  ## Task (T)
  Perform the following investigation and fix workflow:
  
  ### Phase 1: Analysis (30 minutes)
  1. **Review suspect code files:**
     - src/cache/cache.service.ts (primary suspect)
     - src/cache/cache.manager.ts
     - Focus on code added in last 5 days
  
  2. **Identify memory leak patterns:**
     - Event listener accumulation
     - Closure memory retention
     - Timer/interval leaks
     - Map/Set unbounded growth
     - Connection pool issues
  
  3. **Analyze heap snapshots:**
     ```bash
     # Commands we'll use for analysis
     node --inspect src/server.js
     # Take heap snapshots at intervals
     # Compare retained size between snapshots
     ```
  
  ### Phase 2: Root Cause Identification (30 minutes)
  1. Pinpoint exact code causing leak
  2. Explain WHY the leak occurs
  3. Estimate leak rate (MB/hour)
  4. Identify when leak was introduced (git commit)
  
  ### Phase 3: Fix Implementation (2 hours)
  1. **Implement permanent fix:**
     - Remove root cause completely
     - Add proper cleanup logic
     - Ensure all resources are released
  
  2. **Add safeguards:**
     - Maximum size limits for collections
     - Automatic cleanup for old entries
     - Graceful shutdown handling
  
  3. **Add monitoring:**
     - Track event listener counts
     - Monitor collection sizes
     - Alert on abnormal growth
  
  ### Phase 4: Testing (1 hour)
  1. **Create regression test:**
     - Test that reproduces the leak
     - Verify fix prevents the leak
  
  2. **Load testing:**
     - Run for 2+ hours with production load
     - Monitor memory with heap snapshots
     - Verify memory stays stable
  
  3. **Validate:**
     - Memory growth < 5MB/hour
     - No increase in listener count
     - All existing tests pass
  
  ### Phase 5: Documentation (30 minutes)
  1. Document root cause in Jira ticket
  2. Add inline comments explaining fix
  3. Update monitoring runbook
  4. Create incident post-mortem
  
  ## Evaluation (E)
  The fix must meet ALL of these critical criteria:
  
  ### Root Cause Analysis (Required)
  - ✅ Exact line(s) of code causing leak identified
  - ✅ Clear explanation of WHY leak occurs
  - ✅ Evidence from heap snapshots or profiling
  - ✅ Git commit that introduced the issue
  - ✅ Estimated leak rate (MB/hour)
  
  ### Fix Quality (Required)
  - ✅ Addresses root cause, not symptoms
  - ✅ No memory leaks after 4+ hours of load testing
  - ✅ Heap size growth < 5MB/hour (natural variance)
  - ✅ All event listeners properly cleaned up
  - ✅ No new memory leaks introduced
  - ✅ Backward compatible (no API changes)
  - ✅ Performance regression < 5% (P95 latency)
  
  ### Testing (Required)
  - ✅ Regression test that fails before fix, passes after
  - ✅ Load test runs for 4+ hours without issues
  - ✅ Heap snapshots show stable memory
  - ✅ All existing tests still pass
  - ✅ Test coverage maintained at 80%+
  
  ### Monitoring & Prevention (Required)
  - ✅ Added metrics for collection sizes
  - ✅ Added metrics for event listener counts
  - ✅ Alert configured for abnormal memory growth
  - ✅ Runbook updated with troubleshooting steps
  - ✅ Memory usage dashboard in DataDog
  
  ### Documentation (Required)
  - ✅ Root cause documented in Jira
  - ✅ Inline code comments explain fix
  - ✅ Post-mortem document created
  - ✅ Prevention measures documented
  - ✅ Team notified of fix and prevention strategies
  
  ### Deployment (Required)
  - ✅ Fix reviewed by 2+ senior engineers
  - ✅ Deployed to staging first
  - ✅ Monitored in staging for 2+ hours
  - ✅ Production deployment plan documented
  - ✅ Rollback plan prepared
  - ✅ On-call engineer notified
  
  ### Timeline (Critical)
  - ✅ Analysis complete within 1 hour
  - ✅ Fix implemented within 3 hours
  - ✅ Deployed to production within 4 hours
  - ✅ Memory stable after 24 hours in production

context:
  jira_ticket: "BUG-892"
  priority: "Critical"
  severity: "P1"
  sprint: "Sprint 24"
  type: "Production Bug"
  sla: "Fix within 4 hours"
  
incident_context:
  last_crash: "2 hours ago"
  frequency: "Every 24-36 hours"
  affected_users: "All users"
  business_impact: "Service unavailable during crashes"
  estimated_revenue_loss: "$5K per hour downtime"
  
expected_output:
  format: "root_cause_analysis_and_fix"
  priority_order:
    1: "root_cause_identification"
    2: "permanent_fix_implementation"
    3: "regression_tests"
    4: "monitoring_and_alerts"
  documentation: "detailed_rca_and_postmortem"
```

## Expected AI Response Structure

The AI should provide:

1. **Root Cause Analysis:**
   - Exact code causing the leak
   - Explanation of the mechanism
   - Evidence (heap snapshot analysis)
   - When it was introduced

2. **Fix Implementation:**
   - Modified code with proper cleanup
   - Before/after comparison
   - Explanation of changes

3. **Regression Test:**
   - Test that reproduces the leak
   - Validates the fix works
   - Can be run in CI/CD

4. **Monitoring Setup:**
   - Metrics to track
   - Alert thresholds
   - Dashboard updates

5. **Documentation:**
   - Inline code comments
   - Jira update template
   - Post-mortem outline

## Post-Fix Checklist

- [ ] Root cause clearly identified and documented
- [ ] Fix implemented and code reviewed
- [ ] Regression test added and passing
- [ ] Load tested for 4+ hours with stable memory
- [ ] Monitoring and alerts configured
- [ ] Deployed to staging and validated
- [ ] Production deployment completed
- [ ] Memory monitored for 24+ hours post-deployment
- [ ] Post-mortem document completed
- [ ] Team retrospective scheduled
- [ ] Jira ticket updated and closed

## Monitoring After Deploy

```yaml
monitoring_plan:
  immediate_checks:
    - Memory usage every 5 minutes
    - Event listener counts
    - Response time P95/P99
    - Error rate
  
  24_hour_validation:
    - Memory growth trend < 5MB/hour
    - No abnormal heap snapshots
    - No new errors in logs
    - Customer complaints = 0
  
  long_term:
    - Weekly memory usage review
    - Monthly heap snapshot analysis
    - Quarterly performance audit
```

## Post-Mortem Template

```markdown
# Post-Mortem: BUG-892 Memory Leak

## Incident Summary
- **Date:** [Date]
- **Duration:** [Hours]
- **Impact:** [Number] users affected
- **Downtime:** [Hours] total

## Root Cause
[Detailed explanation of what caused the leak]

## Timeline
- 5 days ago: Feature X deployed
- 2 days ago: First memory leak observed
- Today 10:23 AM: Production crash
- Today 2:45 PM: Fix deployed

## Resolution
[What was done to fix it]

## Lessons Learned
1. [Lesson 1]
2. [Lesson 2]

## Action Items
- [ ] [Prevention measure 1]
- [ ] [Prevention measure 2]
```

---

**Example Version:** 1.0  
**Last Updated:** January 2025  
**Use Case:** Critical Production Bug Fix
