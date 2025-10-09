# Automation Analysis Example Using the CREATE Framework

## Prompt Overview

This document provides an example of how to use the CREATE framework to analyze the automation suitability of a specific application. The example illustrates the application of the framework in a practical scenario, guiding QA engineers through the process of crafting effective prompts.

## Example Prompt

```yaml
prompt: |
  # E-commerce Platform Automation Analysis
  
  ## Character (C)
  Act as a senior QA automation consultant with over 10 years of experience in e-commerce platforms. You specialize in automation feasibility studies and have a deep understanding of both frontend and backend testing strategies.
  
  ## Request (R)
  Evaluate the automation suitability of key features in an e-commerce platform. For each feature, provide a recommendation on whether it should be automated, manually tested, or requires a hybrid approach. Justify your recommendations based on technical complexity, business impact, and maintenance considerations.
  
  ## Examples (E)
  Consider these scenarios when making your assessments:
  - Successful Automation: Checkout process with stable APIs and high regression risk
  - Unsuitable Automation: Customer service interactions requiring human empathy
  - Hybrid Approach: Product search functionality (API testing + manual UI validation)
  
  ## Application (A)
  The application is a high-traffic e-commerce platform serving millions of users with a diverse product catalog. The system architecture includes:
  - Frontend: Angular, Bootstrap, Progressive Web App (PWA)
  - Backend: Java Spring Boot, MySQL, Redis
  - Cloud: AWS, Docker, Kubernetes
  - Integrations: Payment gateways (Stripe, PayPal), shipping APIs, CRM systems
  
  ## Task (T)
  Assess automation suitability for the following features:
  1. User registration and login
  2. Product browsing and filtering
  3. Shopping cart management
  4. Checkout process
  5. Order tracking
  6. Customer reviews and ratings
  7. Promotional campaigns management
  8. Customer support chat
  
  ## Evaluation (E)
  A successful analysis should include:
  - Automation suitability rating (High/Medium/Low/Not Suitable) for each feature
  - Detailed technical feasibility assessment with identified challenges
  - Business impact analysis and ROI considerations
  - Recommendations for alternative testing strategies for features deemed unsuitable for automation
  - Maintenance complexity evaluation for automated features

context:
  domain: "e-commerce"
  complexity: "high"
  urgency: "strategic_planning"
  
expected_output:
  format: "detailed_analysis"
  length: "comprehensive"
  technical_depth: "thorough"
```

## Conclusion

This example demonstrates how to effectively utilize the CREATE framework for analyzing automation suitability in an e-commerce platform. By following the structured approach outlined in this prompt, QA engineers can generate actionable insights that inform their testing strategies and decisions.