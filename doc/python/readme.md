python
----


## mac 安装 pip 阿里镜像

[参考:使用pyenv在mac上进行python多版本控制](http://achuan.me/2016/09/26/20160926使用pyenv在mac上进行python多版本控制/)

```
brew install pyenv
```
.bashrc
```
if which pyenv > /dev/null; then eval "$(pyenv init -)"; fi
```

pyenv install -l

.bashrc
```
export  PYTHON_BUILD_MIRROR_URL="http://pyenv.qiniudn.com/pythons/"
```

安装指定版本
```
wget http://mirrors.sohu.com/python/$v/Python-$v.tar.xz -P ~/.pyenv/cache/;pyenv install $v  

wget http://mirrors.sohu.com/python/2.7.12/Python-2.7.12.tar.xz -P ~/.pyenv/cache/;pyenv install 2.7.12  

wget http://mirrors.sohu.com/python/3.5.2/Python-3.5.2.tar.xz -P ~/.pyenv/cache/;pyenv install 3.5.2  
```

安装 virtualenv

```
git clone https://github.com/yyuu/pyenv-virtualenv.git ~/.pyenv/plugins/pyenv-virtualenv

# bashrc
if which pyenv-virtualenv-init > /dev/null; then eval "$(pyenv virtualenv-init -)"; fi
```

```
pyenv versions

pyenv global 3.5 # 设置全局的 Python => ~/.pyenv/version

pyenv local 2.7.3 # =>  ./.python-version

pyenv shell pypy-2.2.1

pyenv virtualenv 2.7.12 2.7
pyenv virtualenv 3.5.2 3.5

pyenv virtualenvs
pyenv versions

pyenv activate 2.7
pyenv activate 3.5

pyenv global 3.5   # 默认使用
pyenv global 3.5
pyenv shell 3.5    # shell 使用哪个版本

pyenv deactivate

```

[阿里pip镜像](http://mirrors.aliyun.com/help/pypi)

```
在~/.pip/pip.conf文件中添加或修改

[global]
index-url = http://mirrors.aliyun.com/pypi/simple/

[install]
trusted-host=mirrors.aliyun.com
```

###  试装 gitsome

```
pip install gitsome

gitsome
```

[参考](http://blog.codylab.com/python-pyenv-management/)
