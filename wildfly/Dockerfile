From serenedocker/java1.8
Maintainer serenedocker/wildfly

# Set the WILDFLY_VERSION env variable
ENV WILDFLY_VERSION 9.0.1.Final
ENV WILDFLY_SHA1 abe037d5d1cb97b4d07fbfe59b6a1345a39a9ae5
ENV JBOSS_HOME /opt/jboss/wildfly
# Add the WildFly distribution to /opt, and make wildfly the owner of the extracted tar content
# Make sure the distribution is available from a well-known place

RUN mkdir /opt/jboss
RUN cd /tmp
RUN curl -O https://download.jboss.org/wildfly/$WILDFLY_VERSION/wildfly-$WILDFLY_VERSION.tar.gz 
RUN sha1sum wildfly-$WILDFLY_VERSION.tar.gz | grep $WILDFLY_SHA1 
RUN tar xf wildfly-$WILDFLY_VERSION.tar.gz 
RUN mv wildfly-$WILDFLY_VERSION $JBOSS_HOME 
RUN rm wildfly-$WILDFLY_VERSION.tar.gz

# Ensure signals are forwarded to the JVM process correctly for graceful shutdown
ENV LAUNCH_JBOSS_IN_BACKGROUND true

# Expose the ports we're interested in
EXPOSE 8080
EXPOSE 9990
EXPOSE 9090

# Set the default command to run on boot
# This will boot WildFly in the standalone mode and bind to all interface
CMD ["/opt/jboss/wildfly/bin/standalone.sh", "-b", "0.0.0.0"]
