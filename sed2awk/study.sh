脚本原则:可重用最优

awk
	+模式+过程
sed

sed

	选项:			作用:
	-n 				去掉sed默认的输出(sed会默认输出每一个输入行经处理后的输出。无论这个输入行是否被四配和操作)

指定简单指令:

	A 使用多重指令  				示例:
		1) -e							sed -e 's/M/Message/p' -e 's/TB/NewBI/p'
		2) ;							sed 's/M/MessAge/p;s/NB/NewBI/p' 			(此中用法，要注意只用一对引号)
		3) 使用she11的分行 				回车换行,此种用法比较常用的就是条件操作，即匹配摸个模式后再执行其他的操作。
		
					root@zyb-ubt:/home/zyb/CODE/SHELL/shell_study/sed2awk# cat test.txt
					1 line

					2 line

					3 line


					4 line



					end
					
					root@zyb-ubt:/home/zyb/CODE/SHELL/shell_study/sed2awk# sed '/1 line/{
					a\
					aaaaaaaaaaaaaa
					}' test.txt
					1 line
					aaaaaaaaaaaaaa

					2 line

					3 line


					4 line



					end

		

脚本文件:
	sed -f script.flle

awk

			选项:								作用:

			F								变更字段分隔符

	注意事项:
		1.指令必须在单引号中
		2.awk将每一行当做一个记录，每一行上的每个空格分隔出来的当做每一个字段

	A 使用多重指令								示例:

		1) -e awk 'Iprint 61:print 42) sem.txt (此中用法，要注意只用一对单引号)

		2) 使用shell的分行			

	B.模式匹配的使用
	
		1).同sed							root@zyb-ubt:~#: awk '/1355760 K/;/, 436624 K/' mem.txt
											Mem: 1355760 K used, 677404 K tree, 47880 K ahrd, 52364 K buff, 436608 K cached
											Mem: 1355588 K used, 677576 K free, 47880 K ahrd, 52412 K buff, 436624 K cached
											Mem: 1355980 K used, 677184	K free, 47880 K shrd, 52412 K buff, 436624 K cached
													

	C.使用字段段分隔符选项
			-F								root@zyb-ubt:~# awk -F'a' '{print $1;print $2;print $3;print $4;print $5;}' a.txt

											jksncklo
											csm
											mkl;
											vsdclknm
											
											root@zyb-ubt:~# cat a.txt
											ajksnckloacsmamkl;avsdclknmajksncalscnlkacnalkcvnaca

											
一定要注意的:

	1) [过程)
	2) '指令'
	3) /正则表达式/

正则表达式:

	1) 字符串:		表明是首尾相邻的字符

	2) 元字符
			.	:	匹配任何一个字符
			*	:	匹配它前面的任意个字符

			[字符类]:	匹配字符类中的任何一个字符
			
				[] + ^(第一个) :	则不匹配[]中的任何一个字符
				[] + -(连字符) :	表示匹配一个范围的字符类
				[]]			   :	则表明]是字符类中的一个字符
				
				除以上字符外，其他字符在[]中，都表示是字符类而不再具有其他意义，比如*。
			
			^	:	正则表达式中，^指定匹配行的开始字符

			$	:	...	, $指定匹配行的结尾字符
			
						root@zyb-ubt:~# cat abc.txt grep 'a$'
						knacnasca
						root@zyb-ubt:~# cat abc.txt grep '^a' 
						abcklmalamcamscabcmkkascmlkascml kacmlamc
						aa\asc!sdfvwle Eb#≤adviqwefredfbs db(sadcv)w
						
			?	:	匹配前面表达式的0或1次出现
			
			\{n,m\}		:		匹配它前面出现x次的单个字符

				\{n\}	:		x == n

				\{n,\}	:		x >= n

				\{n,m\}	:		m >= x >= n
				

			\			:	转义它之后跟的一个字符
			
			|			:	或,Astring|Bstring,即匹配Astring或者Bstring的匹配行
			
						root@zyb-ubt:~# cat ex.txt
						big
						big house
						small
						small car
						root@zyb-ubt:~# sed -n '/house\|car/p' ex.txt
						big house
						small car
			
			()			:	分组操作，用于对正则表达式进行分组并设置优先级
			
						root@zyb-ubt:~# sed -n '/big/p' ex.txt
						big
						big house
						
						root@zyb-ubt:~# sed -n '/big\( house\)/p' ex.txt
						big house
			
			+			:		正则表达式元字符扩展集中的一部分,它表示"一个或更多"。因此，包含一个或多个数字序列的行将被看做是一个整数。

						root@zyb-ubt:/home/zyb/CODE/SHELL/shell_study/sed2awk# cat awksrc
						/[0-9 ]+/       { print "This is an integer" }
						/[A-Za-z]+/     { print "This is a string" }
						/^$/            { print "This is a blank line." }
						root@zyb-ubt:/home/zyb/CODE/SHELL/shell_study/sed2awk# echo "123" | awk -f awksrc
						This is an integer
						
						
			
	构建单词类正则表达式:
			<word>	:	匹配单词开始处和结束处的字符串
						root@zyb-ubt:~# grep '\<car\>' ex.txt
						small car
						
sed一次处理一行，不仅仅是处理，而是程序的设计，每次就从文本中读取一行，处理完后又读取下一行，这样就不用将所有文件内容读取到内存中导致占用大量内存空间了。
sed的模式空间就是它用于读取输入、输入处理后存放的内存空间。
这里有一个重点，这个空间是随时改变的。在多条命令的情况下，模式空间读入一行，要经过所有的命令处理后，才算真正的处理完，才会输出。

sed默认处理单位为一行，也可以通过设置新的处理单位。



	正则表达式	+	寻址
		1) 没有地址		:		处理每一行

		root@zyb-ubt:~# sed -n 'P' sample.txt
		abc
		def
		ghi
		jkl
		mno
		pqr
		stu
		vwx
		yz

		2) 一个地址		:		处理该地址代表的行
								root@zyb-ubt:~# sed-n '1p' gample.txt
								abc

		3) 地址范围		:		处理该地址范围内的所有行
								root@zyb-ubt:~# sed -n '1,3p' sample. txt
								abc
								def
								ghi

		4) 地址!		: 		处理除该地址以外的所有行
								root@zyb-ubt:~# sed -n '1p' abc.txt
								abc
								
								root@zyb-ubt:~# sed -n '1!p' abc.txt
								def
								ghi
								jkl
								mno
								pqr
								stu
								vwx
								yz
								
元字符汇总

	\{n,m\}		:

元字符使用示例:
	1) \ 	将元字符转换为普通字符，或者将普通字符转换为元字符
	

grep之后的模式为啥要加引号？因为是为了将模式作为grep的参数，当然这也是因为grep支持正则表达式。
	
如果程序不能得到你想要的结果，那么你应该考虑如何描述想要结果的表达式


元字符详解：
	[字符类]		对通配符的改进,列出要匹配的字符，而不是匹配特殊位置的任意字符
		(所以,字符类的匹配结果,情况更多是组合而不是唯一.)
		
		-		:	连字符
		
		当它不在第一个或者最后一个位置时，表示一个范围	
		由此，比如我们为了匹配加减乘除，我们应该为[-+*/]或者[+*/-]，当然，我们也可以使用\-来转义，但是比较乱。
		它也可以在字符类中混合其他字符一起用，如[a-z?,.;']
		
多个字符类的使用:
	[exp1][exp2],则是递进关系,即先由exp1过滤,再由exp2过滤.
	
	
POSIX类补充					匹配的字符		

字符类:				由[:字符类:]组成
	[:alnum:]			可打印的字符
	[:alpha:]			字母字符
	[:blank:]			空格和制表符	
	[:cntrl:]			控制字符
	[:digit:]			数字字符
	[:graph:]			可打印的和可见的(非空格)字符
	[:lower:]			小写字符
	[:print:]			可打印的字符(包括空白字符)
	[:punct:]			标点符号字符
	[:space:]			空白字符
	[:upper:]			大写字符
	[:xdigit:]			十六进制数字
	
	

sed的基本命令:

	删除	d	:
	追加	a	:
	插入	i	:
	更改	c	:


不同类型命令必须在多行上指定。


1) 替换

