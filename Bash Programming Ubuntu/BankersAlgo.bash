# # BankersAlgo() {

# # }

# echo -n "Enter total no. of Process = "
# read p
# echo -n "Enter total no. of Resources = "
# read r

# # Declare all 2D Arrays
# declare -A Max
# declare -A Allocation
# declare -A Need

# # Process Id Matrix
# echo -n "Enter Process Id's : "
# for ((i = 0; i < $p; i++)); do
#     read pId[$i]
# done

# # Max Matrix
# echo -n "Enter Data for Max Matrix : "
# for ((i = 0; i < $p; i++)); do
#     for ((j = 0; j < $r; j++)); do
#         read Max[$i,$j]
#     done
# done

# # Allocation Matrix
# echo -n "Enter Data for Allocation Matrix : "
# for ((i = 0; i < $p; i++)); do
#     for ((j = 0; j < $r; j++)); do
#         read Allocation[$i,$j]
#     done
# done

# # Resource Matrix
# echo -n "Enter Resource Data : "
# for ((i = 0; i < $r; i++)); do
#     read Resource[$i]
# done

# # Calculate Need Matrix
# for ((i = 0; i < $p; i++)); do
#     for ((j = 0; j < $r; j++)); do
#         a=${Max[$i,$j]}
#         b=${Allocation[$i,$j]}
#         if [ $a -ge $b ]; then
#             a=${Max[$i,$j]}
#             b=${Allocation[$i,$j]}
#             Need[$i,$j]=$(($a - $b))
#         else
#             echo "Max Matrix should be Greater than Allocation Matrix"
#             break
#         fi
#     done
# done

# # Calculate Total Allocation of Process
# for ((i = 0; i < $r; i++)); do
#     TotalAllocation[$i]=0
#     for ((j = 0; j < $p; j++)); do
#         a=${Allocation[$j,$i]}
#         TotalAllocation[$i]=$((${TotalAllocation[$i]} + $a))
#     done
# done

# for((i=0;i<$r;i++)); do
#     echo "${TotalAllocation[$i]}"
# done

# # Calculate Available
# for ((i = 0; i < $r; i++)); do
#     Available[$i]=$((${Resource[$i]} - ${TotalAllocation[$i]}))
# done

# # BankersAlgo

# completed=0
# count=0
# for ((i = 0; i < $p; i++)); do
#     Finish[$i]=0
# done

# while [ $completed != $p ]; do
#     for ((i = 0; i < $p; i++)); do
#         if [ ${Finish[$i]} == 0 ]; then
#             for ((j = 0; j < $r; j++)); do
#                 a=${Need[$i,$j]}
#                 if [ $a -le ${Available[$j]} ]; then
#                     count=$(($count + 1))
#                 fi
#             done
#             if [ $count == $r ]; then
#                 for ((k = 0; k < $r; k++)); do
#                     a=${Allocation[$i,$k]}
#                     Available[$k]=$((${Available[$k]} + $a))
#                 done
#                 echo "${pId[$i]}"
#                 completed=$(($completed + 1))
#                 Finish[$i]=1
#             fi
#             count=0
#         fi
#     done
# done
# printf "<"
# for ((i = 0; i < $p - 1; i++)); do
#     printf " %s ," ${Process[$i]}
# done
# printf " %s >" ${Process[$i]}

echo -n "Enter the Total number of Processes : "
read pnum
echo -n "Enter the Total number of Resources : "
read rnum

declare -A PROCESSID
echo "Enter $pnum Process Id : "
read -a m
for ((i = 1; i <= pnum; i++)); do
    j=$((i - 1))
    PROCESSID[$i]=${m[j]}
done

declare -A MAX
echo "Enter MAX matrix of size $pnum x $rnum : "
for ((i = 1; i <= pnum; i++)); do
    read -a m
    for ((j = 1; j <= rnum; j++)); do
        k=$((j - 1))
        MAX[$i,$j]=${m[k]}
    done
done

declare -A ALLOCATION
echo "Enter ALLOCATION matrix of size $pnum x $rnum : "
for ((i = 1; i <= pnum; i++)); do
    read -a m
    for ((j = 1; j <= rnum; j++)); do
        k=$((j - 1))
        ALLOCATION[$i,$j]=${m[k]}
    done
