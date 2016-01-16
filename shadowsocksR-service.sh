
#!/bin/sh 
#inoder to start or stop or restart shadowsocks 
#chkconfig:2345 80 55 
#description:shadowsocos start|stop|restart 
SERVER_NAME=shadowsocks 
PROG=server.py 
PROG_PATH=/home/shadowsocks/shadowsocks 
PID_PATH=/var/run 
start(){ 
        echo "begin start" 
        if [[ -e $PID_PATH/$SERVER_NAME.pid ]]; then 
                echo "$SERVER_NAME is runing now " 
                exit 1 
        else 
                python $PROG_PATH/$PROG -c /etc/shadowsocks.json -d start 
                echo "start sussful" 
        fi 
} 
stop(){ 
        echo "begin stop" 
        if [[ -e $PID_PATH/$SERVER_NAME.pid ]]; then 
                python $PROG_PATH/$PROG -c /etc/shadowsocks.json -d stop 
                echo "stop sussful"      
         
else 
        echo "$SERVER_NAME NOT runing"
fi
}
if [ "$(id -u)" != "0" ]; then  
    echo "This script must be run as root" 1>&2  
    exit 1  
fi  
case $1 in
        start )
        start
        exit 0
        ;;
        stop )
        stop
        exit 0
        ;;
        restart )
        stop
        start
        ;;
        ** )
        echo "Usage: $0 {start|stop|reload}" 1>&2 
        exit 1
        ;;      
esac
