Sharding pattern
------

核心:
把一个数据库拆成多个放
垂直拆: 表多数据少
水平拆: 表少数据多
混合: 先垂直后水平
混合例子:
            |-  users     => users1 users2
SingleDB =  |-  op_logs   => op_logs1 op_logs2
            |-  orders    => orders1 orders2
http://wiki.jikexueyuan.com/project/cloud-design-patterns/sharding.html
