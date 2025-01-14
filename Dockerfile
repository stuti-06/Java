# Use a base image with Java pre-installed (e.g., OpenJDK)
FROM openjdk:11-jre-slim

# Set the working directory inside the container
WORKDIR /app

# Copy your Java source file from GitHub (or local directory) into the container
COPY addition.java /app/addition.java

# Compile the Java file to produce a .class file
RUN javac addition.java

# Create a simple Jar file (if needed, you can skip this if it's a simple class app)
RUN echo "Main-Class: addition" > manifest.txt && jar cfm addition.jar manifest.txt addition.class

# Now, copy the JAR file into a Tomcat image if necessary
# You can use another Tomcat image if needed
FROM tomcat:9.0

# Copy the compiled JAR/WAR file to the Tomcat webapps directory
COPY --from=0 /app/addition.jar /usr/local/tomcat/webapps/yourapp.war

# Expose the port for Tomcat
EXPOSE 8080

# Start Tomcat
CMD ["catalina.sh", "run"]
