# API Standards Check

## Description
Validate FastAPI endpoints follow healthcare RESTful standards and naming conventions.

## Usage
Use when implementing or reviewing API endpoints to ensure consistency with healthcare application standards.

## Prompt
Review this API implementation for healthcare standards compliance:

1. **Resource Naming**: Verify plural endpoints (`/api/patients/`, `/api/assessments/`)
2. **HTTP Methods**: Confirm proper verb usage (GET, POST, PUT, DELETE)
3. **Status Codes**: Validate appropriate responses (200, 201, 404, 422, 500)
4. **Authentication**: Check role-based access for healthcare data
5. **Validation**: Ensure Pydantic models for request/response validation
6. **Error Handling**: Verify comprehensive error messages for clinical context
7. **Documentation**: Confirm OpenAPI docs generated with healthcare descriptions

Reference API naming conventions and ensure alignment with data model class names.