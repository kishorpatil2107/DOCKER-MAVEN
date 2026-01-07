# Docker-Maven Java App

A simple Java application built with Maven and containerized using Docker, upgraded to Java 21 LTS.

## Features

- Java 21 runtime
- Maven for build management
- Multi-stage Docker build for optimized image size
- Simple HTTP server responding with "Hello World!"
- Non-root user for security

## Prerequisites

- Docker
- Maven (for local builds)
- Java 21 (optional, for local development)

## Project Structure

```
.
├── Dockerfile          # Multi-stage Docker build
├── my-app/             # Maven project
│   ├── pom.xml         # Maven configuration
│   └── src/
│       └── main/java/com/example/App.java  # Main application
└── README.md           # This file
```

## Build and Run

### Using Docker (Recommended)

1. Build the Docker image:
   ```bash
   docker build -t maven-app:21 .
   ```

2. Run the container:
   ```bash
   docker run -d -p 8081:8080 maven-app:21
   ```

3. Access the app at http://localhost:8081/

### Local Development

1. Build the project:
   ```bash
   cd my-app
   mvn clean package
   ```

2. Run the JAR:
   ```bash
   java -jar target/my-app-1.0-SNAPSHOT.jar
   ```

3. Access at http://localhost:8080/

## API

- GET / : Returns "Hello World!"

## Technologies

- Java 21
- Maven 3.9+
- Eclipse Temurin JDK
- Docker

## Contributing

1. Fork the repository
2. Create a feature branch
3. Commit your changes
4. Push to the branch
5. Create a Pull Request

## License

This project is open source. Feel free to use and modify.