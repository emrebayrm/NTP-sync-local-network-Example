#!/bin/bash

mylog=/var/log/clock_sync.log
clockpid=/var/run/clock_sync.pid

run(){
    if [ -e "$clockpid" ]; then
        pid=$(cat $clockpid)
    else 
        pid=""
    fi
    if [ "$pid" != "" ]; then
        echo "there is already running one stop it before"
        exit 0
    fi

    cp ./ntp.conf.client /etc/
    cp ./ntp.conf.server /etc/

    cp ./vip-down.sh /etc/
    cp ./vip-up.sh /etc/

    ucarp --vhid=42 --pass=love --addr=10.224.172.252 --srcip=$(hostname -I) --upscript=/etc/vip-up.sh --downscript=/etc/vip-down.sh $1 -B>> $mylog 2>$mylog & 
    sleep 1
    echo $(ps -aux |grep  ucarp | head -n 1|awk '{print $2}') >$clockpid
    echo "started"
}

if [ "$1" == "" ]; then
    echo "Missing operation start <master|slave> | stop "
fi

if [ "$1" == "start" ]; then
    echo "starting ... "
    if [ "$2" == "master" ]; then
        run "-P -n"
    elif [ "$2" == "slave" ]; then
        run " "
    else
        echo " missing or wrong operator <master|slave> "
    fi
    exit 0
fi

if [ "$1" == "stop" ]; then
    echo "stopping ..."
    pid=$(cat $clockpid)
    if [ "$pid" == "" ]; then
        echo "no running process"
        exit 0
    fi
    kill -9 $pid
    rm $clockpid
    exit 0;
fi
