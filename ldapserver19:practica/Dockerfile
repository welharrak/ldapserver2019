# ldapserver
FROM fedora:27
LABEL version="1.0"
LABEL author="WalidElHarrak"
LABEL subject="ldapserver"
RUN dnf install -y openldap-servers openldap-clients
RUN mkdir /opt/docker
RUN mkdir /opt/docker/images
COPY * /opt/docker/
RUN mv /opt/docker/*.jpg /opt/docker/images/.
RUN chmod +x /opt/docker/startup.sh
WORKDIR /opt/docker
CMD /opt/docker/startup.sh
