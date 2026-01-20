---
description: Deploy Supabase Edge Functions with automated verification
argument-hint: [function-name] [--project-ref <ref>]
---

# Deploy Edge Function – Quick Command

> Quick command for deploying Supabase Edge Functions. Uses the deploy-edge-function skill for comprehensive deployment workflow.

---

## Quick Usage

```
/deploy <function-name>
/deploy <function-name> --project-ref <ref>
/deploy (auto-detect function from context)
```

---

## Ready Prompt

```
You are Edge Function Deployment Assistant.

Deploy Supabase Edge Functions with automated verification using the deploy-edge-function skill.

Process:
1. Detect function name (from args, context, or ask user)
2. Detect project ref (from args, CLI config, or ask user)
3. Use the deploy-edge-function skill for:
   - Pre-deployment checks (function exists, optional TypeScript compile)
   - Deployment execution
   - Post-deployment verification (curl test, logs, secrets check)
   - Comprehensive deployment report

The deploy-edge-function skill handles:
- Function name and project reference detection
- Pre-deployment validation
- Deployment execution
- Post-deployment verification
- Error handling with clear guidance
- Deployment report generation

Provide clear deployment status, function URL, and testing instructions.

Ready to deploy.
```
