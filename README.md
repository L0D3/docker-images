# Readme

This repo contains docker Images for the Serene Project as well as a simple 
Makefile to facilitate managing the services.

## Commands

Build all services (all commands are equivalent, only one command):

  ```
  make build
  make all-build
  ```
This includes:
  - mysql
  - data
  - wildfly
  - elastic search
  - client

Start all services (all commands are equivalent, only one command):

  ```
  make
  make run
  make all-run
  ```

This includes:
  - wildfly
  - client
  - mysql
  - elastic search

Stop all services (all commands are equivalent, only one command):

  ```
  make stop
  make all-stop
  ```

### wildfly

Build wildfly-docker:

  ```
  make wildfly-build
  ```
 
Run wildfly-docker (requires elastic, mysql)

  ```
  make wildfly-run
  ```

### Data

This container stores the data for the other dockers. It is suifficient to run 
it once and need not be active.

Build data-docker:

  ```
  make data-build
  ```

Run data-docker (requires Build: data| Run: elastic, mysql)

  ```
  make data-run
  ```

### Wildfly

Build wildfly-docker:

  ```
  make wildfly-build
  ```

Run wildfly-docker (requires Build: data| Run: elastic, mysql)

  ```
  make wildfly-run
  ```

### Elastic Search

Build elastic-docker:

  ```
  make elastic-build
  ```

Run elastic-docker (requires Build: data)

  ```
  make elastic-run
  ```

### Mysql

Build mysql-docker:

  ```
  make mysql-build
  ```

Run mysql-docker (requires Build: data)

  ```
  make mysql-run
  ```

### Client

A simple client to test the services.

Build client-docker:

  ```
  make client-build
  ```

Run client-docker (requires Build: data| Run: wildfly, elastic, mysql)

  ```
  make client-run
  ```

