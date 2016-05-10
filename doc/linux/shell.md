shell
====
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
