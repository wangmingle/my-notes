DOCKER
=============

##

### 为什么要用

* 安装方便简单
* 没有权限烦恼
* 漏洞攻击影响小,保护宿主机

### 使用国内镜像安装docker

#### ubuntu

您可以通过阿里云的镜像仓库下载： mirrors.aliyun.com/help/docker-engine

在线安装:

```
curl -sSL http://acs-public-mirror.oss-cn-hangzhou.aliyuncs.com/docker-engine/internet | sh -
```

配置Docker加速器(aliyun)

```
echo "DOCKER_OPTS=\"\$DOCKER_OPTS --registry-mirror=https://j90112tg.mirror.aliyuncs.com\"" | sudo tee -a /etc/default/docker
sudo service docker restart
```

#### mac

Toolbox的介绍和帮助： mirrors.aliyun.com/help/docker-toolbox

Mac系统的安装文件目录： mirrors.aliyun.com/docker-toolbox/mac

  # 创建一台安装有Docker环境的Linux虚拟机，指定机器名称为default，同时配置Docker加速器地址。
  ```
  docker-machine create --engine-registry-mirror=https://j90112tg.mirror.aliyuncs.com -d virtualbox default
  ```

  # 查看机器的环境配置，并配置到本地。然后通过Docker客户端访问Docker服务。
  ```
  docker-machine env default
  eval "$(docker-machine env default)"
  docker info
  ```
#### windows

推荐您安装Docker Toolbox。
Toolbox的介绍和帮助： mirrors.aliyun.com/help/docker-toolbox
Windows系统的安装文件目录： mirrors.aliyun.com/docker-toolbox/windows

#### 创建一台安装有Docker环境的Linux虚拟机，指定机器名称为default，同时配置Docker加速器地址。
docker-machine create --engine-registry-mirror=https://j90112tg.mirror.aliyuncs.com -d virtualbox default

#### 查看机器的环境配置，并配置到本地。然后通过Docker客户端访问Docker服务。
docker-machine env default
eval "$(docker-machine env default)"
docker info


## 参考

https://www.gitbook.com/book/joshhu/docker_theory_install/details
https://joshhu.gitbooks.io/docker_theory_install/content/

http://dockone.io/article/783

## FAQ


1. ERROR: TERM environment variable not set.
export TERM=dumb

### 阿里云深度学习

alicloudhpc/toolkit

https://dev.aliyun.com/detail.html?spm=5176.100208.8.2.VSKcdu&repoId=2

### mac下访问宿主机端口

https://github.com/docker/docker/issues/1143

Docker auto updating /etc/hosts on every container with the host IP, e.g. 172.17.42.1 and calling it for example dockerhost would be a convenient fix.
I guess for now we are stuck with
netstat -nr | grep '^0\.0\.0\.0' | awk '{print $2}'
就是写hosts 然后直接访问就好了
