# 创建表

# 创建学生表
CREATE TABLE STUDENT(
			 SNO VARCHAR(3) NOT NULL,
             SNAME VARCHAR(20) NOT NULL,
             SSEX VARCHAR(2) NOT NULL,
             SBIRTHDAY DATE,
             CLASS VARCHAR(5));

# 创建课程表
CREATE TABLE COURSE(
			 CNO VARCHAR(5) NOT NULL,
             CNAME VARCHAR(20) NOT NULL,
             TNO VARCHAR(10) NOT NULL);

# 创建得分表
CREATE TABLE SCORE(
			 SNO VARCHAR(5) NOT NULL,
             CNO VARCHAR(5) NOT NULL,
             DEGREE NUMERIC(10, 1) NOT NULL);

# 创建教师表
CREATE TABLE TEACHER(
			 TNO VARCHAR(5) NOT NULL,
             TNAME VARCHAR(20) NOT NULL,
             TSEX VARCHAR(2) NOT NULL,
             TBIRTHDAY DATE NOT NULL,
             PROF VARCHAR(6),
             DEPART VARCHAR(10) NOT NULL);
			

             
             
             
             
             
             
             
             
             
             
             
             
             
             
             
             
             
             
             
             
             