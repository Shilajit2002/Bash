echo -n "Enter total no. of Terms = "
read n

fact=1
sum=0

for ((i = 1; i <= $n; i++)); do
    fact=$(($fact * $i))
    div=$(($fact / $i))
    sum=$(($sum + $div))
done

echo "Sum of the Sereis 1!/1 + 2!+2 + 3!/3.... = $sum"
