# blocklist .awk --use block type to print name and addr
# input a file: name、company、street、city、state、state zip、tel
{
print "" # output blank line
print $1  # name
print $2  # company
print $3  # street
print $4, $5 # city,state zip
}
