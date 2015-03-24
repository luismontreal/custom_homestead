#!/bin/bash
echo "Enter the user's LDAP username:"
read LDAP_USERNAME
echo "Enter the name of your project, e.g tube8, porniq:"
read PROJECT_NAME
echo "Enter what facet of the site you are setting up a dev environment for (e.g. front, cms):"
read SITE_FACET

# Get the username without an underscore to use in their vhost URL
LAST_NAME=`echo $LDAP_USERNAME | cut -d_ -f2`
SUBDOMAIN="$SITE_FACET.$PROJECT_NAME.$LAST_NAME.local"
PROJECT_DIR=/home/vagrant/webs/$PROJECT_NAME/$SUBDOMAIN

case $PROJECT_NAME in
        "tube8"*)
                case $SITE_FACET in
                        "front")
                                REPO_URL="http://$LDAP_USERNAME@stash.mgcorp.co/scm/tub/tube8.front.git"
                                PROJECT_NGINX_CONF="/home/vagrant/Homestead/mindgeek/tube8.com/nginx_confs/tube8.include.conf"
                        ;;
                        "cms")
                                REPO_URL="http://$LDAP_USERNAME@stash.mgcorp.co/scm/tub/tube8.cms.git"
								PROJECT_NGINX_CONF="sites-available/cms.tube8.include.conf"
                        ;;
                esac
                PROJECT_ROOT="/root/"
        ;;

        "porniq"*)
                case $SITE_FACET in
                        "front")                              
                                REPO_URL="http://svn.tubes.na.manwin.local/PornIQ/trunk/"                                
                        ;;
                        "cms")
                                REPO_URL="http://svn.tubes.na.manwin.local/PornIQ/admin/trunk/"                                
                        ;;
                esac
                PROJECT_NGINX_CONF="sites-available/porniq.front.include.conf"
                PROJECT_ROOT="/root/"
        ;;

        *)
        echo "Project name not recognized. Sorry." 
        ;;
esac

if [ ! $REPO_URL ]; then
        echo "GIT Repo could not be retrieved for the specified project. Exiting..."
        exit;
fi

echo "Making the project directory..."
mkdir -p $PROJECT_DIR

echo "Checking out project from GIT..."
git clone $REPO_URL $PROJECT_DIR

echo "Post-checkout steps for $PROJECT_NAME..."
case $PROJECT_NAME in
        "tube8"*)
                case $SITE_FACET in
                        "front")
                                DEV_CONFIG="/home/vagrant/Homestead/mindgeek/tube8.com/site_confs/v1_custom_conf.php"
                                if [ -e $DEV_CONFIG ]; then
									echo "Creating Custom Config for V1..."
									mkdir $PROJECT_DIR/confs
									cp $DEV_CONFIG $PROJECT_DIR/confs/config.inc.php
									sed -i "s/<USER_LASTNAME>/$LAST_NAME/g" $PROJECT_DIR/confs/config.inc.php

									echo "Creating Custom Config for V2..."
									DEV_CONFIG="/home/vagrant/Homestead/mindgeek/tube8.com/site_confs/v2_custom_conf.php"
									mkdir cd $PROJECT_DIR/inc/lib/tube8.v2/App/Config/Dev
									cp $DEV_CONFIG $PROJECT_DIR/inc/lib/tube8.v2/App/Config/Dev/config.php
									sed -i "s/<USER_LASTNAME>/$LAST_NAME/g" $PROJECT_DIR/inc/lib/tube8.v2/App/Config/Dev/config.php

									echo "Installing Composer Libraries..."
									cd $PROJECT_DIR/inc/lib/tube8.v2
									composer install

									echo "Installing Tube8 PHP extensions"
									source /home/vagrant/Homestead/mindgeek/tube8.com/php-extensions/extensions_install.sh
                                fi
                        ;;
                        "cms")
                                echo "Creating the required zendlog file..."
                                mkdir -p $PROJECT_DIR/logs/
                                touch $PROJECT_DIR/logs/zendlog.log
                                chmod 777 $PROJECT_DIR/logs/zendlog.log
                        ;;
                esac
        ;;
        "porniq"*)
             cd $PROJECT_DIR
             php composer.phar install
        ;;
		*)

        echo "Project name not recognized. Sorry."
        ;;
esac

chown -R vagrant:vagrant "$(dirname "$PROJECT_DIR")"
echo "Creating the required log files..."
mkdir /home/vagrant/logs
ERROR_LOG="/home/vagrant/logs/$SUBDOMAIN.error.log"
ACCESS_LOG="/home/vagrant/logs/$SUBDOMAIN.access.log"
touch $ERROR_LOG
touch $ACCESS_LOG

chown -R vagrant:vagrant "$(dirname "$ERROR_LOG")"

echo "Creating vhost entry..."
echo "server {
        listen 80;
        root $PROJECT_DIR$PROJECT_ROOT;

        server_name $SUBDOMAIN *.$SUBDOMAIN;

        access_log $ACCESS_LOG;
        error_log $ERROR_LOG;

        include $PROJECT_NGINX_CONF;
}
" >> /etc/nginx/sites-available/$SUBDOMAIN

echo "Creating a symbolic link to sites-enabled..."
ln -s /etc/nginx/sites-available/$SUBDOMAIN /etc/nginx/sites-enabled/$SUBDOMAIN

echo "Testing the nginx config..."
service nginx configtest

echo "Vhost is: $SUBDOMAIN"