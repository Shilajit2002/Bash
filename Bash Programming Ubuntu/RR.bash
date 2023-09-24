# Sort the Process Using Arrival Time
sortArrival() {
    # Selection Sort
    for ((i = 0; i < $n; i++)); do
        key=${arrivalTime[$i]}
        pro=${process[$i]}
        burst=${burstTime[$i]}
        proId=${processId[$i]}

        for ((j = $i - 1; j >= 0 && ${arrivalTime[$j]} > $key; j--)); do
            arrivalTime[$(($j + 1))]=${arrivalTime[$j]}
            process[$(($j + 1))]=${process[$j]}
            burstTime[$(($j + 1))]=${burstTime[$j]}
            processId[$(($j + 1))]=${processId[$j]}
        done

        arrivalTime[$(($j + 1))]=$key
        process[$(($j + 1))]=$pro
        burstTime[$(($j + 1))]=$burst
        processId[$(($j + 1))]=$proId
    done
}

# Sort the Process Using ProcessId
sortProcessId() {
    # Selection Sort
    for ((i = 0; i < $n; i++)); do
        key1=${processId[$i]}
        arri=${arrivalTime[$i]}
        pro=${process[$i]}
        burst=${burstTime[$i]}
        st=${startTime[$i]}
        ct=${completionTime[$i]}
        tat=${turnAroundTime[$i]}
        wt=${waitingTime[$i]}
        rt=${responseTime[$i]}

        for ((j = $i - 1; j >= 0 && ${processId[$j]} > $key1; j--)); do
            arrivalTime[$(($j + 1))]=${arrivalTime[$j]}
            process[$(($j + 1))]=${process[$j]}
            burstTime[$(($j + 1))]=${burstTime[$j]}
            processId[$(($j + 1))]=${processId[$j]}
            startTime[$(($j + 1))]=${startTime[$j]}
            completionTime[$(($j + 1))]=${completionTime[$j]}
            turnAroundTime[$(($j + 1))]=${turnAroundTime[$j]}
            waitingTime[$(($j + 1))]=${waitingTime[$j]}
            responseTime[$(($j + 1))]=${responseTime[$j]}
        done

        arrivalTime[$(($j + 1))]=$arri
        process[$(($j + 1))]=$pro
        burstTime[$(($j + 1))]=$burst
        processId[$(($j + 1))]=$key1
        startTime[$(($j + 1))]=$st
        completionTime[$(($j + 1))]=$ct
        turnAroundTime[$(($j + 1))]=$tat
        waitingTime[$(($j + 1))]=$wt
        responseTime[$(($j + 1))]=$rt
    done
}

# Ready Queue
front=$((-1))
rear=$((-1))

# When the Ready Queue will Empty
QueueEmpty() {
    if [ $front == -1 ] && [ $rear == -1 ]; then
        return 1
    else
        return 0
    fi
}

# Push Value in ReadyQueue
Enqueue() {
    val="${1}"
    if [ $front == -1 ] && [ $rear == -1 ]; then
        rear=$(($rear + 1))
        front=$(($front + 1))
        queue[$rear]=$val
    else
        rear=$(($rear + 1))
        queue[$rear]=$val
    fi
}

# Pop Value in ReadyQueue
Dequeue() {
    if [ $front == $rear ]; then
        front=$((-1))
        rear=$((-1))
    else
        front=$(($front + 1))
    fi
}

