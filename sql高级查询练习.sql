
# 1、查询“001”课程比“002”课程成绩高的所有学生的学号； 
SELECT DISTINCT A.SNO
FROM SC AS A
WHERE (SELECT B.SCORE FROM SC AS B WHERE B.SNO = A.SNO AND B.CNO = "001") > 
      (SELECT C.SCORE FROM SC AS C WHERE C.SNO = A.SNO AND C.CNO = "002");

# 2、查询平均成绩大于60分的同学的学号和平均成绩；
SELECT SNO, AVG(SCORE)
FROM SC
GROUP BY SNO
HAVING AVG(SCORE) > 60;

# 3、查询所有同学的学号、姓名、选课数、总成绩； 
Select 
 SNO, SNAME,
 (Select Count(CNO) From sc AS A Where A.SNO=S.SNO) AS TOTAL_COURSE, 
 (Select Sum(SCORE) From sc AS B Where B.SNO=S.SNO) AS TOTAL_SCORE
From STUDENT AS S;
#添加下面两行表示只查看有总分的学生
#GROUP BY SNO
#HAVING TOTAL_SCORE IS NOT NULL;

# 4、查询姓“李”的老师的个数；
SELECT COUNT(*)
FROM TEACHER
WHERE TNAME LIKE "李%";

# 5、查询没学过“叶平”老师课的同学的学号、姓名；
# 上过叶平老师课的学生的编号
SELECT sc.SNO
FROM sc INNER JOIN COURSE AS c ON sc.CNO = c.CNO
 INNER JOIN TEACHER AS t ON c.TNO = t.TNO
WHERE t.TNAME = "叶平";
# 查询不在上面学号里的学生的学号、姓名
SELECT SNO, SNAME
FROM STUDENT
WHERE SNO NOT IN (SELECT sc.SNO
				  FROM sc INNER JOIN COURSE AS c ON sc.CNO = c.CNO
				   INNER JOIN TEACHER AS t ON c.TNO = t.TNO
				  WHERE t.TNAME = "叶平");

# 6、查询学过“001”并且也学过编号“002”课程的同学的学号、姓名；
# 第一种解法: 运用COUNT()函数判断学生学号SNO对应的sc中的课程编号为"001"和"002"的数目是否为0
SELECT SNO, SNAME
FROM STUDENT AS S
WHERE (SELECT COUNT(*) FROM sc WHERE CNO="001" AND sc.SNO = S.SNO) > 0
 AND (SELECT COUNT(*) FROM sc WHERE CNO="002" AND sc.SNO = S.SNO) > 0;

# 第二种解法: 求出既上过"001"课程也上过"002"课程的学生学号, 再判断。
SELECT SNO, SNAME
FROM STUDENT
WHERE SNO IN (SELECT A.SNO
			 FROM SC AS A
			 WHERE A.CNO = "001"
			  AND EXISTS(SELECT B.SNO
						 FROM SC AS B
						 WHERE B.SNO = A.SNO
						  AND B.CNO = "002"));

# 7、查询学过“叶平”老师所教的所有课的同学的学号、姓名； 
# 理解: 不存在"叶平"老师所教过的所有课程编号不在该对应学号的学生所学的课程编号中的情况。
SELECT SNO, SNAME
FROM STUDENT AS S
WHERE NOT EXISTS(SELECT CNO
				 FROM COURSE AS C INNER JOIN TEACHER AS T ON C.TNO = T.TNO
                 WHERE T.TNAME = "叶平"
                  AND CNO NOT IN (SELECT CNO
								  FROM sc
                                  WHERE SNO = S.SNO));

# 8、查询课程编号“002”的成绩比课程编号“001”课程低的所有同学的学号、姓名； 
SELECT SNO, SNAME
FROM STUDENT AS S
WHERE (SELECT SCORE FROM sc WHERE CNO = "002" AND sc.SNO = S.SNO) <
 (SELECT SCORE FROM sc WHERE CNO = "001" AND sc.SNO = S.SNO);

