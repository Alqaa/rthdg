#!/bin/bash
# assign variables
ACTION=${1}
version=1.0.0
function run () {
sudo yum update -y
sudo yum install nginx -y
sudo chkconfig nginx on
sudo aws s3 cp s3://reem-assignment-4/index.html /usr/share/nginx/html/index.html
sudo service nginx start
}

function remove_file () {
sudo service nginx stop
sudo rm -r /usr/share/nginx/html/*
sudo yum remove nginx -y
}

function show_version (){

echo  $version
}

function display_help() {

cat << EOF
Usage: ${0} {-v|--version|-r|--remove|-h|--help} <filename>
OPTIONS:
        -r |--remove a file
        -v |-- the version
        -h | --help     Display the command help
Examples:
        Show the version:
                $ ${0} -v
        remove a file:
                $ ${0} -r
        Display help:
                $ ${0} -h
EOF
}

if [ -z "$1" ]
	then
		run
	else
		case "$ACTION" in
			-r|--remove)
			remove_file
			;;
			-v|--version)
			show_version
			;;
			-h|--help)
			display_help
			;;
		*)
		display_help
		exit 1
		esac
fi
