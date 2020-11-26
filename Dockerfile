FROM maven:3.5-jdk-8 as BUILD
COPY src /usr/src/myapp/src
COPY pom.xml /usr/src/myapp
RUN mvn install
#Download all required dependencies into one layer
RUN mvn -B dependency:resolve dependency:resolve-plugins
# Build application
RUN mvn package

FROM tomcat:7.0
COPY --from=BUILD /usr/src/myapp/target/project-ucll.war /usr/local/tomcat/webapps/ROOT.war
EXPOSE 8080 
