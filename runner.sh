#!/bin/bash

<<<<<<< HEAD
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

=======
run(){
    mylog=/var/log/clock_sync.log
>>>>>>> 74dc3fe3bca8e47f341d90bbc23e645c229eee5a
    cp ./ntp.conf.client /etc/
    cp ./ntp.conf.server /etc/

    cp ./vip-down.sh /etc/
    cp ./vip-up.sh /etc/

<<<<<<< HEAD
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
=======
    ucarp --vhid=42 --pass=love --addr=10.224.172.252 --srcip=$(hostname -I) --upscript=/etc/vip-up.sh --downscript=/etc/vip-down.sh -P -B>> $mylog 2>&1

    echo $! >/var/run/clock_sync.pid
}

if [ "$1" == "" ]; then
    echo "Missing operation run|stop "
fi

if [ "$1" == "run" ]; then
    echo "starting ... "
    run
>>>>>>> 74dc3fe3bca8e47f341d90bbc23e645c229eee5a
    exit 0
fi

if [ "$1" == "stop" ]; then
    echo "stopping ..."
<<<<<<< HEAD
    pid=$(cat $clockpid)
    if [ "$pid" == "" ]; then
        echo "no running process"
        exit 0
    fi
    kill -9 $pid
    rm $clockpid
=======
    kill -9 $(cat /var/run/clock_sync.pid)
>>>>>>> 74dc3fe3bca8e47f341d90bbc23e645c229eee5a
    exit 0;
fi
