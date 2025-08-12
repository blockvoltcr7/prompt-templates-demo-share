## 🎯 Purpose

Generate a comprehensive GitHub Copilot instruction system that includes multiple specialized files for maximum organizational value and SDLC coverage.

## 🏗️ Multi-File Architecture

Based on the latest GitHub Copilot capabilities, we can now create:

### Core Instruction Files

- **`.github/copilot-instructions.md`** - Main repository instructions (works everywhere)
- **`.github/instructions/*.instructions.md`** - Specialized instruction files with targeting
- **`.github/prompts/*.prompt.md`** - Reusable prompt files for common tasks

### Organizational Benefits

- ✅ **Cross-IDE Compatibility** - Works in VS Code, Visual Studio, JetBrains, GitHub.com
- ✅ **Granular Control** - Different instructions for different code areas
- ✅ **Reusable Prompts** - Standardized workflows across teams
- ✅ **Version Controlled** - Track changes and share across organization

## 📝 Primary Prompt Template (Main Instructions File)

```
@workspace Please analyze this codebase and generate a comprehensive GitHub Copilot instruction system with multiple specialized files that will guide GitHub Copilot to produce code consistent with this project's patterns, conventions, and architecture.

## Analysis Requirements

### 1. Project Technology Stack Analysis
Examine and document:
- **Framework version**: [Identify exact Spring Boot version from pom.xml/build.gradle]
- **Java version**: [Check from build files and source compatibility]
- **Build tool**: [Maven or Gradle, include version]
- **Database technology**: [JPA provider, database type from dependencies/config]
- **Testing frameworks**: [JUnit version, Mockito, TestContainers, etc.]
- **Additional libraries**: [Security, validation, documentation tools, etc.]
- **Cloud/deployment tools**: [Docker, Kubernetes, cloud SDKs]

### 2. Package Structure Analysis
Map the actual package organization:
- Examine `src/main/java/[base-package]/` structure
- Identify layer separation patterns (controller, service, repository, etc.)
- Note any domain-driven design or modular patterns
- Document naming conventions used across packages

### 3. Code Pattern Analysis
Review existing code to identify:

**Entity Patterns:**
- JPA annotation usage patterns
- Lombok usage (which annotations are preferred)
- Inheritance patterns (mapped superclass, table per class, etc.)
- Audit field patterns
- Validation annotation preferences

**Controller Patterns:**
- REST endpoint design patterns
- Response wrapper patterns (ResponseEntity usage)
- Error handling approach
- OpenAPI/Swagger annotation usage
- Validation patterns (@Valid, @Validated usage)

**Service Layer Patterns:**
- Interface usage (do services have interfaces?)
- Transaction management patterns
- Error handling and exception patterns
- Business logic organization

**Repository Patterns:**
- Spring Data JPA usage patterns
- Custom query patterns (JPQL, native, Criteria)
- Repository inheritance patterns

**Configuration Patterns:**
- Configuration class organization
- Property binding patterns (@ConfigurationProperties usage)
- Profile usage patterns

### 4. Testing Patterns Analysis
Examine test code for:
- Test class naming conventions
- Test method naming patterns
- Mocking strategies (Mockito patterns)
- Integration test approaches
- Test data setup patterns

### 5. Code Style Analysis
Identify:
- Naming conventions actually used
- Import organization preferences
- Code formatting patterns
- Comment and documentation patterns
- Method organization within classes

## Generation Instructions

Create a complete GitHub Copilot instruction system with the following files:

### 1. **Main Instructions File** (`.github/copilot-instructions.md`)
The primary instruction file that works across all GitHub Copilot environments:

- **Project Overview**: Brief description of what this specific project does
- **Technology Stack**: Exact versions and dependencies found
- **General Coding Standards**: Universal patterns that apply everywhere
- **Architecture Guidelines**: Overall system design principles
- **Security & Best Practices**: Security patterns and quality standards

### 2. **Specialized Instruction Files** (`.github/instructions/`)
Create targeted instruction files using YAML frontmatter for specific areas:

**`.github/instructions/backend-api.instructions.md`**
```yaml
---
applyTo: "src/main/java/**/*.java"
description: "Backend API development standards"
---

```

- Controller, Service, Repository patterns
- JPA and database interaction standards
- API design and REST principles
- Error handling and validation

**`.github/instructions/testing.instructions.md`**

```yaml
---
applyTo: "src/test/**/*.java"
description: "Testing standards and patterns"
---

```

- Unit test patterns and naming
- Integration test approaches
- Mocking strategies and test data setup
- Test organization and structure

**`.github/instructions/configuration.instructions.md`**

```yaml
---
applyTo: "src/main/java/**/*Config*.java,src/main/resources/**"
description: "Configuration and properties management"
---

```

- Configuration class patterns
- Properties management
- Profile-specific configurations
- Bean definition standards

### 3. **Reusable Prompt Files** (`.github/prompts/`)

Create task-specific prompt files for common development activities:

**`.github/prompts/create-rest-endpoint.prompt.md`**

```yaml
---
mode: 'agent'
description: 'Generate a new REST endpoint following project patterns'
---

```

**`.github/prompts/generate-unit-tests.prompt.md`**

```yaml
---
mode: 'agent'
description: 'Generate comprehensive unit tests for selected code'
---

```

**`.github/prompts/code-review.prompt.md`**

```yaml
---
mode: 'ask'
description: 'Perform code review following project standards'
---

```

**`.github/prompts/refactor-service.prompt.md`**

```yaml
---
mode: 'agent'
description: 'Refactor service class following best practices'
---

```

## Output Requirements

1. **Be Specific**: Use patterns actually present in THIS codebase, not generic advice
2. **Include Real Examples**: Use actual class names, package names, and patterns from the analyzed code
3. **Reference Actual Dependencies**: Only mention libraries and versions actually in use
4. **Reflect Real Structure**: Mirror the actual package organization and naming found
5. **Capture Unique Patterns**: Include any custom or unusual patterns specific to this project
6. **Enable Reusability**: Create templates that can be easily adapted to similar projects

## Enterprise Benefits

This multi-file approach provides:

- **Granular Control**: Different rules for different code areas
- **Team Consistency**: Standardized prompts across developers
- **Knowledge Sharing**: Reusable patterns across projects
- **SDLC Coverage**: Templates for all development phases
- **Maintainability**: Easier to update specific rules without affecting others

Generate all the instruction and prompt files with their complete content now.

```

## 🔧 Usage Instructions

### Step 1: Copy the Prompt
Copy the entire prompt template above

### Step 2: Execute in GitHub Copilot
1. Open VS Code with the target Spring Boot project
2. Open GitHub Copilot Chat
3. Paste the prompt template
4. Wait for analysis and generation

### Step 3: Review and Refine
- Verify the generated instructions match your project
- Add any organization-specific standards not captured
- Test with a few code generation requests to validate effectiveness

### Step 4: Commit to Repository
Save the generated content as `.github/copilot-instructions.md` in your project root

## 🎯 Expected Outcomes

This template will generate:
- ✅ Project-specific coding standards
- ✅ Accurate technology stack documentation
- ✅ Real package structure guidance
- ✅ Actual code pattern examples
- ✅ Relevant testing approaches
- ✅ Customized configuration patterns

## 🔄 Reusability Notes

This prompt template can be used across:
- Different Spring Boot projects
- Various Java versions and dependencies
- Different organizational standards
- Multiple team coding styles

Each execution will produce a unique, project-specific instruction file that accurately reflects the actual codebase patterns rather than generic best practices.

```

https://code.visualstudio.com/docs/copilot/copilot-customization