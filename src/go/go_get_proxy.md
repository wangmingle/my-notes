### orgalorg go不能下载 还不能用
http://stackoverflow.com/questions/10383299/how-do-i-configure-go-to-use-a-proxy
http_proxy=127.0.0.1:1080 go get code.google.com/p/go.crypto/bcrypt
http://www.tiege.me/?p=802
socket5 to http
privoxy
brew install privoxy
vim /usr/local/etc/privoxy/config
```
forward-socks5 / 127.0.0.1:1080 .
listen-address 127.0.0.1:8118
# local network do not use proxy
forward 192.168.*.*/ .
forward 10.*.*.*/ .
forward 127.*.*.*/ .
```
http_proxy=127.0.0.1:8118 go get github.com/reconquest/orgalorg
orgalorg -o webuser@123.56.190.63 -x -C whoami #root sudo
orgalorg -o webuser@123.56.190.63 -C whoami
https://github.com/reconquest/orgalorg
