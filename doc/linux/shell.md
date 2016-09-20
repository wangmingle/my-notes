shell
-----

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
```

### 使用im的公司排序
```
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
