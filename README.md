## 个人主页
> 我的个人主页,

docker nginx容器运行服务

 [点击这里预览](http://itstudying.com)

## 步骤
### 拉取nginx镜像，默认最新
```bash
docker pull nginx
```
运行容器，
```bash
docker run -d -p 80:80 --name nginx nginx
```

### 创建nginx工作目录，以及放置代码和配置文件
1. 创建目录
```bash
# 存放日志文件
mkdir /data/nginx/logs
# 存放nginx配置文件
mkdir /data/nginx/conf
# 存放静态页面文件
mkdir /data/nginx/html
```

2. 更改nginx配置文件
先拉取nginx配置在做更改
```bash
docker cp nginx:/etc/nginx/ /data/nginx/conf/

# 删除在运行的nginx容器
docker stop nginx
docker rm nginx
```

更改配置
```bash
vim /data/nginx/conf/nginx.conf
```
```
# 配置信息

#user  nobody;
worker_processes  1;

error_log  /data/nginx/logs/error.log;
error_log  /data/nginx/logs/error.log  notice;
error_log  /data/nginx/logs/error.log  info;

pid        /data/nginx/logs/nginx.pid;


events {
    worker_connections  1024;
}


http {
    include       mime.types;
    default_type  application/octet-stream;

    log_format  main  '$remote_addr - $remote_user [$time_local] "$request" '
                      '$status $body_bytes_sent "$http_referer" '
                      '"$http_user_agent" "$http_x_forwarded_for"';

    access_log /data/nginx/logs/access.log  main;

    sendfile        on;
    #tcp_nopush     on;

    #keepalive_timeout  0;
    keepalive_timeout  65;

    gzip  on;

#     upstream zp_serve1{
#	server 127.0.0.1:8080;
#     }

     server {
	listen 80;
	listen 443 ssl;
   	server_name itstudying.com;
    	#root html;
    	#index index.html index.htm;
    	ssl_certificate   /etc/nginx/cert/214970708330093.pem;
    	ssl_certificate_key   /etc/nginx/cert/214970708330093.key;
    	ssl_session_timeout 5m;
    	ssl_ciphers ECDHE-RSA-AES128-GCM-SHA256:ECDHE:ECDH:AES:HIGH:!NULL:!aNULL:!MD5:!ADH:!RC4;
    	ssl_protocols TLSv1 TLSv1.1 TLSv1.2;
    	ssl_prefer_server_ciphers on;

	location / {
		root /var/share/html;
		index index.html;
	}
     }
}

```

3. 加入ssl文件
新建cert文件夹存储ssl文件
```bash
mkdir /data/nginx/conf/cert
cp *.key /data/nginx/conf/cert && cp *.pem /data/nginx/conf/cert
```

4. 拷贝源码文件
将assets、images、index.html拷贝至/data/nginx/html/

5. 执行命令运行nginx容器
```bash
docker run -d -p 80:80 -p 443:443 -v /data/nginx/html:/var/share/html -v /data/nginx/logs:/data/nginx/logs -v /data/nginx/conf:/etc/nginx --name nginx nginx
```

6. 测试访问
```bash
curl 127.0.0.1
curl 127.0.0.1:443
```

## 注意事项
1. 注意挂载的目录，比如这里的cert文件夹下的文件，使用命令挂载为`-v /data/nginx/conf:/etc/nginx`，又因为cert在conf目录下，所以在nginx配置文件中要写`/etc/nginx/cert/*****.pem`。而logs文件夹是挂载`-v /data/nginx/logs:/data/nginx/logs`，所以nginx配置中只需要写`/data/nginx/logs/`就好
2. 如果https不能访问，检查证书以及检查nginx是否支持ssl
