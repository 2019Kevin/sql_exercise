
# 重点关注第12题、第20题、第28题,
#         第29题、第33题、第39题、第42题。


# 1、 查询Student表中的所有记录的Sname、Ssex和Class列。

SELECT SNAME, SSEX, CLASS
FROM STUDENT;


# 2、查询Teacher表所有的单位即不重复的Depart列。
SELECT DISTINCT DEPART
FROM TEACHER;


# 3、 查询Student表的所有记录。
SELECT *
FROM STUDENT;


# 4、 查询Score表中成绩在60到80之间的所有记录。
SELECT *
FROM SCORE
WHERE DEGREE BETWEEN 60 and 80;


# 5、 查询Score表中成绩为85，86或88的记录
SELECT *
FROM SCORE
WHERE DEGREE IN (85, 86, 88);


# 6、 查询Student表中“95031”班或性别为“女”的同学记录。
SELECT *
FROM STUDENT
WHERE CLASS = "95031" OR SSEX = "女";

# 7、 以Class降序查询Student表的所有记录。
SELECT *
FROM STUDENT
ORDER BY CLASS DESC;

# 8、 以Cno升序、Degree降序查询Score表的所有记录。
SELECT *
FROM SCORE
ORDER BY CNO, DEGREE DESC;

# 9、 查询“95031”班的学生人数。
SELECT COUNT(*) AS studentNum_of_class95031
FROM STUDENT
WHERE CLASS="95031";

# 10、查询Score表中的最高分的学生学号和课程号。
SELECT SNO, CNO
FROM SCORE
ORDER BY DEGREE DESC
limit 1 offset 0;

# 11、查询‘3-105’号课程的平均分。
SELECT AVG(DEGREE) AS avg_degree_3_105
FROM SCORE
WHERE CNO = "3-105";

# 12、查询Score表中至少有5名学生选修的并以3开头的课程的平均分数。
# 注：先用WHERE过滤再用GROUP BY分组最后用HAVING对分组数据过滤。
SELECT CNO, AVG(DEGREE)
FROM SCORE
WHERE CNO LIKE "3%"
GROUP BY CNO
HAVING COUNT(SNO) >= 5;

# 13、查询最低分大于70，最高分小于90的SNO列。
SELECT MIN(DEGREE), MAX(DEGREE), SNO
FROM SCORE
GROUP BY SNO
HAVING MIN(DEGREE) > 70 AND MAX(DEGREE) < 90;


# 14、查询所有学生的Sname、Cno和Degree列。
SELECT SNAME, CNO, DEGREE
FROM STUDENT LEFT OUTER JOIN SCORE
 ON STUDENT.SNO = SCORE.SNO;
 

# 15、查询所有学生的Sno、Cname和Degree列。
SELECT S1.SNO, C.CNAME, S2.DEGREE
FROM STUDENT AS S1, SCORE AS S2, COURSE AS C
WHERE S1.SNO = S2.SNO
 AND S2.CNO = C.CNO;

# 16、查询所有学生的Sname、Cname和Degree列。
SELECT S1.SNAME, C.CNAME, S2.DEGREE
FROM STUDENT AS S1, SCORE AS S2, COURSE AS C
WHERE S1.SNO = S2.SNO
 AND S2.CNO = C.CNO;

# 17、查询“95033”班所选课程的平均分。
SELECT AVG(S2.DEGREE)
FROM STUDENT AS S1 INNER JOIN SCORE AS S2
 ON S1.SNO = S2.SNO
WHERE S1.CLASS = "95033";


/*
# 创建等级表
CREATE TABLE grade(low INT(4),
				   upp INT(4),
                   rank char(1));

# 等级表中插入数据
insert into grade values(90,100,"A");
insert into grade values(80,89,"B");
insert into grade values(70,79,"C");
insert into grade values(60,69,"D");
insert into grade values(0,59,"E");
*/


# 18、查询所有同学的Sno、Cno和rank列。
SELECT S1.SNO, S2.CNO, G.rank
FROM STUDENT AS S1, SCORE AS S2, GRADE AS G
WHERE S1.SNO = S2.SNO
 AND S2.DEGREE BETWEEN G.low and G.upp
ORDER BY G.rank;

