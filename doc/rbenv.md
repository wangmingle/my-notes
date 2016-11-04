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

rbenv install 2.4.0

rbenv global 2.3.0

rbenv shell $(rbenv global)

bundle install --binstubs
bundle binstubs rake
rake rails:update:bin

gem install mysql2 -v '0.3.18' -- --srcdir=/usr/local/mysql/include –platform=ruby
gem install mysql2 -v '0.3.20' -- --srcdir=/usr/local/mysql/include


done:
bundle config build.puma --with-cppflags=-I$(brew --prefix openssl)/include
bundle install

gem install puma -v 2.8.2 -- --with-opt-dir=/usr/local/opt/openssl

gem install nokogiri -v '1.6.3.1'

brew install libxml2
brew install libxslt
brew install homebrew/dupes/libiconv

brew install homebrew/dupes/libiconv
gem install nokogiri -v '1.6.3.1' -- --with-iconv-dir=/usr/local/Cellar/libiconv/1.14/
udesk_im
xcode-select --install
gem install nokogiri -v 1.6.6.2 -- --with-iconv-dir=/usr/local/Cellar/libiconv/1.14/


cd {RailsApp_Root}/vendor/bundle/ruby/1.9.1/gems/mysql2-0.3.11/ext/mysql2
ruby extconf.rb
make
make install


dont do :
/usr/local/opt/mysql/bin/mysql_secure_installation

1）brew services stop mysql

2) mysql -uroot

$ gem sources --add https://gems.ruby-china.org/ --remove https://rubygems.org/
$ gem sources -l
*** CURRENT SOURCES ***

https://gems.ruby-china.org
# 请确保只有 gems.ruby-china.org
$ gem install rails

$ bundle config mirror.https://rubygems.org https://gems.ruby-china.org
