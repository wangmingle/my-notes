textmate
======

rmate
sudo curl -Lo /usr/local/bin/rmate https://raw.githubusercontent.com/textmate/rmate/master/bin/rmate
sudo chmod a+x /usr/local/bin/rmate

ratom
https://atom.io/packages/remote-atom
apm install remote-atom
config 52698 -> 52698
sudo cp /usr/local/bin/rmate /usr/local/bin/ratom
sudo grep -rl '52698' /usr/local/bin/ratom  | xargs sed -i 's/52698/53698/g'
