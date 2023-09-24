# Sort the Process Using Arrival Time
sort() {
    # Selection Sort
    for ((i = 0; i < $n; i++)); do
        key=${arrivalTime[$i]}
        pro=${process[$i]}
        burst=${burstTime[$i]}

        for ((j = $i - 1; j >= 0 && ${arrivalTime[$j]} > $key; j--)); do
            arrivalTime[$j + 1]=${arrivalTime[$j]}
            process[$(($j + 1))]=${process[$j]}
            burstTime[$(($j + 1))]=${burstTime[$j]}
        done

        arrivalTime[$(($j + 1))]=$key
        process[$(($j + 1))]=$pro
        burstTime[$(($j + 1))]=$burst
    done
}

# Completition Time
CT() {
    for ((i = 0; i < $n; i++)); do
        # For First Process
        if [ $i -eq 0 ]; then
            startTime[$i]=${arrivalTime[$i]}
            completionTime[$i]=$((${arrivalTime[$i]} + ${burstTime[$i]}))
        # For Another Process
        else
            # If the next process already arrive
            if [ ${completionTime[$(($i - 1))]} -ge ${arrivalTime[$i]} ]; then
                startTime[$i]=${completionTime[$i - 1]}
                completionTime[$i]=$((${completionTime[$(($i - 1))]} + ${burstTime[$i]}))
            # If the next process not arive then there is a space or gap
            else
                startTime[$i]=${arrivalTime[$i]}
                space=$((${arrivalTime[$i]} - ${completionTime[$(($i - 1))]}))
                completionTime[$i]=$((${completionTime[$(($i - 1))]} + ${burstTime[$i]} + $space))
            fi
        fi
    done
}

# TurnAround Time
TAT() {
    averageTAT=0
    for ((i = 0; i < $n; i++)); do
        # Turn Around Time Calculation
        turnAroundTime[$i]=$((${completionTime[$i]} - ${arrivalTime[$i]}))
        # Average Turn Around Time Calculation
        averageTAT=$(($averageTAT + ${turnAroundTime[$i]}))
    done
}

# Waiting Time
WT() {
    averageWT=0
    for ((i = 0; i < $n; i++)); do
        # Waiting Time Calculation
        waitingTime[$i]=$((${turnAroundTime[$i]} - ${burstTime[$i]}))

        # Average Waiting Time Calculation
        averageWT=$(($averageWT + ${waitingTime[$i]}))
    done
}

# Response Time
RT() {
    for ((i = 0; i < $n; i++)); do
        # For First Process
        if [ $i -eq 0 ]; then
            # First Process Response Time is 0
            responseTime[$i]=$((${arrivalTime[$i]} - ${arrivalTime[$i]}))
        # For Another Process
        else
            # If the next process already arrive
            if [ ${completionTime[$(($i - 1))]} -ge ${arrivalTime[$i]} ]; then
                responseTime[$i]=$((${completionTime[$(($i - 1))]} - ${arrivalTime[$i]}))
            # If the next process not arive then there is a space or gap so the response time is 0
            else
                responseTime[$i]=$((${arrivalTime[$i]} - ${arrivalTime[$i]}))
            fi
        fi
    done

}

# Print the Process
print() {
    # Heading
    printf "\n\tFirst Cum First Serve CPU Scheduling Algorithm (FCFS)\n"

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
    processId[$i]=$i
    echo -n "Enter ${process[$i]} Arrival Time = "
    read arrivalTime[$i]
    echo -n "Enter ${process[$i]} Burst Time = "
    read burstTime[$i]
done

# Sort Function Call
sort
# Completion Time Function Call
CT
# Turn Around Time Function Call
TAT
# Waiting Time Function Call
WT
# Response Time Function Call
RT
# Print Function Call
print
# Print Gnatt Chart
printGnatt
