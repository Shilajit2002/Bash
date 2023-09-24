d=$(ls -l | grep "^d" | wc -l)
echo "No. of Sub-Directories : $d"

f=$(ls -l | grep "^-" | wc -l)
echo "No. of Files : $f"
