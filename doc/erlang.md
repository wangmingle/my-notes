erlang
=====







## ejabberd

monitor

https://www.ejabberd.im/mod_monitor_web


网络监控

erlang性能分析及进程监控工具
http://blog.sina.com.cn/s/blog_a78beb1f0102vgss.html

etop -node ejabberd@localhost
/usr/local/lib/erlang/lib/observer-2.1.1/priv/bin/etop -setcookie JHWKZOZFBUYXNYPMXOSA -node ejabberd@localhost


以下失败
 ./etop -node 'ejabberd@localhost'  -setcookie  JHWKZOZFBUYXNYPMXOSA -lines 5 -sort memory -interval 50 -accumulate true -tracing on
 #!/bin/sh

 NAME="etop@testrsa.igrslabdns.com"
 echo erl -sname $NAME -hidden -s etop -s erlang halt -output text $@
 erl -name $NAME -hidden -s etop -s erlang halt -output text $@
 ~                                             

http://dev.groupdock.com/2010/10/05/monitoring-ejabberd-with-munin.html

https://github.com/processone/grapherl

```
ejabberdctl debug

ejabberdctl debug
>i().

```

https://www.ejabberd.im/tricks

erl -sname node1 -remsh ejabberd@localhost

erlang:get_cookie().

erl -setcookie KDETQBSASTSJCDRLAUUN -sname node1 -remsh ejabberd@localhost -run i -run init stop -noshell
erl -noshell -s program main -s init stop


ejabberd_config:load_file("/home/ejabberd/ejabberd.cfg").
c(mod_version).
l(mod_version).

erlang:system_info(process_limit).
processes:max(N). % set processes limits.

MonitorRef = erlang:monitor(Pid).
{MonitorRef,Pid} = spawn_monitor(...). %% spawn and monitor, atomic.
demonitor(MonitorRef). %% remove monitor



`exec $ERL $NAME ejabberdetop$SUFFIX -hidden -s etop -s erlang halt -output
text -tracing off -node $ERLANG_NODE`
