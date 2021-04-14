#!/usr/bin/with-contenv bash

# 创建文件夹
	mkdir -p /config/{www/{default,proxy,website,reverse},v2ray}

# 复制配置文件
[[ ! -f /config/nginx/site-confs/default ]] && \
 	cp /defaults/default /config/nginx/site-confs/default && \
	cp /defaults/proxy.conf /config/nginx/site-confs/proxy.conf && \
        cp /defaults/reverse.conf /config/nginx/site-confs/reverse.conf && \
        cp /defaults/website.conf /config/nginx/site-confs/website.conf
[[ ! -f /config/v2ray/config.json ]] && \
	cp /defaults/config.json /config/v2ray/config.json
[[ $(find /config/www/default -type f | wc -l) -eq 0 ]] && \
	rm /config/www/index.html && \
	cp /defaults/index.html /config/www/default/index.html && \
	cp /defaults/Donot-delete-me /config/www/default/Donot-delete-me && \	
        cp /defaults/proxy/ /config/www/proxy

# 设置权限
chown -R abc:abc \
	/config
chmod -R g+w \
	/config/{v2ray,www}

/usr/bin/v2ray -config /config/v2ray/config.json
nginx -g daemon off
echo "--- v2ray&nginx started ---"
tail -f /dev/null