UniverDB

*Описание основных таблиц:

('Students', 'Содержит информацию о студентах, включая их личные данные и группу.'),
('Professors', 'Хранит данные о преподавателях.'),
('Subjects', 'Список всех предметов, преподаваемых в учебном заведении.'),
('Courses', 'Связывает предметы, преподавателей и учебные периоды.'),
('Grades', 'Хранит оценки студентов по курсам.'),
('StudentGroups', 'Информация об учебных группах.');

*Отношения


Students и StudentGroups (Группы студентов):

Каждый студент принадлежит только к одной группе, но в группе может быть много студентов.
Таблица Students имеет внешний ключ GroupID, который ссылается на первичный ключ GroupID в таблице StudentGroups.

Professors (Преподаватели) и Courses (Курсы):

Один преподаватель может вести несколько курсов, но каждый курс ведется одним преподавателем.
Таблица Courses имеет внешний ключ ProfessorID, который ссылается на первичный ключ ProfessorID в таблице Professors.

Subjects (Предметы) и Courses (Курсы):

Один предмет может быть представлен в нескольких курсах, но каждый курс относится только к одному предмету.
Разница в том, что в рамках одного предмета может быть несколько курсов (например, разная математика для разных специальностей или разного уровня)
Таблица Courses имеет внешний ключ SubjectID, который ссылается на первичный ключ SubjectID в таблице Subjects.

Students (Студенты) и Courses (Курсы) через Grades (Оценки):

Студент может посещать много курсов, и курс может посещаться многими студентами.
Таблица Grades служит связующей таблицей, имея внешние ключи StudentID и CourseID, которые ссылаются на соответствующие первичные ключи в таблицах Students и Courses.

Courses (Курсы) и Grades (Оценки):

Один курс может иметь много оценок (для разных студентов), но каждая оценка относится только к одному курсу.
Таблица Grades имеет внешний ключ CourseID, который ссылается на первичный ключ CourseID в таблице Courses.

Students (Студенты) и Grades (Оценки):


Один студент может иметь много оценок, но каждая оценка принадлежит только одному студенту.
Таблица Grades имеет внешний ключ StudentID, который ссылается на первичный ключ StudentID в таблице Students.

Эти отношения обеспечивают следующие возможности:

Отслеживание принадлежности студентов к группам
Связь курсов с преподавателями и предметами
Учет оценок студентов по различным курсам
Возможность анализа успеваемости студентов по разным параметрам (предметам, преподавателям, группам)


*Запросы (5 пункт) (также добавлены PROCEDURE и VIEW)

Вывод списка студентов по определённому предмету(VIEW StudentsInSubject):


SELECT DISTINCT s.StudentID, s.FullName
FROM Students s
JOIN Enrollments e ON s.StudentID = e.StudentID
JOIN Courses c ON e.CourseID = c.CourseID
JOIN Subjects sub ON c.SubjectID = sub.SubjectID
WHERE sub.SubjectName = 'Название предмета';

Вывод списка предметов, которые преподаёт конкретный преподаватель(VIEW ProfessorSubjects):


SELECT DISTINCT sub.SubjectName
FROM Subjects sub
JOIN Courses c ON sub.SubjectID = c.SubjectID
JOIN Professors p ON c.ProfessorID = p.ProfessorID
WHERE p.FullName = 'Имя Фамилия преподавателя';

Вывод среднего балла студента по всем предметам (PROCEDURE GetStudentAverageGrade):


SELECT s.StudentID, s.FullName, AVG(g.Grade) AS AverageGrade
FROM Students s
LEFT JOIN Grades g ON s.StudentID = g.StudentID
GROUP BY s.StudentID, s.FullName;

Вывод рейтинга преподавателей по средней оценке студентов (VIEW ProfessorRating):


