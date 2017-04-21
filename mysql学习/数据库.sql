-- 创建数据库
create database mydatabase charset utf8;
-- 名称可以用反引号括起来`mydatabase`

--- 查看数据库
show databases;

-- 查看创建语句
show create  database  mydatabase;

-- 更新数据库
-- 数据库名字不可以修改，只能修改字符集和校对集
alter database mydatabase charset utf8;
alter database mydatabase collate [...];

-- 删除数据库
drop database mydatabase;


-- 创建表
use mydatabase;
create table if not exists student(
	name  varchar(10),
	gender varchar(10);
	age int
)charset utf8;

-- 查看表
show tables;

-- 查看表的创建语句
show create table student;

-- 查看表中的字段信息
show columns from student;

-- 修改表
-- 修改表本身，表名，表选项
rename oldtablename newtablename;
alter table 表名 表选项 值;
-- 修改字段，增加，修改，重命名，删除字段
alter table 表名 add column 字段名 数据类型 [列属性] [位置];
-- 位置：字段名可以存放表中任意位置 first ，after 字段名

alter table 表名 modify 字段名 数据类型 [属性] [位置];

alter table 表名 change 旧字段 新字段 数据类型 [属性] [位置];

alter table 表名 drop 字段名;


-- 删除数据表
drop table 表名1,表名2...;


-- 新增数据
insert into 表名 values('..','..','..'),('..','..','..');
insert into 表名(字段列表) values('..','..'),('..','..');

-- 更新数据
update 表名 set 字段=值 [查询条件];

-- 删除数据
delete from 表名 [查询条件];




-- 数据类型(列类型)

-- 时间日期类型
datetime 时间日期，yyyy-mm-dd hh:ii:ss
date: 日期
time：时间
timestamp：时间戳，但是格式和datetime一样（自动会更新）

-- 字符串
char varchar text(文字) blob(二进制，通常不用) enum 和 set
定义：enum('男','女');
定义：set('篮球','足球','乒乓球','羽毛球');插入：insert into.. values('篮球,足球');



-- 主键 primary key 
-- 方法1，创建表的时候增加  
create table my_primary(
	name varchar(20) not null comment '姓名',
	number char(10) primary key comment '学号'
)charset utf8;
-- 方法2，创建表的时候增加后面
create table my_primary2(
	number char(10) comment '学号',
	course char(10) comment '课程代码',
	score tinyint unsigned default 0 comment '成绩',
	-- 增加主键number，course
	primary key(number,course)
)charset utf8;
-- 方法3，表建好后增加主键
alter table 表名 add primary key(字段列表);

-- 删除主键
alter table 表名 drop primary key;

-- 自增长
-- 自增长必须前提是本身是一个索引
-- 必须是整形

auto_increment 

-- 修改自增长
alter table 表名 auto_increment=(当前最大值以上)

-- 查看自增长
show variables like 'auto_increment'

-- 删除自增长
alter table 表名 字段名 类型;

-- 唯一键
create table my_unique(
	number int  unique comment '学号'
)charset utf8;

alter table 表名 add unique key(number);


-- 索引
-- 几乎所有的索引建立在字段上
-- 提升查询数据的效率
-- 约束数据的有效性
-- 主键索引primary key ，唯一索引unique key ，全文索引fulltext index，普通索引index


