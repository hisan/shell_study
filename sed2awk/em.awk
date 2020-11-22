#BEGIN { FS = "\t" }
BEGIN { FS = "[':\t]" }
{ print $1,$2,$3,$4 }
