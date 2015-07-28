#!/bin/bash
#############################################################
#
#   @author edward Chen
#	Zabbix configuration for CentOS 6.5
#
#	server-proxy-agent
#zabbix server与proxy需要数据库，angent不需要
#proxy只需要导入一个sql文件，而server一共要导入3个sql文件
#
#############################################################

LOG_FILE="/root/config_zabbix.log"
DB_USER="root"
DB_PASSWORD="cyq1018"
ZABBIX_SEVER_DIR="zabbix_server"
ZABBIX_AGENT_DIR="zabbix_agent"
ZABBIX_PROXY_DIR="zabbix_proxy"
ZABBIX_URL="http://downloads.sourceforge.net/project/zabbix/ZABBIX%20Latest%20Stable/2.2.2/zabbix-2.2.2.tar.gz"

LOG(){
	echo $1 >> $LOG_FILE
}

download_zabbix(){
	cd /usr/local/src
	if [ ! -f zabbix*.tar.gz ]; then
		wget $ZABBIX_URL
		tar -xzvf zabbix*.tar.gz
	fi

	LOG "download zabbix" 
}

configure_server(){
	LOG "install zabbix server"

	./configure --prefix=/usr/local/$ZABBIX_DIR/ --enable-server \
		--enable-agent --with-mysql --with-net-snmp --with-libcurl --with-libxml2
	make&&make install	

	mysql -u$DB_USER -p$DB_PASSWORD zabbix < database/mysql/schema.sql
	mysql -u$DB_USER -p$DB_PASSWORD zabbix < database/mysql/images.sql
	mysql -u$DB_USER -p$DB_PASSWORD zabbix < database/mysql/data.sql

	sed -i "s/# DBName=/DBName=zabbix/" $ZABBIX_SERVER_DIR/etc/zabbix_server.conf
	sed -i "s/# DBUser=/DBUser=$DB_USER/" $ZABBIX_SERVER_DIR/etc/zabbix_server.conf
	sed -i "s/# DBPassword=/DBPassword=$DB_PASSWORD/" $ZABBIX_SERVER_DIR/etc/zabbix_server.conf
	sed -i "s/# DBPort=/DBPort=3306/" $ZABBIX_SERVER_DIR/etc/zabbix_server.conf
	$ZABBIX_SERVER_DIR/sbin/zabbix_server

	COUNT=`ps -ef|grep zabbix_server|grep -v grep|wc -l`
	if [ $COUNT -eq 1 ]; then
		LOG "install zabbix server OK"
	fi

	$PKG_INSTALL nginx
	service nginx start
	COUNT_NGINX=`ps -ef|grep nginx|grep -v grep|wc -l`
	if [ $COUNT_NGINX -eq 2 ];then
		LOG "install nginx OK"
	else
		LOG "######### install nginx error ##########" 
		exit
	fi

	cp -rp /usr/local/src/$ZABBIX_DIR/frontends/php/* /usr/share/nginx/zabbix

	#### modify /etc/nginx/nginx.conf
	echo "###############################################################"
	echo "############ please modify your nginx.conf file ##############"
	echo "###############################################################"

	# modify /etc/php.ini
	sed -i "s/;date.timezone =/date.timezone PRC/g" /etc/php.ini
	sed -i "s/max_execution_time = 30/max_execution_time = 300/g" /etc/php.ini
	sed -i "s/post_max_size = 8M/post_max_size = 16M/g" /etc/php.ini
	sed -i "s/max_input_time = 60/max_input_time = 300/g" /etc/php.ini
	sed -i "s/memory_limit = 128M/memory_limit = 128M/g" /etc/php.ini

	$PKG_INSTALL php-fpm php-gd php-bcmath php-xml php-mbstring php-mysql

	service php-fpm start
	# modify /etc/php-fpm.d/www.conf
	sed -i "s/listen = 127.0.0.1:9000/listen = \/var\/run\/php-fpm.sock/g" /etc/php-fpm.d/www.conf

	# add php modify permission
	chown -R nginx.nginx /usr/share/nginx/zabbix
}

configure_proxy(){
	./configure --prefix=/usr/local/zabbix --with-mysql \
			--with-net-snmp --enable-proxy
	make&&make install
	mysql -u$DB_USER -p$DB_PASSWORD zabbix < database/mysql/schema.sql
}

configure_agent(){
	./configure --prefix=/usr/local/zabbix --enable-agent
	make&&make install

	mysql -u$DB_USER -p$DB_PASSWORD zabbix < database/mysql/schema.sql
	mysql -u$DB_USER -p$DB_PASSWORD zabbix < database/mysql/images.sql
	mysql -u$DB_USER -p$DB_PASSWORD zabbix < database/mysql/data.sql

	cd /usr/local/$ZABBIX_AGENT_DIR/etc/
	echo "Server=127.0.0.1\nServerActive=127.0.0.1\nHostname=Zabbix server" >> zabbix_agentd.conf

	/usr/local/$ZABBIX_AGENT_DIR/sbin/zabbix_agentd
	COUNT_AGENT=`ps -ef|grep zabbix_agent|grep -v grep|wc -l`
	if [ $COUNT_AGENT -gt 0 ];then
		echo "start zabbix agent OK" >> $LOG_FILE
	fi
}

init(){
	if [ ! -n $(command -v yum) ]; then
		LOG "no PKG_MANAGER "
		exit
	fi

	PKG_MANAGER=yum
	$PKG_MANAGER update -y
	$PKG_MANAGER upgrage -y
	PKG_INSTALL=$PKG_MANAGER" install -y"

	if [ id zabbix ];then
		LOG "exist user zabbix"
	else
		groupadd zabbix
		useradd -g zabbix zabbix
	fi

	./tool.sh
}


config_mysql(){
	$PKG_INSTALL mysql-server mysql-devel
	service mysqld start
	/usr/bin/mysqladmin -u $DB_USER password $DB_PASSWORD
	echo "set DB user:"$DB_USER" password:"$DB_PASSWORD >> $LOG_FILE

	#crate database zabbix
	mysql -u$USER -p$DB_PASSWORD << EOF 2>/dev/null
	create database zabbix default charset utf8
EOF
	[ $? -eq 0 ] && echo "created DB zabbix " >> $LOG_FILE || echo "DB zabbix already exist " >> $LOG_FILE

}


init 
# if [ $1 == "server" ]; then
# 		
# elif [ $1 == "proxy" ]; then
# 	
# else
# 	
# fi


