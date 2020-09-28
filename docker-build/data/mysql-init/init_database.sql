-- 建库
CREATE DATABASE IF NOT EXISTS auto_db;

-- 切换数据库
use auto_db;

-- 建表
DROP TABLE IF EXISTS `ucs_user`;

CREATE TABLE `ucs_user`
(
    `id`   int(11) unsigned NOT NULL AUTO_INCREMENT,
    `name` varchar(20) DEFAULT NULL COMMENT '姓名',
    `age`  int(11)     DEFAULT NULL COMMENT '年龄',
    PRIMARY KEY (`id`)
);

-- 插入数据
INSERT INTO `ucs_user` (`id`, `name`, `age`)
VALUES (1, '姓名1', 10),
       (2, '姓名2', 11);