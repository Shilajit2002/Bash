echo "1.Create two blank file"
echo "2.Add content into the file"
echo "3.Copy Content of one file to another"
echo "4.Search & Print the lines which contains a specific word"
echo "5.Count the total number of files whose name start with a vowel"
echo "6.Exit"
echo -n "Enter your menu choice : "

# Menu Driver
while :; do

    read choice

    # Switch Case
    case "${choice}" in
    1)
        echo -n "Enter the files : "
        read file1 file2
        touch $file1 $file2
        echo "File Created"
        ;;
    2)
        echo -n "Enter the file name : "
        read file1
        echo -n "Enter Content : "
        cat >>$file1
        echo "Content Appended"
        ;;
    3)
        echo -n "Enter the file name : "
        read file1
        echo -n "Enter another file name : "
        read file2
        cp $file1 $file2
        echo "Copied"
        ;;
    4)
        echo -n "Enter the file name : "
        read file3
        echo -n "Enter word to search : "
        read file4
        n=$(grep $file4 $file3)
        echo $n
        ;;
    5)
        n1=$(ls -l | grep "^-" | cut -c45 | grep [aeiouAEIOU] | wc -l)
        echo "$n1"
        ;;
    6)
        echo "Quiting.."
        exit
        ;;

    *)
        echo "Invalid Choice"
        ;;
    esac

    echo -n "Enter your menu choice : "
done
