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
	2) ;							sed ‘s/M/MessAge/p;s/NB/NewBI/p' 			(此中用法，要注意只用一对引号)
	3) 使用she11的分行 				回车换行(不实用)

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

		2) 使用shell的分行						回车换行(不实用)

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

	1).[过程)
	2).‘指令’
	3)./正则表达式1

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
			
			\(n,m\}		:		匹配它前面出现x次的单个字符

				\{n)	:		x == n

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
								root@zyb-ubt:~# sed-n'1p' gample.txt
								abc

		3) 地址范围		:		处理该地址范围内的所有行
								root@zyb-ubt:~# sed -n '1,3p* sample. txt
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
		(所以,字符类的匹配结果，情况更多是组合而不是唯一。)
		
		-		:	连字符
		
		当它不在第一个或者最后一个位置时，表示一个范围	
		由此，比如我们为了匹配加减乘除，我们应该为[-+*/]或者[+*/-]，当然，我们也可以使用\-来转义，但是比较乱。
		它也可以在字符类中混合其他字符一起用，如[a-z?,.;']
		
多个字符类的使用：
	[exp1][exp2],则是递进关系，即先由exp1过滤,再由exp2过滤.
	
	
POSIX类补充					匹配的字符		

字符类:		由[:字符类:]组成
	[:alnum:]			可打印的字符
	[:alpha:]			字母字符
	[:blank:]			空格和制表符	
	[:cntrl:]			控制字符
	[:digit:]			数字字符
	[:graph:]			可打印的和可见的(非空格)字符
	[:lower:]			小写字符
	[:print:]			可打印的字符（包括空白字符）
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
			root@zyb-ubt:/home/zyb/CODE/SHELL/shell_study/sed2awk# cat email_t.txt
			From: Linus Torvalds <torvalds@linux-foundation.org>
			Newsgroups: fa.linux.kernel
			Subject: Re: [git pull][resend] Input updates for 2.6.22-rc7
			Date: Thu, 05 Jul 2007 23:09:49 UTC
			Message-ID: <fa.dJLARsFLFkz9Isp0gVJ6B6Vlk8I@ifi.uio.no>

			root@zyb-ubt:/home/zyb/CODE/SHELL/shell_study/sed2awk# sed '/^From/,/^$/c\
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

下一步 next next改变了正常的流控制，直到到达脚本的底部才会输出模式空间的内容。

		[address]n
			
			128page
	


	
	
	

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
			
		2) 第二种类型定义的变量的值可以用于报告或数据处理中。
		
		

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
		
		
		
		
		






	







































	
