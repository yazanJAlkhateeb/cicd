FROM progressoft/tomcat-sql5:alpine8-latest
ARG  PSCI_VERSION=1.0
ENV  VERSION=${PSCI_VERSION}
USER root

RUN  printf "║ %-25s │ %-25s ║\n" "core" ${VERSION} >> /VERSION_INFO; \
     chown -R nobody:nobody /VERSION_INFO

COPY --chown=nobody:nobody artifacts/core-war-*.war /usr/local/tomcat/webapps/core.war
COPY --chown=nobody:nobody cicd/docker/entrypoint.sh                    /usr/local/tomcat/

RUN unzip -q /usr/local/tomcat/webapps/core.war -d                      /usr/local/tomcat/webapps/ROOT \
    && rm /usr/local/tomcat/webapps/core.war \
    && chown -R nobody:nobody /usr/local/tomcat \
    && chmod +x /usr/local/tomcat/*.sh 

WORKDIR /usr/local/tomcat/bin
CMD   ../entrypoint.sh
USER  nobody
