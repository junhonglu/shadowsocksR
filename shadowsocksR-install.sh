#!/bin/bash
if [[ $UID -ne 0 ]]; then
echo "#####you must to user root,try to sudo#####"
exit 0
fi
echo "#########################################"
echo "Welcome to Shadowsocks-R install script##"
echo "Made by piaok.org ##"
echo "#########################################"
sleep 3
####this is to install base packe and git the Shadowsocks-R###
function ubunbase(){
apt-get install -y m2crypto git
git clone -b manyuser https://github.com/breakwa11/shadowsocks.git
}
function centbase(){
yum install -y m2crypto git libsodium
git clone -b manyuser https:// github.com/breakwa11/shadowsocks.git
}
OS=`cat /etc/issue |awk 'NR==1{print $1}'`
if [ $OS==Ubuntu ]; then
echo "this is ubuntu"
sleep 2
ubunbase
elif [ $OS==CentOS ]; then
echo "this is CentOS"
sleep 2
centbase
else
echo "###do not support you os###"
exit 1
fi
dir=`pwd`
ss="/shadowsocks"
cd $dir$ss$ss
function config_shaodowsocks(){
cat > /etc/shadowsocks.json << EOF
{
"server": "$serverip",
"server_ipv6": "::",
"server_port": $local_port,
"local_address": "127.0.0.1",
"local_port": 1080,
"password": "$password",
"timeout": 120,
"method": "aes-256-cfb",
"protocol": "auth_sha1_compatible",
"protocol_param": "",
"obfs": "tls1.0_session_auth_compatible",
"obfs_param": "",
"redirect": "",
"dns_ipv6": false,
"fast_open": false,
"workers": 1
}
EOF
}
while :
do
read -p "input your ip: " serverip
if [[ $serverip =~ ^[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}$ ]]; then
break
else
echo "you ip error,please input one more time"
fi
done
while :
do
read -p "input your serverport,between 1-65535:" local_port
if [ $local_port -ge 1 ] && [ $local_port -le 65535 ] ;then
break
else
echo "your port error,please input again "
fi
done
while :
do
read -p "input you passwd:" password
if [ ! -z $password ]; then
break
else
echo "you must input a passwd"
fi
done
config_shaodowsocks
python server.py -c /etc/shadowsocks.json -d start
if [[ $? -eq 0 ]]; then
echo "####you server sussful###"
fi
