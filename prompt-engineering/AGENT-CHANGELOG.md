# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

```sample
## [Unreleased]

### Added

- **Room Number Field**: Added `room_number` to patient forms and models for better ICU workflow management.

### Changed

- **API Route Refactoring**: Refactored all UI routes in `your_app` to follow RESTful naming conventions for consistency and predictability.
- **Database Session Management**: Implemented a new strategy to create a new database session for each request involving URL parameters, enhancing data integrity.

## [1.0.1] - 2025-08-11

### Changed

- **Parameter Injection Implementation**: Implemented comprehensive NiceGUI parameter injection across all UI pages for clean architecture and better data integrity.
- **Navigation Pattern Refactoring**: Migrated from query parameters (`?patient=123`) to RESTful path parameters (`/patients/123`) across all navigation calls.
```