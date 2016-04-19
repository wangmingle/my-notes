THE GREAT WALL
======

代理规则 :

http://www.duoluodeyu.com/1337.html

user-rule.txt
与GFWlist同，即adblockplus过滤规则 https://adblockplus.org/en/filter-cheatsheet

1. 通配符支持，如 *.example.com/* 实际书写时可省略* 如.example.com/ 意即*.example.com/*
2. 正则表达式支持，以\开始和结束， 如 \[\w]+:\/\/example.com\
3. 例外规则 @@，如 @@*.example.com/* 满足@@后规则的地址不使用代理
4. 匹配地址开始和结尾 |，如 |http://example.com、example.com|分别表示以http://example.com开始和以example.com结束的地址
5. || 标记，如 ||example.com *://*.example.com/*
6. 注释 ! 如 ! Comment

例如你要添加www.ip138.com、ip.cn两个网站到自定义代理规则，编辑user-rule.txt文件，在文件最后加入：
!测试user-rule生效
||ip138.com
||ip.cn

备注：user-rule.txt一行只能有一条代理规则。

user-rule.txt 规则生效 执行下面重要的一步：更新本地的PAC

TIPS: 如果发现哪个网站载入很慢,样式有问题,很可能cdn被墙,用chrome 打开,看newwork里红色的请求,把地址加到 user-rule.txt中

如:
https://atom.io/packages/remote-atom
包含
https://github-atom-io-herokuapp-com.global.ssl.fastly.net/assets/application-ba07c5c2889a34307a4b7d49410451d9.css
加
||fastly.net
然后 更新本地的PAC
