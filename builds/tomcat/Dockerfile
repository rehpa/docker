FROM dtr.dts.utah.gov/mluce/centos:latest 
MAINTAINER Luce <mluce@utah.gov>
RUN yum -y update && \
yum install wget -y && \
wget --header "Cookie: oraclelicense=accept-securebackup-cookie" http://download.oracle.com/otn-pub/java/jdk/8u144-b01/090f390dda5b47b9b721c7dfaa008135/jdk-8u144-linux-x64.rpm -O /tmp/jdk.rpm && \
yum localinstall /tmp/jdk.rpm -y && \
wget ftp://apache.cs.utah.edu/apache.org/tomcat/tomcat-9/v9.0.1/bin/apache-tomcat-9.0.1.tar.gz -O /tmp/tomcat.tar.gz && \
groupadd tomcat && \
useradd -s /bin/false -g tomcat -d /opt/tomcat tomcat && \
mkdir -p /opt/tomcat/ && \
tar -xzvf /tmp/tomcat.tar.gz --strip-components=1 -C /opt/tomcat && \
rm -rf /opt/tomcat/webapps/examples /opt/tomcat/webapps/ROOT /opt/tomcat/webapps/docs && \
chown -hR tomcat: /opt/tomcat && \
rm -f /tmp/tomcat.tar.gz /tmp/jdk.rpm && \
yum clean all && \
mkdir /nfsmount

HEALTHCHECK --interval=30s --timeout=20s --start-period=1m CMD curl --fail http://localhost:8080/ || exit 1
COPY artifactory-get.sh /
COPY startup.sh /
CMD ["/startup.sh"]


