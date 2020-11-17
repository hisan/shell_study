
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
			

				
	
				




		
			
	
	
	
	
	
	
	


	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	

	
	
	





























	
