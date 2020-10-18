FROM openjdk:8-jdk-alpine
MAINTAINER ucucs ucucs@icloud.com
# 挂载临时盘目录
VOLUME /tmp
# 复制外部的JAR包到镜像内
ARG JAR_FILE=target/*.jar
COPY ${JAR_FILE} app.jar
# 运行程序相关参数
ENV JAVA_OPTS=""
ENV APP_OPTS=""
# 设置镜像的时区,避免出现8小时的误差
ENV TZ=Asia/Shanghai
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone
# 暴露端口进行访问
EXPOSE 8080
# 镜像入口
ENTRYPOINT [ "sh", "-c", "java $JAVA_OPTS -Djava.security.egd=file:/dev/./urandom -jar /app.jar $APP_OPTS" ]

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

# Debug JAVA镜像
# docker run -e "JAVA_TOOL_OPTIONS=-agentlib:jdwp=transport=dt_socket,address=5005,server=y,suspend=n" -p 8080:8080 -p 5005:5005 -t springio/gs-spring-boot-docker
