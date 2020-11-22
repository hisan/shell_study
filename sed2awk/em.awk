#BEGIN { FS = "\t" }
BEGIN { FS = "[':\t]" }
NF == 2 { print $1,$2,$3,$4 }