# 9、查询所有课程成绩小于60分的同学的学号、姓名；
# 理解: 该学号学生对应的所有成绩，运用ALL()函数。
SELECT SNO, SNAME
FROM STUDENT AS S
WHERE 60 > ALL(SELECT SCORE
			   FROM SC
               WHERE S.SNO = SC.SNO);

# 10、查询没有学全所有课的同学的学号、姓名；
# 理解：该学号学生对应的课程数目小于总的课程总数。COUNT()函数的运用。
SELECT SNO, SNAME
FROM STUDENT AS s
WHERE (SELECT COUNT(*) FROM sc WHERE sc.SNO = s.SNO) <
 (SELECT COUNT(*) FROM COURSE);

# 11、查询至少有一门课与学号为“1001”的同学所学相同的同学的学号和姓名;
# 理解：该学生所选的课程编号在学号1001的学生所选的课程编号中。
SELECT DISTINCT S.SNO, S.SNAME
FROM STUDENT AS S INNER JOIN sc ON S.SNO = sc.SNO
 WHERE sc.CNO = ANY(SELECT CNO
				    FROM sc
                    WHERE SNO = "1001")
 AND S.SNO != "1001";

# 12、查询至少学过学号为“1001”同学所有一门课的其他同学学号和姓名；
# 理解：根据1001同学获得选择的课程的编号，然后得到选取上了这些课程中的至少一门课程的学生学号(注意使用DISTINCT消除重复学号),最后判断。
SELECT SNO, SNAME
FROM STUDENT
WHERE SNO IN (SELECT DISTINCT SNO 
			  FROM sc
              WHERE CNO = ANY(SELECT CNO FROM sc WHERE SNO = "1001"))
 AND SNO != "1001";

# 13、把“SC”表中“叶平”老师教的课的成绩都更改为此课程的平均成绩；
# 注: 这涉及数据的更新.而且mysql不能在同一个表中进行更新。先创建一个复制表sc_copy看看。
# 思路：找出"叶平"老师教的课的所有课程编号然后用对应编号的所有课程的均值替代每门课程的成绩。
CREATE TABLE sc_copy AS
SELECT * FROM sc;

UPDATE sc
SET SCORE = (SELECT AVG(sc_copy.SCORE)
			 FROM sc_copy
             WHERE sc_copy.CNO = "001" OR sc_copy.CNO = "016")
WHERE CNO IN (SELECT CNO
			  FROM teacher AS t INNER JOIN course AS c ON t.TNO = c.TNO
              WHERE t.TNAME = "叶平");

# 14、查询和“1002”号的同学学习的课程完全相同的其他同学学号和姓名；
# 理解: "完全相同"意味着不存在有一门课"1002"同学选了而该同学没选, 同时也不存在有一门课该同学选了而"1002"号同学没选。
SELECT s.SNO, s.SNAME
FROM student AS s
WHERE NOT EXISTS(SELECT *
				 FROM sc 
                 WHERE SNO = "1002"
                  AND CNO NOT IN (SELECT CNO FROM sc WHERE sc.SNO = s.SNO))
 AND NOT EXISTS(SELECT *
			    FROM sc
                WHERE SNO = s.SNO
                 AND CNO NOT IN (SELECT CNO FROM sc WHERE SNO = "1002"))
 AND s.SNO != "1002";

# 15、删除学习“叶平”老师课的SC表记录；
DELETE sc.*
FROM sc
WHERE CNO IN (SELECT c.CNO
			  FROM teacher AS t INNER JOIN course AS c ON t.TNO = c.TNO
			  AND t.TNAME = "叶平");

# 16、向SC表中插入一些记录，这些记录要求符合以下条件：没有上过编号“003”课程的同学学号、'002'号课的平均成绩；
# 理解: 这是插入检索出的数据。 
INSERT INTO sc(SNO, CNO, SCORE) 
SELECT SNO, "002", (SELECT AVG(SCORE) FROM sc WHERE CNO='002')
From sc 
Where SNO NOT IN (SELECT SNO FROM sc Where CNO='003')
























