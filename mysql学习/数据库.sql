-- �������ݿ�
create database mydatabase charset utf8;
-- ���ƿ����÷�����������`mydatabase`

--- �鿴���ݿ�
show databases;

-- �鿴�������
show create  database  mydatabase;

-- �������ݿ�
-- ���ݿ����ֲ������޸ģ�ֻ���޸��ַ�����У�Լ�
alter database mydatabase charset utf8;
alter database mydatabase collate [...];

-- ɾ�����ݿ�
drop database mydatabase;


-- ������
use mydatabase;
create table if not exists student(
	name  varchar(10),
	gender varchar(10);
	age int
)charset utf8;

-- �鿴��
show tables;

-- �鿴��Ĵ������
show create table student;

-- �鿴���е��ֶ���Ϣ
show columns from student;

-- �޸ı�
-- �޸ı�����������ѡ��
rename oldtablename newtablename;
alter table ���� ��ѡ�� ֵ;
-- �޸��ֶΣ����ӣ��޸ģ���������ɾ���ֶ�
alter table ���� add column �ֶ��� �������� [������] [λ��];
-- λ�ã��ֶ������Դ�ű�������λ�� first ��after �ֶ���

alter table ���� modify �ֶ��� �������� [����] [λ��];

alter table ���� change ���ֶ� ���ֶ� �������� [����] [λ��];

alter table ���� drop �ֶ���;


-- ɾ�����ݱ�
drop table ����1,����2...;


-- ��������
insert into ���� values('..','..','..'),('..','..','..');
insert into ����(�ֶ��б�) values('..','..'),('..','..');

-- ��������
update ���� set �ֶ�=ֵ [��ѯ����];

-- ɾ������
delete from ���� [��ѯ����];




-- ��������(������)

-- ʱ����������
datetime ʱ�����ڣ�yyyy-mm-dd hh:ii:ss
date: ����
time��ʱ��
timestamp��ʱ��������Ǹ�ʽ��datetimeһ�����Զ�����£�

-- �ַ���
char varchar text(����) blob(�����ƣ�ͨ������) enum �� set
���壺enum('��','Ů');
���壺set('����','����','ƹ����','��ë��');���룺insert into.. values('����,����');



-- ���� primary key 
-- ����1���������ʱ������  
create table my_primary(
	name varchar(20) not null comment '����',
	number char(10) primary key comment 'ѧ��'
)charset utf8;
-- ����2���������ʱ�����Ӻ���
create table my_primary2(
	number char(10) comment 'ѧ��',
	course char(10) comment '�γ̴���',
	score tinyint unsigned default 0 comment '�ɼ�',
	-- ��������number��course
	primary key(number,course)
)charset utf8;
-- ����3�����ú���������
alter table ���� add primary key(�ֶ��б�);

-- ɾ������
alter table ���� drop primary key;

-- ������
-- ����������ǰ���Ǳ�����һ������
-- ����������

auto_increment 

-- �޸�������
alter table ���� auto_increment=(��ǰ���ֵ����)

-- �鿴������
show variables like 'auto_increment'

-- ɾ��������
alter table ���� �ֶ��� ����;

-- Ψһ��
create table my_unique(
	number int  unique comment 'ѧ��'
)charset utf8;

alter table ���� add unique key(number);


-- ����
-- �������е������������ֶ���
-- ������ѯ���ݵ�Ч��
-- Լ�����ݵ���Ч��
-- ��������primary key ��Ψһ����unique key ��ȫ������fulltext index����ͨ����index


