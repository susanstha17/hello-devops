FROM tomcat:9.0
ARG PROJDIR="/usr/local/tomcat/webapps/"
WORKDIR $PROJDIR
ADD **/*.war $PROJDIR/ROOT.war
EXPOSE 8080
CMD [ "catalina.sh","run" ]