#!/bin/bash
#testing=$(date)
#echo "The date and time are: " $testing
teststring=$(date +%y%m%d)
ls -l > log.$teststring
echo $teststring




