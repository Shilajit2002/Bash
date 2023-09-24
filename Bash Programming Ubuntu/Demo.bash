declare -A pro

for((i=0;i<3;i++)); do
    for((j=0;j<3;j++)); do
        read pro[$i,$j]
    done
done

for((i=0;i<3;i++)); do
    for((j=0;j<3;j++)); do
        printf "%s\t" ${pro[$i,$j]}
    done
    printf "\n"
done