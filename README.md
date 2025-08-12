# Python Healthcare Dev - AI Context Framework

This repository provides a structured set of resources designed to transform general-purpose AI coding assistants from "confused interns" into context-aware "senior engineers" for your software projects.

By providing a well-defined framework of project conventions, architectural patterns, and specialized instructions, you can significantly improve the quality, consistency, and relevance of AI-generated code and analysis.

## Core Philosophy

AI assistants excel when given clear, structured, and accessible context. This project is built on the principle that by "prompt-engineering" the AI's environment with key project documents, we can elevate its understanding from basic task execution to strategic contribution. The resources herein are designed to be the "onboarding guide" for any AI agent joining your project.

## Quick Start: Injecting Context

To use this framework in your own project, navigate to your project's root directory and run one of the commands below. This will download the `prompt-engineering` directory and its contents, making them available to your AI tools.

### Option 1: Interactive Setup (Recommended)

```bash
# Run from your project's root directory
curl -sSL https://raw.githubusercontent.com/addaguob/healthcare-engineering/main/setup.sh | bash
```

This interactive setup script will:
- Check if you're in a project root directory
- Handle existing installations gracefully
- Download only the prompt-engineering framework
- Create a CLAUDE.md file if it doesn't exist
- Provide helpful next steps and available resources

### Option 2: Manual Installation

```bash
# Run from your project's root directory
curl -L https://github.com/addaguob/healthcare-engineering/archive/refs/heads/main.tar.gz | tar -xz --strip-components=1 healthcare-engineering-main/prompt-engineering
```

## Recommended Technology Stacks

This framework is agnostic but provides guidance for common deployment targets. The included `deployment_strategy_agent.md` helps AI agents recommend the right tools for the job.

### ASGI Hosts (e.g., Fly.io)

For modern, asynchronous server gateway interface (ASGI) hosting platforms, the recommended stack is:

-   **UI Framework**: NiceGUI - A high-level, Python-based framework for building web UIs with a gentle learning curve.
-   **API Framework**: FastAPI - A modern, fast (high-performance) web framework for building APIs with Python 3.7+ based on standard Python type hints.
-   **Database Toolkit**: SQLModel - A library for interacting with SQL databases from Python code, with Python objects. It is designed to be intuitive, easy to use, highly compatible, and robust.

This stack is ideal for applications that require high performance and can leverage asynchronous programming.

### WSGI Hosts (e.g., PythonAnywhere)

For traditional web server gateway interface (WSGI) hosting platforms, the recommended stack is:

-   **UI Framework**: Taipy - A low-code Python library for building full-stack web applications.
-   **API Framework**: Flask - A lightweight WSGI web application framework. It is designed to make getting started quick and easy, with the ability to scale up to complex applications.
-   **Database Toolkit**: SQLModel - SQLModel can also be used in a WSGI context, providing a consistent data access layer across different deployment environments.

This stack is well-suited for applications that need to run in a more traditional, synchronous environment.

## How It Works

The core of this project is the `/prompt-engineering` directory. It contains specialized resources that an AI can reference to understand:

-   **Agent Personas**: How to act (e.g., as a `database-architect` or `healthcare-validator`).
-   **Commands**: How to perform specific, recurring tasks (e.g., `hipaa-check` or `deploy-check`).
-   **Project Conventions**: The specific rules of your project, from API naming to clinical data mapping.

By including these files in your interactions with AI assistants (e.g., through Claude's context or VS Code's agent settings), you provide the necessary guardrails and knowledge for them to perform at a much higher level.

## Contributing

Contributions to improve and expand this framework are welcome. Please feel free to open an issue or submit a pull request.