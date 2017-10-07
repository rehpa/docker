FROM alpine:latest 
MAINTAINER Luce <mluce@utah.gov>
COPY id_maven_rsa /root/.ssh/id_maven_rsa
COPY config /root/.ssh/config
COPY known_hosts /root/.ssh/known_hosts
COPY startup.sh /startup.sh
RUN apk update && \
apk upgrade && \
apk add maven git openssh bash && \
chmod 600 /root/.ssh/* && \
chmod +x /startup.sh 
CMD ["/startup.sh"]

