#!/bin/bash
echo "the initital parameter:$@"
set -- $(getopt -q ab:cd "$@")
while [ -n "$1" ]
do 
	echo 
	echo "brefore do case $1"
	echo 
	case "$1" in
		-a) echo "Found the -a option";;
		
		-b) param="$2"
			echo "Found the -b option,with parameter value $param"
			shift
			echo "before -b -- $1";;
			
		-c) echo "Found the -C option";;
		--) echo "it's brefore -- $1"
			shift
			echo "it's after -- $1"
			break;;
		 *) echo "$1 is not an option";;
	esac
	echo "after case $1"
	shift
	echo "after case and shift $1"
done 
echo "finish parameter:$@"