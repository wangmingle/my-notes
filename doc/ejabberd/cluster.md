Clustering
-----

生产双活:
1. 先把 现有ejabberd 升级为node
/etc/hosts
127.0.0.1 node00
10.46.161.47 node01
2. node01 备份启动
3. ./bin/ejabberdctl join_cluster 'ejabberd@node00'
4. LVS双机配置

sudo iptables -t nat -A PREROUTING -p tcp -i eth1 --dport 5222 -j DNAT --to 10.24.193.252:5222

1. 配置几个module : router/ local router/ session manager/ s2s manager
2. ~ejabberd/.erlang.cookie
3. ejabberdctl join_cluster 'ejabberd@ejabberd01' / ejabberdctl leave_cluster 'ejabberd@ejabberd02'

client -> LVS-> ejabberd node 1/2 -> db
ejabberd node1 -> ejabberd udtim
ejabberd node2 -> ejabberd udmonkey

check_list
1. 不同机器agent/customer是不是可以聊天
2. 在一个机器上是不是可以取得所有的在线用户
3. 插件的表现

apt-get update && apt-get build-dep erlang -y
测试环境返回java7
ln -nfs /usr/lib/jvm/java-7-openjdk-amd64/jre/bin/java /etc/alternatives/java
cp -r /srv/www/udesk_im/current/modules/mod_offline_receipt  ./
cp -r /srv/www/udesk_im/current/modules/mod_post_log/ ./

配置影响
bin/ejabberdctl:ERLANG_NODE=ejabberd@node01
conf/inetrc:{host,{127,0,0,1}, ["localhost","node01"]}.
conf/ejabberdctl.cfg:#ERLANG_NODE=ejabberd@node01

执行:
把两台机器加到/etc/hosts中
10.46.161.47 node01
10.25.92.172 node02
./bin/ejabberdctl join_cluster 'ejabberd@node01'

在try上进行登录,看能不能在monkey上看到结果
在monkey上登录客户,看能不能通讯
101.201.41.155 im03.tryudesk.com


mysql proxy

mysql-proxy ，mysql官方的代理，使用起来并不友好，需要进行lua定制，而且本人对其稳定性和性能存疑。 Aug 19, 2014
Cobar ，阿里的东西，品质没的说，但对于我们项目，有点杀鸡用牛刀的感觉，另外我们都不会java。
Atlas ，360出品的基于mysql-proxy的增强版，几乎用c重写了核心框架，性能和稳定性都没话说。

https://github.com/siddontang/mixer

好像这两个都是一个人
https://github.com/flike/kingshard/blob/master/README_ZH.md
https://github.com/Qihoo360/Atlas/

https://github.com/Qihoo360/Atlas/wiki/Atlas的架构
https://github.com/Qihoo360/Atlas/wiki/Atlas的安装
rpm –i Atlas-2.2.1.el6.x86_64.rpm
sudo dpkg -i Atlas-2.2.1.el6.x86_64.rpm
cd /usr/local/mysql-proxy/
ln -nfs /usr/local/mysql-proxy/ /srv/mysql-proxy
没有ubuntu 的....

减少pool
node00:
127.0.0.1 node00
10.46.161.47 node01

node01:

10.24.193.252 node00
127.0.0.1 node01

./bin/ejabberdctl join_cluster 'ejabberd@node00'

cluster 状态


可视算法
http://algo-visualizer.jasonpark.me/#path=backtracking/n_queens/n_queens
## Purpose

The purpose of ejabberd clustering is to be able to use several servers for a single or small group of large domains, for fault-tolerance and scalability.
ejabberd集群的目的是:可以用一个或一组子域名机器来实现容灾和扩展.

Note that you do not necessarily need clustering if you want to run two large domains independantly. You may simply want to run two different independant servers.
如果你想用于两个独立域名,用不同机器就可以了.

However, to build reliable service and support large user base, clustering is a must have feature.
无论如何,要让系统更可靠,容纳更多人,cluster是必须的.

## How it Works
A XMPP domain is served by one or more ejabberd nodes. These nodes can be run on different machines that are connected via a network. They all must have the ability to connect to port 4369 of all another nodes, and must have the same magic cookie (see Erlang/OTP documentation, in other words the file ~ejabberd/.erlang.cookie must be the same on all nodes). This is needed because all nodes exchange information about connected users, s2s connections, registered services, etc…

