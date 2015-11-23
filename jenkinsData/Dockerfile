FROM debian:jessie
Maintainer serenedocker

# Jenkins
Run mkdir -p /shared/jenkins/data
Run ln -s /shared/jenkins/data /var/jenkins_home
Run chown -R  1000:1000 /shared/jenkins/data
VOLUME /var/jenkins_home
