echo -n "Enter Salary = "
read basicSalary

if [ $basicSalary -lt 1500 ]; then
    HRA=$((($basicSalary * 10) / 100))
    echo "HRA = $HRA"

    DA=$((($basicSalary * 90) / 100))
    echo "DA = $DA"

    GS=$((($basicSalary) + ($HRA) + ($DA)))
    echo "Gross Salary = $GS"

elif [ $basicSalary -ge 1500 ]; then
    HRA=$(($basicSalary + 500))
    echo "HRA = $HRA"

    DA=$((($basicSalary * 98) / 100))
    echo "DA = $DA"

    GS=$((($basicSalary) + ($HRA) + ($DA)))
    echo "Gross Salary = $GS"
fi
