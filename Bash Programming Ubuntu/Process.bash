function PROCESS() {
    echo "Thank You"
}
PROCESS &
pid=$!
echo "Process created"
echo "Process Id : $pid"