一个XMPP域名可以用于一个或多个ejabberd节点.这些节点部署在联通的网络中.他们之间使用4369端口通讯,并用相同的Erlang magic cookie(见Erlang/OTP文档.换句话说,所有节点的~ejabberd.erlang.cookie这个文件必须一样.).这样才能保证不同节点交换在线用户,s2s连接,已注册服务等.

Each ejabberd node has the following modules:
每个ejabberd节点必须包含下面的modules:
router
local router
session manager
s2s manager.

Router
This module is the main router of XMPP packets on each node. It routes them based on their destination’s domains. It uses a global routing table. The domain of the packet’s destination is searched in the routing table, and if it is found, the packet is routed to the appropriate process. If not, it is sent to the s2s manager.
此module是每个节点上的XMPP包主路由.他会根据目标域名分发.使用一个全局路由表.系统根据XMPP包的目标域名在路由表中检索,如果找到,就把包分发到对应进程中.如果找不到,就发给s2s manager进程.

Local Router
This module routes packets which have a destination domain equal to one of this server’s host names. If the destination JID has a non-empty user part, it is routed to the session manager, otherwise it is processed depending on its content.
此module 分发那些目标域名(可多个)是本地机器的消息包,如果jid是用户部分非空,就发给session manager进程,不然会根据内容来处理.

Session Manager
This module routes packets to local users. It looks up to which user resource a packet must be sent via a presence table. Then the packet is either routed to the appropriate c2s process, or stored in offline storage, or bounced back.
此module把包发给当前用户.他会根据在线列表来把投送包发送给相应resource的用户.然后包会分发给相应的c2s进程,或离线存贮进程.或是返回.

s2s Manager
This module routes packets to other XMPP servers. First, it checks if an opened s2s connection from the domain of the packet’s source to the domain of the packet’s destination exists. If that is the case, the s2s manager routes the packet to the process serving this connection, otherwise a new connection is opened.
此module与其它的xmpp服务器通讯.首先,他检查包来源域名与目标域名的s2s连接是否存在.如果已经存在,就直接通过这个连接投送,不然会启用新的连接.

## Before you get started
Before you start implementing clustering, there are a few things you need to take into account:
在你实现集群前,先必须考虑下面的问题:

Cluster should be set up in a single data center: The clustering in ejabberd Community Edition relies on low latency networking. While it may work across regions, it is recommended that you run an ejabberd cluster in a single Amazon region.
Clustering relies on Erlang features and Mnesia shared schemas. Before getting started, it is best to get familiar with the Erlang environment as this guide will heavily reference Erlang terms.
集群必须建立独立数据中心:集群必须建立在可信认和低风险的网络中.虽然他是可以跨区使用,但还是建议部署在相同的亚马逊区域内.
集群依赖于Erlang特性和Mnesia 同享模式.开始前,最好先熟悉一下erlang环境,本指引会较深涉及erlang一些概念.


## Clustering Setup
Adding a node to a cluster
Suppose you have already configured ejabberd on one node named ejabberd01. Let’s create an additional node (ejabberd02) and connect them together.
添加一个节点到集群中
假设你已经有一个节点叫ejabberd01,这里会添加一个ejabberd02到现在的节点中.

Copy the /home/ejabberd/.erlang.cookie file from ejabberd01 to ejabberd02.
从ejabberd01拷贝文件/home/ejabberd/.erlang.cookie到ejabberd02

Alternatively you could pass the -setcookie <value> option to all erl commands below.
或者你可以每次都用 -setcookie <value> 来执行下面的erl命令

Make sure your new ejabberd node is properly configured. Usually, you want to have the same ejabberd.yml config file on the new node that on the other cluster nodes.
确认你的新ejabberd正确的设置.一般你的ejabberd.yml配置文件必须是一样的.

Adding a node to the cluster is done by starting a new ejabberd node within the same network, and running a command from a cluster node. On the ejabberd02 node for example, as ejabberd is already started, run the following command as the ejabberd daemon user, using the ejabberdctl script:
在同一网络中打开节点并执行一个命令就可以把节点加到集群中了.
比如在ejabberd02上,用ejabberd启用用户执行下面的脚本:

1
$ ejabberdctl join_cluster 'ejabberd@ejabberd01'
SELECT CODE
This enables ejabberd’s internal replications to be launched across all nodes so new nodes can start receiving messages from other nodes and be registered in the routing tables.
此命令启用ejabberd的内部应答,这样集群所有节点会把新节点加入到路由表中,这样新节点就可以接收消息了.

