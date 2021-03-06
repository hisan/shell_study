#!/bin/bash
#得到要统计的目录下的所有的绝对目录，将起输出到文件$second_dir中便于下一步处理

#输入要统计的路径
realpath=$1   
if [[ "$realpath" == '' ]]
then 
	echo "please input the path you want to statistic!"
	exit 127
fi 

basepath="/home/zyb/"
first_dir="/home/zyb/first_dir.txt"
second_dir="/home/zyb/dir.txt"
code_dir="/home/zyb/code.txt"

#将我们要进行代码统计的根目录的所有目录及文件拷贝到$first_dir中
ls -R $realpath >> $first_dir

#设置行分隔符便于接下来的读取
IFS=$'\n'

#读取保存有我们要统计的根目录下的所有目录到文件$second_dir中
for var in $( cat $first_dir )
do
        if [[ "$var" == *: ]]
        then
			echo $var >> $second_dir
        fi      
done

#将文件$second_dir中的每一行字符串的结尾的:替换为/，以便得到每一个绝对路径
sed -i "s#:#/#g" $second_dir

#遍历每个目录下的文件，统计每一个.c和.h文件的文本行并写入文件$code_dir中
for dir in $( cat $second_dir )
do 
	for subdir in $( ls $dir )
	do 
		if [ -f "$dir$subdir" ]
		then
			if [[ "$dir$subdir" == *.c ]]
			then 
				cat $dir$subdir | wc -l >> $code_dir
			elif [[ "$dir$subdir" == *.h ]]
			then 
				cat $dir$subdir | wc -l >> $code_dir
			elif [[ "$dir$subdir" == *.cpp ]]
			then
				cat $dir$subdir | wc -l >> $code_dir
			fi
		fi
	done 
done 


#进行统计
total=0
for num in $(cat $code_dir)
do 
	total=$[$total+$num]
done 
echo "the all code lines under the directory:$1 is :$total"

rm -f $first_dir
rm -f $second_dir
rm -f $code_dir

 