[addr]s/pattern/replacement/flags

	1) 定界符:
		一般，我们使用 /来作为正则表达式的定界符,若模式中包含/时，我们可以使用其他的定界符，
		也就是说，在正则表达式中，我们可以使用除换行符以外的符号作为定界符。
		
		如下，因为要匹配的字符串中包含/，则另用定界符#
		root@zyb-ubt:/home/zyb/CODE/SHELL/shell_study/sed2awk# echo '/home/zyb/CODE/' | sed -n 's#/home/zyb/#/usr/zyb/#p'
		/usr/zyb/CODE/
	
	2) flags(在有意义的前提下,可组合使用):	
	
		n 	:	1~512之间的一个数字，表示对本模式中指定模式的第n次出现进行替换
		
				(这个数字标志也是很有用的,因为你不总是想替换输入的一行上的所有匹配的模式)
		
				root@zyb-ubt:/home/zyb/CODE/SHELL/shell_study/sed2awk# cat date.txt
				2020年 11月 10日 星期二 22:12:25 CST  2020年 11月 10日 星期二 22:12:25 CST
				2020年 11月 10日 星期二 22:12:26 CST  2020年 11月 10日 星期二 22:12:26 CST
				2020年 11月 10日 星期二 22:12:27 CST  2020年 11月 10日 星期二 22:12:27 CST
				2020年 11月 10日 星期二 22:12:27 CST  2020年 11月 10日 星期二 22:12:27 CST
				2020年 11月 10日 星期二 22:12:28 CST  2020年 11月 10日 星期二 22:12:28 CST
				2020年 11月 10日 星期二 22:12:28 CST  2020年 11月 10日 星期二 22:12:28 CST
				2020年 11月 10日 星期二 22:12:28 CST  2020年 11月 10日 星期二 22:12:29 CST
				2020年 11月 10日 星期二 22:12:29 CST  2020年 11月 10日 星期二 22:12:29 CST
				2020年 11月 10日 星期二 22:12:30 CST

				root@zyb-ubt:/home/zyb/CODE/SHELL/shell_study/sed2awk# sed -n 's/2020/1111/p1' date.txt
				1111年 11月 10日 星期二 22:12:25 CST  2020年 11月 10日 星期二 22:12:25 CST
				1111年 11月 10日 星期二 22:12:26 CST  2020年 11月 10日 星期二 22:12:26 CST
				1111年 11月 10日 星期二 22:12:27 CST  2020年 11月 10日 星期二 22:12:27 CST
				1111年 11月 10日 星期二 22:12:27 CST  2020年 11月 10日 星期二 22:12:27 CST
				1111年 11月 10日 星期二 22:12:28 CST  2020年 11月 10日 星期二 22:12:28 CST
				1111年 11月 10日 星期二 22:12:28 CST  2020年 11月 10日 星期二 22:12:28 CST
				1111年 11月 10日 星期二 22:12:28 CST  2020年 11月 10日 星期二 22:12:29 CST
				1111年 11月 10日 星期二 22:12:29 CST  2020年 11月 10日 星期二 22:12:29 CST
				1111年 11月 10日 星期二 22:12:30 CST
				
				root@zyb-ubt:/home/zyb/CODE/SHELL/shell_study/sed2awk# sed -n 's/2020/1111/p2' date.txt
				2020年 11月 10日 星期二 22:12:25 CST  1111年 11月 10日 星期二 22:12:25 CST
				2020年 11月 10日 星期二 22:12:26 CST  1111年 11月 10日 星期二 22:12:26 CST
				2020年 11月 10日 星期二 22:12:27 CST  1111年 11月 10日 星期二 22:12:27 CST
				2020年 11月 10日 星期二 22:12:27 CST  1111年 11月 10日 星期二 22:12:27 CST
				2020年 11月 10日 星期二 22:12:28 CST  1111年 11月 10日 星期二 22:12:28 CST
				2020年 11月 10日 星期二 22:12:28 CST  1111年 11月 10日 星期二 22:12:28 CST
				2020年 11月 10日 星期二 22:12:28 CST  1111年 11月 10日 星期二 22:12:29 CST
				2020年 11月 10日 星期二 22:12:29 CST  1111年 11月 10日 星期二 22:12:29 CST

		
		g	:	对模式空间的所有出现的情况进行全局更改，而没有g时通常只有第一次出现的情况被替换
				root@zyb-ubt:/home/zyb/CODE/SHELL/shell_study/sed2awk# sed -n 's/2020/1111/pg' date.txt
				1111年 11月 10日 星期二 22:12:25 CST  1111年 11月 10日 星期二 22:12:25 CST
				1111年 11月 10日 星期二 22:12:26 CST  1111年 11月 10日 星期二 22:12:26 CST
				1111年 11月 10日 星期二 22:12:27 CST  1111年 11月 10日 星期二 22:12:27 CST
				1111年 11月 10日 星期二 22:12:27 CST  1111年 11月 10日 星期二 22:12:27 CST
				1111年 11月 10日 星期二 22:12:28 CST  1111年 11月 10日 星期二 22:12:28 CST
				1111年 11月 10日 星期二 22:12:28 CST  1111年 11月 10日 星期二 22:12:28 CST
				1111年 11月 10日 星期二 22:12:28 CST  1111年 11月 10日 星期二 22:12:29 CST
				1111年 11月 10日 星期二 22:12:29 CST  1111年 11月 10日 星期二 22:12:29 CST
				1111年 11月 10日 星期二 22:12:30 CST

		p	:	打印模式空间的内容
					
				root@zyb-ubt:/home/zyb/CODE/SHELL/shell_study/sed2awk# sed -n 's/2020/2022/pg' example.txt
				2022年 11月 10日 星期二 22:12:25 CST  2022年 11月 10日 星期二 22:12:25 CST
				2022年 11月 10日 星期二 22:12:26 CST  2022年 11月 10日 星期二 22:12:26 CST
				2022年 11月 10日 星期二 22:12:27 CST  2022年 11月 10日 星期二 22:12:27 CST
				2022年 11月 10日 星期二 22:12:27 CST  2022年 11月 10日 星期二 22:12:27 CST
				2022年 11月 10日 星期二 22:12:28 CST  2022年 11月 10日 星期二 22:12:28 CST
				2022年 11月 10日 星期二 22:12:28 CST  2022年 11月 10日 星期二 22:12:28 CST
				2022年 11月 10日 星期二 22:12:28 CST  2022年 11月 10日 星期二 22:12:29 CST
				2022年 11月 10日 星期二 22:12:29 CST  2022年 11月 10日 星期二 22:12:29 CST
				2022年 11月 10日 星期二 22:12:30 CST
				root@zyb-ubt:/home/zyb/CODE/SHELL/shell_study/sed2awk# sed -n 's/2020/2022/p' example.txt
				2022年 11月 10日 星期二 22:12:25 CST  2020年 11月 10日 星期二 22:12:25 CST
				2022年 11月 10日 星期二 22:12:26 CST  2020年 11月 10日 星期二 22:12:26 CST
				2022年 11月 10日 星期二 22:12:27 CST  2020年 11月 10日 星期二 22:12:27 CST
				2022年 11月 10日 星期二 22:12:27 CST  2020年 11月 10日 星期二 22:12:27 CST
				2022年 11月 10日 星期二 22:12:28 CST  2020年 11月 10日 星期二 22:12:28 CST
				2022年 11月 10日 星期二 22:12:28 CST  2020年 11月 10日 星期二 22:12:28 CST
				2022年 11月 10日 星期二 22:12:28 CST  2020年 11月 10日 星期二 22:12:29 CST
				2022年 11月 10日 星期二 22:12:29 CST  2020年 11月 10日 星期二 22:12:29 CST
				2022年 11月 10日 星期二 22:12:30 CST

		w	:	将模式空间中的内容写到文件file中
			 
				sed -n 's/2020/1111/w a.txt' date.txt
				root@zyb-ubt:/home/zyb/CODE/SHELL/shell_study/sed2awk# cat a.txt
				1111年 11月 10日 星期二 22:12:25 CST  2020年 11月 10日 星期二 22:12:25 CST
				1111年 11月 10日 星期二 22:12:26 CST  2020年 11月 10日 星期二 22:12:26 CST
				1111年 11月 10日 星期二 22:12:27 CST  2020年 11月 10日 星期二 22:12:27 CST
				1111年 11月 10日 星期二 22:12:27 CST  2020年 11月 10日 星期二 22:12:27 CST
				1111年 11月 10日 星期二 22:12:28 CST  2020年 11月 10日 星期二 22:12:28 CST
				1111年 11月 10日 星期二 22:12:28 CST  2020年 11月 10日 星期二 22:12:28 CST
				1111年 11月 10日 星期二 22:12:28 CST  2020年 11月 10日 星期二 22:12:29 CST
				1111年 11月 10日 星期二 22:12:29 CST  2020年 11月 10日 星期二 22:12:29 CST
				1111年 11月 10日 星期二 22:12:30 CST
	
	3)	replacement
	这一部分原意就是待匹配模式后被替换的字符串。
	但是当使用下列这些字符时，便具有了特殊的含义.
				
				(各种等价说法)
		&	:	用正则表达式的内容进行替换 == (匹配模式后，用模式这个字符串来替换被匹配的内容) == (&符号用于在替换字符串中引用整个匹配的内容)
	
				用法1:
					root@zyb-ubt:/home/zyb/CODE/SHELL/shell_study/sed2awk# cat tmp.txt
					UNIX
					root@zyb-ubt:/home/zyb/CODE/SHELL/shell_study/sed2awk# sed -n 's/UNIX/\\s-2&\\s0/pg' tmp.txt
					\s-2UNIX\s0
					root@zyb-ubt:/home/zyb/CODE/SHELL/shell_study/sed2awk# sed -n 's/UNIX/\\s-2&#&#&#&\\s0/pg' tmp.txt
					\s-2UNIX#UNIX#UNIX#UNIX\s0
				
				用法2:
					$的一个很显著的用法，比如我们要把匹配的内容1变为(1),即sed -n 's/1/(&)/p' 
					
					root@zyb-ubt:/home/zyb/CODE/SHELL/shell_study/sed2awk# cat tmp.txt
					1.第一章节
					root@zyb-ubt:/home/zyb/CODE/SHELL/shell_study/sed2awk# sed -n 's/1/(&)/p' tmp.txt
					(1).第一章节

		\n	:	n是一个数字，范围为1~9;即匹配第n个子串。== (它用于选择被匹配的字符串的任意独立部分,并且在替换字符串中回调它)
		
		如何表示"被匹配的字符串的任意独立部分"？ 在sed中转义的圆括号括住正则表达式的任意部分并且保存它以备回调,且一行最多允许"保存"9次。此时，\n用于回调被保存的匹配部分。
		
				(为啥我的没能得到正确的结果呢?)
				root@zyb-ubt:/home/zyb/CODE/SHELL/shell_study/sed2awk# cat keyvalue.txt
				ip=192.168.1.254
				port=8080
				root@zyb-ubt:/home/zyb/CODE/SHELL/shell_study/sed2awk# sed -n 's/\(.*\)=\(.*\)/\2=\1/p' keyvalue.txt
				=ip.168.1.254
				=port

		
		\	:	当在替换部分,包含&，\和替换命令的定界符时,可用\转义他们
		
				root@zyb-ubt:/home/zyb/CODE/SHELL/shell_study/sed2awk# sed -n 's/2020/\&/p' date.txt
				&年 11月 10日 星期二 22:12:25 CST  2020年 11月 10日 星期二 22:12:25 CST
				&年 11月 10日 星期二 22:12:26 CST  2020年 11月 10日 星期二 22:12:26 CST
				&年 11月 10日 星期二 22:12:27 CST  2020年 11月 10日 星期二 22:12:27 CST
				&年 11月 10日 星期二 22:12:27 CST  2020年 11月 10日 星期二 22:12:27 CST
				&年 11月 10日 星期二 22:12:28 CST  2020年 11月 10日 星期二 22:12:28 CST
				&年 11月 10日 星期二 22:12:28 CST  2020年 11月 10日 星期二 22:12:28 CST
				&年 11月 10日 星期二 22:12:28 CST  2020年 11月 10日 星期二 22:12:29 CST
				&年 11月 10日 星期二 22:12:29 CST  2020年 11月 10日 星期二 22:12:29 CST
				&年 11月 10日 星期二 22:12:30 CST
				
				root@zyb-ubt:/home/zyb/CODE/SHELL/shell_study/sed2awk# sed -n 's/2020/&/p' date.txt
				2020年 11月 10日 星期二 22:12:25 CST  2020年 11月 10日 星期二 22:12:25 CST
				2020年 11月 10日 星期二 22:12:26 CST  2020年 11月 10日 星期二 22:12:26 CST
				2020年 11月 10日 星期二 22:12:27 CST  2020年 11月 10日 星期二 22:12:27 CST
				2020年 11月 10日 星期二 22:12:27 CST  2020年 11月 10日 星期二 22:12:27 CST
				2020年 11月 10日 星期二 22:12:28 CST  2020年 11月 10日 星期二 22:12:28 CST
				2020年 11月 10日 星期二 22:12:28 CST  2020年 11月 10日 星期二 22:12:28 CST
				2020年 11月 10日 星期二 22:12:28 CST  2020年 11月 10日 星期二 22:12:29 CST
				2020年 11月 10日 星期二 22:12:29 CST  2020年 11月 10日 星期二 22:12:29 CST
				2020年 11月 10日 星期二 22:12:30 CST
				