Removing a node from the cluster
To remove a node from the cluster, it just needs to be shut down. There is no specific delay for the cluster to figure out that the node is gone, the node is immediately removed from other router entries. All clients directly connected to the stopped node are disconnected, and should reconnect to other nodes.
删除节点
把节点关上就可以删除节点.如果没有特别指定延迟删除时间,那么其它的节点会立刻生效.所有连这个节点的客户端都会断开,并去连其它的节点.

If the cluster is used behind a load balancer and the node has been removed from the load balancer, no new clients should be connecting to that node but established connections should be kept, thus allowing to remove a node smoothly, by stopping it after most clients disconnected by themselves. If the node is started again, it’s immediately attached back to the cluster until it has been explicitly removed permanently from the cluster.
如果集群是在负载均衡下使用或是说被负载均衡移除.那么不能建立新的连接但是会老连接会保持.这样等老用户都下了,就可以平滑地删除节点了.
当节点再次打开,他马上会补加入到集群当中,除非已经明确地从集群中永久地删除他.

To permanently remove a running node from the cluster, the following command must be run as the ejabberd daemon user, from one node of the cluster:
 要明确删除一个节点,需要在一个集群结点上执行:

1
$ ejabberdctl leave_cluster 'ejabberd@ejabberd02'
SELECT CODE
The removed node must be running while calling leave_cluster to make it permanently removed. It’s then immediately stopped.
执行命令的时候这个节点必须还在运行.之后它马上会停止.


13 Distributed Erlang
13 分布式Erlang框架

13.1  Distributed Erlang System
13.1 分布式Erlang系统

A distributed Erlang system consists of a number of Erlang runtime systems communicating with each other. Each such runtime system is called a node. Message passing between processes at different nodes, as well as links and monitors, are transparent when pids are used. Registered names, however, are local to each node. This means that the node must be specified as well when sending messages, and so on, using registered names.
分布式Erlang系统由相互通讯的Erlang runtime组成.每个runtime也被称为node(节点). 当使用pids来交互时,不同节点进程(如links和monitors)的消息传递是透明的.
注册的名字被定位到每个节点上.这意味着,当发送消息时,节点必须明确指定,如使用被注册过的名称.

The distribution mechanism is implemented using TCP/IP sockets. How to implement an alternative carrier is described in the ERTS User's Guide.
这种分布式机制使用TCP/IP实现.详见<<ERTS用户手册>>
http://erlang.org/doc/apps/erts/alt_dist.html

13.2  Nodes

A node is an executing Erlang runtime system that has been given a name, using the command-line flag -name (long names) or -sname (short names).
一个节点是一个正在运行的Erlang程序,用命令-name或-sname来标记.

The format of the node name is an atom name@host. name is the name given by the user. host is the full host name if long names are used, or the first part of the host name if short names are used. node() returns the name of the node.
节点名称格式如name@host.name是用户定义的程序名称.host是机器名(ping host可以ping到).如果用-name是使用全称,如果使用-sname则指第一部分.
在代码中使用node().返回这个节点的名称.

Example:

% erl -name dilbert
(dilbert@uab.ericsson.se)1> node().
'dilbert@uab.ericsson.se'

% erl -sname dilbert
(dilbert@uab)1> node().
dilbert@uab
Note
A node with a long node name cannot communicate with a node with a short node name.

13.3  Node Connections

The nodes in a distributed Erlang system are loosely connected. The first time the name of another node is used, for example, if spawn(Node,M,F,A) or net_adm:ping(Node) is called, a connection attempt to that node is made.

Connections are by default transitive. If a node A connects to node B, and node B has a connection to node C, then node A also tries to connect to node C. This feature can be turned off by using the command-line flag -connect_all false, see the erl(1) manual page in ERTS.

If a node goes down, all connections to that node are removed. Calling erlang:disconnect_node(Node) forces disconnection of a node.

The list of (visible) nodes currently connected to is returned by nodes().

13.4  epmd

The Erlang Port Mapper Daemon epmd is automatically started at every host where an Erlang node is started. It is responsible for mapping the symbolic node names to machine addresses. See the epmd(1) manual page in ERTS.

13.5  Hidden Nodes

In a distributed Erlang system, it is sometimes useful to connect to a node without also connecting to all other nodes. An example is some kind of O&M functionality used to inspect the status of a system, without disturbing it. For this purpose, a hidden node can be used.

