


mac
----


### bogon

https://air20.com/archives/486.html

sudo hostname your-desired-host-name
sudo scutil --set LocalHostName $(hostname)
sudo scutil --set HostName $(hostname)

### slate 和编辑器的热键冲突 done

1. 左右不全 
2. subl不能用上下
3. cmd+左右 不能用

### 三指拖 

辅助功能->鼠标与触控板->触控板选项->拖拽->三指

### brew 

http://heepo.github.io/工具/2015/08/05/Homebrew-Mirror-Links.html

https://mirrors.tuna.tsinghua.edu.cn/help/homebrew/

https://mirrors.tuna.tsinghua.edu.cn/help/homebrew-bottles/


brew tap homebrew/science
$ cd /usr/local/Library/Taps/homebrew/homebrew-science
$ git remote set-url origin git://mirrors.tuna.tsinghua.edu.cn/homebrew-science.git
$ brew update


### slate


窗口控制 

https://github.com/jigish/slate

https://github.com/jigish/slate/blob/master/Slate/default.slate

vim ~/.slate

```bash
config defaultToCurrentScreen true
config nudgePercentOf screenSize
config resizePercentOf screenSize

# Resize Bindings
bind right:alt       resize +10% +0
bind left:alt        resize -10% +0
bind up:alt          resize +0   -10%
bind down:alt        resize +0   +10%
bind right:ctrl;alt  resize -10% +0 bottom-right
bind left:ctrl;alt   resize +10% +0 bottom-right
bind up:ctrl;alt     resize +0   +10% bottom-right
bind down:ctrl;alt   resize +0   -10% bottom-right

# Push Bindings
bind right:ctrl;alt;cmd  push right bar-resize:screenSizeX/2
bind left:ctrl;alt;cmd   push left  bar-resize:screenSizeX/2
bind up:ctrl;alt;cmd     push up    bar-resize:screenSizeY/2
bind down:ctrl;alt;cmd   push down  bar-resize:screenSizeY/2

# Nudge Bindings
bind right:shift;alt nudge +10% +0
bind left:shift;alt  nudge -10% +0
bind up:shift;alt    nudge +0   -10%
bind down:shift;alt  nudge +0   +10%

# Throw Bindings
bind m:ctrl;alt;cmd         throw 0 resize
```



可能是这个pf的问题

http://www.jianshu.com/p/6052831a8e91
https://my.oschina.net/91jason/blog/546711
mac /etc/pf.conf

16/9/21 上午1:18:56.998 sudo[44776]:     root : TTY=unknown ; PWD=/ ; USER=root ; COMMAND=/sbin/pfctl -evf /etc/elephantoidal.conf

16/9/21 上午1:18:57.025 sudo[44778]:     root : TTY=unknown ; PWD=/ ; USER=pinsons ; COMMAND=/Library/elephantoidal/Contents/MacOS/elephantoidal

16/9/21 上午1:18:57.056 ReportCrash[44669]: Saved crash report for elephantoidal[44779] version ??? to /Library/Logs/DiagnosticReports/elephantoidal_2016-09-21-011857_MacBook-Air.crash


sudo cat /etc/elephantoidal.conf
Password:
rdr pass inet proto tcp from en0 to any port 80 -> 127.0.0.1 port 9882
pass out on en0 route-to lo0  inet proto tcp from en0 to any port 80 keep state
pass out proto tcp all user pinsons

https://github.com/eastany/eastany.github.com/issues/55  中文,而且是
http://superuser.com/questions/1088488/pseudohydrophobia-process-mac
https://objective-see.com/blog/blog_0x0E.html 分析

这是一个恶意的广告软件,把机器的80请求都转给9882,显示广告后才会请求真的网站



http://osxdaily.com/2014/10/25/fix-wi-fi-problems-os-x-yosemite/


1: Remove Network Configuration & Preference Files
Manually trashing the network plist files should be your first line of troubleshooting. This is one of those tricks that consistently resolves even the most stubborn wireless problems on Macs of nearly any OS X version. This is particularly effective for Macs who updated to Yosemite that may have a corrupt or dysfunctional preference file mucking things up:

2. Turn Off Wi-Fi from the Wireless menu item
From the OS X Finder, hit Command+Shift+G and enter the following path:
/Library/Preferences/SystemConfiguration/


3. Within this folder locate and select the following files:
com.apple.airport.preferences.plist
 com.apple.network.identification.plist
com.apple.wifi.message-tracer.plist 
NetworkInterfaces.plist 
preferences.plist

4. Move all of these files into a folder on your Desktop called ‘wifi backups’ or something similar – we’re backing these up just in case you break something but if you regularly backup your Mac you can just delete the files instead since you could restore from Time Machine if need be
Reboot the Mac
Turn ON WI-Fi from the wireless network menu again
This forces OS X to recreate all network configuration files. This alone may resolve your problems, but if you’re continuing to have trouble we recommend following through with the second step which means using some custom network settings.

not work

http://www.tomshardware.com/answers/id-1735863/ping-browse.html


not work

