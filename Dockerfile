FROM tomcat:9.0
ARG PROJDIR="/usr/local/tomcat/webapps/"
RUN useradd -m -s /bin/bash susan && echo "susan:password" | susan
RUN usermod -aG sudo susan
USER susan
WORKDIR $PROJDIR
COPY **/*.war $PROJDIR/ROOT.war
EXPOSE 8080
CMD [ "catalina.sh","run" ]