# phonelist.awk --print name and tel
# input file: name company street city state state zip tel
BEGIN { FS = "," } #用逗号分隔字符

{ print $1 ","$6 }
