#!/usr/bin/env bash

echo "Lets Get this party started..."
sudo apt-get update
sudo apt-get install git-core curl zlib1g-dev build-essential libssl-dev libreadline-dev libyaml-dev libsqlite3-dev sqlite3 libxml2-dev libxslt1-dev libcurl4-openssl-dev python-software-properties libffi-dev -y

echo "Installing rvm..."
gpg --keyserver hkp://keys.gnupg.net --recv-keys 409B6B1796C275462A1703113804BB82D39DC0E3
\curl -sSL https://get.rvm.io | bash -s stable --ruby

echo "Installing ruby..."
source /home/vagrant/.rvm/scripts/rvm
sudo rvm install ruby-1.9.3-p551

echo "Installing bundler..."
sudo gem install bundler
sudo bundle install

echo "Installing Node and Bower"
curl -sL https://deb.nodesource.com/setup_4.x | sudo -E bash -
sudo apt-get install -y nodejs
npm install -g bower
npm install -g fury-bower-resolver
bower install
bower update

echo "Installing Memcached"
sudo apt-get install -y memcached

echo "Installing Redis"
sudo apt-get install -y redis-server

echo "Installing postgres.."
sudo apt-get install postgresql postgresql-contrib libpq-dev -y
sudo -u postgres bash -c "psql -c \"CREATE USER vagrant WITH SUPERUSER;\""

echo "Installing mysql.."
sudo debconf-set-selections <<< 'mysql-server mysql-server/root_password password'
sudo debconf-set-selections <<< 'mysql-server mysql-server/root_password_again password'
sudo apt-get -y install mysql-server

echo "Overwriting the postgres conf"
sudo sed -i 's/md5/trust/g' /etc/postgresql/*/main/pg_hba.conf

cd /vagrant

rake db:create db:migrate
