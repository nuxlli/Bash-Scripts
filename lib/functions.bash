#!/bin/sh

function search_array() {
    index=0
    array=( `echo "$1"` )
    while [ "$index" -lt "${#array[@]}" ]; do
        if [ "${array[$index]}" = "$2" ]; then
            echo $index
            return
        fi
        let "index++"
    done
    echo ""
}