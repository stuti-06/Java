# Use a Tomcat base image 
FROM tomcat:9.0 

# Copy the WAR file into the webapps directory of Tomcat 
COPY target/addition-1.0.war /usr/local/tomcat/webapps/ 

# Expose Tomcat's default HTTP port 
EXPOSE 8080 

# Start Tomcat 
CMD ["catalina.sh", "run"] 

