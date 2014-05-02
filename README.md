XHI
===

The full name is xinetd http interface, to provide a set of API base on HTTP protocol

Installation
---
* Install xinetd if not. Perform the following in openwrt:

    `opkg install xinetd`
    
* Add xhi service in /etc/services, for example:

    `xhi        8080/tcp`

* Create xhi configuration file for xinetd, you can simplily copy file "xhi" in source code into /etc/xinetd.d/
* Put xhi code to your disk. 

The default location is "/opt/xhi". If you decide to use another location, please remember to update it in web.sh

* Re-start xhi service

    `/etc/init.d/xinetd restart`
* Enjoy it

Reference
---
[预览版固件中apcli的配置方法](http://cn.wrtnode.com/?topic=%E9%A2%84%E8%A7%88%E7%89%88%E5%9B%BA%E4%BB%B6%E4%B8%ADapcli%E7%9A%84%E9%85%8D%E7%BD%AE%E6%96%B9%E6%B3%95)
