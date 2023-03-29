--Show me ids, names, surnames, and marks of the students with mark > 3.6. Sort the result by mark descending.
--id,name,surname,mark


SELECT id, name, surname, mark
from students s
where s.mark >3.6
order by s.mark DESC;


--Show me student names, surnames, and majors that they have applied to. Sort the results by surname and name.
--name,surname, major

select s.name, s.surname, a.major 
from students s, applies a 
where a.stid = s.id 
order by s.surname, s.name;


-- Show me names, surnames, marks, and application decision of students with size_high_school < 1000 applying to CS at Stanford.
-- name, surname, mark, decision


SELECT DISTINCT s.name, s.surname, s.mark, a.decision
FROM students s
JOIN applies a ON s.id = a.stid
WHERE s.id IN (
  SELECT stid
  FROM applies
  WHERE college = 'Stanford' AND major = 'CS' AND size_high_school < 1000 AND decision IS NOT NULL
)
ORDER BY s.name;

--. Show me all large campuses (enrollment>20000) with CS applicants.
--name


SELECT distinct colleges.name 
FROM colleges 
JOIN applies ON colleges.name = applies.college 
WHERE applies.major = 'CS' AND colleges.enrollment > 20000;


--Show me the minimum and maximum marks of all the students.
--mymark


SELECT MIN(mark) AS mymark FROM students
UNION
SELECT MAX(mark) AS mymark FROM students;




--. Show me the difference between the maximum and the minimum marks of all the students. /difference

SELECT MAX(mark) - MIN(mark) AS difference FROM students;


--25 Show me the students who applied to CS but not EE. Sort the results by student surname, student name and student id.


SELECT s.id, s.name, s.surname
FROM students s
WHERE s.id IN 
    (SELECT a.stid
     FROM applies a
     WHERE a.major = 'CS' AND a.stid NOT IN 
         (SELECT a2.stid
          FROM applies a2
          WHERE a2.major = 'EE'))
ORDER BY s.surname, s.name, s.id;

--26 Show me the colleges such that some other college is in the same state. Sort the results by state and college. It’s mandatory to use EXISTS.


SELECT name, state 
FROM colleges c1 
WHERE EXISTS 
    (SELECT * 
     FROM colleges c2 
     WHERE c1.state = c2.state AND c1.name != c2.name)
ORDER BY state, name;



--  Show me the name of the biggest college.

SELECT name 
FROM colleges 
WHERE enrollment = 
    (SELECT MAX(enrollment) 
     FROM colleges);

-- Show me the student (or students) with highest mark (using EXISTS).
SELECT id, name, surname, mark 
FROM students s1 
WHERE EXISTS 
    (SELECT * 
     FROM students s2 
     WHERE s2.mark > s1.mark)
     OR NOT EXISTS 
    (SELECT * 
     FROM students s3 
     WHERE s3.mark < s1.mark)
ORDER BY mark DESC 
;


 

--Do 7 of the following queries:
--16, 17, 19, 20, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31, 32, 35, 36, 37, 38, 39.

--Do query 40 (mandatory, 0 points).

--Do 3 of the following queries:
--41, 42, 43, 44, 45, 46, 47.
