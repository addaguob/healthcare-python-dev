# Quick Test Runner

## Description
Run targeted tests for healthcare application functionality with appropriate markers.

## Usage
Use for rapid testing of specific healthcare features without running the full test suite.

## Prompt
Run focused tests for the current implementation (edit sample below):

```bash
# Healthcare-specific test categories
uv run python -m pytest healthcare_app/tests/ -m "healthcare" -v
uv run python -m pytest healthcare_app/tests/ -m "clinical" -v  
uv run python -m pytest healthcare_app/tests/ -m "healthcare_app" -v
uv run python -m pytest healthcare_app/tests/ -m "hipaa" -v

# Single test file for rapid feedback
uv run python -m pytest healthcare_app/tests/test_healthcare_app.py -v

# API endpoint testing
uv run python -m pytest healthcare_app/tests/ -m "api" -v
```

Focus on the most relevant test category for the current implementation and provide immediate feedback on healthcare functionality.