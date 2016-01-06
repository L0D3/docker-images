FROM debian:jessie
Maintainer serenedocker


Run mkdir -p /shared
# Kafka
ENV KAFKA /tmp/kafka-logs
ENV ZOOKEEPER /tmp/zookeeper
Run mkdir -p $KAFKA
Run mkdir -p $ZOOKEEPER
VOLUME $KAFKA
VOLUME $ZOOKEEPER
RUN ln -s $ZOOKEEPER /shared/ 
RUN ln -s $KAFKA /shared/ 

# Elasticsearch
ENV ELASTIC_HOME /usr/share/elasticsearch/data
RUN mkdir -p $ELASTIC_HOME
RUN ln -s  $ELASTIC_HOME /shared/elasticsearch
VOLUME $ELASTIC_HOME

# Mysql
ENV MYSQL /var/lib/mysql
RUN mkdir -p $MYSQL
RUN ln -s  $MYSQL /shared/
VOLUME $MYSQL

# Jenkins
ENV JENKINS /var/jenkins_home
Run mkdir -p $JENKINS
Run chown -R  1000:1000 $JENKINS
RUN ln -s  $JENKINS /shared/
VOLUME $JENKINS


# Postgresql
ENV postgresql /var/lib/postgresql
Run mkdir -p $postgresql
VOLUME $postgresql
RUN ln -s $postgresql /shared/

# Jira
ENV JIRA_HOME /var/atlassian/jira
RUN mkdir -p $JIRA_HOME
Run chmod 700 $JIRA_HOME
Run chown -R daemon:daemon $JIRA_HOME
VOLUME $JIRA_HOME
RUN ln -s $JIRA_HOME /shared/


# Confluence
ENV CONFLUENCE_HOME /var/atlassian/confluence
Run mkdir -p $CONFLUENCE_HOME
RUn chmod -R 700 $CONFLUENCE_HOME
Run chown -R daemon:daemon $CONFLUENCE_HOME
VOLUME $CONFLUENCE_HOME
RUN ln -s /shared/ $CONFLUENCE_HOME


VOLUME /shared
