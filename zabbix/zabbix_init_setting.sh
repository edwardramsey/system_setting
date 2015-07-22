#!/bin/bash
#############################################################
#
#   @author edward Chen
#	Zabbix init for CentOS 6.5
#   for zabbix you have to install php mysql/orcle and nginx
#
#############################################################

LOG_FILE="/root/config_zabbix.log"
DB_USER="root"
DB_PASSWORD="cyq1018"
ZABBIX_DIR="zabbix-2.2.2"
ZABBIX_AGENT_DIR=$ZABBIX_DIR"_agent"

echo 'check CentOS or Ubuntu'

PKG_MANAGER=$( command -v yum || command -v apt-get || echo "no pkgManager")
if [ $PKG_MANAGER == "no pkgManager" ]; then
	echo "no PKG_MANAGER " >> $LOG_FILE
fi

echo "$PKG_MANAGER"
if [ 'whoami'="root" ]; then
	echo "root user" > $LOG_FILE
else
	echo "need add sudo" >$LOG_FILE
	if [ command -v apt-get ]; then
		PKG_MANAGER = sudo PKG_MANAGER
	fi
fi

$PKG_MANAGER update -y
$PKG_MANAGER upgrage -y
PKG_INSTALL=$PKG_MANAGER" install -y"

echo "---- install mysql ----" >> $LOG_FILE
$PKG_INSTALL mysql-server mysql-devel

./tool.sh
echo "install basic for system" >> $LOG_FILE

service mysqld start

echo "---- install zabbix ----" >> $LOG_FILE

$PKG_INSTALL net-snmp-devel libxml2-devel libcurl-devel
cd /usr/local/src
if [ ! -d $ZABBIX_DIR ]; then
	wget "http://downloads.sourceforge.net/project/zabbix/ZABBIX%20Latest%20Stable/2.2.2/zabbix-2.2.2.tar.gz"
	tar -xzvf zabbix-2.2.2.tar.gz
else
	echo "zabbix already exist" >>$LOG_FILE
fi

cd $ZABBIX_DIR
./configure --prefix=/usr/local/$ZABBIX_DIR/ --enable-server \
--enable-agent --with-mysql --with-net-snmp --with-libcurl --with-libxml2
make
make install

echo "install zabbix OK" >> $LOG_FILE

groupadd zabbix
useradd -g zabbix zabbix

/usr/bin/mysqladmin -u $DB_USER password $DB_PASSWORD
echo "set DB user:"$DB_USER" password:"$DB_PASSWORD >> $LOG_FILE

mysql -u$DB_USER -p$DB_PASSWORD  -e 'create database zabbix default charset utf8'
#zabbix server与proxy需要数据库，angent不需要
#proxy只需要导入一个sql文件，而server一共要导入3个sql文件
mysql -u$DB_USER -p$DB_PASSWORD zabbix < database/mysql/schema.sql
mysql -u$DB_USER -p$DB_PASSWORD zabbix < database/mysql/images.sql
mysql -u$DB_USER -p$DB_PASSWORD zabbix < database/mysql/data.sql

echo "add schema.sql images.sql data.sql to mysql OK" >> $LOG_FILE

mkdir -p /etc/zabbix
cp conf/zabbix_server.conf /etc/zabbix/zabbix_server.conf.bak
echo "DBName=zabbix\nDBUser="$DB_USER"\nDBPassword="$DB_PASSWORD"\nDBPort=3306" >> /etc/zabbix/zabbix_server.conf

/usr/local/zabbix-2.2.2/sbin/zabbix_server

COUNT=`ps -ef|grep zabbix_server|grep -v grep|wc -l`
if [ $COUNT -eq 1 ]; then
	echo "start zabbix server OK" >> $LOG_FILE
fi


echo "---- install agent ----" >> $LOG_FILE

cd /usr/local/src
if [ -d $ZABBIX_DIR ];then
	mv $ZABBIX_DIR $ZABBIX_DIR"_server"
	wget "http://downloads.sourceforge.net/project/zabbix/ZABBIX%20Latest%20Stable/2.2.2/zabbix-2.2.2.tar.gz"
	tar -xzvf zabbix-2.2.2.tar.gz
fi
cd $ZABBIX_DIR
./configure --prefix=/usr/local/$ZABBIX_AGENT_DIR/ --enable-agent
make
make install

cd /usr/local/$ZABBIX_AGENT_DIR/etc/
echo "Server=127.0.0.1\nServerActive=127.0.0.1\nHostname=Zabbix server" >> zabbix_agentd.conf

/usr/local/$ZABBIX_AGENT_DIR/sbin/zabbix_agentd
COUNT_AGENT=`ps -ef|grep zabbix_agent|grep -v grep|wc -l`
if [ $COUNT_AGENT -gt 0 ];then
	echo "start zabbix agent OK" >> $LOG_FILE
fi

$PKG_INSTALL epel-release
$PKG_INSTALL tmux
$PKG_INSTALL nginx
nginx -v 
cp -rp /usr/local/src/$ZABBIX_DIR/frontends/php/* /usr/share/nginx/zabbix

#### modify /etc/nginx/nginx.conf

# modify /etc/php.ini
sed -i "s/;date.timezone =/date.timezone PRC/g" /etc/php.ini
sed -i "s#max_execution_time = 30#max_execution_time = 300#g" /etc/php.ini
sed -i "s#post_max_size = 8M#post_max_size = 16M#g" /etc/php.ini
sed -i "s#max_input_time = 60#max_input_time = 300#g" /etc/php.ini
sed -i "s#memory_limit = 128M#memory_limit = 128M#g" /etc/php.ini

$PKG_INSTALL php-fpm php-gd php-bcmath php-xml php-mbstring php-mysql

service php-fpm start
# modify /etc/php-fpm.d/www.conf
sed -i "s/listen = 127.0.0.1:9000/listen = /var/run/php-fpm.sock#g" /etc/php-fpm.d/www.conf

# add php modify permission
chown -R nginx.nginx /usr/share/nginx/zabbix
