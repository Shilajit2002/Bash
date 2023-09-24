echo -n "Enter the File1 Path : "
read file1
echo -n "Enter the File2 Path : "
read file2
if [ -f $file1 ] && [ -f $file2 ]; then
    rsync $file1 $file2
    echo "File1 Content is Copied to File2 "
else
    echo "File1 & File2 doesnot exist"
fi