# 19、查询选修“3-105”课程的成绩高于“109”号同学成绩的所有同学的记录。
SELECT S1.*
FROM SCORE AS S1, SCORE AS S2
WHERE S1.CNO = S2.CNO
 AND S1.DEGREE > S2.DEGREE
 AND S2.CNO = "3-105"
 AND S2.SNO = 109;


# 20、查询score中选学一门以上课程的同学中分数为非最高分成绩的记录。
SELECT *
FROM SCORE
WHERE DEGREE < (SELECT MAX(DEGREE)
				FROM SCORE)
GROUP BY SNO
HAVING COUNT(SNO) > 1;


# 21、查询成绩高于学号为“109”、课程号为“3-105”的成绩的所有记录。
SELECT SNO, CNO, DEGREE
FROM SCORE
WHERE CNO = "3-105" AND DEGREE > (SELECT DEGREE
								 FROM SCORE
                                 WHERE CNO = "3-105" AND SNO = 109);

# 22、查询和学号为108的同学同年出生的所有学生的Sno、Sname和Sbirthday列。
SELECT SNO, SNAME, SBIRTHDAY
FROM STUDENT
WHERE YEAR(SBIRTHDAY) = (SELECT YEAR(SBIRTHDAY)
						  FROM STUDENT
                          WHERE SNO = 108)
 AND SNO != 108;

# 23、查询“张旭“教师任课的学生成绩。
SELECT S.SNO, S.CNO, S.DEGREE
FROM TEACHER AS T, COURSE AS C, SCORE AS S
WHERE T.TNO = C.TNO
 AND C.CNO = S.CNO
 AND T.TNAME = "张旭";

# 24、查询选修某课程的同学人数多于5人的教师姓名。
SELECT T.TNAME
FROM TEACHER AS T, COURSE AS C, SCORE AS S
WHERE T.TNO = C.TNO 
 AND  C.CNO = S.CNO
GROUP BY S.CNO
HAVING COUNT(S.CNO) > 5;

# 25、查询95033班和95031班全体学生的记录。
SELECT *
FROM STUDENT AS S
WHERE S.CLASS IN ("95033", "95031");

# 26、查询存在有85分以上成绩的课程Cno.
SELECT CNO
FROM SCORE
GROUP BY CNO
HAVING MAX(DEGREE) > 85;

# 27、查询出“计算机系“教师所教课程的成绩表。
SELECT S.*
FROM TEACHER AS T, COURSE AS C, SCORE AS S
WHERE T.TNO = C.TNO
 AND C.CNO = S.CNO
 AND T.DEPART = "计算机系";

# 28、查询“计算机系”中与“电子工程系“中的不同职称的教师的Tname和Prof。
SELECT TNAME, PROF
FROM TEACHER
WHERE DEPART = "计算机系"
 AND PROF NOT IN (SELECT PROF
				  FROM TEACHER
                  WHERE DEPART = "电子工程系");

# 29、查询选修编号为“3-105“课程且成绩至少高于选修编号为“3-245”的同学的Cno、Sno和Degree,并按Degree从高到低次序排序。
# 注: ANY()函数, 与比较操作符联合使用，表示与子查询返回的任何值比较为 TRUE ，则返回 TRUE 。
SELECT *
FROM SCORE
WHERE CNO = "3-105"
 AND DEGREE > ANY(SELECT DEGREE
				 FROM SCORE
				 WHERE CNO = "3-245"
                 )
ORDER BY DEGREE DESC;

# 30、查询选修编号为“3-105”且成绩高于选修编号为“3-245”课程的同学的Cno、Sno和Degree.
# 注: ALL()函数, 与比较操作符联合使用，表示与子查询返回的所有值比较都为 TRUE ，则返回 TRUE 。
SELECT S.CNO, S.SNO, S.DEGREE
FROM SCORE AS S
WHERE S.CNO = "3-105"
 AND S.DEGREE > ALL(SELECT DEGREE
					FROM SCORE
					WHERE CNO = "3-245")

# 31、查询所有教师和同学的name、sex和birthday.
SELECT TNAME, TSEX, TBIRTHDAY
FROM TEACHER 
UNION
SELECT SNAME, SSEX, SBIRTHDAY
FROM STUDENT;

