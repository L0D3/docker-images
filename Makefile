# Makefile to build and run Docker Images for the Serene Project
# Maintainer: Johannes Lahann

# Global Vars

maintainer=serenedocker/
.DEFAULT_GOAL := run
rootDir=$(shell pwd)
dataDir=  ~/sereneDataFolder
backupDir=  ~/sereneBackup
init: 
	mkdir -p $(dataDir)
 

build: all-build

run: all-run

stop: all-stop

# All: {{{1
# ----------------------------------------------------------------------------

all-build: data-build  mysql-build kafka-build wildfly-build elastic-build 

all-run-split:
	tmux split-window -p 33 -h '$(mysql-run)' 
	tmux split-window -p 66 -v '$(elastic-run)'
	sleep 1
	tmux split-window  -v '$(wildfly-run)'
	tmux rotate -D
	tmux select-pane -t 2
	
all-run:	
	tmux new-window -n mysql '$(mysql-run)' 
	tmux new-window -n kafka '$(kafka-run)' 
	tmux new-window -n elastic '$(elastic-run)'
	sleep 1
	tmux new-window  -n wildfly '$(wildfly-run)'

all-stop: 
	docker stop wildfly mysql elastic client kafka

	 
# Wildfly: {{{1
# ----------------------------------------------------------------------------
sparkJobsDir=  "$(shell dirname "$(shell pwd)")/development/main/SparkJobs"
wildfly=$(maintainer)wildfly
wildfly-build:
	docker build  -t $(wildfly) wildfly

wildfly-run=docker run -v $(sparkJobsDir):/sparkJobs  --name wildfly -p 8080:8080 -p 9990:9990 -p 9090:9090 --link mysql --link kafka --link elastic --rm  $(wildfly) 
	
wildfly-run:
	$(wildfly-run)

wildfly-stop:
	docker stop wildfly
# Elastic Search: {{{1
# ----------------------------------------------------------------------------

elastic=$(maintainer)elastic

elastic-build:
	docker build -t $(elastic) elastic
elastic-run = docker run --name elastic --rm  $(elastic) --volumes-from data
elastic-run:
	$(elastic-run)

# Mysql: {{{1
# ----------------------------------------------------------------------------

mysql=$(maintainer)mysql

mysql-build:
	docker build -t $(mysql) mysql

mysql-run= docker run --name mysql --rm --volumes-from data  -e MYSQL_ROOT_PASSWORD=mysql $(mysql)
mysql-run:
	$(mysql-run)

# Data: {{{1
# ----------------------------------------------------------------------------

data=$(maintainer)data
date=$(shell date +%Y-%m-%d_%H_%M)
data-build:
	docker build -t $(data) data 

data-run= docker run  --name data $(data)
data-run:
	$(data-run)

data-backup-postgresql= docker run --volumes-from data -v $(backupDir):/backup ubuntu tar cvf /backup/postgresql_backup_$(date).tar /var/lib/postgresql
data-backup-mysql= docker run --volumes-from data -v $(backupDir):/backup ubuntu tar cvf /backup/mysql_backup_$(date).tar /var/lib/mysql
data-backup-kafka= docker run --volumes-from data -v $(backupDir):/backup ubuntu tar cvf /backup/kafka_backup_$(date).tar /tmp/kafka-logs
data-backup-elasticsearch= docker run --volumes-from data -v $(backupDir):/backup ubuntu tar cvf /backup/elasticsearch_backup_$(date).tar /usr/share/elasticsearch/data
data-backup-jenkins= docker run --volumes-from data -v $(backupDir):/backup ubuntu tar cvf /backup/jenkins_backup_$(date).tar /var/jenkins_home
data-backup-jira= docker run --volumes-from data -v $(backupDir):/backup ubuntu tar cvf /backup/jira_backup_$(date).tar /var/atlassian/jira
data-backup-confluence= docker run --volumes-from data -v $(backupDir):/backup ubuntu tar cvf /backup/confluence_backup_$(date).tar /var/atlassian/confluence
data-backup:
	$(data-backup-postgresql)
	$(data-backup-mysql)
	$(data-backup-kafka)
	$(data-backup-elasticsearch)
	$(data-backup-jenkins)
	$(data-backup-jira)
	$(data-backup-confluence)

