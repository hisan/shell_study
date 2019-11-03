#!/bin/bash
#引用库
. ./myfuncs
value1=10
value2=5
rt1=$(addem $value1 $value2)
rt2=$(multem $value1 $value2)

echo "The addem result is :$rt1"
echo "The multem result is :$rt2"