2) 删除
	删除,即删除匹配的行或者指定的地址行,这种删除对于模式空间来说,是整行的删除，如果需要只删除匹配的部分，那么请使用替换。
	例如:	删除空行 /^$/d
	
3) 追加、插入、更改

	追加：
		[line-address]a\
		text	
	
	插入:
		[line-address]i\
		text	
	
	更改:
		[line-address]c\
		text
	
	这三个命令中的每一个都要求后面跟一个反斜杠用于转义第一个行尾。text必须从下一行开始。
	
	追加、插入命令只应用于单个行地址，更改命令可以处理一个范围内的行。
	
		1) 更改
			root@zyb-ubt:cat email_t.txt
			From: Linus Torvalds <torvalds@linux-foundation.org>
			Newsgroups: fa.linux.kernel
			Subject: Re: [git pull][resend] Input updates for 2.6.22-rc7
			Date: Thu, 05 Jul 2007 23:09:49 UTC
			Message-ID: <fa.dJLARsFLFkz9Isp0gVJ6B6Vlk8I@ifi.uio.no>

			root@zyb-ubt:sed '/^From/,/^$/c\
			<Mail Header Removed>' email_t.txt
			<Mail Header Removed>
			
		2) 插入和追加: 此两个命令不影响模式空间的内容,提供的文本将不匹配脚本中的后续命令中的任何地址。
		
			示例1.追加
			
				root@zyb-ubt:/home/zyb/CODE/SHELL/shell_study/sed2awk# sed '/^From/a\
				this is a test insert txt!' email_t.txt
				
				From: Linus Torvalds <torvalds@linux-foundation.org>
				this is a test insert txt!(追加的行，这表示追加总是追加在模式行之后)
				Newsgroups: fa.linux.kernel
				Subject: Re: [git pull][resend] Input updates for 2.6.22-rc7
				Date: Thu, 05 Jul 2007 23:09:49 UTC
				Message-ID: <fa.dJLARsFLFkz9Isp0gVJ6B6Vlk8I@ifi.uio.no>

				root@zyb-ubt:/home/zyb/CODE/SHELL/shell_study/sed2awk# cat email_t.txt
				From: Linus Torvalds <torvalds@linux-foundation.org>
				Newsgroups: fa.linux.kernel
				Subject: Re: [git pull][resend] Input updates for 2.6.22-rc7
				Date: Thu, 05 Jul 2007 23:09:49 UTC
				Message-ID: <fa.dJLARsFLFkz9Isp0gVJ6B6Vlk8I@ifi.uio.no>
		
			示例2.插入

				root@zyb-ubt:/home/zyb/CODE/SHELL/shell_study/sed2awk# sed '/^From/i\
				this is a insert test txt!' email_t.txt
				this is a insert test txt! (插入的行，这表示插入总是插入在模式行之前)
				From: Linus Torvalds <torvalds@linux-foundation.org>
				Newsgroups: fa.linux.kernel
				Subject: Re: [git pull][resend] Input updates for 2.6.22-rc7
				Date: Thu, 05 Jul 2007 23:09:49 UTC
				Message-ID: <fa.dJLARsFLFkz9Isp0gVJ6B6Vlk8I@ifi.uio.no>

				
