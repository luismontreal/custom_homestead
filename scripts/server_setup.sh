#!/bin/bash
debug=0
if [ $debug -eq 1 ]; then
	wget_args='-v'
	aptget_args=''
else
	wget_args='-q'
	aptget_args='-qq'
fi

# Make sure only root can run our script
if [ "$(id -u)" != "0" ]; then
   echo "This script must be run as root" 1>&2
   exit 1
fi

echo 'Starting Server Setup'

echo 'Updating Time'
ntpdate ntp.ubuntu.com

if [ ! -d /home/vagrant/.vagrant ]; then
	sudo -u vagrant mkdir /home/vagrant/.vagrant
fi

if [ ! -f /home/vagrant/.vagrant/aptgetupdate ]; then
	echo "Update apt get"
	apt-get update $aptget_args -y
	touch /home/vagrant/.vagrant/aptgetupdate	
fi

if [ ! -f /home/vagrant/.vagrant/htop ]; then
	echo "Install htop"
	apt-get $aptget_args -y install htop
	touch /home/vagrant/.vagrant/htop	
fi

if [ ! -f /home/vagrant/.vagrant/nginxupdate ]; then
	echo 'Updating nginx.conf'
	sed -r 's/server_names_hash_bucket_size 64/server_names_hash_bucket_size 128/' /etc/nginx/nginx.conf > /tmp/nginx.conf
	mv /tmp/nginx.conf /etc/nginx/nginx.conf
	touch /home/vagrant/.vagrant/nginxupdate
fi

if [ ! -f /home/vagrant/.vagrant/phpiniupdate ]; then
	echo 'Updating php.ini'
	sed -r 's/short_open_tag = Off/short_open_tag = On/' /etc/php5/cli/php.ini > /tmp/php.ini
	mv /tmp/php.ini /etc/php5/cli/php.ini
	sed -r 's/short_open_tag = Off/short_open_tag = On/' /etc/php5/fpm/php.ini > /tmp/php.ini
	mv /tmp/php.ini /etc/php5/fpm/php.ini
	touch /home/vagrant/.vagrant/phpiniupdate
fi

if [ ! -f /home/vagrant/.vagrant/apcuupdate ]; then
	echo "Updating apcu"
	if [ $debug -eq 1 ]; then
		yes '' | pecl upgrade apcu
	else
		yes '' | pecl upgrade apcu > /dev/null 2>&1
	fi

	touch /home/vagrant/.vagrant/apcuupdate
fi

echo 'Installing Tools'
cp /home/vagrant/custom_homestead/confs/nginx_default.conf /etc/nginx/sites-enabled/
cd /home/vagrant/custom_homestead/tools/web/phpRedisAdmin
composer install
cd 

echo 'Stopping Mysql'
#this will come back up...
service mysql stop

echo 'Stopping Postgresql'
#this will come back up...
/etc/init.d/postgresql stop

if [ ! -f /usr/local/bin/symfony ]; then
	echo 'Installing Symfony'
	curl -LsS http://symfony.com/installer > symfony.phar
    mv symfony.phar /usr/local/bin/symfony
    chmod a+x /usr/local/bin/symfony
fi


echo 'Restarting services'
restart php5-fpm
service nginx restart

chown vagrant /home/vagrant/.vagrant

if [ ! -f /home/vagrant/.vagrant/cmake ]; then
	echo "Install htop"
	apt-get $aptget_args -y install cmake
	touch /home/vagrant/.vagrant/cmake
fi

echo ''
echo 'Server setup complete'
echo 'Open http://192.168.10.10/ to Test connections'
echo ''


