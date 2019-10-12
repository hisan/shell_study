#!/bin/bash
read -n1 -p "do you wan't to continue[Y|N]?" cont
	case "$cont" in
		Y | y) echo 
				echo "fine,continue on...";;
		N | n) echo 
				echo "ok!goodbye"
				exit;;
	esac
	echo "this is the end of the script"