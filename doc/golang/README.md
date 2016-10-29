README - Golang
-----
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
