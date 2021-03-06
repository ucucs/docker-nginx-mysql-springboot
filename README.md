# docker-nginx-mysql-springboot
Docker compose to build Nginx Mysql Springboot Environment

docker-compose基本模版
```
version: "3" # 指定 docker-compose.yml 文件的写法格式
services: # 用来表示compose需要启动的服务

  redis: # 自定义服务名
    image: redis:6.0.8-alpine # 指定服务所使用的镜像
    container_name: env-redis # docker容器实例名称
    restart: always # 配置重启，表示如果服务启动不成功会一直尝试
    privileged: true # 特权模式,修改系统变量
    environment: # 环境变量定义
      - author=ucucs
    ports: # 端口映射,外部访问的端口 不同端口可以如此配置 6379:6380,单独写代表随机端口
      - "6379:6379"
    networks: # 网络网段定义
      - frontend
    volumes: # 加载本地目录下的配置文件到容器目标地址下
      - ./config/redis/redis.conf:/usr/local/etc/redis/redis.conf
      - ./data/redis/:/data/
      - ./log/redis/:/var/log/redis/
    command: # 表示以这个命令来启动服务
      /bin/sh -c "echo 65535 > /proc/sys/net/core/somaxconn
      && echo never > /sys/kernel/mm/transparent_hugepage/enabled
      && echo never > /sys/kernel/mm/transparent_hugepage/defrag
      && redis-server /usr/local/etc/redis/redis.conf --appendonly yes"
    deploy: # 需要用命令才生效 docker stack deploy --compose-file docker-compose.yml
      replicas: 1 # 部署副本数量
      update_config: # 升级回滚控制
        parallelism: 2 # 服务中多个容器同时更新数量
        delay: 10s # 设置每组容器更新之间的延迟时间
      restart_policy: # 设置何时重启容器
        condition: on-failure # 设置重启策略的条件

networks: # 网络定义
  frontend: # 网络命名
    driver: bridge # 定义网络模式,默认时可忽略 bridge(默认) host none service:[service name] container:[container name/id]
```

# 启动命令
```
docker-compose up 启动
```

# 环境变量配置
```
使用.env文件进行配置

compose里格式如下,设置默认值
环境变量${VARIABLE:-default}引用
```

# Mysql查看binlog日志内容
```
mysqlbinlog --base64-output=decode-rows -v mysql-bin.000006
```

# Dockerfile 解释
```
# FROM 它的父母是谁 基础镜像
# MAINTAINER 作者 维护者姓名
# RUN 执行命令
# ENV 环境变量设置
# ADD 往镜像添加文件
# COPY 往镜像添加文件 会自动解压
# WORKDIR 当前工作目录 CD进入某个目录
# VOLUME 目录挂载
# EXPOSE 暴露的端口
# ENTRYPOINT 镜像入口 启动命令

# 构建镜像执行命令
# docker build -t hello:v2 .
# hello:v2 镜像名和版本号 指令最后一个 . 是上下文路径

# 运行镜像
# docker run -d -p8080:8080 hello:v2
# -p 端口映射
```