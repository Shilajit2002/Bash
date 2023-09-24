function PROCESS() {
    s="MY COUNTRY"
    strlen=${#s}
    strlen=${#s}
    for ((i = $strlen - 1; i >= 0; i--)); do
        revstr=$revstr${s:$i:1}
    done
    echo "$revstr"
    echo "Hello" | rev
}

PROCESS &
pid=$!
echo "Process created"
echo "Process Id : $pid"
