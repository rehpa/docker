FROM centos:latest 
MAINTAINER Luce <junk@598north.com>
COPY MariaDB.repo /etc/yum.repos.d/
RUN yum -y update && \
    yum -y install MariaDB-server MariaDB-client && \
    yum clean all && \
    /sbin/usermod -u 65534 mysql && \
    /sbin/groupmod -g 65534 mysql && \
    rm -rf /var/lib/mysql/* && \
    touch /var/lib/mysql/donotremove.txt
COPY startup.sh /
CMD ["/startup.sh"]


