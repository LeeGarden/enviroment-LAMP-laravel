#Install Needed Package
sudo yum install python-setuptools
sudo easy_install pip
sudo pip install supervisor

#Setup Supervisor
echo_supervisord_conf > supervisord.conf
sudo cp supervisord.conf /etc/supervisord.conf
sudo mkdir /etc/supervisord.d/

#Edit supervisord config file
sudo nano /etc/supervisord.conf

#Add 2 line below to end of supervisord config file.
################BeginCode#########################
[include]
files = /etc/supervisord.d/*.conf
##################EndCode#########################

#Next we need to set “Supervisor” to run automatically every time you restart your machine,
# we need to create /etc/rc.d/init.d/supervisord with the following content:

sudo nano /etc/rc.d/init.d/supervisord

#Add some code below to it.
################BeginCode#########################
#!/bin/sh
#
# /etc/rc.d/init.d/supervisord
#
# Supervisor is a client/server system that
# allows its users to monitor and control a
# number of processes on UNIX-like operating
# systems.
#
# chkconfig: - 64 36
# description: Supervisor Server
# processname: supervisord

# Source init functions
. /etc/rc.d/init.d/functions

prog="supervisord"

prefix="/usr/"
exec_prefix="${prefix}"
prog_bin="${exec_prefix}/bin/supervisord"
PIDFILE="/var/run/$prog.pid"

start()
{
      echo -n $"Starting $prog: "
      daemon $prog_bin --pidfile $PIDFILE
      [ -f $PIDFILE ] && success $"$prog startup" || failure $"$prog startup"
      echo
}

stop()
{
      echo -n $"Shutting down $prog: "
      [ -f $PIDFILE ] && killproc $prog || success $"$prog shutdown"
      echo
}

case "$1" in

start)
  start
;;

stop)
  stop
;;

status)
      status $prog
;;

restart)
  stop
  start
;;

*)
  echo "Usage: $0 {start|stop|restart|status}"
;;

esac
##################EndCode#########################

#Then make sure CentOS knows about it:
sudo chmod +x /etc/rc.d/init.d/supervisord
sudo chkconfig --add supervisord
sudo chkconfig supervisord on
sudo service supervisord start

#Create config supervisord for Your project
sudo nano /etc/supervisord.d/{your-project-name}.conf

#Add some code below to it
################BeginCode#########################
[program:{program-your-project-name}]
directory={path-to-your-project}
command=php artisan queue:work
numprocs=1
# UNIX Socket version (better with Nginx)
#command=/home/rayed/.virtualenvs/dev/bin/gunicorn apps.wsgi:application -b unix:/tmp/my_django_cms.sock --workers 8  --max-requests 1000
autostart=true
autorestart=true
redirect_stderr=true
;stderr_logfile=/var/log/long.err.log
;stdout_logfile=/var/log/long.out.log
stdout_logfile=/var/www/{your-project-name}.log
##################EndCode#########################


sudo supervisorctl add {program-your-project-name}
sudo supervisorctl start {program-your-project-name}

#Restart supervirsord for active config
sudo service supervisord restart

#Check log in /var/www/{your-project-name}.log
#Enjoy it. Have fun!
