# Repository Agent Guidance

This repository contains a custom GitHub Copilot CLI performance testing workflow.

Use the `performance-test-engineer` custom agent for API performance testing, JMeter test planning, production traffic analysis, scenario modeling, and `.jmx` generation.

Use the `/jmeter-performance-test-planner` skill for the actual performance test planning workflow.

Do not calculate performance metrics manually.

Use the Python scripts bundled in the skill for all calculations.

Always ask whether the endpoint has one scenario or multiple request/payload scenarios.

Always produce the performance test plan first and stop for approval before generating `.jmx` files.
