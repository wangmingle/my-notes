
iptables
-----


禁止ping
iptables -I INPUT -p icmp  -m state --state ESTABLISHED,RELATED -j ACCEPT
iptables -I INPUT -i eth0 -p icmp -j DROP

见配置文件内容/etc/sysconfig/iptables
-A INPUT -i eth0 -p icmp -j DROP
-A INPUT -p icmp -m state --state RELATED,ESTABLISHED -j ACCEPT

开启ping
iptables -D INPUT  -p icmp  -m state --state ESTABLISHED,RELATED -j ACCEPT
iptables -D INPUT  -i eth0 -p icmp -j DROP

删除此句即没有了上面的配置了



查找禁ping语句直接用这条命令可以了 iptables -nL INPUT |  awk '{print NR-2 " " $0}' |sed -ne '/icmp/{/DROP/p}'

查序列号iptables -nL |grep AC |awk '{print NR-1 " " $0}'

Linux 禁ping和开启ping操作
# echo 1 > /proc/sys/net/ipv4/icmp_echo_ignore_all
如果要恢复，只要：
# echo 0 > /proc/sys/net/ipv4/icmp_echo_ignore_all
即可，挺方便，不要去专门使用ipchains或者iptables了。

或者用以下方法也可以，异曲同工

以root进入Linux系统，然后编辑文件icmp_echo_ignore_all
vi /proc/sys/net/ipv4/icmp_echo_ignore_all
将其值改为1后为禁止PING
将其值改为0后为解除禁止PING

ping -f 211.95.79.164

iptables -t nat -L

iptables -F   清除当前所有规则

curl -d "" https://www.funguide.com.cn/UniversalPay/create.json -vvv

iptables-clean
#!/bin/sh
echo "Stopping firewall and allowing everyone..."
iptables -F
iptables -X
iptables -t nat -F
iptables -t nat -X
iptables -t mangle -F
iptables -t mangle -X
iptables -P INPUT ACCEPT
iptables -P FORWARD ACCEPT

iptables -P OUTPUT ACCEPT

iptables-load

#!/bin/sh
iptables-restore < /etc/iptables/iptables.rules
exit 0

iptables-reload

#!/bin/sh
/etc/iptables/iptables-clean
/etc/iptables/iptables-load

exit 0

导出

iptables-save > /etc/iptables.rules

Linux上iptables防火墙的基本应用教程

2011年05月14日 上午 | 作者：VPS侦探

iptables是Linux上常用的防火墙软件，下面vps侦探给大家说一下iptables的安装、清除iptables规则、iptables只开放指定端口、iptables屏蔽指定ip、ip段及解封、删除已添加的iptables规则等iptables的基本应用。

1、安装iptables防火墙

如果没有安装iptables需要先安装，CentOS执行：

yum install iptables

Debian/Ubuntu执行：

apt-get install iptables

2、清除已有iptables规则

iptables -F
iptables -X
iptables -Z

3、开放指定的端口

#允许本地回环接口(即运行本机访问本机)
iptables -A INPUT -s 127.0.0.1 -d 127.0.0.1 -j ACCEPT
# 允许已建立的或相关连的通行
iptables -A INPUT -m state --state ESTABLISHED,RELATED -j ACCEPT
#允许所有本机向外的访问
iptables -A OUTPUT -j ACCEPT
# 允许访问22端口
iptables -A INPUT -p tcp --dport 22 -j ACCEPT
#允许访问80端口
iptables -A INPUT -p tcp --dport 80 -j ACCEPT
#允许FTP服务的21和20端口
iptables -A INPUT -p tcp --dport 21 -j ACCEPT
iptables -A INPUT -p tcp --dport 20 -j ACCEPT
#如果有其他端口的话，规则也类似，稍微修改上述语句就行
#禁止其他未允许的规则访问
iptables -A INPUT -j REJECT  （注意：如果22端口未加入允许规则，SSH链接会直接断开。）
iptables -A FORWARD -j REJECT

4、屏蔽IP

#如果只是想屏蔽IP的话“3、开放指定的端口”可以直接跳过。
#屏蔽单个IP的命令是
iptables -I INPUT -s 123.45.6.7 -j DROP
#封整个段即从123.0.0.1到123.255.255.254的命令
iptables -I INPUT -s 123.0.0.0/8 -j DROP
#封IP段即从123.45.0.1到123.45.255.254的命令
iptables -I INPUT -s 124.45.0.0/16 -j DROP
#封IP段即从123.45.6.1到123.45.6.254的命令是
iptables -I INPUT -s 123.45.6.0/24 -j DROP

4、查看已添加的iptables规则

iptables -L -n

v：显示详细信息，包括每条规则的匹配包数量和匹配字节数
x：在 v 的基础上，禁止自动单位换算（K、M） vps侦探
n：只显示IP地址和端口号，不将ip解析为域名

5、删除已添加的iptables规则

将所有iptables以序号标记显示，执行：

iptables -L -n --line-numbers

比如要删除INPUT里序号为8的规则，执行：

iptables -D INPUT 8

6、iptables的开机启动及规则保存

CentOS上可能会存在安装好iptables后，iptables并不开机自启动，可以执行一下：

chkconfig --level 345 iptables on

将其加入开机启动。

CentOS上可以执行：service iptables save保存规则。

另外更需要注意的是Debian/Ubuntu上iptables是不会保存规则的。

需要按如下步骤进行，让网卡关闭是保存iptables规则，启动时加载iptables规则：

创建/etc/network/if-post-down.d/iptables 文件，添加如下内容：

#!/bin/bash
iptables-save > /etc/iptables.rules

执行：chmod +x /etc/network/if-post-down.d/iptables 添加执行权限。

创建/etc/network/if-pre-up.d/iptables 文件，添加如下内容：

#!/bin/bash
iptables-restore < /etc/iptables.rules

执行：chmod +x /etc/network/if-pre-up.d/iptables 添加执行权限。

关于更多的iptables的使用方法可以执行：iptables --help或网上搜索一下iptables参数的说明。
