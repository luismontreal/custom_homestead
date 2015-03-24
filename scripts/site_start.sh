#!/bin/bash
# Turn on a case-insensitive matching (-s set nocasematch)
shopt -s nocasematch

web_root='/home/vagrant/webs'
setup_root='/home/vagrant/Homestead/mindgeek'
#defaults
install_extremetube='y'
install_keezmovies='y'
install_mofosex='y'
install_pornmd='y'
install_spankwire='y'

if [ "$(id -u)" != "0" ]; then
   echo "This script must be run as root." 1>&2
   exit 1
fi

default='y'
echo ""

read -p 'Alias (used in domains): ' alias

if [ "$alias" == "" ]; then
	echo 'Error: Invalid alias.'
	exit 1
fi

echo ""
read -p 'Start all sites (Y/n): ' all_sites
all_sites=${all_sites:-$default}

if [ "$all_sites" != "y" ]; then
	read -p 'Start extremetube.com (Y/n): ' install_extremetube
	install_extremetube=${install_extremetube:-$default}
	read -p 'Start keezmovies.com (Y/n): ' install_keezmovies
	install_keezmovies=${install_keezmovies:-$default}
	read -p 'Start mofosex.com (Y/n): ' install_mofosex
	install_mofosex=${install_mofosex:-$default}
	read -p 'Start spankwire.com (Y/n): ' install_spankwire
	install_spankwire=${install_spankwire:-$default}
	read -p 'Start pornmd.com (Y/n): ' install_pornmd
	install_pornmd=${install_pornmd:-$default}
fi


read -p 'Start sphinx (Y/n): ' start_sphinx
start_sphinx=${start_sphinx:-$default}

if [ -f $setup_root/keezmovies.com/site_start.sh ] && [ "$install_keezmovies" == "y" ]; then
	$setup_root/keezmovies.com/site_start.sh keezmovies.com $start_sphinx
	echo front.keezmovies."$alias".fw.nayul-tubesdev.mgcorp.co >> /tmp/install_sites
	echo cms.keezmovies."$alias".fw.nayul-tubesdev.mgcorp.co >> /tmp/install_sites
fi
if [ -f $setup_root/spankwire.com/site_start.sh ] && [ "$install_spankwire" == "y" ]; then
	$setup_root/spankwire.com/site_start.sh spankwire.com $start_sphinx
	echo front.spankwire."$alias".fw.nayul-tubesdev.mgcorp.co >> /tmp/install_sites
	echo cms.spankwire."$alias".fw.nayul-tubesdev.mgcorp.co >> /tmp/install_sites
fi
if [ -f $setup_root/extremetube.com/site_start.sh ] && [ "$install_extremetube" == "y" ]; then
	$setup_root/extremetube.com/site_start.sh extremetube.com $start_sphinx
fi
if [ -f $setup_root/mofosex.com/site_start.sh ] && [ "$install_mofosex" == "y" ]; then
	$setup_root/mofosex.com/site_start.sh mofosex.com $start_sphinx
	echo front.mofosex."$alias".fw.nayul-tubesdev.mgcorp.co >> /tmp/install_sites
	echo cms.mofosex."$alias".fw.nayul-tubesdev.mgcorp.co >> /tmp/install_sites
fi
if [ -f $setup_root/pornmd.com/site_start.sh ] && [ "$install_pornmd" == "y" ]; then
	$setup_root/pornmd.com/site_start.sh pornmd.com $start_sphinx
	echo front.pornmd."$alias".fw.nayul-tubesdev.mgcorp.co >> /tmp/install_sites
fi

echo ''
echo 'Site setup complete.'
echo ''

# Turn off a case-insensitive matching (-u unset nocasematch)
shopt -u nocasematch