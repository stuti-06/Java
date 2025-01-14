# Step 1: Use a Maven image to build the application
FROM maven:3.8.1-openjdk-11-slim AS build

# Set the working directory in the container
WORKDIR /app

# Copy your pom.xml and the source code to the container
COPY pom.xml /app/
COPY src /app/src/

# Build the application and create a JAR file
RUN mvn clean package -DskipTests

# Step 2: Use an OpenJDK image to run the application
FROM openjdk:11-jre-slim

# Set the working directory in the container
WORKDIR /app

# Copy the JAR file created in the previous step to the container
COPY --from=build /app/target/addition-1.0-SNAPSHOT.jar /app/addition.jar

# Expose the port (optional, if you need to expose it)
EXPOSE 8080

# Command to run the JAR file
CMD ["java", "-jar", "addition.jar"]
