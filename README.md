XHI
===

The full name is xinetd http interface, to provide a set of API base on HTTP protocol

Installation
---
1 Install xinetd if not. Perform the following in openwrt:

    `opkg update`
    `opkg install xinetd`
    
2 Add xhi service in /etc/services, for example:

    `xhi        8080/tcp`

3 Create xhi configuration file for xinetd, you can simplily copy file "xhi" in source code into /etc/xinetd.d/

4 Put xhi code to your disk. 

The default location is "/etc/xhi". If you decide to use another location, please remember to update it in web.sh

5 Re-start xhi service

    `/etc/init.d/xinetd restart`
6 Enjoy it

Installation for uhttpd
---
The shell script can be used for uhttpd directly instead of setup xinetd service. For this approach, you can simply
copy files under cgi-bin folder to /www/cgi-bin folder in your openwrt. Then access the following address to call 
the interfaces:

    `http://192.168.8.1/cgi-bin/api_name`

Reference
---
[预览版固件中apcli的配置方法](http://cn.wrtnode.com/?topic=%E9%A2%84%E8%A7%88%E7%89%88%E5%9B%BA%E4%BB%B6%E4%B8%ADapcli%E7%9A%84%E9%85%8D%E7%BD%AE%E6%96%B9%E6%B3%95)
