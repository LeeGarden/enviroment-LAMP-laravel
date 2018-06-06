#First, cd to project deploy

#Install Ruby
sudo apt install ruby

#Install Capistrano
sudo gem install capistrano

#Install Gem for deploy
sudo gem install capistrano-file-permissions
sudo gem install capistrano-supervisor
 
#REMEMBER
#Change directory pem file in deploy/bartr_dev.rp && deploy/bartr_pro.rp

#Run deploy DEV (default branch develop)
#cap bartr_dev deploy:bartr
#Run deploy with orther branch
#cap bartr_dev deploy:bartr branch=branch_name

#Run deploy PROD (default branch develop)
#cap bartr_pro deploy:bartr
#Run deploy with orther branch
#cap bartr_pro deploy:bartr branch=branch_name




