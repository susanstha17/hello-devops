FROM tomcat:9.0-alpine

ARG PROJDIR="/usr/local/tomcat/webapps/"
RUN adduser -D -s /bin/sh susan && echo "susan:susan" | chpasswd
USER susan
WORKDIR $PROJDIR

COPY **/*.war $PROJDIR/ROOT.war

EXPOSE 8080
CMD ["catalina.sh", "run"]
