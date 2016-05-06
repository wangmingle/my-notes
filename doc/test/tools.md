tools
=====
## proxy
http://www.saitjr.com/develop-tools/tools-charles-cracker.html

## shell

 ```
redis-cli keys  "*:workers" | while read LINE ; do TTL=`redis-cli expire "$LINE" 60`; echo "$LINE"; done;
```
