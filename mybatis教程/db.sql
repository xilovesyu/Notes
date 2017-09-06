use ssm;
drop table  if exists authors;
CREATE TABLE authors (
    id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(30) NOT NULL COMMENT '姓名',
    sex VARCHAR(20) NOT NULL COMMENT '性别',
    mobilephone VARCHAR(11) COMMENT '手机号',
    QQ VARCHAR(13) COMMENT 'QQ',
    Address VARCHAR(50) COMMENT '地址',
    birthday DATETIME DEFAULT NULL COMMENT '出生年月'
)  CHARSET=UTF8;
 
 
 drop table  if exists categorys;
 create table categorys(
	id int primary key auto_increment,
    name varchar(30) not null comment '类别名称',
    description varchar(300) default null comment '描述',
    status varchar(30) comment '状态'
 )charset=utf8;
 
  drop table  if exists tags;
 create table tags(id int primary key auto_increment,
    name varchar(30) not null comment '标签名称', status varchar(30) comment '状态')charset=utf8;
    
    
     drop table  if exists articles;
 -- 文章的实体
 create table articles(id int primary key auto_increment,
 name varchar(30) not null comment '文章标题',
 content text comment '内容',
 -- c_id int comment '类别id'
 -- t_id int comment 'tagid'
 status varchar(10) comment '文章状态',
 a_id int comment '文章作者id',
 write_time datetime default null comment '撰写时间',
 pub_time datetime default null comment '发布时间'
 )charset=utf8;
 


 drop table  if exists articles_categorys;
 create table articles_categorys(
 id int primary key auto_increment,
 c_id int not null comment '类别id',
 a_id int not null comment '文章id'
 )charset=utf8; 
 
 
  drop table  if exists articles_tags;
  create table articles_tags(
 id int primary key auto_increment,
 t_id int not null comment 'tagid',
 a_id int not null comment '文章id'
 )charset=utf8; 