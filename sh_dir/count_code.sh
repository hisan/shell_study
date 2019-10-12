#!/bin/bash
#统计某个目录下的所有代码文件中的代码行
Dir="./"
list=$(ls -Rl $Dir)
for curdir in $list
do 
        if [[ "$curdir" == *.c ]]
        then echo "num:" $(wc -l $curdir) 
        elif [[ "$curdir" == *.h ]]
        then echo "num:" $(wc -l $curdir)
        fi
done
#有一个问题：得到的只是各个目录下的文件名，而不是绝对路径，因此没用

