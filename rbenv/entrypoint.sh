cd enigmatic-retreat-3180/
2  rm .ruby-version 
3  bash -l bundle
4  vim config/database.yml 
5  apt-get install vim
6  vim config/database.yml 
7  bash -l bundle exec rails s -b 0.0.0.0
8  bash -l rake db:create
9  bash -l rake db:migrate
10  bash -l bundle exec rails s -b 0.0.0.0
11  history

