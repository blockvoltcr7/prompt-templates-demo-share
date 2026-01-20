---
name: deploy-edge-function
description: Deploy Supabase Edge Functions to production. Use when the user wants to deploy an edge function to Supabase.
allowed-tools: Bash, Glob, AskUserQuestion, Read
---

# Deploy Supabase Edge Function Skill

## Overview
This skill helps deploy Supabase Edge Functions to production using the Supabase CLI. It discovers available functions, prompts the user to select which one to deploy, and handles the deployment process.

## Workflow

### Step 1: Discover Available Functions
List all edge functions in the `apps/web/supabase/functions/` directory:

```bash
ls apps/web/supabase/functions/
```

Filter out non-function directories (like `_shared`, documentation files, etc.)

### Step 2: Present Options to User
Use the AskUserQuestion tool to present the available functions and ask which one to deploy.

Example:
```
Available Edge Functions:
- ghl-program-webhook
- smoke-test
- [other functions]

Which function would you like to deploy?
```

### Step 3: Confirm Deployment Settings
Ask the user if they want to:
- Deploy with JWT verification (`--verify-jwt`, default)
- Deploy without JWT verification (`--no-verify-jwt`, for webhooks)

### Step 4: Deploy the Function
Execute the deployment command:

```bash
cd apps/web && supabase functions deploy <function-name> [--no-verify-jwt]
```

### Step 5: Confirm Success
After deployment:
- Display the function URL
- Show the dashboard link
- List any environment variables that need to be set

## Common Use Cases

### Deploying a Webhook Function (No JWT)
```bash
supabase functions deploy ghl-program-webhook --no-verify-jwt
```

**When to use `--no-verify-jwt`:**
- Webhook endpoints (Stripe, GoHighLevel, etc.)
- Public APIs that use custom authentication
- Functions that implement their own auth logic

### Deploying an Authenticated Function (Default)
```bash
supabase functions deploy my-function
```

**When to use default (JWT verification):**
- User-facing API endpoints
- Functions that require Supabase Auth
- Internal admin functions

## Environment Variables

After deployment, remind the user to check these environment variables are set:

**Common Variables:**
- `SUPABASE_URL` - Auto-configured
- `SUPABASE_SERVICE_ROLE_KEY` - Auto-configured
- Custom variables (function-specific)

**To set secrets:**
```bash
supabase secrets set MY_SECRET=value
```

**To list secrets:**
```bash
supabase secrets list
```

## Function Structure

Edge functions should be located in:
```
apps/web/supabase/functions/
├── _shared/           # Shared utilities (not deployed)
│   ├── cors.ts
│   └── response-helpers.ts
├── function-name/     # Individual function folder
│   ├── index.ts       # Main handler
│   └── _helpers.ts    # Function-specific helpers
├── COMMANDS.md        # Documentation
└── README.md          # Function documentation
```

## Dashboard Access

After deployment, functions can be managed at:
```
https://supabase.com/dashboard/project/PROJECT_REF/functions
```

## Troubleshooting

### Issue: "Cannot find project ref"
**Solution:**
```bash
supabase link --project-ref YOUR_PROJECT_REF
```

### Issue: "Module not found" errors
**Solution:** Ensure all imports use correct relative paths and shared files are in `_shared/`

### Issue: Function times out
**Solution:** Check function execution time limits (default: 2 minutes), optimize long-running operations

### Issue: Environment variables not set
**Solution:**
```bash
# List current secrets
supabase secrets list

# Set missing secret
supabase secrets set SECRET_NAME=value
```

## Best Practices

1. **Test locally first**: Always test with `supabase functions serve` before deploying
2. **Review changes**: Check git diff to understand what's being deployed
3. **Check logs**: Monitor function logs after deployment for errors
4. **Gradual rollout**: Test with low-traffic functions first
5. **Document secrets**: Keep a list of required environment variables

## Related Commands

```bash
# List all functions
supabase functions list

# Delete a function
supabase functions delete function-name

# View function logs
supabase functions logs function-name

# Serve locally
supabase functions serve function-name

# Download function code
supabase functions download function-name
```

## Security Considerations

- **JWT Verification**: Only disable for functions with custom authentication
- **Secrets Management**: Never commit secrets to git
- **CORS Configuration**: Only allow necessary origins
- **Rate Limiting**: Consider implementing rate limits for public endpoints
- **Input Validation**: Always validate and sanitize inputs
