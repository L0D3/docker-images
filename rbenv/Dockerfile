FROM ubuntu:12.04

MAINTAINER tcnksm "https://github.com/tcnksm"

# Install packages for building ruby
RUN apt-get update
RUN apt-get install -y --force-yes build-essential curl git
RUN apt-get install -y --force-yes zlib1g-dev libssl-dev libreadline-dev libyaml-dev libxml2-dev libxslt-dev
RUN apt-get clean

# Install rbenv and ruby-build
RUN git clone https://github.com/sstephenson/rbenv.git /root/.rbenv
RUN git clone https://github.com/sstephenson/ruby-build.git /root/.rbenv/plugins/ruby-build
RUN /root/.rbenv/plugins/ruby-build/install.sh
ENV PATH /root/.rbenv/bin:$PATH
RUN echo 'eval "$(rbenv init -)"' >> /etc/profile.d/rbenv.sh # or /etc/profile
RUN echo 'eval "$(rbenv init -)"' >> .bashrc

# Install multiple versions of ruby
ENV CONFIGURE_OPTS --disable-install-doc
ADD ./versions.txt /root/versions.txt
RUN rbenv install  $(cat /root/versions.txt)
# Install Bundler for each version of ruby
RUN echo 'gem: --no-rdoc --no-ri' >> /.gemrc
RUN bash -l -c ' rbenv global 2.1.5 && gem install bundler'

RUN \
apt-get install -y sudo wget && \
apt-get install -y libpq-dev && \
apt-get install -y imagemagick libmagickwand-dev nodejs 
Run \
wget -O- https://toolbelt.heroku.com/install-ubuntu.sh | sh && \
heroku
#rm .ruby-version 
#bash -l bundle
#bash -l bundle
#bash -l bundle
#bash -l bundle exec rails s
#apt-get install nodejs
#bash -l bundle exec rails s
#bash -l bundle exec rails s -b 0.0.0.0
#vim config/database.yml 
#apt-get install vim
#vim config/database.yml 
#bash -l bundle exec rails s -b 0.0.0.0
#bash -l rake db:create
#vim config/database.yml 
#bash -l rake db:create
#bash -l rake db:migrate
#bash -l bundle exec rails s -b 0.0.0.0
#history
