echo -n "Enter the File Name : "
read fileName

if [ -f $fileName ]; then
    echo -n "Total Lines in the file $fileName : "
    lines=$ grep -c ^ $fileName
else
    echo -e "\n'$fileName' is not a file\n"
fi