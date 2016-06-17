#!/bin/bash
sudo wget http://liquidtelecom.dl.sourceforge.net/project/pcre/pcre/8.38/pcre-8.38.tar.bz2
sudo bzip2 -d pcre-8.38.tar.bz2
sudo tar xvf pcre-8.38.tar
cd pcre-8.38
sudo ./configure
sudo make
sudo make install

https://www.nginx.com/resources/wiki/start/topics/tutorials/installoptions/#
sudo wget http://nginx.org/download/nginx-1.9.14.tar.gz
sudo tar xzvf nginx-1.9.14.tar.gz && cd nginx-1.9.14

https://www.nginx.com/resources/admin-guide/tcp-load-balancing/
sudo ./configure --prefix=/srv/nginx-wss \
  --with-cc-opt="-Wno-deprecated-declarations"  \
  --with-http_ssl_module \
  --with-pcre=/srv/pcre-8.38 \
  --with-stream_ssl_module \
  --with-stream
sudo make
sudo make install

worker_processes  1;

events {
    worker_connections  1024;
}

stream{
  upstream visitor {
        server localhost:6001;
    }
  server {
    listen 6002 ssl;

    ssl_certificate /srv/nginx-wss/conf/udesk.cn.crt;
    ssl_certificate_key /srv/nginx-wss/conf/privateKey.pem;
    ssl_protocols  SSLv3 TLSv1 TLSv1.1 TLSv1.2;
    ssl_ciphers    HIGH:!aNULL:!MD5;
    proxy_pass visitor;
  }
}

worker_processes  1;

events {
    worker_connections  1024;
}

stream{
  upstream visitor {
        server localhost:6001;
    }
  server {
    listen 6002 ssl;

    ssl_certificate /srv/nginx-wss/conf/udeskdog.com.chained.crt;
    ssl_certificate_key /srv/nginx-wss/conf/udeskdog.com.key;
    ssl_protocols  SSLv3 TLSv1 TLSv1.1 TLSv1.2;
    ssl_ciphers    HIGH:!aNULL:!MD5;
    proxy_pass visitor;
  }
}


sudo /srv/nginx-wss/sbin/nginx -t
sudo /srv/nginx-wss/sbin/nginx

后台全站HTTPS设置.md

# 生成证书

## 单独证书
> 参考: https://www.digitalocean.com/community/tutorials/how-to-create-an-ssl-certificate-on-nginx-for-ubuntu-14-04

```bash
sudo mkdir /etc/nginx/ssl
sudo openssl req -x509 -nodes -days 365 -newkey rsa:2048 -keyout /etc/nginx/ssl/nginx.key -out /etc/nginx/ssl/nginx.crt
```

## 根证书 + 服务器证书
> 参考: http://blog.creke.net/762.html

```bash
# 生成CA证书
openssl genrsa -des3 -out ca.key 2048
openssl req -new -x509 -days 7305 -key ca.key -out ca.crt

# 用CA签名前的准备
mkdir -p demoCA/newcerts
touch demoCA/index.txt
touch demoCA/serial
echo 01 > demoCA/serial

# 生成服务器证书(ud.com为例)
# 注意第三步 Common Name 填写 *.ud.com
openssl genrsa -des3 -out ud.com.pem 1024
openssl rsa -in ud.com.pem -out ud.com.key
openssl req -new -key ud.com.pem -out ud.com.csr

# Sign
openssl ca -policy policy_anything -days 1460 -cert ca.crt -keyfile ca.key -in ud.com.csr -out ud.com.crt

# 创建证书链
cat ud.com.crt ca.crt > ud.com.chained.crt

# copy到目录
sudo mkdir /etc/nginx/ssl
sudo cp ud.com.chained.crt /etc/nginx/ssl/nginx.crt
sudo cp ud.com.key /etc/nginx/ssl/nginx.key
```

## Chrome设置

设置 -> 管理证书 -> 授权中心 -> 导入(ca.crt)

# 配置 Nginx

## 配置虚拟主机

```
server {
  listen 80;
  listen 443 ssl;

  server_name *.ud.com;

  ssl on;
  ssl_certificate /etc/nginx/ssl/nginx.crt;
  ssl_certificate_key /etc/nginx/ssl/nginx.key;
  ...
}
```

## 优化

在 http 中加入

```
# 1m可以存放4000个session
ssl_session_cache shared:SSL:10m;
ssl_session_timeout 10m;
```

在配置https的虚拟主机server{}中加入：

```
keepalive_timeout 70;
```
