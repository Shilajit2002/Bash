echo -n "Enter Total number of Rows : "
read n
for ((i = 1; i <= n; i++)); do
    for ((j = 1; j <= (n - i) * 2 + 1; j++)); do
        echo -n " "
    done
    for ((j = 1; j <= i; j++)); do
        echo -n " |z  "
    done
    echo ""
done
