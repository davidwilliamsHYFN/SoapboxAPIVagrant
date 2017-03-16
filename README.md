# Setting Up A SoapboxAPI Environment

You are reading this because you have been handed some files and you are now scratching your head. You are in luck! I will get you up and running in no time!

### Some things to note before starting

Open up the Vagrant file. Note a couple of things:
- The Ip address listed as "private_network". This is how you will access the api.
- The sync folder is the folder that you keep the soapbox rails app. Vagrant is mapping /vagrant to the folder listed in this config. I kept mine at ~/sites/soapbox_api. You can put yours anywhere, just change the name or you will be SOL. Side note: if you are using a PC, nfs is not an option for you, so you will want to delete that option and maybe reevaluate how you are going to set this environment up.

### Ready..Set..
  vagrant up
Go grab a cup of coffee or stare intently at the monitor so people will think you are busy, either way you are going to be waiting for a little while

### After installation completes
  cd /vagrant
    rvm install ruby-(whatever version the message tells you. right now it is 2.3.0)
    gem install bundler
    bundle install

### Post install housekeeping
At the moment you have a rails app and some gems. Now you need to ask an administrator for a copy of the .env file and the database.yml file. These are stored on drive somewhere. Once you get them add .env to the root directory of the app and add the database.yml to the config directory.

### Setting up the DB
  rake db:create db:migrate
    
### Now you need to grab foreman and fire up the server
  gem install foreman
    foreman start
    
visit 192.168.33.99:3000 (the IP address in the Vagrant file)
You should now see a welcome file!

