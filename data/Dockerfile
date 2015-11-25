FROM debian:jessie
Maintainer serenedocker


# Kafka
Run mkdir -p /shared/kafka/data
Run mkdir -p /shared/zookeeper/data
Run ln -s /shared/kafka/data /tmp/kafka-logs
Run ln -s /shared/zookeeper/data /tmp/zookeeper
VOLUME /tmp/kafka-logs
VOLUME /tmp/zookeeper

# Elasticsearch
Run mkdir -p /shared/elasticsearch/data
RUN mkdir -p /usr/share/elasticsearch/
Run ln -s  /shared/elasticsearch/data /usr/share
VOLUME /usr/share/elasticsearch/data

# Mysql
Run mkdir -p /shared/mysql/data
RUN mkdir -p /var/lib/
Run ln -s  /shared/mysql/data /var/lib/mysql
VOLUME /var/lib/mysql

# Jenkins
Run mkdir -p /shared/jenkins/data
Run ln -s /shared/jenkins/data /var/jenkins_home
Run chown -R  1000:1000 /shared/jenkins/data
VOLUME /var/jenkins_home


# Postgresql
Run mkdir -p /shared/postgresql/data
Run ln -s /shared/postgresql/data /var/lib/postgresql
VOLUME /var/lib/postgresql

# Jira
ENV JIRA_HOME     /var/atlassian/jira
Run mkdir -p /shared/jira/data
Run mkdir -p /var/atlassian
Run mkdir -p /shared/jira/data/caches/indexes
RUn chmod -R 700 /shared/jira/data 
Run chown -R daemon:daemon /shared/jira/data
Run ln -s /shared/jira/data /var/atlassian/jira
VOLUME /var/atlassian/jira


# Confluence
Run mkdir -p /shared/confluence/data
RUn chmod -R 700 /shared/confluence/data 
Run chown -R daemon:daemon /shared/confluence/data
Run ln -s /shared/confluence/data /var/atlassian/confluence
VOLUME /var/atlassian/confluence


VOLUME /shared
