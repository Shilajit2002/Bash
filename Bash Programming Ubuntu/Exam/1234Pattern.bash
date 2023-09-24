echo -n "Enter total no. of rows = "
read n

count=0

for((i=$n;i>=1;i--)); do
    for((space=1;space<=$n-$i;space++)); do
        echo -n " " 
    done
    for((j=1;j<=$i;j++)); do
        count=$(($count + 1))
        echo -n "$count  "
    done
    echo
done
