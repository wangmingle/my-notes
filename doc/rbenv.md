rbenv
========
apt-get install -y libreadline-dev

git clone https://github.com/sstephenson/rbenv.git ~/.rbenv
git clone https://github.com/sstephenson/ruby-build.git ~/.rbenv/plugins/ruby-build
git clone git://github.com/jf/rbenv-gemset.git $HOME/.rbenv/plugins/rbenv-gemset
git clone https://github.com/andorchen/rbenv-taobao-mirror.git ~/.rbenv/plugins/rbenv-taobao-mirror

新的ruby-china https有问题,用原来的
cd ~/.rbenv/plugins/rbenv-taobao-mirror
git co -b taobao d9d5e07

echo 'export PATH="$HOME/.rbenv/bin:$PATH"' >> ~/.bashrc
echo 'eval "$(rbenv init -)"' >> ~/.bashrc

apt-get install libreadline-dev -y

rbenv install 2.1.1
rbenv install 2.1.6
rbenv install 2.3.0
rbenv global 2.3.0
bundle install --binstubs
bundle binstubs rake
rake rails:update:bin
