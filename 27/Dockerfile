FROM jetty:12.0.22-jdk17-al2023-amazoncorretto

# enable automatic WAR deployment + EE10 servlet/JSP support
RUN java -jar /usr/local/jetty/start.jar \
        --add-modules=deploy,ee10-webapp

# copy the freshly-built WAR (context path “/”)
COPY target/my-jsp-app.war /var/lib/jetty/webapps/