data-rm: docker rm data

# Client: {{{1
# ----------------------------------------------------------------------------

client=$(maintainer)client

client-build:
	docker build -t $(client) client 

client-run= docker run --link kafka --link wildfly --link mysql --link elastic --volumes-from data --rm -it  $(client)
client-run:
	$(client-run)
		
# Kafka: {{{1
# ----------------------------------------------------------------------------

kafka=$(maintainer)kafka

kafka-build:
	docker build -t $(kafka) kafka 

kafka-run= docker run --rm --volumes-from data --name kafka --env ADVERTISED_PORT=9092 --env ADVERTISED_HOST=kafka $(kafka) supervisord -n 
kafka-run:
	$(kafka-run)

kafka-client-run= docker run --rm --link kafka -it  $(client) bash

kafka-server-run= docker run --name kafka --rm -it  $(client)
kafka-server-run:
	$(kafka-server-run)

kafka-client-run:
	$(kafka-client-run)

# Spark: {{{1
# ----------------------------------------------------------------------------
spark-run=docker run -v $(sparkJobsDir):/sparkJobs -it  --link mysql --link kafka --link elastic --rm  $(wildfly) bash
spark-run:
	$(spark-run)

# Jenkins: {{{1
# ----------------------------------------------------------------------------
jenkins=$(maintainer)jenkins
jenkins-build:
	docker build  -t $(jenkins) jenkins

jenkins-run= docker run  -e VIRTUAL_PORT=8080 -e VIRTUAL_HOST=jenkins.willie.iwi.uni-sb.de --link wildfly --rm -it --volumes-from data --name  jenkins $(jenkins)

jenkins-run:
	$(jenkins-run)


# Jira: {{{1
# ----------------------------------------------------------------------------
jira=$(maintainer)jira
jira-build:
	docker build  -t $(jira) jira

jira-run= docker run --rm --volumes-from data -e VIRTUAL_HOST=jira.willie.iwi.uni-sb.de --link postgresql --name jira $(jira)

jira-run:
	$(jira-run)

# Confluence: {{{1
# ----------------------------------------------------------------------------
confluence=$(maintainer)confluence
confluence-build:
	docker build  -t $(confluence) confluence

confluence-run= docker run  --rm --volumes-from data  -e VIRTUAL_HOST=confluence.willie.iwi.uni-sb.de --link postgresql --name confluence $(confluence)

confluence-run:
	$(confluence-run)

# Apache: {{{1
# ----------------------------------------------------------------------------
apache=$(maintainer)apache
apache-build:
	docker build  -t $(apache) apache

apache-run= docker run  --publish 8070:80 -it --name apache $(apache) bash

apache-run:
	$(apache-run)
	 

# Postgresql: {{{1
# ----------------------------------------------------------------------------
postgresql=$(maintainer)postgresql
postgresql-build:
	docker build  -t $(postgresql) postgresql

postgresql-run= docker run --name postgresql --rm --volumes-from data $(postgresql)

postgresql-run:
	$(postgresql-run)
	 



# Trac: {{{1
# ----------------------------------------------------------------------------
trac=$(maintainer)trac
trac-build:
	docker build  -t $(trac) trac

trac-run= docker run --rm --volumes-from data --publish 8889:80 --link postgresql --name trac $(trac)

trac-run:
	$(trac-run)
# Nginxproxy: {{{1
# ----------------------------------------------------------------------------
nginxproxy=$(maintainer)nginxproxy
nginxproxy-build:
	docker build  -t $(nginxproxy) nginxproxy

nginxproxy-run= docker run   --rm  --publish 80:80   -v /var/run/docker.sock:/tmp/docker.sock:ro --name nginxproxy $(nginxproxy)

nginxproxy-run:
	$(nginxproxy-run)
# Phpmyadmin: {{{1
# ----------------------------------------------------------------------------
phpmyadmin=$(maintainer)phpmyadmin
phpmyadmin-build:
	docker build  -t $(phpmyadmin) phpmyadmin

phpmyadmin-run= docker run   --rm  -e VIRTUAL_HOST=phpmyadmin.willie.iwi.uni-sb.de -e MYSQL_USERNAME=root --link mysql --name phpmyadmin $(phpmyadmin)

phpmyadmin-run:
	$(phpmyadmin-run)