SELECT p.ProfessorID, p.FullName, AVG(g.Grade) AS AverageGrade
FROM Professors p
JOIN Courses c ON p.ProfessorID = c.ProfessorID
JOIN Grades g ON c.CourseID = g.CourseID
GROUP BY p.ProfessorID, p.FullName
ORDER BY AverageGrade DESC;

Вывод списка преподавателей, которые преподавали более 3 предметов за последний год (VIEW ActiveProfessors):

sql Скопировать Закрыть блок
SELECT p.ProfessorID, p.FullName, COUNT(DISTINCT c.SubjectID) AS SubjectCount
FROM Professors p
JOIN Courses c ON p.ProfessorID = c.ProfessorID
WHERE c.Year = YEAR(CURDATE()) - 1
GROUP BY p.ProfessorID, p.FullName
HAVING SubjectCount > 3;

Вывод списка студентов, которые имеют средний балл выше 4 по математическим предметам, но ниже 3 по гуманитарным (VIEW SpecialStudents):


SELECT s.StudentID, s.FullName
FROM Students s
JOIN Grades g ON s.StudentID = g.StudentID
JOIN Courses c ON g.CourseID = c.CourseID
JOIN Subjects sub ON c.SubjectID = sub.SubjectID
GROUP BY s.StudentID, s.FullName
HAVING 
AVG(CASE WHEN sub.SubjectType = 'Math' THEN g.Grade END) > 4
AND AVG(CASE WHEN sub.SubjectType = 'Humanities' THEN g.Grade END) < 3;

Определение предметов, по которым больше всего двоек в текущем семестре (VIEW WorstSubjects):


SELECT sub.SubjectName, COUNT(*) AS FailCount
FROM Subjects sub
JOIN Courses c ON sub.SubjectID = c.SubjectID
JOIN Grades g ON c.CourseID = g.CourseID
WHERE g.Grade = 2 
AND c.Year = YEAR(CURDATE()) 
AND c.Semester = (SELECT MAX(Semester) FROM Courses WHERE Year = YEAR(CURDATE()))
GROUP BY sub.SubjectID, sub.SubjectName
ORDER BY FailCount DESC
LIMIT 5;

Вывод студентов, которые получили высший балл по всем своим экзаменам, и преподавателей, которые вели эти предметы (VIEW TopStudentsAndProfessors):


SELECT DISTINCT s.FullName AS StudentName, p.FullName AS ProfessorName
FROM Students s
JOIN Grades g ON s.StudentID = g.StudentID
JOIN Courses c ON g.CourseID = c.CourseID
JOIN Professors p ON c.ProfessorID = p.ProfessorID
WHERE s.StudentID NOT IN (
SELECT DISTINCT StudentID
FROM Grades
WHERE Grade < 5
);

Просмотр изменения среднего балла студента по годам обучения (VIEW StudentProgressByYear):


SELECT s.StudentID, s.FullName, c.Year, AVG(g.Grade) AS AverageGrade
FROM Students s
JOIN Grades g ON s.StudentID = g.StudentID
JOIN Courses c ON g.CourseID = c.CourseID
GROUP BY s.StudentID, s.FullName, c.Year
ORDER BY s.StudentID, c.Year;

Определение групп, в которых средний балл выше, чем в других по аналогичным предметам (VIEW TopGroups):


SELECT sg.GroupName, sub.SubjectName, AVG(g.Grade) AS AverageGrade
FROM StudentGroups sg
JOIN Students s ON sg.GroupID = s.GroupID
JOIN Grades g ON s.StudentID = g.StudentID
JOIN Courses c ON g.CourseID = c.CourseID
JOIN Subjects sub ON c.SubjectID = sub.SubjectID
GROUP BY sg.GroupID, sub.SubjectID
HAVING AverageGrade > (
SELECT AVG(g2.Grade)
FROM Grades g2
JOIN Courses c2 ON g2.CourseID = c2.CourseID
WHERE c2.SubjectID = sub.SubjectID
)
ORDER BY sub.SubjectName, AverageGrade DESC;
