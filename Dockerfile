FROM maven:3.5-jdk-8 as BUILD
COPY src /usr/src/myapp/src
COPY pom.xml /usr/src/myapp/pom.xml
RUN mvn install
#Download all required dependencies into one layer
RUN mvn clean install
# Build application
RUN mvn package

FROM tomcat:7.0
COPY --from=BUILD /usr/src/myapp/target/project-ucll.war /usr/local/tomcat/webapps/ROOT.war
EXPOSE 8080 
