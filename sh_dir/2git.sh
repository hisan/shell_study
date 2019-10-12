#！/bin/bash
exec 0<passwd
git add --all .
git commit -m "info"
git push origin master

