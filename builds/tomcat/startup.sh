#!/bin/bash

: "${REPOURL:?Need to set REPOURL non-empty}"
: "${GROUP:?Need to set GROUP non-empty}"
: "${ARTIFACT:?Need to set ARTIFACT non-empty}"
: "${APIKEY:?Need to set APIKEY non-empty}"
secretapikey=$(head -n 1 "${APIKEY}")
./artifactory-get.sh -r "${REPOURL}" -g "${GROUP}" -a "${ARTIFACT}" -k $secretapikey
rm -rf /opt/tomcat/webapps/ROOT*
mv root.war /opt/tomcat/webapps/ROOT.war
exec /opt/tomcat/bin/catalina.sh run