列表 	
		|		用于显示模式空间的内容，将非打印的字符显示为两个数字的ASCII代码.

				root@zyb-ubt:/home/zyb/CODE/SHELL/shell_study/sed2awk# sed -n -e "l" email_t.txt
				From: Linus Torvalds <torvalds@linux-foundation.org>$
				Newsgroups: fa.linux.kernel$
				Subject: Re: [git pull][resend] Input updates for 2.6.22-rc7$
				Date: Thu, 05 Jul 2007 23:09:49 UTC$
				Message-ID: <fa.dJLARsFLFkz9Isp0gVJ6B6Vlk8I@ifi.uio.no>$
				$

				root@zyb-ubt:/home/zyb/CODE/SHELL/shell_study/sed2awk# sed -e "l" email_t.txt
				From: Linus Torvalds <torvalds@linux-foundation.org>$
				From: Linus Torvalds <torvalds@linux-foundation.org>
				Newsgroups: fa.linux.kernel$
				Newsgroups: fa.linux.kernel
				Subject: Re: [git pull][resend] Input updates for 2.6.22-rc7$
				Subject: Re: [git pull][resend] Input updates for 2.6.22-rc7
				Date: Thu, 05 Jul 2007 23:09:49 UTC$
				Date: Thu, 05 Jul 2007 23:09:49 UTC
				Message-ID: <fa.dJLARsFLFkz9Isp0gVJ6B6Vlk8I@ifi.uio.no>$
				Message-ID: <fa.dJLARsFLFkz9Isp0gVJ6B6Vlk8I@ifi.uio.no>
				$

转换
		此命令将字符串abc中的每个字符，都转换成字符串xyz中的等价字符。(所以互相转换的字符串长度必须相等)
		
	[address]y/abc/xyz/   这里的转换单位是字符，两个字符串是互相对照的。
	
			root@zyb-ubt:/home/zyb/CODE/SHELL/shell_study/sed2awk# cat a.txt
			12345611223344
			abcedf

			root@zyb-ubt:/home/zyb/CODE/SHELL/shell_study/sed2awk# sed 'y/123/abc/' a.txt
			abc456aabbcc44
			abcedf

打印行号
		[line-address]=
		
			root@zyb-ubt:/home/zyb/CODE/SHELL/shell_study/sed2awk# sed '1,$=' a.txt
			1
			12345611223344
			2
			abcedf
			3

下一步 next  (next改变了正常的流控制，直到到达脚本的底部才会输出模式空间的内容。)
		
		[address]n	
			
			root@zyb-ubt:/home/zyb/CODE/SHELL/shell_study/sed2awk# cat mail.txt
			.Hi "On Egypt"

			Napopleon,pointing to the Pyramids,siad to his troops:
			.Soldiers, forty centuries have their eyes upon you.
			root@zyb-ubt:/home/zyb/CODE/SHELL/shell_study/sed2awk# sed '/^\.Hi/{
			n
			/^$/d
			}' mail.txt
			.Hi "On Egypt"
			Napopleon,pointing to the Pyramids,siad to his troops:
			.Soldiers, forty centuries have their eyes upon you.
			
		综上:next输出当前模式空间的内容，然后读取输入的下一行，而不返回脚本的顶端。
		思考一下，这个next命令，能有什么用处呢？目前我只想到用于对和某个模式匹配的行的下一行做一些其他的操作。

读写文件 w/r
	[line-address]r infile			:	r将指定文本的内容读入到模式空间,它不能对一个范围内的行进行操作
	[address]w outfile				:	w将模式空间的内容写入到file中

		r示例:
		root@zyb-ubt:/home/zyb/SHELL# cat a.txt
		abcd
		efgh
		
		root@zyb-ubt:/home/zyb/SHELL# cat num.txt
		123
		
		root@zyb-ubt:/home/zyb/SHELL# sed '/\<abcd\>/r num.txt' a.txt
		abcd
		123			--->>> (匹配到abed后，读入了num.txt中的内容到模式空间)
		efgh

		w示例:
		root@zyb-ubt:/home/zyb/SHELL# sed'/\<abcd\>/w insert.txt' a.txt
		
		root@zyb-ubt:/home/zyb/SHELL# cat insert.txt
		abcd
		
	重要应用场景说明：
		若有一个统计人信息的文本,这个信息每一行包含:姓名、性别、家乡...,如果需要将这些属性分别写入到不同的文件中，那么此时的w就很有用
			sed -n '/姓名/w 姓名.txt;/性别/w 性别.txt' 普查文本.txt

退出q	: 	使sed停止读取新的输入行，并停止将它们发送到输出。
	[line-address]q

	root@zyb-ubt:/home/zyb/SHELL# cat repeat.txt
	abc
	abc
	abedef
	wwwka
	acmasca
	acaaacaca
	acackasc

	root@zyb-ubt :/home/zyb/SHELL# sed '/a/q' repeat.txt
	abc

	root@zyb-ubt:/home/ zyb/SHELL# sed '4q' repeat.txt
	abc
	abc
	abedef
	wwwka
	
	重要应用场景说明:	若我们使用sed只是为了某个操作，比如查找到某个字符串、删除了某个字符串后，就停止脚本，那么q是非常有用的。
		
