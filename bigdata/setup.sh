#! /bin/bash

## Steps for configuring local repository
yum -y install wget
yum -y install httpd
chkconfig https on
service httpd start
service httpd status

## Download cloudera-manager repositories (6.1.1)
mkdir -p /var/www/html/cloudera-repos
wget --recursive --no-parent --no-host-directories https://archive.cloudera.com/cm6/6.1.1/redhat7/ -P /var/www/html/cloudera-repos
wget --recursive --no-parent --no-host-directories https://archive.cloudera.com/cm6/6.1.1/allkeys.asc -P /var/www/html/cloudera-repos
chmod -R ugo+rX /var/www/html/cloudera-repos/cm6

## Download CDH 6.1.1
wget --recursive --no-parent --no-host-directories https://archive.cloudera.com/cdh6/6.1.1/redhat7/yum/ -P /var/www/html/cloudera-repos
wget --recursive --no-parent --no-host-directories https://archive.cloudera.com/gplextras6/6.1.1/redhat7/ -P /var/www/html/cloudera-repos
chmod -R ugo+rX /var/www/html/cloudera-repos/cdh6
chmod -R ugo+rX /var/www/html/cloudera-repos/gplextras6

## Parcles Installation:
wget --recursive --no-parent --no-host-directories https://archive.cloudera.com/cdh6/6.1.1/parcels/ -P /var/www/html/cloudera-repos
wget --recursive --no-parent --no-host-directories https://archive.cloudera.com/gplextras6/6.1.1/parcels/ -P /var/www/html/cloudera-repos
chmod -R ugo+rX /var/www/html/cloudera-repos/cdh6
chmod -R ugo+rX /var/www/html/cloudera-repos/gplextras6


## Create cloudera-manager.repo file under /etc/yum.repos.d/

echo -n "[cloudera-manager]
name=Cloudera Manager 6.1.1
baseurl=https://<hostname>/cloudera-repos/cm6/6.1.1/redhat7/yum/
gpgkey=https://<hostname>/cloudera-repos/cm6/6.1.1/redhat7/yum/RPM-GPG-KEY-cloudera
gpgcheck=1
enabled=1
autorefresh=0
type=rpm-md " | sudo tee -a  /etc/yum.repos.d/cloudera-manager.repo > /dev/null

## Vm.swapiness to 1:
sysctl -w vm.swappiness=1  

     
##  Installing cloudera manager
## yum install oracle jdk
## yum list all | grep cloudera
yum -y install oracle-j2sdk1.8.x86_64
yum -y install cloudera-manager-server

## Install Mariadb(mysql) 
yum -y install mariadb-server
/usr/bin/mysql_secure_installation
sudo systemctl enable mariadb
sudo systemctl start mariadb

## connect 
mysql -u root -p
create database scm;
GRANT ALL ON scm.* TO 'scm'@'%' IDENTIFIED BY 'scm';
/opt/cloudera/cm/schema/scm_prepare_database.sh mysql scm scm scm

## start cloudera manager server
systemctl start cloudera-scm-server
