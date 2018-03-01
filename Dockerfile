FROM jenkins/jenkins:2.89.4
# if we want to install via apt
USER root
RUN apt-get update && apt-get install -y git curl sudo python-pip libltdl7 && rm -rf /var/lib/apt/lists/* \
    && pip install docker-compose \
    && echo "jenkins ALL=NOPASSWD: /usr/bin/apt-get /usr/local/bin/docker-compose,/usr/bin/docker" >> /etc/sudoers
# drop back to the regular jenkins user - good practice
USER jenkins
