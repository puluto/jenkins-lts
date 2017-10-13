FROM jenkins/jenkins:lts
# if we want to install via apt
USER root
RUN apt-get update && apt-get install -y git curl sudo python-pip && rm -rf /var/lib/apt/lists/* \
    && pip install docker-compose \
    && echo "jenkins ALL=NOPASSWD: /usr/local/bin/docker-compose,/usr/bin/docker" >> /etc/sudoers
# drop back to the regular jenkins user - good practice
USER jenkins
