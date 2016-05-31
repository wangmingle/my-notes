git

=====

### git 管理

### udeskim加 customer_traces
```
--

    Did you mean? customer_extra
 ) return: {:code=>"4444", :message=>"未知错误", :exception=>"undefined method `customer_traces' for #<Customer:0x007f50141a7e38>\n\n    Did you mean? customer_extra\n "}
 ```
### push 问题 wechat 都会进worker
### push packet没有成功
```
"<presence xmlns="jabber:client" from="agent_18027_5427@im03.udesk.cn/16112500020077866961774411868081672461613713976093961848035" to="customer_4880553_5427@im03.udesk.cn/5614415742900837915458564004793125997916330707809512259944"><status>online</status><nick>李凌乾</nick><delay xmlns="urn:xmpp:delay" from="agent_18027_5427@im03.udesk.cn/16112500020077866961774411868081672461613713976093961848035" stamp="2016-05-27T14:51:05.604Z"/></presence>"
agent_9344_5427@im03.udesk.c
1.

I, [2016-05-27T22:24:33.085093 #27568]  INFO -- : Completed 200 OK in 1ms (Views: 0.2ms | ActiveRecord: 0.0ms)

{"message"=>{"to"=>"agent_9344_5427@im03.udesk.cn", "from"=>"customer_4880553_5427@im03.udesk.cn", "type"=>"chat", "id"=>"UDESK_2_msg1464360746901", "body"=>"{\"type\":\"message\",\"version\":1,\"platform\":\"web\",\"data\":{\"content\":\"1222\",\"filename\":\"\",\"filesize\":\"\"}}", "request"=>{"xmlns"=>"urn:xmpp:receipts"}}}
jid = 'agent_9344_5427@im03.udesk.cn'
push_id = ImV4::AppPushProxy.get_push_id(jid)
```


### git config
  http://stackoverflow.com/questions/23918062/simple-vs-current-push-default-in-git-for-decentralized-workflow
  push
    default = simple / current / matching

  如果用matching,会出现把所有的本地与origin名字相同的都上推,如果一担用了git push -f 会强推覆盖,造成不想要的结果

  最好用 current

### 删除远程分支
  git push origin :serverfix
  git push origin :Develop

https://github.com/udesk/udesk_proj/compare/hotfix_speedup_api_token?expand=1

https://github.com/udesk/udesk_proj/compare/develop...hotfix_speedup_api_token?expand=1
