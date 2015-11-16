FROM debian:jessie
Maintainer serenedocker
Run apt-get update 
Run apt-get install -y curl wget git grep unzip

# JAVA 1.8
RUN \
echo oracle-java8-installer shared/accepted-oracle-license-v1-1 select true | debconf-set-selections && \
echo "deb http://ppa.launchpad.net/webupd8team/java/ubuntu trusty main" > /etc/apt/sources.list.d/webupd8team-java.list && \
echo "deb-src http://ppa.launchpad.net/webupd8team/java/ubuntu trusty main" >> /etc/apt/sources.list.d/webupd8team-java.list && \
apt-key adv --keyserver keyserver.ubuntu.com --recv-keys EEA14886 && \
apt-get update && \
apt-get install -y oracle-java8-installer 

# Define commonly used JAVA_HOME variable
ENV JAVA_HOME /usr/lib/jvm/java-8-oracle

# ConfluentInc
RUN \
cd / && \
wget http://packages.confluent.io/archive/1.0/confluent-1.0.1-2.10.4.zip && \
unzip confluent-1.0.1-2.10.4.zip   
Run rm confluent-1.0.1-2.10.4.zip
Run mv confluent* confluent

# Install supervisor
RUN apt-get install -y supervisor dnsutils
   

# Supervisor config
ADD supervisor/kafka.conf supervisor/confluent-schema.conf supervisor/zookeeper.conf /etc/supervisor/conf.d/


#CMD ["supervisord", "-n"]
