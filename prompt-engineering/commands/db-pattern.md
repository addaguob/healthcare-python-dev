# Database Pattern Check

## Description
Validate SQLModel database patterns and healthcare data modeling standards.

## Usage
Use when implementing or reviewing database models to ensure SQLModel best practices.

## Prompt
Review this database implementation for SQLModel healthcare patterns:

1. **Model Definition**: Verify singular class names (`Patient`, `Assessment`) 
2. **Table Names**: Confirm singular table names (auto-generated or explicit)
3. **Relationships**: Check proper foreign keys and back-references
4. **Validation**: Ensure Pydantic Field constraints for medical data
5. **HIPAA Compliance**: Verify no PHI storage (initials only for patients)
6. **Session Management**: Confirm fresh sessions for parameter-based pages
7. **Pure SQLModel**: Ensure no raw SQL queries, only Pythonic operations

Reference database model patterns and SQLModel implementation guidelines.