RRSchedule() {
    # Set Value
    currentTime=0
    Enqueue "0"
    completed=0
    for ((i = 0; i < 100; i++)); do
        mark[$i]=0
    done
    mark[0]=1

    index=0
    while [ $completed != $n ]; do
        # Get the First Process in ReadyQueue
        idx=${queue[$front]}
        # Remove the Process from ReadyQueue
        Dequeue

        # Check the Process is Start or Not
        if [ ${burstRemainingTime[$idx]} == ${burstTime[$idx]} ]; then
            # Set the Process Start Time
            if [ $currentTime -gt ${arrivalTime[$idx]} ]; then
                startTime[$idx]=$currentTime
            else
                startTime[$idx]=${arrivalTime[$idx]}
            fi
            # Set the Current Time as Process Start TIme
            currentTime=${startTime[$idx]}
        fi

        # Check the Process Execution is left or not
        if [ $((${burstRemainingTime[$idx]} - $ts)) -gt 0 ]; then
            # Set Gantt Chart Process Start Time
            GT[$index]=$currentTime
            index=$(($index + 1))
            # Set Gantt Chart Process Id
            GT[$index]=${process[$idx]}
            index=$(($index + 1))

            # Decrease the Burst Time Using Time Quantam
            burstRemainingTime[$idx]=$((${burstRemainingTime[$idx]} - $ts))
            # Current Time increase with Time Quantam
            currentTime=$(($currentTime + $ts))

            k=$currentTime
        # If the Process Executed
        else
            # Calculate all the Operation
            currentTime=$(($currentTime + ${burstRemainingTime[$idx]}))
            burstRemainingTime[$idx]=0
            completed=$(($completed + 1))

            GT[$index]=$k
            index=$(($index + 1))
            GT[$index]=${process[$idx]}
            index=$(($index + 1))
            k=$currentTime

            completionTime[$idx]=$currentTime
            turnAroundTime[$idx]=$((${completionTime[$idx]} - ${arrivalTime[$idx]}))
            waitingTime[$idx]=$((${turnAroundTime[$idx]} - ${burstTime[$idx]}))
            responseTime[$idx]=$((${startTime[$idx]} - ${arrivalTime[$idx]}))

            # Average Turn Around Time Calculation
            averageTAT=$(($averageTAT + ${turnAroundTime[$idx]}))
            # Average Waiting Time Calculation
            averageWT=$(($averageWT + ${waitingTime[$idx]}))

            # If all process are executed
            if [ $completed == $n ]; then
                # Store the Completion Time of Last Process
                GT[$index]=$currentTime
            fi

        fi

        # Check Which Process execution are left & push the Process in ReadyQueue
        for ((i = 1; i < $n; i++)); do
            if [ ${burstRemainingTime[$i]} -gt 0 ] && [ ${arrivalTime[$i]} -le $currentTime ] && [ ${mark[$i]} == 0 ]; then
                Enqueue "$i"
                mark[$i]=1
            fi
        done

        # If the current process is not executed then push in ReadyQueue
        if [ ${burstRemainingTime[$idx]} -gt 0 ]; then
            Enqueue "$idx"
        fi

        # If the ReadyQueue is Empty
        if [ $(QueueEmpty) ]; then
            for ((i = 1; i < n; i++)); do
                # If any process is left then push it in ReadyQueue
                if [ ${burstRemainingTime[$i]} -gt 0 ]; then
                    Enqueue "$i"
                    mark[$i]=1
                    break
                fi
            done
        fi
    done
}

# Print the Process
print() {
    # Heading
    printf "\n\tRound Robin CPU Scheduling Algorithm (RR)-->PreEmptive\n"

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

    echo
}

printGnatt() {
    # Heading
    printf "\n\n\tGantt Chart\n"
    echo "---------------------------"
    echo

    for ((i = 1; i <= $index; i += 2)); do
        printf "|  %s  |" ${GT[$i]}
    done

    printf "\n"

    for ((i = 0; i <= $index; i += 2)); do
        printf "%s\t" ${GT[$i]}
    done
}

# Main Function
echo -n "Enter Total no. of Process = "
read n

echo -n "Enter Time Slice = "
read ts

# Input Data from User
for ((i = 0; i < $n; i++)); do
    echo -n "Enter Process Name = "
    read process[$i]
    processId[$i]=$i
    echo -n "Enter ${process[$i]} Arrival Time = "
    read arrivalTime[$i]
    echo -n "Enter ${process[$i]} Burst Time = "
    read burstTime[$i]

    burstRemainingTime[$i]=${burstTime[$i]}
done

sortArrival
RRSchedule
sortProcessId
print
printGnatt