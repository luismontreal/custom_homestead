#!/bin/bash
root=/home/vagrant/Homestead/mindgeek
site=$1
# data_dir=$2
run_indexer=$2

conf_file="$root"/"$site"/sphinx.conf;

data_dir=`cat $root/$site/sphinx.conf | grep path | cut -d= -f2 | sort | sed 's/ //g' | head -n1`;

echo "$data_dir";







if [ ! -d "$data_dir" ]; then
	mkdir "$data_dir" -p
	mkdir "$data_dir"/data -p
	echo 'No data. Running Indexer'
	run_indexer="y";
fi


if [ "y" == $2 ]; then
	echo "Running indexer";
	indexer -c "$conf_file" --rotate --all
fi;

echo 'Starting Sphinx'
searchd -c "$root"/"$site"/sphinx.conf

