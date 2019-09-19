#!/bin/bash
total=$[ $1 * $2 ] 
name=$(basename $0)
new=$[ ${10} * ${11} ]
echo "the first para:$1"
echo "the second para:$2"
echo "the result para:$total"
echo "the extra result:$new"
echo "name:$name"
