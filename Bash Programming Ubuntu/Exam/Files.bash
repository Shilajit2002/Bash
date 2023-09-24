if cmp -s "$1" "$2"; then
    printf 'The file "%s" is the same as "%s"\n' "$1" "$2"
    rm $2
    echo -n "Total Lines in the file $1 : "
    lines=$ grep -c ^ $1
else
    printf 'The file "%s" is different from "%s"\n' "$1" "$2"
fi