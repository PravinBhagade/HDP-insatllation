#!/bin/bash

#setting passwordless ssh for server
echo "setting passwordless ssh for server"

ssh-keyscan -H localhost > ~/.ssh/known_hosts  
y|ssh-keygen -t dsa -P '' -f ~/.ssh/id_dsa  
cat ~/.ssh/id_dsa.pub > ~/.ssh/authorized_keys  


yum install -y ntp wget
chkconfig --list ntpd
chkconfig ntpd on
service ntpd start
chkconfig iptables off
/etc/init.d/iptables stop
setenforce 0
sed -i 's/enforcing/disabled/g' /etc/selinux/config /etc/selinux/config
sestatus
umask 0022
echo umask 0022 >> /etc/profile
echo "vm.swappiness=1" >> /etc/sysctl.conf 
echo "1" > /proc/sys/vm/swappiness 

echo never > /sys/kernel/mm/redhat_transparent_hugepage/enabled
echo never > /sys/kernel/mm/redhat_transparent_hugepage/defrag


echo "Ambari repo:
echo "https://docs.hortonworks.com/HDPDocuments/Ambari-2.5.1.0/bk_ambari-installation/content/ambari_repositories.html"
echo
echo "HDP repo"
echo "https://docs.hortonworks.com/HDPDocuments/Ambari-2.5.1.0/bk_ambari-installation/content/hdp_stack_repositories.html"

echo "amabri upgrade"
echo "wget -nv http://public-repo-1.hortonworks.com/ambari/centos6/2.x/updates/2.5.1.0/ambari.repo -O /etc/yum.repos.d/ambari.repo"

