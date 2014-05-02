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
