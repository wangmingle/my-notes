shell
-----

###

### [2>&1 的含义](http://blog.csdn.net/ithomer/article/details/9288353)


### 当前路径

```
## 在执行脚本中可以用
cd `dirname $0`
dir=`pwd`
```

```
cat shell/a.sh
#!/bin/bash
echo '$0: '$0
echo "pwd: "`pwd`
echo "============================="
echo "scriptPath1: "$(cd `dirname $0`; pwd)
echo "scriptPath2: "$(pwd)
echo "scriptPath3: "$(dirname $(readlink -f $0))
echo "scriptPath4: "$(cd $(dirname ${BASH_SOURCE:-$0});pwd)
echo -n "scriptPath5: " && dirname $(readlink -f ${BASH_SOURCE[0]})
Jun@VAIO 192.168.1.216 23:53:17 ~ >
bash shell/a.sh
$0: shell/a.sh
pwd: /home/Jun
=============================
scriptPath1: /home/Jun/shell
scriptPath2: /home/Jun
scriptPath3: /home/Jun/shell
scriptPath4: /home/Jun/shell
scriptPath5: /home/Jun/shell
Jun@VAIO 192.168.1.216 23:54:54 ~ >
```
### color

http://misc.flogisoft.com/bash/tip_colors_and_formatting

### bash with args

```bash
reset_remote_branch(){
  name=$1
  cd ~/udesk/$name
  echo "reset $name"
  set -x \
    && git fetch --all \
    && git checkout develop && git reset --hard origin/develop \
    && git checkout master && git reset --hard origin/master \
    && git checkout week && git reset --hard origin/week
}
proj="udesk_proj"
im="udesk_im"
reset_remote_branch $proj
reset_remote_branch $im
```

### sshd

```
sshd_config
  PasswordAuthentication no
```

### sed 代替

```
grep -rl '52698' /usr/local/bin/ratom  | xargs sed -i 's/52698/53698/g'
grep -rl 'stagingpush.udesk.cn' conf/ejabberd.yml  | xargs sed -i 's/stagingpush.udesk.cn/stagingpush.udeskcat.com/g'
```

mac

```
# http://stackoverflow.com/questions/4247068/sed-command-with-i-option-failing-on-mac-but-works-on-linux
grep -rl 'api: http://im03.udesk.cn/' config/property/*.yml | xargs sed -i 's/api\: http\:\/\/im03\.udesk\.cn\//api\: http\:\/\/im03\.udesk\.cn\:5888\//g'
mac
grep -rl 'api: http://im03.udesk.cn/' config/property/*.yml | xargs sed -i '' 's/api\: http\:\/\/im03\.udesk\.cn\//api\: http\:\/\/im03\.udesk\.cn\:5888\//g'
grep -rl 'api: http://im03.udesk.cn:5888/' config/property/*.yml | xargs sed -i '' 's/api\: http\:\/\/im03\.udesk\.cn\:5888\//api\: http\:\/\/internalim03\.udesk\.cn\:5888\//g'
grep -rl 'http://imdev.udeskmonkey.com:5880/http-bind/' config/property/*.yml | xargs sed -i '' 's/http\:\/\/imdev.udeskmonkey.com\:5880\/http-bind\//http\:\/\/imdev.udeskmonkey.com\/http-bind\//g'


grep -rl 'http://v3.faqrobot.org/' config/property/*.yml | xargs sed -i '' 's/http\:\/\/v3.faqrobot.org\//http\:\/\/udesk.faqrobot.org\//g'

grep -rl 'im_v4:' config/property/*.yml | xargs sed -i '' "s/im_v4:/vistor_server: http:\/\/localhost:6001\/\nim_v4:/g"

grep -rl 'localhost:6001' config/property/server.*.yml | xargs sed -i '' 's/vistor_server: http:\/\/localhost:6001\//g'


grep -rl 'github.com/googollee/go-engine.io' * | \
xargs sed -i '' 's/github.com\/googollee\/go-engine.io/github.com\/azhao1981\/go-engine.io/g'

```

### 使用im的公司排序
```
tower 上redis 问题查看
netstat -na| grep -v 7001 | grep -v 7002 |grep 6379| grep ESTABLISHED | \
 awk '{split($5,a,":" ); print a[1]}' | sort|uniq -c|sort -nr

'{split($5,a,":" ); print a[1]}' # 把 $5 用 : 拆分放在a中. 取第一个
'{split($4,a,":" ); print a[2]}' # 把 $5 用 : 拆分放在a中. 取第一个

grep /api/v2/im/agent.json log/production.log | awk '{print $5}' |sort|uniq -c|sort -nr

args tips

((!$#)) && echo 请指定文件, command ignored! && exit 1

for in
for branch in $MERGE_BRANCHS
do
    echo "$DEPLOY_BRANCH merge $branch"
done
```

### vim 自动加可执行:


```
vim ~/.vimrc
au BufWritePost * if getline(1) =~ "^#!" | silent !chmod a+x <afile>
```


if
#!/bin/bash
echo "Enter your name: "  
read A
if [ "$A" = "GS" ];then
        echo "yes"
elif [ "$A" = "UC" ];then
        echo "no"
else
        echo  "your are wrong"
fi
