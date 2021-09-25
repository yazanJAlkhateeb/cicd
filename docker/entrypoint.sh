#!/bin/bash

if ! dbtool  $db_engine \
    --user   $db_user \
    --pass   $db_password \
    --host   $db_host \
    --port   $db_port \
    --inst   $db_instance \
    --test   JFW_USERS \
    --external $db_external \
    --rebuild true \
    --command "sh -c \"cd /usr/local/tomcat/webapps/ROOT/WEB-INF/lib && java -jar initializer-*.jar *domain*.jar\""

then
    echo "[JFW_ENTRY] Failed to dbtool"
    exit 1
fi
echo "############################# Running App Initialization script #############################"
sed -i 's@C:/temp@/tmp/communication-folders/core@g' /usr/local/tomcat/webapps/ROOT/WEB-INF/classes/config/product/camel/profiles/default/communication.properties
sed -i 's@C:/temp@/tmp/communication-folders/converter@g' /usr/local/tomcat/webapps/ROOT/WEB-INF/classes/config/product/camel/profiles/default/converter.properties
sed -i 's@C:/temp@/tmp/communication-folders/core@g' /usr/local/tomcat/webapps/ROOT/WEB-INF/classes/config/product/camel/profiles/default/core.properties
sed -i 's/setup.enabled=false/setup.enabled=true/g' /usr/local/tomcat/webapps/ROOT/WEB-INF/properties/startup.properties
sed -i 's/main.menu.style=horizontal/main.menu.style=vertical/g' /usr/local/tomcat/webapps/ROOT/WEB-INF/classes/config/core/system-generic.properties
sed -i 's@SRV_TENANT=SYSTEM@SRV_TENANT=PSYSJO@g' /usr/local/tomcat/webapps/ROOT/WEB-INF/classes/config/product/camel/profiles/default/core.properties


cd /usr/local/tomcat/bin || exit
catalina.sh jpda run
