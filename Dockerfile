FROM maven:3.5-jdk-8 as BUILD
COPY src /usr/src/myapp/src
COPY pom.xml /usr/src/myapp
RUN mvn install

FROM tomcat:7.0
COPY --from=BUILD /usr/src/myapp/target/project-ucll.war /usr/local/tomcat/webapps/ROOT.war
EXPOSE 8080 
