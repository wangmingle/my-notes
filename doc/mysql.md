MYSQL
=====

http://www.cnblogs.com/hustcat/archive/2009/10/28/1591648.html 理解MySQL——索引与优化

http://www.cnblogs.com/billyxp/p/3548540.html myslq char varchar text 之分
http://stackoverflow.com/questions/2023481/mysql-large-varchar-vs-text
```ruby
def up
  change_column :im_sessions, :src_url, :string, limit: 2000
end
def down
  change_column :im_sessions, :src_url, :string
end
```

http://blog.csdn.net/voidccc/article/details/40077329 Innodb index

apt-get install libmysqlclient-dev
You can see a log of iCloud Drive transactions being made


CREATE TABLE #{backup_table} AS SELECT * FROM im_users;"
TRUNCATE table im_users

Znkfpt2015
ejabberdctl change_password admin im03.udesk.cn Znkfpt2015


memory:

http://www.robbyonrails.com/articles/2013/11/24/reducing-mysqls-memory-usage-on-os-x-mavericks

mkdir -p /usr/local/etc

vim /usr/local/etc/my.cnf

```
[mysqld]
 max_connections       = 10

 key_buffer_size       = 16K
 max_allowed_packet    = 1M
 table_open_cache      = 4
 sort_buffer_size      = 64K
 read_buffer_size      = 256K
 read_rnd_buffer_size  = 256K
 net_buffer_length     = 2K
 thread_stack          = 128K
 ```

mysql.server stop

最后80M左右

my.cnf 中没有这个设置
通过下面的值进行计算

key_buffer_size + (read_buffer_size + sort_buffer_size) * max_connections = K bytes

key_buffer_size = 8G
sort_buffer_size = 1M
read_buffer_size = 1M
read_rnd_buffer_size = 2M
myisam_sort_buffer_size = 2M
join_buffer_size = 2M

#Innodb
innodb_buffer_pool_size = 16G
innodb_additional_mem_pool_size = 2G
innodb_log_file_size = 1G
innodb_log_buffer_size = 8M
innodb_flush_log_at_trx_commit = 1
innodb_lock_wait_timeout = 30
innodb_file_format=barracuda


https://www.pureweber.com/article/myisam-vs-innodb/
