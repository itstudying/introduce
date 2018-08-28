## 个人主页
> 我的个人主页,

 [点击这里预览](http://itstudying.com)

### 快速开始
#### 直接运行
1. 使用dep管理依赖
```bash
cd src
dep ensure -v
```

2. 打包运行
```bash
go run main.go
```

3. 访问
> http://127.0.0.1:8080

#### 使用docker 运行
1. 安装docker

[docker官网](https://www.docker.com/)

2. 在根目录构建image
```bash
docker build -t lijq-introduce .
```

3. 运行
```bash
docker run -d -p 80:8080 --name introduce lijq-introduce
```
