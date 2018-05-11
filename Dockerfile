FROM jenkinsci/jenkins:2.107.3
# if we want to install via apt
USER root
COPY docker_gpg /tmp/docker_gpg
RUN apt update && apt install -y git curl software-properties-common apt-transport-https && \
    cat /tmp/docker_gpg | apt-key add - && rm -f /tmp/docker_gpg && \
    add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/debian $(lsb_release -cs) stable" && \
    apt update && apt install docker-ce=17.06.2~ce-0~debian docker-compose -y && \
    chmod 4755 `whereis docker-compose` && chmod 4755 `whereis docker` && \
    echo "jenkins ALL=NOPASSWD: `whereis docker-compose`,`whereis docker`" >> /etc/sudoers && \
    apt clean autoclean && apt autoremove --yes && rm -rf /var/lib/{apt,dpkg,cache,log}/

# drop back to the regular jenkins user - good practice
USER jenkins
