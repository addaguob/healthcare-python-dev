# Deployment Strategy Agent

This agent provides guidance on selecting the appropriate technology stack based on the target deployment environment.

## ASGI Hosts (e.g., Fly.io)

For modern, asynchronous server gateway interface (ASGI) hosting platforms, the recommended stack is:

-   **UI Framework**: [NiceGUI](https://nicegui.io/) - A high-level, Python-based framework for building web UIs with a gentle learning curve.
-   **API Framework**: [FastAPI](https://fastapi.tiangolo.com/) - A modern, fast (high-performance) web framework for building APIs with Python 3.7+ based on standard Python type hints.
-   **Database Toolkit**: [SQLModel](https://sqlmodel.tiangolo.com/) - A library for interacting with SQL databases from Python code, with Python objects. It is designed to be intuitive, easy to use, highly compatible, and robust.

This stack is ideal for applications that require high performance and can leverage asynchronous programming.

## WSGI Hosts (e.g., PythonAnywhere)

For traditional web server gateway interface (WSGI) hosting platforms, the recommended stack is:

-   **UI Framework**: [Taipy](https://www.taipy.io/) - A low-code Python library for building full-stack web applications.
-   **API Framework**: [Flask](https://flask.palletsprojects.com/) - A lightweight WSGI web application framework. It is designed to make getting started quick and easy, with the ability to scale up to complex applications.
-   **Database Toolkit**: [SQLModel](https://sqlmodel.tiangolo.com/) - SQLModel can also be used in a WSGI context, providing a consistent data access layer across different deployment environments.

This stack is well-suited for applications that need to run in a more traditional, synchronous environment.
