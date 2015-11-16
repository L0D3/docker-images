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