done

declare -A NEED
for ((i = 1; i <= pnum; i++)); do
    for ((j = 1; j <= rnum; j++)); do
        NEED[$i,$j]=$((${MAX[$i,$j]} - ${ALLOCATION[$i,$j]}))
    done
done

declare -A REQUEST
echo "Enter REQUEST matrix of size $pnum x $rnum : "
for ((i = 1; i <= pnum; i++)); do
    read -a m
    for ((j = 1; j <= rnum; j++)); do
        k=$((j - 1))
        REQUEST[$i,$j]=${m[k]}
    done
done

declare -A AVAILABLE
echo "Enter AVAILABLE matrix of size $rnum : "
read -a m
for ((i = 1; i <= rnum; i++)); do
    j=$((i - 1))
    AVAILABLE[$i]=${m[j]}
done

# Check Request is Greater than Need or Not
for ((i = 1; i <= pnum; i++)); do
    for ((j = 1; j <= rnum; j++)); do
        if [ ${REQUEST[$i,$j]} -gt ${NEED[$i,$j]} ]; then
            echo "The request is invalid as it is asking for more resources than needed."
            exit
        fi
    done
done

for ((i = 1; i <= rnum; i++)); do
    total=0
    for ((j = 1; j <= pnum; j++)); do
        total=$((total + ${REQUEST[$j,$i]}))
    done
    if [ $total -gt ${AVAILABLE[$i]} ]; then
        echo "The request cannot be fulfilled as it is asking for more resources than currently available."
        exit
    fi
done

declare -A newALLOCATION
declare -A newNEED
declare -A newAVAILABLE

for ((i = 1; i <= rnum; i++)); do
    newAVAILABLE[$i]=${AVAILABLE[$i]}
done

for ((i = 1; i <= pnum; i++)); do
    for ((j = 1; j <= rnum; j++)); do
        newALLOCATION[$i,$j]=$((${ALLOCATION[$i,$j]} + ${REQUEST[$i,$j]}))
        newNEED[$i,$j]=$((${NEED[$i,$j]} - ${REQUEST[$i,$j]}))
        newAVAILABLE[$j]=$((${newAVAILABLE[$j]} - ${REQUEST[$i,$j]}))
    done
done

declare -A WORK
declare -A FINISH
for ((i = 1; i <= rnum; i++)); do
    WORK[$i]=${newAVAILABLE[$i]}
done

for ((i = 1; i <= pnum; i++)); do
    FINISH[$i]=0
done

function allProcessFinished() {
    for ((i = 1; i <= pnum; i++)); do
        if [ ${FINISH[$i]} -eq 0 ]; then
            return 0
        fi
    done
    return 1
}

allFinished=0
id=1

while [ $allFinished -eq 0 ]; do
    selectedProcess=0
    for ((i = 1; i <= pnum; i++)); do
        if [ ${FINISH[$i]} -eq 0 ]; then
            executionPossible=1
            for ((j = 1; j <= rnum; j++)); do
                if [ ${newNEED[$i,$j]} -gt ${WORK[$j]} ]; then
                    executionPossible=0
                fi
            done
            if [ $executionPossible -eq 1 ]; then
                selectedProcess=$i
                break
            fi
        fi
    done
    if [ $selectedProcess -eq 0 ]; then
        echo "The request cannot be fulfilled as the resource allocation state is not safe. Allocating the requested resource will lead to deadlock."
        exit
    else
        FINISH[$selectedProcess]=1
        for ((i = 1; i <= rnum; i++)); do
            WORK[$i]=$((${WORK[$i]} + ${newALLOCATION[$selectedProcess,$i]}))
        done
        Chart[$id]=${PROCESSID[$selectedProcess]}
        id=$(($id + 1))
    fi
    allProcessFinished
    allFinished=$?
done
echo "The request has been fulfilled as the resource allocation state is safe."
# Safe Sequence
echo "---- Safe Sequence ----"
printf "<"
for ((i = 1; i < $id - 1; i++)); do
    printf " %s ," ${Chart[$i]}
done
printf " %s >" ${Chart[$i]}