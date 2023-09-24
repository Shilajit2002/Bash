word="laboratory"
flag=true

for args in "$@"; do
    n=$(grep $word $args)
    if [[ $n == $word ]]; then
        echo "File $args containing the Word $word"
        flag=false
        break
    fi
done

if [ $flag == true ]; then
    echo "No Files are containing the Word $word"
fi
