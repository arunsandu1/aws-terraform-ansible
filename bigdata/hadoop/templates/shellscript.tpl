#!/bin/bash

touch /tmp/testfile


yum -y install wget
yum -y install httpd
chkconfig https on
service httpd start
service httpd status
