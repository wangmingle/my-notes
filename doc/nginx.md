nginx
=========

## 编译安装

wget http://liquidtelecom.dl.sourceforge.net/project/pcre/pcre/8.38/pcre-8.38.tar.bz2
bzip2 -d pcre-8.38.tar.bz2
tar xvf pcre-8.38.tar
cd pcre-8.38
./configure
make
make install

https://www.nginx.com/resources/wiki/start/topics/tutorials/installoptions/#
wget http://nginx.org/download/nginx-1.9.14.tar.gz
tar xzvf nginx-1.9.14.tar.gz && cd nginx-1.9.14
./configure --prefix=/srv/nginx \
  --with-cc-opt="-Wno-deprecated-declarations"  \
  --with-http_ssl_module \
  --with-pcre=/srv/pcre-8.38

make && make install

adduser webuser
passwd -d webuser
/etc/sudoers
webuser ALL=(ALL) NOPASSWD:ALL
没成功
chown -R webuser:webuser /home/webuser/.ssh
chmod 0700 /home/webuser/.ssh
chmod 0600 /home/webuser/.ssh/authorized_keys


websocket的反向代理
http://blog.fens.me/nodejs-websocket-nginx/

```

user  webuser;
worker_processes  2;

error_log  logs/error.log;
#error_log  logs/error.log  notice;
#error_log  logs/error.log  info;

pid        logs/nginx.pid;


events {
    worker_connections  1024;
}


http {
    include       mime.types;
    default_type  application/octet-stream;

    log_format  main  '$remote_addr - $remote_user [$time_local] "$request" '
                     '$status $body_bytes_sent "$http_referer" '
                     '"$http_user_agent" "$http_x_forwarded_for"';

    #access_log  logs/access.log  main;

    sendfile        on;
    #tcp_nopush     on;

    #keepalive_timeout  0;
    keepalive_timeout  65;

    gzip  on;
    map $http_upgrade $connection_upgrade {
        default upgrade;
        ''      close;
    }


    server {
        listen       80;
        server_name  localhost;

        charset utf-8;

        access_log  logs/host.access.log  main;

        location / {
            root   html;
            index  index.html index.htm;
        }

        location ^~ /admin {
          proxy_pass http://localhost:5880/admin;
          proxy_set_header X-Real-IP $remote_addr;
    	    proxy_set_header Host $host;
    	    proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;

    	    proxy_http_version 1.1;
        }
        location ^~ /http-bind {
          proxy_pass http://localhost:5880/http-bind;
          proxy_set_header X-Real-IP $remote_addr;
    	    proxy_set_header Host $host;
    	    proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;

    	    proxy_http_version 1.1;
        }
        location ^~ /websocket {
          proxy_pass http://localhost:5880/websocket;
          proxy_set_header X-Real-IP $remote_addr;
          proxy_set_header Host $host;
          proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;

          proxy_http_version 1.1;
          proxy_set_header Upgrade $http_upgrade;
          proxy_set_header Connection "upgrade";
        }



        error_page   500 502 503 504  /50x.html;
        location = /50x.html {
            root   html;
        }
    }
}

```
