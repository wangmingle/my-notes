shell
====

代替
```
grep -rl '52698' /usr/local/bin/ratom  | xargs sed -i 's/52698/53698/g'

mac
http://stackoverflow.com/questions/4247068/sed-command-with-i-option-failing-on-mac-but-works-on-linux
grep -rl 'api: http://im03.udesk.cn/' config/property/*.yml | xargs sed -i 's/api\: http\:\/\/im03\.udesk\.cn\//api\: http\:\/\/im03\.udesk\.cn\:5888\//g'
mac
grep -rl 'api: http://im03.udesk.cn/' config/property/*.yml | xargs sed -i '' 's/api\: http\:\/\/im03\.udesk\.cn\//api\: http\:\/\/im03\.udesk\.cn\:5888\//g'
grep -rl 'api: http://im03.udesk.cn:5888/' config/property/*.yml | xargs sed -i '' 's/api\: http\:\/\/im03\.udesk\.cn\:5888\//api\: http\:\/\/internalim03\.udesk\.cn\:5888\//g'
```
使用im的公司排序
grep /api/v2/im/agent.json log/production.log | awk '{print $5}' |sort|uniq -c|sort -nr

args tips

((!$#)) && echo 请指定文件, command ignored! && exit 1

for in
for branch in $MERGE_BRANCHS
do
    echo "$DEPLOY_BRANCH merge $branch"
done


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
