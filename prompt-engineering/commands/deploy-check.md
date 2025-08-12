# Deployment Readiness Check

## Description
Validate production deployment readiness for healthcare application environment.

## Usage
Use before deploying to ensure healthcare-grade production configuration.

## Prompt
Perform deployment readiness check for healthcare production:

1. **Environment Config**: Verify production/development environment separation
2. **Secrets Management**: Check all sensitive data moved to environment variables
3. **Database Persistence**: Confirm Fly.io volume configuration for healthcare data
4. **Security Headers**: Validate HTTPS enforcement and security headers
5. **Health Checks**: Ensure endpoint monitoring for clinical availability
6. **Logging**: Configure appropriate log levels (no PHI in production logs)
7. **Performance**: Verify optimization for extended continuous healthcare usage

Reference deployment patterns in `fly.toml`, `Dockerfile`, and production environment configurations.