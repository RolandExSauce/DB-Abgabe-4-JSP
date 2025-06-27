# Java JSP Web Application

This is a basic Java web application project generated using the Maven `maven-archetype-webapp` archetype.  
It uses JSP (JavaServer Pages) and is configured to run with an embedded Tomcat 9 Maven plugin.

## 📁 Project Structure

* when done add image here about project struct 


## ⚙️ Generate Project

This project was created using the following Maven command:

mvn archetype:generate -DarchetypeGroupId=org.apache.maven.archetypes -DarchetypeArtifactId=maven-archetype-webapp -DarchetypeVersion=1.4

src: https://code.visualstudio.com/docs/java/java-webapp


# to run locally with Embedded Tomcat Server, plugin was added in POMXL


# cmd to start tomcat server: mvn tomcat9:run

.) Open your browser and navigate to: http://localhost:8080/


# 🧱 Build WAR

To build a .war file for deployment to a standalone server:
mvn clean package
This creates a target/<artifactId>.war file you can deploy to any Servlet container (e.g. Apache Tomcat).

📋 Requirements

.) Java 8 or higher

.) Maven 3.x


