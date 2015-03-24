#!/bin/bash
# Turn on a case-insensitive matching (-s set nocasematch)
shopt -s nocasematch

web_root='/home/vagrant/webs'
setup_root='/home/vagrant/Homestead/mindgeek'
#defaults
install_galago='y'
install_extremetube='y'
install_keezmovies='y'
install_mofosex='y'
install_pornmd='y'
install_spankwire='y'

if [ "$(id -u)" != "0" ]; then
   echo "This script must be run as root." 1>&2
   exit 1
fi

read -p 'Alias (used in domains): ' alias

if [ "$alias" == "" ]; then
	echo 'Error: Invalid alias.'
	exit 1
fi

read -p 'Email: ' email

if [ "$email" == "" ]; then
	echo 'Error: Invalid email.'
	exit 1
fi

read -p 'LDAP Username: ' ldap_user
if [ "$ldap_user" == "" ]; then
	echo 'Error: Invalid LDAP user.'
	exit 1
fi

read -p 'LDAP Password: ' -s ldap_password
if [ "$ldap_password" == "" ]; then
	echo 'Error: Invalid LDAP password.'
	exit 1
fi

default='y'
echo ""
read -p 'Install all sites (Y/n): ' all_sites
all_sites=${all_sites:-$default}

if [ "$all_sites" != "y" ]; then
	read -p 'Install Galago (Y/n): ' install_galago
	install_galago=${install_galago:-$default}
	read -p 'Install extremetube.com (Y/n): ' install_extremetube
	install_extremetube=${install_extremetube:-$default}
	read -p 'Install keezmovies.com (Y/n): ' install_keezmovies
	install_keezmovies=${install_keezmovies:-$default}
	read -p 'Install mofosex.com (Y/n): ' install_mofosex
	install_mofosex=${install_mofosex:-$default}
	read -p 'Install spankwire.com (Y/n): ' install_spankwire
	install_spankwire=${install_spankwire:-$default}
	read -p 'Install pornmd.com (Y/n): ' install_pornmd
	install_pornmd=${install_pornmd:-$default}
fi

echo "Sphinx will need to be started manually if this step is skipped."
read -p "Run Sphinx during installs (Y/n): " start_sphinx
start_sphinx=${start_sphinx:-$default}

if [  -f $setup_root/galago/site_setup.sh ] && [ "$install_galago" == "y" ]; then
	$setup_root/galago/site_setup.sh galago $web_root $alias $email $ldap_user $ldap_password $start_sphinx
fi 
if [ -f $setup_root/extremetube.com/site_setup.sh ] && [ "$install_extremetube" == "y" ]; then
	$setup_root/extremetube.com/site_setup.sh extremetube.com $web_root $alias $email $ldap_user $ldap_password $start_sphinx
fi 
if [ -f $setup_root/keezmovies.com/site_setup.sh ] && [ "$install_keezmovies" == "y" ]; then
	$setup_root/keezmovies.com/site_setup.sh keezmovies.com $web_root $alias $email $ldap_user $ldap_password $start_sphinx
fi
if [ -f $setup_root/mofosex.com/site_setup.sh ] && [ "$install_mofosex" == "y" ]; then
	$setup_root/mofosex.com/site_setup.sh mofosex.com $web_root $alias $email $ldap_user $ldap_password $start_sphinx
fi
if [ -f $setup_root/spankwire.com/site_setup.sh ] && [ "$install_spankwire" == "y" ]; then
	$setup_root/spankwire.com/site_setup.sh spankwire.com $web_root $alias $email $ldap_user $ldap_password $start_sphinx
fi
if [ -f $setup_root/pornmd.com/site_setup.sh ] && [ "$install_pornmd" == "y" ]; then
	$setup_root/pornmd.com/site_setup.sh pornmd.com $web_root $alias $email $ldap_user $ldap_password $start_sphinx
fi

echo ''
echo 'Site setup complete.'
echo ''
# Turn off a case-insensitive matching (-u unset nocasematch)
shopt -u nocasematch