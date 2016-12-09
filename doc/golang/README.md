README - Golang
-----
### 
### channel

有类型,有数量,有阻塞

[Go语言学习：Channel/基本概念](http://hustcat.github.io/channel/)
[Go Channel详解/常用代码用法](http://colobu.com/2016/04/14/Golang-Channels/)
[深度剖析channel](http://shanks.leanote.com/post/%E6%B7%B1%E5%BA%A6%E5%89%96%E6%9E%90channel)
[简单用法](http://tonybai.com/2014/09/29/a-channel-compendium-for-golang/)

go 使用 CSP
Actor模型广义上讲与CSP模型很相似。但两种模型就提供的原语而言，又有一些根本上的不同之处：
    – CSP模型处理过程是匿名的，而Actor模型中的Actor则具有身份标识。
    – CSP模型的消息传递在收发消息进程间包含了一个交会点，即发送方只能在接收方准备好接收消息时才能发送消息。相反，actor模型中的消息传递是异步 的，即消息的发送和接收无需在同一时间进行，发送方可以在接收方准备好接收消息前将消息发送出去。这两种方案可以认为是彼此对偶的。在某种意义下，基于交 会点的系统可以通过构造带缓冲的通信的方式来模拟异步消息系统。而异步系统可以通过构造带消息/应答协议的方式来同步发送方和接收方来模拟交会点似的通信 方式。
    – CSP使用显式的Channel用于消息传递，而Actor模型则将消息发送给命名的目的Actor。这两种方法可以被认为是对偶的。某种意义下，进程可 以从一个实际上拥有身份标识的channel接收消息，而通过将actors构造成类Channel的行为模式也可以打破actors之间的名字耦合。

[翻译绝妙的channel](http://mikespook.com/2013/05/%E7%BF%BB%E8%AF%91%E7%BB%9D%E5%A6%99%E7%9A%84-channel/)



### for
for{}
### 字符串

http://www.cnblogs.com/golove/p/3262925.html

### CHINA
https://github.com/gpmgo/gopm
https://github.com/gpmgo/docs/blob/master/zh-CN/README.md

### best
https://peter.bourgon.org/go-in-production/
https://peter.bourgon.org/go-best-practices-2016/#development-environment

### docker

https://dev.aliyun.com/detail.html?spm=5176.1972343.2.6.jIhoPS&repoId=1215

### 开发环境

https://segmentfault.com/a/1190000002586255

### interview

https://github.com/MaximAbramchuck/awesome-interview-questions#golang

https://github.com/mrekucci/epi
http://career.guru99.com/top-20-go-programming-interview-questions/
https://github.com/efischer19/golang_ctci

http://www.golangpro.com/2015/08/golang-interview-questions-answers.html


go get GOPATH error:


```shell
go get
go install: no install location for directory /Users/azhao/dev/mylg outside GOPATH
	For more details see: go help gopath
```

http://stackoverflow.com/questions/26134975/go-install-no-install-location-for-directory-outside-gopath

gc
http://wangzhezhe.github.io/blog/2016/04/30/golang-gc/


tips
http://colobu.com/2015/09/07/gotchas-and-common-mistakes-in-go-golang/


### byte && string
http://xuzhenglun.github.io/2016/04/19/Golang-byte-string-dont-share-menory/
大概是 []byte 对内存的操作不复制
```golang
pckage main

import "fmt"

func main() {
    str := []byte("this is a fucking string")
    str2 := str[0:5]
    str3 := str2[0:2]
    fmt.Printf("%p\n", str)
    fmt.Printf("%p\n", str2)
    fmt.Printf("%p\n", str3)
}
```
