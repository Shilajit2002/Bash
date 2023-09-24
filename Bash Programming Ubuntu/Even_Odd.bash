echo -n "Enter a Number = "
read a

if [ $((a % 2)) -eq 0 ]; then
    echo "$a is a Even Number"
else
    echo "$a is a Odd Number"
fi
