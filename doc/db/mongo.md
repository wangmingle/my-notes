mongo.md
----

### install 


### get start

mongo
> db.system.users.find();
> db.addUser("test_user","password")

db.createUser( { user: "accountAdmin01",
                 pwd: "changeMe",
                 customData: { employeeId: 12345 },
                 roles: [ { role: "clusterAdmin", db: "admin" },
                          { role: "readAnyDatabase", db: "admin" },
                          "readWrite"] },
               { w: "majority" , wtimeout: 5000 } )
use test
db.createUser(
   {
     user: "test",
     pwd: "udesk123456",
     roles:
       [
         { role: "readWrite", db: "test" }
       ]
   }
)
db.system.users.find();
db.auth("test","udesk123456")

mgweb
test:udesk123456@127.0.0.1:27017/test

http://bubkoo.com/2014/02/07/mongodb-authentication/

加用户 db.addUser("guest", "pass", true)
改密码 db.addUser("guest", "newpass")
删除 db.removeUser("guest")

3.2 没有 db.addUser了
db.createUser({user:"yearnfar",pwd:"123456",roles:[]})
db.createUser({user:'ydkt',pwd:'ydkt',roles:['readWrite','dbAdmin']})

use admin
db.createUser(
   {
     user: "appAdmin",
     pwd: "password",
     roles:
       [
         { role: "readWrite", db: "config" },
         "clusterAdmin"
       ]
   }
)



超级用户拥有最大权限，可以对所有数据库进行任意操作，超级用户储存在 admin 数据库中，刚安装的 MongoDB 中 admin 数据库是空的；

数据库用户存储在单个数据库中，只能访问对应的数据库。另外，用户信息保存在 db.system.users 中。

数据库是由超级用户来创建的，一个数据库可以包含多个用户，一个用户只能在一个数据库下，不同数据库中的用户可以同名

如果在 admin 数据库中不存在用户，即使 mongod 启动时添加了 –auth 参数，此时不进行任何认证还是可以做任何操作

在 admin 数据库创建的用户具有超级权限，可以对 MongoDB 系统内的任何数据库的数据对象进行操作

特定数据库比如 test1 下的用户 test_user1，不能够访问其他数据库 test2，但是可以访问本数据库下其他用户创建的数据
不同数据库中同名的用户不能够登录其他数据库。比如数据库 test1 和 test2 都有用户 test_user，以 test_user 登录 test1 后,不能够登录到 test2 进行数据库操作



### tools

https://github.com/paralect/robomongo


### referrent

http://www.cnblogs.com/huangxincheng/category/355399.html

8天学通MongoDB

数据库，集合，文档
collections -> tables
documents -> row

db.person.insert({"name": "weizhao","age": 35});

find 

db.person.find();

>, >=, <, <=, !=, =。
$gt", "$gte", "$lt", "$lte", "$ne", "没有特殊关键字"
db.person.find({"age":{$gt:32}});

And，OR，In，NotIn
"无关键字“, "$or", "$in"，"$nin"

正则
db.person.find({"name":/^w/, "name":/o$/});

where
db.person.find({$where:function(){ return this.name == 'weizhao'}});

update:

var model=db.person.findOne({"name": "weizhao"});
model.age = 36
db.person.find()
db.person.update({"name": "weizhao"}, model)
db.person.update({"name": "weizhao"}, {"name": "weizhao", "age": 36})
db.person.find()

 $inc修改器

       $inc也就是increase的缩写，在原有的基础上 自增$inc指定的值，如果“文档”中没有此key，则会创建key，下面的例子一看就懂。
       加数,或由 0 加
 db.person.update({"name": "weizhao"}, {$inc: {"worktime": 14}} )

 $set修改器

 	非加光改

$upsert

db.person.update({"name": "韦洢澄"}, {"name": "韦洢澄","age": 1},  true)
注: 3.2 必须加 "name": "xxx"


批量更新

     在mongodb中如果匹配多条，默认的情况下只更新第一条，那么如果我们有需求必须批量更新，那么在mongodb中实现也是很简单

的，在update的第四个参数中设为true即可。例子就不举了。


四: Remove操作

db.person.remove({"age": 1})


## count

## distinct
db.person.distinct("age")

<3> group

    在mongodb里面做group操作有点小复杂，不过大家对sql server里面的group比较熟悉的话还是一眼

能看的明白的，其实group操作本质上形成了一种“k-v”模型，就像C#中的Dictionary，好，有了这种思维，

我们来看看如何使用group。

    下面举的例子就是按照age进行group操作，value为对应age的姓名。下面对这些参数介绍一下：

       key：  这个就是分组的key，我们这里是对年龄分组。

       initial: 每组都分享一个”初始化函数“，特别注意：是每一组，比如这个的age=20的value的list分享一个

initial函数，age=22同样也分享一个initial函数。

       $reduce: 这个函数的第一个参数是当前的文档对象，第二个参数是上一次function操作的累计对象，第一次

为initial中的{”perosn“：[]}。有多少个文档， $reduce就会调用多少次。


