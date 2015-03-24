#!/bin/bash
root=/home/vagrant/Homestead/mindgeek
site=$1
data_dir=$2

if [ ! -d "$data_dir" ]; then
	mkdir "$data_dir" -p
fi

echo 'Running Indexer'
indexer -c "$root"/"$site"/sphinx.conf --rotate --all