# 32、查询所有“女”教师和“女”同学的name、sex和birthday.
SELECT TNAME AS NAME, TSEX AS SEX, TBIRTHDAY AS BIRTHDAY
FROM TEACHER
WHERE TSEX = "女"
UNION
SELECT SNAME AS NAME, SSEX AS SEX, SBIRTHDAY AS BIRTHDAY
FROM STUDENT
WHERE SSEX = "女";

# 33、查询成绩比该课程平均成绩低的同学的成绩表。
SELECT S1.*
FROM SCORE AS S1
WHERE S1.DEGREE < (SELECT AVG(DEGREE)
				   FROM SCORE AS S2
                   GROUP BY S2.CNO
                   HAVING S1.CNO = S2.CNO);

# 34、查询所有任课教师的Tname和Depart.
SELECT T.TNAME, T.DEPART
FROM TEACHER AS T INNER JOIN COURSE AS C
 ON T.TNO = C.TNO;

# 35  查询所有未讲课的教师的Tname和Depart. 
# 注: EXISTS用于检查子查询是否至少会返回一行数据，该子查询实际上并不返回任何数据，而是返回值True或False。
SELECT T.TNAME, T.DEPART
FROM TEACHER AS T
WHERE NOT EXISTS(SELECT *
				 FROM COURSE AS C
                 WHERE T.TNO = C.TNO);

# 36、查询至少有2名男生的班号。
SELECT S.CLASS
FROM STUDENT AS S
WHERE S.SSEX = "男"
GROUP BY S.CLASS
HAVING COUNT(*) >= 2;

# 37、查询Student表中不姓“王”的同学记录。
SELECT *
FROM STUDENT AS S
WHERE S.SNAME NOT LIKE "王%";

# 38、查询Student表中每个学生的姓名和年龄。
# 注：根据出生年月日计算年龄。
SELECT SNAME,
	   YEAR(CURDATE())-YEAR(SBIRTHDAY) - (RIGHT(CURDATE(), 5) < RIGHT(SBIRTHDAY, 5)) AS SAGE
FROM STUDENT;

# 39、查询Student表中最大和最小的Sbirthday日期值。
# 这题注意要使用WHERE过滤, 而且注意出生日期越大, 数值越小。
SELECT SNAME, SBIRTHDAY AS BIRTH_DATE
FROM STUDENT
WHERE SBIRTHDAY = (SELECT MIN(SBIRTHDAY)
				   FROM STUDENT)
UNION
SELECT SNAME, SBIRTHDAY AS BIRTH_DATE
FROM STUDENT
WHERE SBIRTHDAY = (SELECT MAX(SBIRTHDAY)
				   FROM STUDENT);

# 40、以班号和年龄从大到小的顺序查询Student表中的全部记录。
SELECT *, YEAR(CURDATE())-YEAR(SBIRTHDAY)-(RIGHT(CURDATE(), 5) < RIGHT(SBIRTHDAY,5)) AS SAGE
FROM STUDENT 
ORDER BY CLASS DESC, SAGE DESC;

# 41、查询“男”教师及其所上的课程。
SELECT T.*, C.*
FROM TEACHER AS T, COURSE AS C
WHERE T.TNO = C.TNO
 AND T.TSEX = "男";

# 42、查询最高分同学的Sno、Cno和Degree列。
# 易错题: 要使用WHERE过滤啊。。。
SELECT S1.*
FROM SCORE AS S1
WHERE S1.DEGREE = (SELECT MAX(DEGREE)
				   FROM SCORE);

# 43、查询和“李军”同性别的所有同学的Sname.
SELECT S1.SNAME
FROM STUDENT AS S1, STUDENT AS S2
WHERE S1.SSEX = S2.SSEX
 AND S2.SNAME = "李军"
 AND S1.SNAME != "李军";

# 44、查询和“李军”同性别并同班的同学Sname.
SELECT S1.SNAME
FROM STUDENT AS S1, STUDENT AS S2
WHERE S1.SSEX = S2.SSEX
 AND S1.CLASS = S2.CLASS
 AND S2.SNAME = "李军";

# 45、查询所有选修“计算机导论”课程的“男”同学的成绩表
SELECT S2.*
FROM STUDENT AS S1, SCORE AS S2, COURSE AS C
WHERE S1.SNO = S2.SNO
 AND S2.CNO = C.CNO
 AND S1.SSEX = "男"
 AND C.CNAME = "计算机导论";



     






