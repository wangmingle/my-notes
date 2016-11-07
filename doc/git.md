git

=====

### git 管理
sublime text:

https://github.com/kemayo/sublime-text-git/wiki

### git config
  http://stackoverflow.com/questions/23918062/simple-vs-current-push-default-in-git-for-decentralized-workflow
  push
    default = simple / current / matching

  如果用matching,会出现把所有的本地与origin名字相同的都上推,如果一担用了git push -f 会强推覆盖,造成不想要的结果
π
  最好用 current
### 忽略已经提交的文件

https://segmentfault.com/q/1010000000430426

git rm --cached logs/xx.log，然后更新 .gitignore
commit
### 删除远程分支

```shell
  git push origin :serverfix
  git push origin :Develop
```

https://github.com/udesk/udesk_proj/compare/hotfix_speedup_api_token?expand=1

https://github.com/udesk/udesk_proj/compare/develop...hotfix_speedup_api_token?expand=1

git tool
https://github.com/paulirish/git-recent 显示本地分支最后的修改

https://hub.github.com/ github 工具

checkout tag

git checkout -b tag_name tag_name
git checkout -b v3.2.1 v3.2.1


git config --global https.proxy 'socks5://127.0.0.1:1080'