A hidden node is a node started with the command-line flag -hidden. Connections between hidden nodes and other nodes are not transitive, they must be set up explicitly. Also, hidden nodes does not show up in the list of nodes returned by nodes(). Instead, nodes(hidden) or nodes(connected) must be used. This means, for example, that the hidden node is not added to the set of nodes that global is keeping track of.

This feature was added in Erlang 5.0/OTP R7.

13.6  C Nodes

A C node is a C program written to act as a hidden node in a distributed Erlang system. The library Erl_Interface contains functions for this purpose. For more information about C nodes, see the Erl_Interface application and Interoperability Tutorial..

13.7  Security

Authentication determines which nodes are allowed to communicate with each other. In a network of different Erlang nodes, it is built into the system at the lowest possible level. Each node has its own magic cookie, which is an Erlang atom.

When a node tries to connect to another node, the magic cookies are compared. If they do not match, the connected node rejects the connection.

At start-up, a node has a random atom assigned as its magic cookie and the cookie of other nodes is assumed to be nocookie. The first action of the Erlang network authentication server (auth) is then to read a file named $HOME/.erlang.cookie. If the file does not exist, it is created. The UNIX permissions mode of the file is set to octal 400 (read-only by user) and its contents are a random string. An atom Cookie is created from the contents of the file and the cookie of the local node is set to this using erlang:set_cookie(node(), Cookie). This also makes the local node assume that all other nodes have the same cookie Cookie.

Thus, groups of users with identical cookie files get Erlang nodes that can communicate freely and without interference from the magic cookie system. Users who want to run nodes on separate file systems must make certain that their cookie files are identical on the different file systems.

For a node Node1 with magic cookie Cookie to be able to connect to, or accept a connection from, another node Node2 with a different cookie DiffCookie, the function erlang:set_cookie(Node2, DiffCookie) must first be called at Node1. Distributed systems with multiple user IDs can be handled in this way.

The default when a connection is established between two nodes, is to immediately connect all other visible nodes as well. This way, there is always a fully connected network. If there are nodes with different cookies, this method can be inappropriate and the command-line flag -connect_all false must be set, see the erl(1) manual page in ERTS.

The magic cookie of the local node is retrieved by calling erlang:get_cookie().

13.8  Distribution BIFs

Some useful BIFs for distributed programming (for more information, see the erlang(3) manual page in ERTS:

BIF	Description
erlang:disconnect_node(Node)	Forces the disconnection of a node.
erlang:get_cookie()	Returns the magic cookie of the current node.
is_alive()	Returns true if the runtime system is a node and can connect to other nodes, false otherwise.
monitor_node(Node, true|false)	Monitors the status of Node. A message{nodedown, Node} is received if the connection to it is lost.
node()	Returns the name of the current node. Allowed in guards.
node(Arg)	Returns the node where Arg, a pid, reference, or port, is located.
nodes()	Returns a list of all visible nodes this node is connected to.
nodes(Arg)	Depending on Arg, this function can return a list not only of visible nodes, but also hidden nodes and previously known nodes, and so on.
erlang:set_cookie(Node, Cookie)	Sets the magic cookie used when connecting to Node. If Node is the current node, Cookie is used when connecting to all new nodes.
spawn[_link|_opt](Node, Fun)	Creates a process at a remote node.
spawn[_link|opt](Node, Module, FunctionName, Args)	Creates a process at a remote node.
Table 13.1:   Distribution BIFs
13.9  Distribution Command-Line Flags

Examples of command-line flags used for distributed programming (for more information, see the erl(1) manual page in ERTS:

Command-Line Flag	Description
-connect_all false	Only explicit connection set-ups are used.
-hidden	Makes a node into a hidden node.
-name Name	Makes a runtime system into a node, using long node names.
-setcookie Cookie	Same as calling erlang:set_cookie(node(), Cookie).
-sname Name	Makes a runtime system into a node, using short node names.
Table 13.2:   Distribution Command-Line Flags
13.10  Distribution Modules

Examples of modules useful for distributed programming:

In the Kernel application:

Module	Description
global	A global name registration facility.
global_group	Grouping nodes to global name registration groups.
net_adm	Various Erlang net administration routines.
net_kernel	Erlang networking kernel.
Table 13.3:   Kernel Modules Useful For Distribution.
In the STDLIB application:

Module	Description
slave	Start and control of slave nodes.
Table 13.4:   STDLIB Modules Useful For Distribution.
