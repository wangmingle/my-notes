DOCKER
=============

##

内核之外所有东西的容器

### ubuntu

请安装1.6.0以上版本的Docker。
您可以通过阿里云的镜像仓库下载： mirrors.aliyun.com/help/docker-engine

curl -sSL http://acs-public-mirror.oss-cn-hangzhou.aliyuncs.com/docker-engine/internet | sh -
配置Docker加速器

您可以使用如下的脚本将mirror的配置添加到docker daemon的启动参数中。

echo "DOCKER_OPTS=\"\$DOCKER_OPTS --registry-mirror=https://j90112tg.mirror.aliyuncs.com\"" | sudo tee -a /etc/default/docker
sudo service docker restart


### mac

安装或升级Docker

推荐您安装Docker Toolbox。
Toolbox的介绍和帮助： mirrors.aliyun.com/help/docker-toolbox
Mac系统的安装文件目录： mirrors.aliyun.com/docker-toolbox/mac

快速开始

# 创建一台安装有Docker环境的Linux虚拟机，指定机器名称为default，同时配置Docker加速器地址。
docker-machine create --engine-registry-mirror=https://j90112tg.mirror.aliyuncs.com -d virtualbox default

# 查看机器的环境配置，并配置到本地。然后通过Docker客户端访问Docker服务。
docker-machine env default
eval "$(docker-machine env default)"
docker info

### windows

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