高级sed命令:(改变了执行或控制命令的流程顺序)

	1.处理多行模式空间：(分别对应于单行模式空间的n,d,p)
	
		a) N	:	通过读取新的输入行，并将它添加到模式空间的现有内容之后，来创建多行模式空间。
					模式空间最初的内容和新的输入行之间用换行符分隔。在模式空间中嵌入的换行符可以利用转义序列“\n”来匹配。
					
					root@zyb-ubt:/home/zyb/CODE/SHELL/shell_study/sed2awk# sed -f sed.blank test.txt
					1 line

					2 line

					3 line
					4 line

					end
					root@zyb-ubt:/home/zyb/CODE/SHELL/shell_study/sed2awk# cat test.txt
					1 line

					2 line

					3 line


					4 line





					end
					root@zyb-ubt:/home/zyb/CODE/SHELL/shell_study/sed2awk# cat sed.blank
					/^$/{	=================>>> 匹配空行后，由于N,所以该空行便被加入模式空间。且与模式空间中的内容以换行符分隔。
					N
					/^\n$/d =================>>> 由于N创建了多行模式空间，所以在^匹配多行模式空间中的第一个字符,$匹配多行模式空间中的最后一个字符
					}
			示例1:
					root@zyb-ubt:/home/zyb/CODE/SHELL/shell_study/sed2awk# cat m2.txt
					.Hi "On Egypt"
					anacnk
					Napopleon,pointing to the Pyramids,siad to his troops:
					.Soldiers, forty centuries have their eyes upon you.
					root@zyb-ubt:/home/zyb/CODE/SHELL/shell_study/sed2awk# sed '/anacnk$/{
					N
					s/anacnk\nNapopleon/a big/
					}' m2.txt
					.Hi "On Egypt"
					a big,pointing to the Pyramids,siad to his troops:
					.Soldiers, forty centuries have their eyes upon you.
				
				可见，N将下一行加入当前模式空间形成多行模式空间，并在模式空间中，进行了跨行的替换。
				所以从程序设计的角度，可以猜测sed支持多行模式空间的根本不在于何种命令，而在与多行模式空间是否可以被创建。
				
				
			多行模式空间中:
				^	匹配模式空间中的第一个字符,而不匹配任何嵌入的换行符。
				$	...				最后的换行符,	...
				
			
			在执行next命令之后,控制将被传递给脚本中的命令.
			
		b) D	:	D是d的多行形式，d删除模式空间的内容，D只删除多行模式空间的第一行。
			
			D删除模式空间中直到第一个嵌入的换行符的这部分内容。它不会导致读入新的输入行。
			相反，它返回到脚本的顶端，将这些指令应用于模式空间剩余的内容。
			
			root@zyb-ubt:/home/zyb/CODE/SHELL/shell_study/sed2awk# cat sed.blank
			/^$/{
			N
			/^\n$/D	=================>>>//使用D,和d比起来,D只删除多行模式空间的第一行,而不是整个模式空间
			}

			root@zyb-ubt:/home/zyb/CODE/SHELL/shell_study/sed2awk# sed -f sed.blank test.txt
			1 line

			2 line

			3 line

			4 line

			end
			root@zyb-ubt:/home/zyb/CODE/SHELL/shell_study/sed2awk# cat test.txt
			1 line

			2 line

			3 line


			4 line



			end

			c) P		多行打印命令与p不同，P输出多行模式空间的第一部分,直到第一个嵌入的换行符位置。
						在执行完脚本中的最后一个命令之后，模式空间的内容自动输出。
			
			
		
	2.采用保持空间来保存模式空间的内容并使它可用于后续的命令
		
		模式空间：用于容纳当前输入行的缓冲区
		保持空间：预留缓冲区。模式空间中的内容可以复制到保持空间，而且保持空间的内容也可以复制到模式空间。
		以下的命令就是用于在两者之间移动数据。
		
		a) H 或 h (hold)	将模式空间中的内容复制或追加到保持空间
		
		hold命令在保持空间的内容之后放置一个换行符,且后买呢跟随模式空间的内容，即使一开始保持空间是空的也是如此。
		
		b) G 或 g (Get)		将保持空间中的内容复制或追加到保持空间
		
		Get命令在模式空间的内容后放置一个换行符，且后面跟随保持空间的内容。
		
		c) x				交换保持空间和模式空间的内容
		
		这些命令中的每一条都可以利用一个地址来指定一行或行范围。
		同一命令的大小写之间的区别:小写改变写目的缓冲区的内容，而大写则追加缓冲区现有的内容。
		
	3.编写使用分支和条件命令的脚本,以更改控制流
		分支b和测试t命令将脚本中的控制转移到包含特殊标签的行，如果没有指定标签，则将控制转移到脚本的结尾处。
		b用于无条件转移，t用于有条件转移，他们只有替换命令改变当前行时才会执行。
		
		a) :		标签是任意不多于七个字符的序列，标签本身占一行并以冒号开始。
			:label1 ========>:与标签之间不允许有空格或其他符号，行结尾处的空格被认为是标签的一部分
		
		b) b		用于在脚本中将控制权转移到另一行
			[addres]b[label] ======================>label可选，没有则代表跳到结尾处。
			
			应用这个命令的一个重要场景就是,你要处理的文本有一部分内容你要跳过，那么用b就很完美。
			
			就像c语言的goto语法一样。
			
			root@zyb-ubt:/home/zyb/CODE/SHELL/shell_study/sed2awk# sed -n '{
			:top
			i\
			abc
			}' test.txt
			abc
			abc
			abc
			abc
			abc
			abc
			abc
			abc
			abc
			abc
			abc
			abc
			root@zyb-ubt:/home/zyb/CODE/SHELL/shell_study/sed2awk# cat test.txt
			1 line

			2 line

			3 line


			4 line



			end

			

		c) t
		[address]t[label] ======================>label可选，没有则代表跳到结尾处。

		
一定要明确，sed、awk都是用来处理数据流的，所以一定要有输入，比如在命令行执行一定命 # awk '{print x += 1}',点击回车后，并没有执行，因为是在等待输入。

awk的底层为使用它的人定义并提供了一个模型，这个模型就是主输入循环。一定要理解这个awk的基本模型，不然用awk的时候就总会受到其他开发语言的影响。

