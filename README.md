# shadowsocksR
###shadowsocksR-install script and other script  
###此为一键安装脚本
根据自身需要自行修改里面的一些路径，执行完shadwosocksR-install.sh后  
将 service.sh脚本 加入 /etc/ini.d,更改名称为shadowsocksR  
chmod +x /etc/ini.d/shadowsocksR  
即可 service shadowsockR start|stop|restart  
此脚本获取本机IP的方法仅针对open-vz的主机，非open-vz的主机请在启动脚本后自行修改shadowsocks.json里面“server”  
字段的ip