db.person.group(
{
"key": {"age": true},
"initial": {"person": []},
"$reduce": function(cur, prev){
	prev.person.push(cur.name);
}

})

condition:  这个就是过滤条件。

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

## mapReduce
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

## 游标

var list=db.person.find();
for / next()
list.forEach(function(x){
	print(x.name);
})
var single=db.person.find().sort({"name",1}).skip(2).limit(2);
? 2016-10-06T23:31:54.756+0800 E QUERY    [thread1] SyntaxError: missing : after property id @(shell):1:40


那些坑:

https://ruby-china.org/topics/20128
主要是锁的问题
如果有,必须是写原始库 读一个库

别的小坑
http://www.jianshu.com/p/13c6a6cf903d
补充: 1. 过高的内存占用   116G数据   占用32G内存跑满
2. 在内存不足的时候如不使用安全模式,大量导入数据时会随机丢数据


skip 太慢

因为文档型数据的长度是不定的，所以其实并没有字节偏移量这种方便的东西。当你 skip(N) 的时候，这其实是一个 O(N) 的计算。可能一百以内感觉还不明显，成千上万以后延迟就已经肉眼可见了。

因此最好用 last_id 之类的来分页。

没有事务

天坑啊。

虽然官方给出了一个名为 两步提交（two phase commit） 的替代方案，但比较麻烦。有事务需求的时候建议还是用支持原生事务的数据库替代。



http://www.cnblogs.com/shanpow/p/4169773.html
map-reduce


http://huoding.com/2011/08/19/107 内存

http://blog.codingnow.com/2014/03/mmzb_mongodb.html


https://github.com/ma6174/blog/issues/3

http://www.edwardesire.com/2016/03/28/a-mountain-to-climb-mongodb-index-query/

越过大山和mongoDB查询操作的坑

https://www.v2ex.com/t/104230
著名的`带条件的count()`慢到爆浆？
由于JS引擎的原因，精度很疼


https://github.com/Tokutek/mongo
http://www.infoq.com/cn/news/2014/11/tokutek-tokudb-7-5-tokumx-2-0


db.person.insert({"name": "韦昭", "age": 36})

db.test1_data.insert({"id":1,"info":"I am in test1"})

show dbs
use admin

db.system.users.find(); # 默认 admin 数据库中不存在用户
> use test
switched to db test
> db.system.users.find(); # 默认 test 数据库中也不存在用户
> db.test_data.insert({"id":1,"info":"I am in test"})
> db.test_data.insert({"id":2,"info":"I am in test"})
> db.test_data.insert({"id":3,"info":"I am in test"})
> db.test_data.find()
{ "_id" : ObjectId("52f5922125d9e18cd51581b6"), "id" : 1, "info" : "I am in test" }
{ "_id" : ObjectId("52f5926d25d9e18cd51581b7"), "id" : 2, "info" : "I am in test" }
{ "_id" : ObjectId("52f5927125d9e18cd51581b8"), "id" : 3, "info" : "I am in test" }
# 创建用户
> db.addUser("test_user","password")
{
        "user" : "test_user",
        "readOnly" : false,
        "pwd" : "bf7a0adf9822a3379d6dfb1ebd38b92e",
        "_id" : ObjectId("52f5928625d9e18cd51581b9")
}
> db.system.users.find()
{ "_id" : ObjectId("52f5928625d9e18cd51581b9"), "user" : "test_user", "readOnly" : false, 
pwd" : "bf7a0adf9822a3379d6dfb1ebd38b92e" }
# 验证函数，验证数据库中是否存在对应的用户
> db.auth("test_user","password")
use test1
switched to db test1
> db.test1_data.insert({"id":1,"info":"I am in test1"})
> db.test1_data.insert({"id":2,"info":"I am in test1"})
> db.test1_data.insert({"id":3,"info":"I am in test1"})
> db.test1_data.find()
{ "_id" : ObjectId("52f593e925d9e18cd51581ba"), "id" : 1, "info" : "I am in test1" }
{ "_id" : ObjectId("52f593ef25d9e18cd51581bb"), "id" : 2, "info" : "I am in test1" }
{ "_id" : ObjectId("52f593f425d9e18cd51581bc"), "id" : 3, "info" : "I am in test1" }


	
D:\MongoDB\mongodb-2.4.8>.\bin\mongod --dbpath=.\data --logpath=.\log\log.log --auth
重新以认证的方式启动数据库，启动时添加 –auth 参数

mongo
MongoDB shell version: 2.4.8
connecting to: test
没有建admin,还是默认有超级用户权限 

# 在 admin 数据库中创建用户 supper，密码为 password
> use admin
switched to db admin
> db.addUser("supper","password")
{
        "user" : "supper",
        "readOnly" : false,
        "pwd" : "0d345bf64f4c1e8bc3e3bbb04c46b4d3",
        "_id" : ObjectId("52f5bdf439a90d49d27742d5")
}
# 认证
> db.auth("supper","password")
1
>

mongo 127.0.0.1/admin -usupper -ppassword