awk程序运行逻辑
	BEGIN		:
	主循环		:
	END			:
	
								--------------
								|            |/		在读入任何输入前,执行第一个例程。
								|			 |------------------------------------------------------
								|  BEGIN     |\
								|------------|
								|			 |/		在读入每个输入行时执行第二个例程：主循环例程
								|			 |------------------------------------------------------
								|			 |\
								|			 |
								--------------
								|            |/		在所有的输入完成后,执行第三个例程。
								|   END      |------------------------------------------------------
								|------------|\

	awk程序的三部分:
		1) 处理输入前将做的处理
		2) 处理输入中将做的处理
		3) 处理输入完成后将做的处理
					
		要理解这三个过程，理解以后写的awk程序才能按照所设想的那样得到处理结果
		
	A) awk中的模式匹配:
		即，当awk读入一输入行时，它试图匹配脚本中的每个模式匹配规则，只有与一个特定的模式相匹配才能成为操作对象。
		如果没有指定操作，与模式相匹配的输入行将被打印出来(执行打印语句是一个默认操作)

				示例: 若匹配空行，则插入一行字符串。
					root@zyb-ubt:/home/zyb/CODE/SHELL/shell_study/sed2awk# echo "" | awk '/^$/ {print "This is a blank line."}'
					This is a blank line.
					root@zyb-ubt:/home/zyb/CODE/SHELL/shell_study/sed2awk# echo "a" | awk '/^$/ {print "This is a blank line."}'
					root@zyb-ubt:/home/zyb/CODE/SHELL/shell_study/sed2awk#
		
	B) 记录和字段
		awk将每一行当做一个记录，每一行上的每个空格或者制表符分隔的单词作为字段(用来分隔字段的字符称为分隔符)。
		
		1) 字段的引用和分离:
			$0 		:		整个记录
			$1		:		第一个字段
			
			root@zyb-ubt:/home/zyb/CODE/SHELL/shell_study/sed2awk# cat names
			John    Robinson        666-555-1111

			root@zyb-ubt:/home/zyb/CODE/SHELL/shell_study/sed2awk# awk '{ print $2,$1,$3 }' names
			Robinson John 666-555-1111
			(print语句中分隔每个参数的逗号使得输出的各值之间有一个空格)
		
		2) 字段的另一个表示		:		可以用任何计算值为整数的表达式来表示一个字段，而不只是数字和变量。
			我在使用awk初期，为了和shell一起使用，经常有这样的需求:另寻它法表示字段，但是很难用对。
			
			root@zyb-ubt:/home/zyb/CODE/SHELL/shell_study/sed2awk# echo a b c | awk 'BEGIN {one=1;two=2 }
			> {print $(one + two)}'
			c
			
		3) 改变字段分隔符  -F：		-F后跟分隔符
			
			root@zyb-ubt:/home/zyb/CODE/SHELL/shell_study/sed2awk# awk -F"\t" '{print $2 }' names
			Robinson
			
			//文本
			root@zyb-ubt:/home/zyb/CODE/SHELL/shell_study/sed2awk# cat seg.txt
			John Robinson,Koren,Inc.,978 4th Ave.,Boston,MA 01760,696-0987
			Phyllis chapmqan,GVE Corp.,34 Sea Drive,Amesbury,MA 01881,879-0900
			
			//awk脚本
			root@zyb-ubt:/home/zyb/CODE/SHELL/shell_study/sed2awk# cat blocklist.awk
			# blocklist .awk --use block type to print name and addr
			# input a file: name、company、street、city、state、state zip、tel
			{
			print "" # output blank line
			print $1  # name
			print $2  # company
			print $3  # street
			print $4, $5 # city,state zip
			}

			//处理结果
			root@zyb-ubt:/home/zyb/CODE/SHELL/shell_study/sed2awk# awk -f blocklist.awk seg.txt

			John
			Robinson,Koren,Inc.,978
			4th
			Ave.,Boston,MA 01760,696-0987

			Phyllis
			chapmqan,GVE
			Corp.,34
			Sea Drive,Amesbury,MA
			
			root@zyb-ubt:/home/zyb/CODE/SHELL/shell_study/sed2awk# awk -F , -f blocklist.awk seg.txt

			John Robinson
			Koren
			Inc.
			978 4th Ave. Boston

			Phyllis chapmqan
			GVE Corp.
			34 Sea Drive
			Amesbury MA 01881

			
	C)  系统变量
		1) 默认值可修改的系统变量
		
			a) FS 		:		字段分隔符，通过定义它来设置字段分隔符，所以它必须在BEGIN例程中设置。
								
								root@zyb-ubt:/home/zyb/CODE/SHELL/shell_study/sed2awk# cat phonelist.awk
								# phonelist.awk --print name and tel
								# input file: name company street city state state zip tel
								BEGIN { FS = "," } #用逗号分隔字符  ======>>>BEGIN例程在主循环例程之前做操作

								{ print $1 ","$6 }
								root@zyb-ubt:/home/zyb/CODE/SHELL/shell_study/sed2awk# awk -f phonelist.awk seg.txt
								John Robinson,MA 01760
								Phyllis chapmqan,879-0900
								
								为FS赋值不影响当前输入行,它仅影响下一个输入行。
								
			
		2) 第二种类型定义的变量的值可以用于报告或数据处理中。
			a)  OFS 		也是分隔符，不过是输出的分割符。
			
			b)  NF			当前输入记录的字段的个数
				
				引用NF,即$NF,等同于应用字段一样。
					root@zyb-ubt:/home/zyb/CODE/SHELL/shell_study/sed2awk# cat block.awk
					# block.awk --打印第一个和最后一个字段
					# $1 = name;$NF = phone number
					BEGIN { FS = "\n"; RS = "" }
					{print $1, $NF }	====================>>>NR此时经过输入主循环，已经为最后的行的计数值了。
					
					root@zyb-ubt:/home/zyb/CODE/SHELL/shell_study/sed2awk# cat phones.block
					John Robinson
					Koren Inc.
					978 Commonwaelth Ave.
					Boston
					MA 01760
					696-0987
					
					root@zyb-ubt:/home/zyb/CODE/SHELL/shell_study/sed2awk# awk -f block.awk phones.block
					John Robinson 696-0987

			
			c)  RS			记录分隔符(是记录！！！)	
			
			d)  ORS			输出...
			
				root@zyb-ubt:/home/zyb/CODE/SHELL/shell_study/sed2awk# cat block.awk
				# block.awk --打印第一个和最后一个字段
				# $1 = name;$NF = phone number
				BEGIN { FS = "\n"; RS = "" }
				BEGIN { OFS = "\n"; ORS = "\n\n" }
				{print $1, $NF }
				root@zyb-ubt:/home/zyb/CODE/SHELL/shell_study/sed2awk# awk -f block.awk phones.block
				John Robinson
				696-0987

				如上所示，为了能将输出结果输出到每一行，就将输出字段分隔符设置为\n，而输出记录设置为\n\n
			
			e)  FILENAME	包含当前输入文件的名称
			
			f)	FNR			应用于多个输入文件的情景，被用来表示与当前输入文件相关的当前记录的代码。
			
			g)	CONVFMT		用来控制数字到字符串的专业
			
			h)	NR			读入的输入记录的个数
			
							root@zyb-ubt:/home/zyb/CODE/SHELL/shell_study/sed2awk# cat phonelist.awk
							# phonelist.awk --print name and tel
							# input file: name company street city state state zip tel
							BEGIN { FS = "," } #用逗号分隔字符

							{ print $1 ","$6 }
							END { print ""
									print NR, "records processed." }
						

			
		

	D)  模式匹配的使用
		1) ~		:   操作符，用于测试一个字段的正则表达式，这个非常有用,指定一个字段去匹配，而非其他字段。
		
							root@zyb-ubt:/home/zyb/CODE/SHELL/shell_study/sed2awk# cat seg.txt
							John Robinson,Koren,Inc.,978 4th Ave.,Boston,MA 01760,696-0987
							Phyllis chapmqan,GVE Corp.,34 Sea Drive,Amesbury,MA 01881,879-0900
							
							root@zyb-ubt:/home/zyb/CODE/SHELL/shell_study/sed2awk# awk '{print $5}' seg.txt
							01760,696-0987
							Drive,Amesbury,MA
							
							root@zyb-ubt:/home/zyb/CODE/SHELL/shell_study/sed2awk# awk '$5 ~ /MA/ {print $1 "," $6 }' seg.txt
							Phyllis,01881,879-0900
							
		2) !~		:	..., !用于反转~的含义。
		
							root@zyb-ubt:/home/zyb/CODE/SHELL/shell_study/sed2awk# awk '$5 !~ /MA/ {print $1 "," $6 }' seg.txt
							John,
			
							root@zyb-ubt:/home/zyb/CODE/SHELL/shell_study/sed2awk# awk '$6 ~ /1?(-| )?\(?[0-9]+\)?( |-)?[0-9]+-[0-9]+/' seg.txt
							Phyllis chapmqan,GVE Corp.,34 Sea Drive,Amesbury,MA 01881,879-0900

							解释：
							1?
							(-| )?			查找一个连字符或一个空格，或者什么也没有
							\(?
							[0-9]+
							\)?
							( |-)?
							[0-9]+-[0-9]+	查找在一个连字符两边的两组数字。======>>> 879-0900
	
	E) 字段的划分：完整的问题
		
		1) 用空格来分割字段
			这种情况下，记录的前导空白字符和结尾空白字符将被忽略。
			
		2)	使用单个字符来划分
		
		3) 使用多个字符来做分隔符
			此时，该分隔符将被作为一个正则表达式来解释。
			 
			 FS='\t',此时将\t作为字段分隔符
			 FS='\t+',此时将一个或多个制表符来分隔字段。
		
			 
			可以使用一个正则表达式指定几个字符分隔符
			FS = "[':\t]"  	   ==============>>>>>    在【】中的三个字符之一都可以被解释成字段分隔符。
			
			这种用法很有用，因为待处理的字符并不总是成规律或者按照我们想要的成规律的,所以我们可以按照文本的大概的样式来设定切割方式。
	
	
	F) 表达式	: 	
		
		1) 可以使用表达式来存储、操作和检索数据，这些操作与在sed中的有很大的区别，但这是大多数程序设计语言所具有的共同特性。
		2) 一个表达式，通过计算返回一个值;
		3) 表达式由数字和字符串常量、变量、操作符、函数和正则表达式组成。
		
		
		1) 常量
			a) 字符串型:
				字符串，在表达式中必须用引号括起来。
				
					在字符串中可以使用下列转义序列。
					\a		报警字符，通常是ASCII BEL字符
					\b		退格键
					\f		走纸符
					\t		水平制表符	
					\v		垂直制表符
					\ddd 	将字符表示唯为1到3位八进制
					\xhex	将字符表示为16进制。
					\c		任何需要字面表示的字符。
					\r		回车
					\n		换行
				
			b) 整数型:
		
		2) 变量		: 变量是引用值的标识符;定义它,只需要为它定义一个名字并将数据赋给它即可。
	
			特点：
				类型安全
				区分大小写
				不必初始化，awk自动将他们初始化为空字符串,如果作为数字，它的值为0。(理解这一点很重要，特别是写c/c++的程序员.)
				
				x = "hello"
				
				空格是字符串连接符
				z = "hello" "world!"
				
		3) 表达式
		
		-----------------.
		.	   .         .
		.操作符.  描述   .
		-----------------.
		. +    .	     .
		-----------------.
		. -    .         .
		-----------------.
		. *    .         .
		-----------------.
		. /    .         .
		-----------------.
		. %    .  取模	 .
		-------.---------.
		. ^    .  取幂   .
		-------.---------.
		. **   .  取幂a  .
		.------.---------.
		
		----------------------------
		.	   .                   .
		.操作符.  定义             .
		---------------------------.
		. ++   .  变量加1          .
		---------------------------.
		. --   .  变量减1          .
		---------------------------.
		. +=   .  加等于           .
		---------------------------.
		. -=   .                   .
		---------------------------.
		. *=   .  		           .
		-------.-------------------.
		. /=   .  		           .
		-------.-------------------.
		. %=   .  		           .
		.------.-------------------.
		. ^=   .  		           .
		.------.-------------------.
		. **=  . 	               .
		.------.-------------------.
		
		x = 1
		print x +  1  ===================>>> x == 2?  error 
		
		print x += 1  ===================>>> x == 2?  right
		
		
		x += 1
		x = x+1
		++x

		
	G) 处理多行记录		: 	
	
			root@zyb-ubt:/home/zyb/CODE/SHELL/shell_study/sed2awk# cat checkbook.awk
			# checkbook.awk
			BEGIN { FS = "\t" }

			#1 期望第一条记录为初始余额
			NR == 1 { print "Beginning Balance:\t"$1
					balance = $1
					next    #取得下一条记录！！！
			}

			#2 应用于每个支票记录，将余额和数量相加
			{
					print $1,$2,$3
					print balance += $3     # 支票数额有负数
			}
			
			root@zyb-ubt:/home/zyb/CODE/SHELL/shell_study/sed2awk# awk -f checkbook.awk check.txt
			Beginning Balance:      1000
			125 market -125.45
			874.55
			126 Hardware Store -34.95
			839.6
			127 Video Store -7.45
			832.15
			128 Book Store -14.32
			817.83
			129 Gasoline -16.10
			801.73
			
	H) 关系操作符合布尔操作符
	
		1) 关系操作符
			<		:
			>		:
			<=		:
			>=		:
			==		:		相等
					
					
				
			!=		:
			~		:		匹配
			!~		:		不匹配
		
		2) 布尔操作符
			||		:		或
			&&		:		与
			！		:		非
		
	I) 格式化打印
		
			printf	:		没有提供自动换行功能，必须明确地为它指定"\n"
			
			printf(format_expression[,argumnets])
						 .				  .	
						/|\              /|\
						 |	              |	
						 |                |---------->参数列表，例如：变量名列表，它和格式表达式相对应。
                         |
                         |
                         |------------>第一部分，圆括号可选，用来描述格式的表达式。
			
			等同于c语言的sprintf(char *dststring,char *formart,...);


		printf中的格式使用:
		
			printf使用的转义字符

			转义字符			定义
			   c	                字符
			   s	                字符串
			   d	                十进制整数
			   ld	                十进制长整数
			   u	                十进制无符号整数
			   lu	                十进制无符号长整数
			   x	                十六进制整数
			   lx	                十六进制长整数
			   o	                八进制整数
			   lo	                八进制长整数
			   e	                用科学记数法(e 记数法)表示的浮点数
			   f	                浮点数
			   g	                选用e或f中较短的一种形式
			 

			printf的修饰符

			字符				定义
			
			-						左对齐修饰符
			#						显示8 进制整数时在前面加个0
									显示16 进制整数时在前面加0x
			+						显示使用d 、e 、f 和g 转换的整数时，加上正负号+或-
			0						用0而不是空白符来填充所显示的值
			 

			printf的格式说明符

			格式说明符			功能
			
			%c						打印单个ASCII 字符
									printf("The character is %c\n",x)
									输出: The character is A
									
			%d						打印一个十进制数
									printf("The boy is %d years old\n",y)
									输出：The boy is 15 years old
									
			%e						打印数字的e 记数法形式
									printf("z is %e\n",z) 		
									输出: z is 2.3e+0 1
			
			%f						打印一个浮点数
									printf("z is %f\n", 2.3 * 2)
									输出: z is 4.600000
			
			%o						打印数字的八进制
									printf("y is %o\n",y)
									输出：z is 17
			
			%s						打印一个字符串
									print("The name of the culprit is %s\n",$1)
									输出：The name of the culprit is Bob Smith
			
			%x						打印数字的十六进制值
									printf("y is %x\n",y)
									输出：x is f

	J) 向脚本传递参数		:		参数将值赋给一个变量，这个变量可以在awk脚本中访问。
									这个变量可以在命令行上设置，放在脚本的后面，文件名的前面。
		
		awk 'script' var=value inputfile  //严格要求，在=号的两边不允许出现空格。

		这个一定要明白，awk的参数和shell的参数是不一样的，shell中参数1为$1,而awk中$1表示字段1。
		
							(
								也可以使用命令行参数定义系统变量。
									awk '{ print NR, $0 }' OFS=',' names
							)	
		
		这种传参的局限性以及改进
		
		局限性：
			示例:
					root@zyb-ubt:/home/zyb/CODE/SHELL/shell_study/sed2awk# cat seg.txt
					John Robinson,Koren,Inc.,978 4th Ave.,Boston,MA 01760,696-0987
					Phyllis chapmqan,GVE Corp.,34 Sea Drive,Amesbury,MA 01881,879-0900
					root@zyb-ubt:/home/zyb/CODE/SHELL/shell_study/sed2awk# cat a.txt
					ajksnckloacsmamklavsdclknmajksncalscnlkacnalkcvnaca
					root@zyb-ubt:/home/zyb/CODE/SHELL/shell_study/sed2awk# awk 'BEGIN {print n}
					{ if (n==1) print "reading the 1 book"
					if (n==2) print "reading the 2 book"
					}' n=1 seg.txt n=2 a.txt

					reading the 1 book
					reading the 1 book
					reading the 2 book
					root@zyb-ubt:/home/zyb/CODE/SHELL/shell_study/sed2awk# awk 'BEGIN {print n}
					{ if (n==1) print "reading the 1 book"
					if (n==2) print "reading the 2 book"
					}' n=1 a.txt n=2 seg.txt

					reading the 1 book
					reading the 2 book
					reading the 2 book
					root@zyb-ubt:/home/zyb/CODE/SHELL/shell_study/sed2awk# awk 'BEGIN {if (n==1)print n}' n=1 a.txt
			------>>根据以上awk输出结果,可以看出，命令行传入的参数并不能再BEGIN例程中得以使用。
			这是因为,从命令行传递的参数就像是被awk当做文件名的,赋值操作直到这个变量被求值时才进行。
			这就造成，如果我们要在BEGIN例程中就要对参数有动作，那么这将不能得以实现。
			
		改进:
			为了能在任何输入被读入前定义参数,-v选项指定在执行BEGIN过程之前得到变量赋值。-v选项必须在一个命令行脚本前说明。
			
				示例:
					root@zyb-ubt:/home/zyb/CODE/SHELL/shell_study/sed2awk# awk '{print}' RS=' ' phones.block
					John
					Robinson
					Koren
					Inc.
					978
					Commonwaelth
					Ave.
					Boston
					MA
					01760
					696-0987

					root@zyb-ubt:/home/zyb/CODE/SHELL/shell_study/sed2awk# awk RS=' ' '{print}' phones.block
					awk: line 1: syntax error at or near end of line

					root@zyb-ubt:/home/zyb/CODE/SHELL/shell_study/sed2awk# awk -v n=1 'BEGIN {print n}
					> {
					> if (n==1) print "reading the first book"
					> if (n==2) print "reading the second book"
					> } ' seg.txt
					1
					reading the first book
					reading the first book


					
