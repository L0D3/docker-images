# Makefile to build and run Docker Images for the Serene Project
# Maintainer: Johannes Lahann

# Global Vars

maintainer=serenedocker/
.DEFAULT_GOAL := run

build: all-build

run: all-run

stop: all-stop

# All: {{{1
# ----------------------------------------------------------------------------

all-build: data-build mysql-build wildfly-build elastic-build data-run client-build

all-run-split:
	tmux split-window -p 33 -h '$(mysql-run)' 
	tmux split-window -p 66 -v '$(elastic-run)'
	sleep 1
	tmux split-window  -v '$(wildfly-run)'
	tmux rotate -D
	tmux select-pane -t 2
	
all-run:	
	tmux new-window -n mysql '$(mysql-run)' 
	tmux new-window -n elastic '$(elastic-run)'
	sleep 1
	tmux new-window  -n wildfly '$(wildfly-run)'
	tmux new-window  -n client '$(client-run)'

all-stop: 
	docker stop wildfly mysql elastic client

	 
# Wildfly: {{{1
# ----------------------------------------------------------------------------

wildfly=$(maintainer)wildfly
wildfly-build:
	docker build -t $(wildfly) wildfly
	
wildfly-run=docker run --name wildfly -p 8081:8080 -p 9990:9990  --link mysql --link elastic --rm  $(wildfly) 
	
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

data-build:
	docker build -t $(data) data 

data-run= docker run --name data $(data)
data-run:
	$(data-run)

data-rm: docker rm data

# Client: {{{1
# ----------------------------------------------------------------------------

client=$(maintainer)client

client-build:
	docker build -t $(client) client 

client-run= docker run --link wildfly --link mysql --link elastic --volumes-from data --rm -it --name client $(client)
client-run:
	$(client-run)
