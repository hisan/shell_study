# phonelist.awk --print name and tel
# input file: name company street city state state zip tel
BEGIN { FS = "," } #用逗号分隔字符
BEGIN { OFS = "\n"; ORS = "\n\n" }
NF == 6 { print $1 ","$6 }
END { print ""
	print NR, "records processed." }
