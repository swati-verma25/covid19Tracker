FROM docker.optum.com/hkumar44/oracle_jdk:8_unlimited_jce_ubuntu_16.04

WORKDIR /opt/app
COPY target/covid19-0.0.1-SNAPSHOT.war /opt/app/app.war
RUN mkdir /opt/config && \
    chown -R 1001:1001 /opt/app /opt/config  && \
    chmod -R 777 /opt/app /opt/config
COPY src/main/resources/application.properties /opt/config/application.properties   
EXPOSE 8080
USER 1001
CMD ["java","-jar","app.war","--spring.config.location=file:/opt/config/application.properties"]