FROM tomcat:10.1.35-jdk17

ARG PROJDIR="/usr/local/tomcat/webapps/"

USER root
RUN apt-get update && apt-get upgrade -y && \
    apt-get install -y sudo && \
    useradd -m -s /bin/bash susan && echo "susan:susan" | chpasswd && \
    usermod -aG sudo susan && \
    chown -R susan:susan $PROJDIR && \
    rm -rf /var/lib/apt/lists/*  # Reduce image size

USER susan
WORKDIR $PROJDIR

COPY **/*.war $PROJDIR/ROOT.war

EXPOSE 8080
CMD ["catalina.sh", "run"]
