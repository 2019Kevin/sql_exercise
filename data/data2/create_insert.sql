# 创建表

# 创建学生表
CREATE TABLE STUDENT(
			 SNO VARCHAR(10),
             SNAME NVARCHAR(10),
             SAGE integer(2),
             SSEX NVARCHAR(10));

# 学生表中插入数据
insert into Student values('1000','张无忌',18, '男');
insert into Student values('1001','周芷若',19,'女');
insert into Student values('1002','杨过',19,'男');
insert into Student values('1003','赵敏',18,'女');
insert into Student values('1004','小龙女',17,'女');
insert into Student values('1005','张三丰',18,'男');
insert into Student values('1006','令狐冲',19,'男');
insert into Student values('1007','任盈盈',20,'女');
insert into Student values('1008','岳灵珊',19,'女');
insert into Student values('1009','韦小宝',18,'男');
insert into Student values('1010','康敏',17,'女');
insert into Student values('1011','萧峰',19,'男');
insert into Student values('1012','黄蓉',18,'女');
insert into Student values('1013','郭靖',19,'男');
insert into Student values('1014','周伯通',19,'男');
insert into Student values('1015','瑛姑',20,'女');
insert into Student values('1016','李秋水',21,'女');
insert into Student values('1017','黄药师',18,'男');
insert into Student values('1018','李莫愁',18,'女');
insert into Student values('1019','冯默风',17,'男');
insert into Student values('1020','王重阳',17,'男');
insert into Student values('1021','郭襄',18,'女' );

# 创建课程表
CREATE TABLE COURSE(
			 CNO VARCHAR(10),
             CNAME NVARCHAR(10),
             TNO VARCHAR(10));

# 课程表中插入数据
insert into Course values('001','企业管理','002');
insert into Course values('002','马克思','008');
insert into Course values('003','UML','006');
insert into Course values('004','数据库','007');
insert into Course values('005','逻辑电路','006');
insert into Course values('006','英语','003');
insert into Course values('007','电子电路','005');
insert into Course values('008','毛泽东思想概论','004');
insert into Course values('009','西方哲学史','012');
insert into Course values('010','线性代数','017');
insert into Course values('011','计算机基础','013');
insert into Course values('012','AUTO CAD制图','015');
insert into Course values('013','平面设计','011');
insert into Course values('014','Flash动漫','001');
insert into Course values('015','Java开发','009');
insert into Course values('016','C#基础','002');
insert into Course values('017','Oracl数据库原理','010');

# 创建教师表
CREATE TABLE TEACHER(
			 TNO VARCHAR(10),
             TNAME NVARCHAR(10));
			
# 教师表中插入数据
insert into Teacher values('001','姚明');
insert into Teacher values('002','叶平');
insert into Teacher values('003','叶开');
insert into Teacher values('004','孟星魂');
insert into Teacher values('005','独孤求败');
insert into Teacher values('006','裘千仞');
insert into Teacher values('007','裘千尺');
insert into Teacher values('008','赵志敬');
insert into Teacher values('009','阿紫');
insert into Teacher values('010','郭芙蓉');
insert into Teacher values('011','佟湘玉');
insert into Teacher values('012','白展堂');
insert into Teacher values('013','吕轻侯');
insert into Teacher values('014','李大嘴');
insert into Teacher values('015','花无缺');
insert into Teacher values('016','金不换');
insert into Teacher values('017','乔丹');

# 创建课程分数表
CREATE TABLE SC(
			 SNO VARCHAR(10),
             CNO VARCHAR(10),
             SCORE DECIMAL(18, 1));
             
# 课程分数表中插入数据
insert into SC values('1001','003',90);
insert into SC values('1001','002',87);
insert into SC values('1001','001',96);
insert into SC values('1001','010',85);
insert into SC values('1002','003',70);
insert into SC values('1002','002',87);
insert into SC values('1002','001',42);
insert into SC values('1002','010',65);
insert into SC values('1003','006',78);
insert into SC values('1003','003',70);
insert into SC values('1003','005',70);
insert into SC values('1003','001',32);
insert into SC values('1003','010',85);
insert into SC values('1003','011',21);
insert into SC values('1004','007',90);
insert into SC values('1004','002',87);
insert into SC values('1005','001',23);
insert into SC values('1006','015',85);
insert into SC values('1006','006',46);
insert into SC values('1006','003',59);
insert into SC values('1006','004',70);
insert into SC values('1006','001',99);
insert into SC values('1007','011',85);
insert into SC values('1007','006',84);
insert into SC values('1007','003',72);
insert into SC values('1007','002',87);
insert into SC values('1008','001',94);
insert into SC values('1008','012',85);
insert into SC values('1008','006',32);
insert into SC values('1009','003',90);
insert into SC values('1009','002',82);
insert into SC values('1009','001',96);
insert into SC values('1009','010',82);
insert into SC values('1009','008',92);
insert into SC values('1010','003',90);
insert into SC values('1010','002',87);
insert into SC values('1010','001',96);
insert into SC values('1011','009',24);
insert into SC values('1011','009',25);
insert into SC values('1012','003',30);
insert into SC values('1013','002',37);
insert into SC values('1013','001',16);
insert into SC values('1013','007',55);
insert into SC values('1013','006',42);
insert into SC values('1013','012',34);
insert into SC values('1000','004',16);
insert into SC values('1002','004',55);
insert into SC values('1004','004',42);
insert into SC values('1008','004',34);
insert into SC values('1013','016',86);
insert into SC values('1013','016',44);
insert into SC values('1000','014',75);
insert into SC values('1002','016',100);
insert into SC values('1004','001',83);
insert into SC values('1008','013',97);













