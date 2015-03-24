#!/bin/bash

webs_root='/home/vagrant/webs'
new_repo='http://svn.tubes.mgcorp.co/'

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

read -p 'Email: ' email
if [ "$email" == "" ]; then
	echo 'Error: Invalid email.'
	exit 1
fi

cd $webs_root/extremetube.com/cms
svn relocate  --non-interactive --username $ldap_user --password $ldap_password http://svn.tubes.na.manwin.local/extremetube.com/galago_admin/trunk http://svn.tubes.mgcorp.co/extremetube.com/galago_admin/trunk/

cd $webs_root/extremetube.com/front
svn relocate  --non-interactive --username $ldap_user --password $ldap_password  http://svn.tubes.na.manwin.local/extremetube.com/front/trunk http://svn.tubes.mgcorp.co/extremetube.com/front/trunk

cd $webs_root/galago/dev
svn relocate  --non-interactive --username $ldap_user --password $ldap_password  http://svn.tubes.na.manwin.local/galago/branches/dev http://svn.tubes.mgcorp.co/galago/branches/dev

cd $webs_root/galago/stable
svn relocate  --non-interactive --username $ldap_user --password $ldap_password  http://svn.tubes.na.manwin.local/galago/trunk http://svn.tubes.mgcorp.co/galago/trunk

cd $webs_root/keezmovies.com/cms/
svn relocate  --non-interactive --username $ldap_user --password $ldap_password  http://svn.tubes.na.manwin.local/keezmovies.com/cms/trunk http://svn.tubes.mgcorp.co/keezmovies.com/cms/trunk

cd $webs_root/mofosex.com/cms/
svn relocate  --non-interactive --username $ldap_user --password $ldap_password http://svn.tubes.na.manwin.local/mofosex.com/cms/trunk http://svn.tubes.mgcorp.co/mofosex.com/cms/trunk

cd $webs_root/mofosex.com/front/
svn relocate  --non-interactive --username $ldap_user --password $ldap_password http://svn.tubes.na.manwin.local/mofosex.com/front/trunk http://svn.tubes.mgcorp.co/mofosex.com/front/trunk

cd $webs_root/pornmd.com/front/
svn relocate  --non-interactive --username $ldap_user --password $ldap_password http://svn.tubes.na.manwin.local/PornMD/trunk http://svn.tubes.mgcorp.co/PornMD/trunk




