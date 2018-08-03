#!/bin/bash



settime(){
    date +%T -s $1
}

setdate(){
    date +%Y%m%d -s $1
}

usage(){
    cat << eof

    Usage $0 [option] date whichone

    -t  "HH:MM:SS"   set time
    -d  "YY:MM:DD"   set date 
    -m  master|slave on master or slave (defaul is master )
    -h               see this help
    
    Example: $0 -t 19:05:18 -m master 

eof
}
stop(){
    ./runner.sh "stop"
}

start(){
    ./runner.sh "start" $1
}

mode="master"
valid=0
while test $# -ne 0; do

    case $1 in
        -m)
            mode=$2
            shift
            ;;
        -h)
            usage
            exit
            ;;
        -t)
            stop
            settime $2
            valid=1
            shift
            ;;
        -d)
            stop
            setdate $2
            valid=1
            shift
            ;;
        *)
            echo "Unknown parameter $1"
            usage
            exit
            ;;
    esac
    shift
done

if [ $valid -eq 1 ]; then
    start $mode
else
    echo "missing operation option -t or -d"
fi
exit