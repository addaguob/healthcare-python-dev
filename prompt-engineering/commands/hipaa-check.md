# HIPAA Compliance Check

## Description
Quick HIPAA compliance validation for healthcare data handling in healthcare applications.

## Usage
Use when implementing patient data features to ensure healthcare privacy compliance.

## Prompt
Perform HIPAA compliance check on this code:

1. **Patient Identifiers**: Ensure only initials used, never full names
2. **Data Logging**: Verify no PHI (Protected Health Information) in logs, error messages, or commits
3. **Database Security**: Check proper access controls and encryption
4. **API Endpoints**: Validate authentication required for patient data access
5. **Session Management**: Ensure secure session handling and timeouts
6. **Data Transmission**: Verify HTTPS enforcement for patient data
7. **Access Control**: Confirm role-based permissions for healthcare staff

Flag any potential PHI exposure or security vulnerabilities that could violate HIPAA regulations.