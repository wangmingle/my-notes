mongo.md
----

### 文档

[中文](http://www.runoob.com/mongodb/mongodb-tutorial.html)

### ubuntu 安装

[doc](https://docs.mongodb.com/v3.2/tutorial/install-mongodb-on-ubuntu/)

```
sudo apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv EA312927

# Ubuntu 12.04
echo "deb http://repo.mongodb.org/apt/ubuntu precise/mongodb-org/3.2 multiverse" | sudo tee /etc/apt/sources.list.d/mongodb-org-3.2.list

# Ubuntu 14.04
echo "deb http://repo.mongodb.org/apt/ubuntu trusty/mongodb-org/3.2 multiverse" | sudo tee /etc/apt/sources.list.d/mongodb-org-3.2.list

# Ubuntu 16.04
echo "deb http://repo.mongodb.org/apt/ubuntu xenial/mongodb-org/3.2 multiverse" | sudo tee /etc/apt/sources.list.d/mongodb-org-3.2.list

sudo apt-get update

sudo apt-get install mongodb-org
# or
sudo apt-get install -y mongodb-org=3.2.10 \
  mongodb-org-server=3.2.10 \
  mongodb-org-shell=3.2.10 \
  mongodb-org-mongos=3.2.10 \
  mongodb-org-tools=3.2.10

```

### docker 安装

mkdir -p mongo/db

docker pull mongo:3.2.10

https://dev.aliyun.com/detail.hmongotml?spm=5176.1972343.2.2.u6lXOV&repoId=1237

试`docker run -p 27017:27017 -v $PWD/db:/data/db -d mongo:3.2.10`

这个居然不是后台运行,改使用下面的脚本`run.sh`来运行

```bash
#!/bin/bash
NAME=mongo
mkdir -p log

docker stop $NAME

docker ps -a | grep Exited | awk '{print $1}' | xargs docker rm

nohup docker run -p 27017:27017 -v $PWD/db:/data/db --name $NAME mongo:3.2.10 --auth > log/mongo.log &

```
docker run -p 27017:27017 -v /srv/mongo/db:/data/db --name mongo mongo:3.2.10 --auth > log/mongo.log &
命令行访问

```
docker exec -it mongo mongo -u admin -p xxx test
```

--auth 在没有系统管理账号时不会生效

注: `2.*` 版本客户端不能进入`3.*` 的服务器

如果用户建立得不对,可以去掉这个参数`--auth`重启数据

[参考](https://yeasy.gitbooks.io/docker_practice/content/appendix_repo/mongodb.html)

### get start

#### 建立用户

管理员
```
mongo
use admin
db.system.users.find();

db.createUser( { user: "admin",
                 pwd: "udesk765432",
                 roles: [
                  "root",
                  "dbAdminAnyDatabase",
                  "readWrite",
                  "userAdminAnyDatabase",
                  "readWriteAnyDatabase"] },
               { w: "majority" , wtimeout: 5000 } )
db.system.users.find();
# 提示没有权限
db.auth("admin","xxx")
db.system.users.remove({"user": "UdeskAdmin"})
```

库权限
```
use test
db.createUser(
   {
     user: "test",
     pwd: "test1234",
     roles:
       [
         { role: "readWrite", db: "test" }
       ]
   }
)
db.system.users.find();
db.auth("test","test1234")
```

更新用户权限

```
use admin
db.system.users.find();

```

### 常见查询方法

```
# 查询最后一条
db.online.find({"company_code": "d66b21h"}).sort({'created_at': -1}).limit(1)

# 排名统计
# https://docs.mongodb.com/v3.2/reference/operator/aggregation/group/
db.online.aggregate(
   [
      {
        $group : {
           _id : "$company_code",
           count: { $sum: 1 }
        }
      },
      {
        $sort:{count: -1}
      }
   ]
)
```
参考:

[用户](https://docs.mongodb.com/v3.2/tutorial/manage-users-and-roles/#create-a-user-defined-role)

[角色](https://docs.mongodb.com/v3.2/reference/built-in-roles/#userAdminAnyDatabase)


注:3.2 没有 db.addUser了

### 初始化脚本

/mongo IP/DBName init.js

init.js文件内容可以这么写：

```javascript
db.dropDatabase(); //删除数据库达到清空数据的目的

db.message.ensureIndex({display_id:1}); //在当前数据库中的message集合的display_id字段上创建索引
```

### 权限控制相关

超级用户拥有最大权限， 存在 admin 数据库中，刚安装的 MongoDB 中 admin 数据库是空的；

数据库用户存储在单个数据库中，只能访问对应的数据库。另外，用户信息保存在 db.system.users 中。

数据库是由超级用户来创建的，一个数据库可以包含多个用户，一个用户只能在一个数据库下，不同数据库中的用户可以同名

如果在 admin 数据库中不存在用户，即使 mongod 启动时添加了 –auth 参数，此时不进行任何认证还是可以做任何操作

在 admin 数据库创建的用户具有超级权限，可以对 MongoDB 系统内的任何数据库的数据对象进行操作

特定数据库比如 test1 下的用户 test_user1，不能够访问其他数据库 test2，但是可以访问本数据库下其他用户创建的数据
不同数据库中同名的用户不能够登录其他数据库。比如数据库 test1 和 test2 都有用户 test_user，以 test_user 登录 test1 后,不能够登录到 test2 进行数据库操作

### tools

https://github.com/paralect/robomongo

### 引用

[8天学通MongoDB](http://www.cnblogs.com/huangxincheng/category/355399.html)

数据库，集合，文档

  collections -> tables

  documents -> row

```
db.person.insert({"name": "weizhao","age": 35});
db.person.find();
```

`>, >=, <, <=, !=, =`

$gt", "$gte", "$lt", "$lte", "$ne", "没有特殊关键字"

`db.person.find({"age":{$gt:32}});``

And，OR，In，NotIn

"无关键字“, "$or", "$in"，"$nin"

正则

`db.person.find({"name":/^w/, "name":/o$/});``

where

`db.person.find({$where:function(){ return this.name == 'weizhao'}});`

update:

```
var model=db.person.findOne({"name": "weizhao"});
model.age = 36
db.person.find()
db.person.update({"name": "weizhao"}, model)
db.person.update({"name": "weizhao"}, {"name": "weizhao", "age": 36})
db.person.find()
```

$inc修改器

   $inc也就是increase的缩写，在原有的基础上 自增$inc指定的值，如果“文档”中没有此key，则会创建key，下面的例子一看就懂。

   加数,或由 0 加

```   
 db.person.update({"name": "weizhao"}, {$inc: {"worktime": 14}} )
```

$set修改器

 	非加光改

$upsert

`db.person.update({"name": "韦洢澄"}, {"name": "韦洢澄","age": 1},  true)`

注: 3.2 必须加 "name": "xxx"

批量更新

     在mongodb中如果匹配多条，默认的情况下只更新第一条，那么如果我们有需求必须批量更新，那么在mongodb中实现也是很简单

的，在update的第四个参数中设为true即可。例子就不举了。


四: Remove操作

`db.person.remove({"age": 1})``


$ count

$ distinct

`db.person.distinct("age")`

$ group

    在mongodb里面做group操作有点小复杂，不过大家对sql server里面的group比较熟悉的话还是一眼

能看的明白的，其实group操作本质上形成了一种“k-v”模型，就像C#中的Dictionary，好，有了这种思维，

我们来看看如何使用group。

    下面举的例子就是按照age进行group操作，value为对应age的姓名。下面对这些参数介绍一下：

       key：  这个就是分组的key，我们这里是对年龄分组。

       initial: 每组都分享一个”初始化函数“，特别注意：是每一组，比如这个的age=20的value的list分享一个

initial函数，age=22同样也分享一个initial函数。

       $reduce: 这个函数的第一个参数是当前的文档对象，第二个参数是上一次function操作的累计对象，第一次

为initial中的{”perosn“：[]}。有多少个文档， $reduce就会调用多少次。

```
db.person.group(
  {
  "key": {"age": true},
  "initial": {"person": []},
  "$reduce": function(cur, prev){
  	prev.person.push(cur.name);
  }
})
```

$ condition:  这个就是过滤条件。

finalize:这是个函数，每一组文档执行完后，多会触发此方法，那么在每组集合里面加上count也就是它的活了。

db.person.group(
{
	"key": {"age": true},
	"initial": {"person": []},
	"$reduce": function(cur, prev){
		prev.person.push(cur.name);
	},
	"finalize": function(out){
		out.count = out.person.length;
	},
	"condition": {"age": {$lt: 25}}

})

$ mapReduce
map：
	映射函数，里面会调用emit(key,value)，集合会按照你指定的key进行映射分组。
reduce：
	简化函数，会对map分组后的数据进行分组简化，注意：在reduce(key,value)中的key就是 emit中的key，vlaue为emit分组后的emit(value)的集合，这里也就是很多{"count":1}的数组。
mapReduce:
	这个就是最后执行的函数了，参数为map，reduce和一些可选参数

map
function(){
	emit(this.name, {count: 1});
}

reduce
function(key,value){
	var result = {count: 0};
	for (var i = 0; i < value.length; i++ ){
		result.count += value[i].count;
	}
	return result;
}

db.person.mapReduce(map,reduce, {"out": "collection"})

       result: "存放的集合名“；

       input:传入文档的个数。

       emit：此函数被调用的次数。

       reduce：此函数被调用的次数。

       output:最后返回文档的个数。

最后我们看一下“collecton”集合里面按姓名分组的情况。

db.collection.find()

$ 游标

```
var list=db.person.find();
for / next()
list.forEach(function(x){
	print(x.name);
})
var single=db.person.find().sort({"name",1}).skip(2).limit(2);
```

#### 主从

http://gong1208.iteye.com/blog/1558355

#### 一些坑:

https://ruby-china.org/topics/20128

锁的问题

http://www.jianshu.com/p/13c6a6cf903d

补充:

1. 过高的内存占用   116G数据   占用32G内存跑满

2. 在内存不足的时候如不使用安全模式,大量导入数据时会随机丢数据

3. skip 太慢

因为文档型数据的长度是不定的，所以其实并没有字节偏移量这种方便的东西。当你 skip(N) 的时候，这其实是一个 O(N) 的计算。可能一百以内感觉还不明显，成千上万以后延迟就已经肉眼可见了。

因此最好用 last_id 之类的来分页。

没有事务

虽然官方给出了一个名为 两步提交（two phase commit） 的替代方案，但比较麻烦。有事务需求的时候建议还是用支持原生事务的数据库替代。

[map-reduce](http://www.cnblogs.com/shanpow/p/4169773.html)

[内存](http://huoding.com/2011/08/19/107)

http://blog.codingnow.com/2014/03/mmzb_mongodb.html

https://github.com/ma6174/blog/issues/3

http://www.edwardesire.com/2016/03/28/a-mountain-to-climb-mongodb-index-query/

越过大山和mongoDB查询操作的坑

https://www.v2ex.com/t/104230

著名的`带条件的count()`慢到爆浆？

由于JS引擎的原因，精度有问题

https://github.com/Tokutek/mongo

http://www.infoq.com/cn/news/2014/11/tokutek-tokudb-7-5-tokumx-2-0

[多表查询](http://qianxunniao.iteye.com/blog/1776313)

[connection-string/主从](https://docs.mongodb.com/manual/reference/connection-string/)

[索引](http://www.mongoing.com/archives/2797)

http://www.yl-blog.com/article/482.html

http://eksliang.iteye.com/blog/2178555

https://www.oschina.net/translate/mongodb-indexing-tip-3-too-many-fields-to-index-use
