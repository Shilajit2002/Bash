# Sort the Process Using Start Time for Gnatt Chart
sort() {
    # Selection Sort
    for ((i = 0; i < $n; i++)); do
        key=${startTime[$i]}
        pro=${process[$i]}
        comp=${completionTime[$i]}

        for ((j = $i - 1; j >= 0 && ${startTime[$j]} > $key; j--)); do
            startTime[$j + 1]=${startTime[$j]}
            process[$(($j + 1))]=${process[$j]}
            completionTime[$(($j + 1))]=${completionTime[$j]}
        done

        startTime[$(($j + 1))]=$key
        process[$(($j + 1))]=$pro
        completionTime[$(($j + 1))]=$comp
    done
}

scheduleProcess() {
    # Set value
    for ((i = 0; i < $n; i++)); do
        isCompleted[$i]=0
    done

    currentTime=0
    completed=0
    averageTAT=0
    averageWT=0

    # Calculation
    while [ $completed != $n ]; do
        idx=-1
        min=100000000

        # Compare Arrival & Burst Time
        for ((i = 0; i < $n; i++)); do
            # Check any process is start or not..If the process start then check it is complete or incomplete
            if [ ${arrivalTime[$i]} -le $currentTime ] && [ ${isCompleted[$i]} == 0 ]; then
                # Check which process burst time is lesss
                if [ ${burstTime[$i]} -lt $min ]; then
                    min=${burstTime[$i]}
                    idx=$i
                fi
                # Check both process burst time is equal
                if [ ${burstTime[$i]} == min ]; then
                    # Check which process arrival time is less
                    if [ ${arrivalTime[$i]} -lt ${arrivalTime[$idx]} ]; then
                        min=${burstTime[$i]}
                        idx=$i
                    fi
                fi
            fi
        done

        # If the process index is valid
        if [ $idx != -1 ]; then

            # Calculation
            startTime[$idx]=$currentTime
            completionTime[$idx]=$((${startTime[$idx]} + ${burstTime[$idx]}))
            turnAroundTime[$idx]=$((${completionTime[$idx]} - ${arrivalTime[$idx]}))
            waitingTime[$idx]=$((${turnAroundTime[$idx]} - ${burstTime[$idx]}))
            responseTime[$idx]=$((${startTime[$idx]} - ${arrivalTime[$idx]}))

            # Average Turn Around Time Calculation
            averageTAT=$(($averageTAT + ${turnAroundTime[$idx]}))
            # Average Waiting Time Calculation
            averageWT=$(($averageWT + ${waitingTime[$idx]}))

            # Set this process completed
            isCompleted[$idx]=1
            # Increase the completed
            completed=$(($completed + 1))
            # Current time should be the completion time of this process
            currentTime=${completionTime[$idx]}
        # If the process index is not valid
        else
            currentTime=$(($currentTime + 1))
        fi
    done
}

# Print the Process
print() {
    # Heading
    printf "\n\tShortest Job Scheduling First Algorithm (SJF)--Non-PreEmptive\n"

    # Table Border
    echo "================================================================================================================================================"
    # Table Header
    printf "| %-15s| %-18s| %-18s| %-20s| %-20s| %-20s| %-18s|\n" "Process" "Arrival Time" "Burst Time" "Completion time" "Turn around time" "Waiting time" "Response Time"
    # Table Border
    echo "================================================================================================================================================"

    # Table Value
    for ((i = 0; i < $n; i++)); do
        printf "| %-15s| %-18s| %-18s| %-20s| %-20s| %-20s| %-18s|\n" ${process[$i]} ${arrivalTime[$i]} ${burstTime[$i]} ${completionTime[$i]} ${turnAroundTime[$i]} ${waitingTime[$i]} ${responseTime[$i]}
    done

    # Table Footer
    echo "================================================================================================================================================"

    # Value
    printf "Average Turn Around Time = "
    printf %.3f "$((10 ** 9 * ${averageTAT} / $n))e-9" # Integer to Float Convert
    printf "\nAverage Waiting Time = "
    printf %.3f "$((10 ** 9 * ${averageWT} / $n))e-9" # Integer to Float Convert
}

printGnatt() {
    # Heading
    printf "\n\n\tGantt Chart\n"
    echo "---------------------------"
    echo
    
    # Chart Process Name
    for ((i = 0; i < $n; i++)); do
        if [ $i == 0 ]; then
            if [ ${startTime[$i]} != 0 ]; then
                printf "|\tX\t|"
            fi
            printf "|\t%s\t|" ${process[$i]}
        else
            if [ ${startTime[$i]} == ${completionTime[$i - 1]} ]; then
                printf "|\t%s\t|" ${process[$i]}
            else
                printf "|\tX\t|"
                printf "|\t%s\t|" ${process[$i]}
            fi
        fi
    done
    echo

    # Chart Process Value
    for ((i = 0; i < $n; i++)); do
        if [ $i == 0 ]; then
            if [ ${startTime[$i]} != 0 ]; then
                printf "0\t\t"
            fi
            printf "%s\t\t" ${startTime[$i]}
            printf "%s\t\t" ${completionTime[$i]}
        else
            if [ ${startTime[$i]} == ${completionTime[$i - 1]} ]; then
                printf "%s\t\t" ${completionTime[$i]}
            else
                printf "%s\t\t" ${startTime[$i]}
                printf "%s\t\t" ${completionTime[$i]}
            fi
        fi
    done
    echo
}

# Main Function
echo -n "Enter Total no. of Process = "
read n

# Input Data from User
for ((i = 0; i < $n; i++)); do
    echo -n "Enter Process Name = "
    read process[$i]
    echo -n "Enter ${process[$i]} Arrival Time = "
    read arrivalTime[$i]
    echo -n "Enter ${process[$i]} Burst Time = "
    read burstTime[$i]
done

scheduleProcess
print
sort
printGnatt