awk程序设计逻辑:
	A)条件
		if (expression)
			action1
		[else
			action2]

		使用注意事项:
			1). 如果操作由多个语句组成，则要用一对大括号括起来。

			if (expression) { 		----------------------->左括号可与expression一行,也可下一行单独一行，也可与第一条语句一行
			action1 s1
			action1_s2
			...
			} --------------------->右括号可与最后一条语句一行也可下一行;总之与c语言的用法一致
			[else	---------------------> 也可以这样[else action2]
				action2]

			if (expression) action_s1; [else action2]
			if (expression) (action_s1;action1 s2;action1 _3:)leise action2] //使用多个分号分隔多个语句，必须使用大括号

		使用示例:
			1).1f (x ~ /[Yy](es)?/) print x
				测试x是否与一个模式匹配

			2) .awk也支持条件运算符
			grade = ( avg>=65 )?"Pass":"Fail"

	B) 循环

		1). while循环

			a)	while (condition)
				action
			b)	while (condition)action

			c)	while (condition)
				{
					action1
					action 2
					...
				}
				
			d) Do循环

				do
					action
				while (condition)

				do act1on wh1le (condit1on)

			e) for循环

				for (a;b;c) action


	C) 数组----------关联数组(类似于c++的map, 可以建立很多种类型的键值对之间的匹配关系)
		1) awk中的关键:
			a) 不用指定数组大小.要谨记这条规则
			
			示例:
			acro["BASIC"] = "Beginner's All-Purpose Symbolic Instruction Code"
		
		2) 测试某个值是否是数组中的成员
			item in array <<=-=>> array[item]存在则返回1，否 则返回o

		3) 删除数组中的一个元素
			delete array[subscript]

		4) awk不支持多维数组，只能使用模拟方式来应用多维数组

			file array[NR,1]
				file array[2,4] <<======>> 即文本中第二行记录的第四个字段。

	D) 常用函数

		1)
			n = split (input string, array,seperator);
											/|\
											 |
											 |
											 |
											 |
											 .-----------> 1) 若seperator没指定，则默认为$FS
																	2) seperator可为正则表达式
		2)  exp(x) 		e的x次幂
			sqrt (x)
			int(x) 		x的整数截断
			rand()		返回随机数x, 0<=x<1
			srand(x)	为rand()产生新的种子数，使得rand()被多次调用时能产生真正的随机数。

		3) 字符串函数
		
			geub(exreg, substring, mainstring)  //用substring替换mainstring 中和正则表达式exreg匹配的所有字符串
			sub(exreg, substring, mainstring) 	//替换mainstring中首次匹配exreg的substring
			substr(malnstring,p, n)				//返回mainstring中从p处开始的长度为n的字符串
			index(mainstring,substring)			//返回substring在mainstring中的位置
			length(mainstring)					//返回mainstring的长度
			match(exreg, mainstring)			//若mainstring中有匹配正则表达式exreg,则返回首次匹配的字符的起始位置
			tolower(mainstring)					//转大写
			toupper(mainstring)					//转小写
			
		4) 自定义函数
		
			function insert(argv_1,argv_2)
			{
				action_1
				action_2
				...
			}
		5) getline <<=========>> next
		
	我们很多时候，都是在shell脚本中调用awk脚本来完成特定的逻辑，所以我们常常需要
		1) 在shell中给awk传递参数。
			传参两种方式:
				a) awk -v argv="value" input.txt
				b) awk -f "script" argv="value" input.txt
				
		2) 在awk中执行shell命令。
			a) 使用函数 system()函数
			system()函数执行一个以表达式给出的命令。
			
				示例1：
				root@zyb-ubt:/home/zyb/CODE/SHELL/shell_study/sed2awk# cat category.txt
				/home/zyb
				root@zyb-ubt:/home/zyb/CODE/SHELL/shell_study/sed2awk# awk '{cmd="ls -alt ";system(cmd $0)}' category.txt
				总用量 128
				drwxrwxrwx 12 root root 4096 11月 19 23:08 BASE_CODE
				drwxrwxrwx 16 root root 4096 11月 14 17:57 CODE
				drwxrwxrwx 24 root root 4096 11月  8 11:34 CPP_CODE_BASE
				drwxr-xr-x  3 root root 4096 11月  8 10:37 ..
				drwxrwxrwx 23 zyb  zyb  4096 11月  7 22:35 .
				-rw-------  1 zyb  zyb   111 11月  1 23:17 .bash_history
				drwxr-xr-x  5 root root 4096 11月  1 21:32 SHELL
				drwx------  2 root root 4096 10月 30 21:52 test
				-rw-------  1 zyb  zyb  1940 10月 25 15:56 .ICEauthority
				drwx------  3 zyb  zyb  4096 10月 25 15:56 .gnupg
				-rw-------  1 zyb  zyb    84 10月 25 15:56 .xsession-errors
				-rw-------  1 zyb  zyb   104 10月 25 15:56 .Xauthority
				drwxrwxrwx  2 root root 4096 10月 11 20:04 LITTLE_BIN
				drwx------ 17 zyb  zyb  4096 9月  30 20:27 .config
				-rw-------  1 zyb  zyb   582 9月  30 20:27 .xsession-errors.old
				drwxrwxrwx  4 root root 4096 9月  20 21:13 DATABASE
				drwxrwxrwx  3 root root 4096 8月   6 08:33 BOOK
				drwxrwxrwx  8 root root 4096 7月  19 13:11 TOOL
				drwxrwxrwx  2 root root 4096 7月  11 01:39 Person_Important
				drwxrwxrwx  3 root root 4096 6月  15 23:38 OPEN_SOURCE
				drwxrwxrwx  2 root root 4096 4月  19  2020 BLOG
				drwxrwxrwx  2 root root 4096 4月  19  2020 LEANOVO
				drwxrwxrwx  3 root root 4096 1月  15  2020 KERNEL
				drwx------  9 zyb  zyb  4096 1月  12  2020 .cache
				-rw-r--r--  1 zyb  zyb     0 1月   5  2020 .sudo_as_admin_successful
				drwx------  2 zyb  zyb  4096 1月   5  2020 .gconf
				drwx------  2 zyb  zyb  4096 1月   5  2020 .presage
				drwx------  3 zyb  zyb  4096 1月   5  2020 .dbus
				drwx------  3 zyb  zyb  4096 1月   5  2020 .local
				-rw-r--r--  1 zyb  zyb    25 1月   5  2020 .dmrc
				-rw-r--r--  1 zyb  zyb   220 1月   5  2020 .bash_logout
				-rw-r--r--  1 zyb  zyb  3771 1月   5  2020 .bashrc
				-rw-r--r--  1 zyb  zyb   655 1月   5  2020 .profile
		
		
				示例2：
				root@zyb-ubt:/home/zyb/CODE/SHELL/shell_study/sed2awk# awk 'BEGIN{if (system("mkdir dale") != 0)print "failed";else print "ok" }'
				ok
				
				
				