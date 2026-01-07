#--------------------multistage build--------------------
#Stage 1: Build the application
FROM maven:3.9.12-eclipse-temurin-21 AS build
WORKDIR /app
#copy the pom.xml for dependency resolution
COPY my-app/pom.xml .
#download the dependencies
RUN mvn dependency:go-offline
#copy the source code
COPY my-app/src ./src
#package the application
RUN mvn package -DskipTests
#stage 2: Create the final image
FROM eclipse-temurin:21-jdk
# create a non root user for security
RUN groupadd -r appgroup && useradd -r appuser -g appgroup
#set the working directory ./   
WORKDIR /app
#copy the jar file from the build stage
COPY --from=build /app/target/*.jar /app/app.jar
#change ownership of the application files
RUN chown -R appuser:appgroup /app
USER appuser
#expose the application port
EXPOSE 8080
#specify the command to run the application
ENTRYPOINT ["java","-jar","/app/app.jar"]