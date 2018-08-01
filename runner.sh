#!/bin/bash
#$(date +"%Y-%m-%d %H:%M:%S")
mylog=/var/log/clock_sync.log
clockpid=/var/run/clock_sync.pid

run(){
    if [ -e "$clockpid" ]; then
        echo "there is already running one stop it before"
        exit 0
    fi

    cp ./ntp.conf.client /etc/
    cp ./ntp.conf.server /etc/

    cp ./vip-down.sh /etc/
    cp ./vip-up.sh /etc/
	stamp=$(date +"%Y-%m-%d %H:%M:%S")
	echo "[$stamp] - starting ucarp " >> $mylog
    ucarp --vhid=42 --pass=love --addr=10.224.172.252 --srcip=$(hostname -I) --upscript=/etc/vip-up.sh --downscript=/etc/vip-down.sh $1 -z >> $mylog 2>&1 & 
    sleep 1
    echo $(ps -aux |grep  ucarp | head -n 1|awk '{print $2}') >$clockpid
    stamp=$(date +"%Y-%m-%d %H:%M:%S")
	echo "[$stamp] - started " >> $mylog
}

if [ "$1" == "" ]; then
    echo "Missing operation start <master|slave> | stop "
fi

if [ "$1" == "start" ]; then
    echo "starting ... "
    if [ "$2" == "master" ]; then
        stamp=$(date +"%Y-%m-%d %H:%M:%S")
		echo "[$stamp] - Master mode " >> $mylog
        run "-P --advskew=3 --advbase=11"
    elif [ "$2" == "slave" ]; then
	stamp=$(date +"%Y-%m-%d %H:%M:%S")
	echo "[$stamp] - Slave mode " >> $mylog
        run " --advskew=7 --advbase=7"
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
	stamp=$(date +"%Y-%m-%d %H:%M:%S")
	echo "[$stamp] - Killed " >> $mylog
    rm $clockpid
    exit 0;
fi
