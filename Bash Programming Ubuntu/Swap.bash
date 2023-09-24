# Using Third Variable
echo "Using Third Variable"
echo -n "Enter a : "
read a
echo -n "Enter b : "
read b

c=0

echo "a = $a || b = $b"

c=$(($a))
a=$(($b))
b=$(($c))

echo "a = $a || b = $b"

echo "----------------------"

# Not using Third Variable
echo "Not using Third Variable"
echo -n "Enter a : "
read a
echo -n "Enter b : "
read b

echo "a = $a || b = $b"

a=$(($a + $b))
b=$(($a -$b))
a=$(($a -$b))

echo "a = $a || b = $b"