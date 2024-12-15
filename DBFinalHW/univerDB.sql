-- MySQL dump 10.13  Distrib 8.0.40, for Win64 (x86_64)
--
-- Host: localhost    Database: univer_db
-- ------------------------------------------------------
-- Server version	8.0.40

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Temporary view structure for view `activeprofessors`
--

DROP TABLE IF EXISTS `activeprofessors`;
/*!50001 DROP VIEW IF EXISTS `activeprofessors`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `activeprofessors` AS SELECT 
 1 AS `FullName`,
 1 AS `SubjectCount`*/;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `courses`
--

DROP TABLE IF EXISTS `courses`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `courses` (
  `CourseID` int NOT NULL AUTO_INCREMENT,
  `SubjectID` int DEFAULT NULL,
  `ProfessorID` int DEFAULT NULL,
  `Semester` int DEFAULT NULL,
  `Year` year DEFAULT NULL,
  PRIMARY KEY (`CourseID`),
  KEY `SubjectID` (`SubjectID`),
  KEY `ProfessorID` (`ProfessorID`),
  CONSTRAINT `courses_ibfk_1` FOREIGN KEY (`SubjectID`) REFERENCES `subjects` (`SubjectID`),
  CONSTRAINT `courses_ibfk_2` FOREIGN KEY (`ProfessorID`) REFERENCES `professors` (`ProfessorID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `courses`
--

LOCK TABLES `courses` WRITE;
/*!40000 ALTER TABLE `courses` DISABLE KEYS */;
/*!40000 ALTER TABLE `courses` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `documentation`
--

DROP TABLE IF EXISTS `documentation`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `documentation` (
  `TableName` varchar(50) DEFAULT NULL,
  `Description` text
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `documentation`
--

LOCK TABLES `documentation` WRITE;
/*!40000 ALTER TABLE `documentation` DISABLE KEYS */;
INSERT INTO `documentation` VALUES ('Students','Содержит информацию о студентах, включая их личные данные и группу.'),('Professors','Хранит данные о преподавателях.'),('Subjects','Список всех предметов, преподаваемых в учебном заведении.'),('Courses','Связывает предметы, преподавателей и учебные периоды.'),('Grades','Хранит оценки студентов по курсам.'),('StudentGroups','Информация об учебных группах.');
/*!40000 ALTER TABLE `documentation` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `grades`
--

DROP TABLE IF EXISTS `grades`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `grades` (
  `GradeID` int NOT NULL AUTO_INCREMENT,
  `StudentID` int DEFAULT NULL,
  `CourseID` int DEFAULT NULL,
  `Grade` int DEFAULT NULL,
  `Date` date DEFAULT NULL,
  PRIMARY KEY (`GradeID`),
  KEY `StudentID` (`StudentID`),
  KEY `CourseID` (`CourseID`),
  CONSTRAINT `grades_ibfk_1` FOREIGN KEY (`StudentID`) REFERENCES `students` (`StudentID`),
  CONSTRAINT `grades_ibfk_2` FOREIGN KEY (`CourseID`) REFERENCES `courses` (`CourseID`),
  CONSTRAINT `check_grade` CHECK ((`Grade` between 1 and 5)),
  CONSTRAINT `grades_chk_1` CHECK ((`Grade` between 1 and 5))
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `grades`
--

LOCK TABLES `grades` WRITE;
/*!40000 ALTER TABLE `grades` DISABLE KEYS */;
/*!40000 ALTER TABLE `grades` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Temporary view structure for view `professorrating`
--

DROP TABLE IF EXISTS `professorrating`;
/*!50001 DROP VIEW IF EXISTS `professorrating`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `professorrating` AS SELECT 
 1 AS `FullName`,
 1 AS `AverageGrade`*/;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `professors`
--

DROP TABLE IF EXISTS `professors`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `professors` (
  `ProfessorID` int NOT NULL AUTO_INCREMENT,
  `FullName` varchar(100) NOT NULL,
  `BirthDate` date DEFAULT NULL,
  `ContactInfo` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`ProfessorID`),
  UNIQUE KEY `idx_unique_professor` (`FullName`,`BirthDate`),
  KEY `idx_professor_name` (`FullName`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `professors`
--

LOCK TABLES `professors` WRITE;
/*!40000 ALTER TABLE `professors` DISABLE KEYS */;
/*!40000 ALTER TABLE `professors` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Temporary view structure for view `professorsubjects`
--

DROP TABLE IF EXISTS `professorsubjects`;
/*!50001 DROP VIEW IF EXISTS `professorsubjects`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `professorsubjects` AS SELECT 
 1 AS `FullName`,
 1 AS `SubjectName`*/;
SET character_set_client = @saved_cs_client;

--
-- Temporary view structure for view `specialstudents`
--

DROP TABLE IF EXISTS `specialstudents`;
/*!50001 DROP VIEW IF EXISTS `specialstudents`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `specialstudents` AS SELECT 
 1 AS `FullName`*/;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `studentgroups`
--

DROP TABLE IF EXISTS `studentgroups`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `studentgroups` (
  `GroupID` int NOT NULL AUTO_INCREMENT,
  `GroupName` varchar(50) NOT NULL,
  PRIMARY KEY (`GroupID`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `studentgroups`
--

LOCK TABLES `studentgroups` WRITE;
/*!40000 ALTER TABLE `studentgroups` DISABLE KEYS */;
INSERT INTO `studentgroups` VALUES (1,'Группа 1');
/*!40000 ALTER TABLE `studentgroups` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Temporary view structure for view `studentprogressbyyear`
--

DROP TABLE IF EXISTS `studentprogressbyyear`;
/*!50001 DROP VIEW IF EXISTS `studentprogressbyyear`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `studentprogressbyyear` AS SELECT 
 1 AS `FullName`,
 1 AS `Year`,
 1 AS `AverageGrade`*/;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `students`
--

DROP TABLE IF EXISTS `students`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `students` (
  `StudentID` int NOT NULL AUTO_INCREMENT,
  `FullName` varchar(100) NOT NULL,
  `BirthDate` date DEFAULT NULL,
  `ContactInfo` varchar(255) DEFAULT NULL,
  `GroupID` int DEFAULT NULL,
  PRIMARY KEY (`StudentID`),
  UNIQUE KEY `idx_unique_student` (`FullName`,`BirthDate`),
  KEY `GroupID` (`GroupID`),
  KEY `idx_student_name` (`FullName`),
  CONSTRAINT `students_ibfk_1` FOREIGN KEY (`GroupID`) REFERENCES `studentgroups` (`GroupID`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `students`
--

LOCK TABLES `students` WRITE;
/*!40000 ALTER TABLE `students` DISABLE KEYS */;
INSERT INTO `students` VALUES (3,'Юрий Любимов','1993-03-15','yuri@example.com',1);
/*!40000 ALTER TABLE `students` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = cp866 */ ;
/*!50003 SET character_set_results = cp866 */ ;
/*!50003 SET collation_connection  = cp866_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `check_student_age` BEFORE INSERT ON `students` FOR EACH ROW BEGIN
    IF YEAR(CURDATE()) - YEAR(NEW.BirthDate) < 17 THEN
        SIGNAL SQLSTATE '45000' 
        SET MESSAGE_TEXT = 'Student must be at least 17 years old';
    END IF;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Temporary view structure for view `studentsinsubject`
--

DROP TABLE IF EXISTS `studentsinsubject`;
/*!50001 DROP VIEW IF EXISTS `studentsinsubject`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `studentsinsubject` AS SELECT 
 1 AS `FullName`,
 1 AS `SubjectName`*/;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `subjects`
--

DROP TABLE IF EXISTS `subjects`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `subjects` (
  `SubjectID` int NOT NULL AUTO_INCREMENT,
  `SubjectName` varchar(100) NOT NULL,
  `SubjectType` enum('Math','Humanities','Other') NOT NULL,
  PRIMARY KEY (`SubjectID`),
  KEY `idx_subject_name` (`SubjectName`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `subjects`
--

LOCK TABLES `subjects` WRITE;
/*!40000 ALTER TABLE `subjects` DISABLE KEYS */;
/*!40000 ALTER TABLE `subjects` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Temporary view structure for view `topgroups`
--

DROP TABLE IF EXISTS `topgroups`;
/*!50001 DROP VIEW IF EXISTS `topgroups`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `topgroups` AS SELECT 
 1 AS `GroupName`,
 1 AS `SubjectName`,
 1 AS `AverageGrade`*/;
SET character_set_client = @saved_cs_client;

--
-- Temporary view structure for view `topstudentsandprofessors`
--

DROP TABLE IF EXISTS `topstudentsandprofessors`;
/*!50001 DROP VIEW IF EXISTS `topstudentsandprofessors`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `topstudentsandprofessors` AS SELECT 
 1 AS `StudentName`,
 1 AS `ProfessorName`*/;
SET character_set_client = @saved_cs_client;

--
-- Temporary view structure for view `worstsubjects`
--

DROP TABLE IF EXISTS `worstsubjects`;
/*!50001 DROP VIEW IF EXISTS `worstsubjects`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `worstsubjects` AS SELECT 
 1 AS `SubjectName`,
 1 AS `FailCount`*/;
SET character_set_client = @saved_cs_client;

--
-- Final view structure for view `activeprofessors`
--

/*!50001 DROP VIEW IF EXISTS `activeprofessors`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = cp866 */;
/*!50001 SET character_set_results     = cp866 */;
/*!50001 SET collation_connection      = cp866_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `activeprofessors` AS select `p`.`FullName` AS `FullName`,count(distinct `c`.`SubjectID`) AS `SubjectCount` from (`professors` `p` join `courses` `c` on((`p`.`ProfessorID` = `c`.`ProfessorID`))) where (`c`.`Year` = year(curdate())) group by `p`.`ProfessorID` having (`SubjectCount` > 3) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `professorrating`
--

/*!50001 DROP VIEW IF EXISTS `professorrating`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = cp866 */;
/*!50001 SET character_set_results     = cp866 */;
/*!50001 SET collation_connection      = cp866_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `professorrating` AS select `p`.`FullName` AS `FullName`,avg(`g`.`Grade`) AS `AverageGrade` from ((`professors` `p` join `courses` `c` on((`p`.`ProfessorID` = `c`.`ProfessorID`))) join `grades` `g` on((`c`.`CourseID` = `g`.`CourseID`))) group by `p`.`ProfessorID` order by `AverageGrade` desc */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `professorsubjects`
--

/*!50001 DROP VIEW IF EXISTS `professorsubjects`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = cp866 */;
/*!50001 SET character_set_results     = cp866 */;
/*!50001 SET collation_connection      = cp866_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `professorsubjects` AS select `p`.`FullName` AS `FullName`,`sub`.`SubjectName` AS `SubjectName` from ((`professors` `p` join `courses` `c` on((`p`.`ProfessorID` = `c`.`ProfessorID`))) join `subjects` `sub` on((`c`.`SubjectID` = `sub`.`SubjectID`))) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `specialstudents`
--

/*!50001 DROP VIEW IF EXISTS `specialstudents`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = cp866 */;
/*!50001 SET character_set_results     = cp866 */;
/*!50001 SET collation_connection      = cp866_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `specialstudents` AS select `s`.`FullName` AS `FullName` from (((`students` `s` join `grades` `g` on((`s`.`StudentID` = `g`.`StudentID`))) join `courses` `c` on((`g`.`CourseID` = `c`.`CourseID`))) join `subjects` `sub` on((`c`.`SubjectID` = `sub`.`SubjectID`))) group by `s`.`StudentID` having ((avg((case when (`sub`.`SubjectType` = 'Math') then `g`.`Grade` end)) > 4) and (avg((case when (`sub`.`SubjectType` = 'Humanities') then `g`.`Grade` end)) < 3)) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `studentprogressbyyear`
--

/*!50001 DROP VIEW IF EXISTS `studentprogressbyyear`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = cp866 */;
/*!50001 SET character_set_results     = cp866 */;
/*!50001 SET collation_connection      = cp866_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `studentprogressbyyear` AS select `s`.`FullName` AS `FullName`,`c`.`Year` AS `Year`,avg(`g`.`Grade`) AS `AverageGrade` from ((`students` `s` join `grades` `g` on((`s`.`StudentID` = `g`.`StudentID`))) join `courses` `c` on((`g`.`CourseID` = `c`.`CourseID`))) group by `s`.`StudentID`,`c`.`Year` order by `s`.`FullName`,`c`.`Year` */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `studentsinsubject`
--

/*!50001 DROP VIEW IF EXISTS `studentsinsubject`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = cp866 */;
/*!50001 SET character_set_results     = cp866 */;
/*!50001 SET collation_connection      = cp866_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `studentsinsubject` AS select `s`.`FullName` AS `FullName`,`sub`.`SubjectName` AS `SubjectName` from (((`students` `s` join `grades` `g` on((`s`.`StudentID` = `g`.`StudentID`))) join `courses` `c` on((`g`.`CourseID` = `c`.`CourseID`))) join `subjects` `sub` on((`c`.`SubjectID` = `sub`.`SubjectID`))) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `topgroups`
--

/*!50001 DROP VIEW IF EXISTS `topgroups`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = cp866 */;
/*!50001 SET character_set_results     = cp866 */;
/*!50001 SET collation_connection      = cp866_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `topgroups` AS select `gr`.`GroupName` AS `GroupName`,`sub`.`SubjectName` AS `SubjectName`,avg(`g`.`Grade`) AS `AverageGrade` from ((((`studentgroups` `gr` join `students` `s` on((`gr`.`GroupID` = `s`.`GroupID`))) join `grades` `g` on((`s`.`StudentID` = `g`.`StudentID`))) join `courses` `c` on((`g`.`CourseID` = `c`.`CourseID`))) join `subjects` `sub` on((`c`.`SubjectID` = `sub`.`SubjectID`))) group by `gr`.`GroupID`,`sub`.`SubjectID` having (`AverageGrade` > (select avg(`g2`.`Grade`) from (`grades` `g2` join `courses` `c2` on((`g2`.`CourseID` = `c2`.`CourseID`))) where (`c2`.`SubjectID` = `sub`.`SubjectID`))) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `topstudentsandprofessors`
--

/*!50001 DROP VIEW IF EXISTS `topstudentsandprofessors`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = cp866 */;
/*!50001 SET character_set_results     = cp866 */;
/*!50001 SET collation_connection      = cp866_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `topstudentsandprofessors` AS select distinct `s`.`FullName` AS `StudentName`,`p`.`FullName` AS `ProfessorName` from (((`students` `s` join `grades` `g` on((`s`.`StudentID` = `g`.`StudentID`))) join `courses` `c` on((`g`.`CourseID` = `c`.`CourseID`))) join `professors` `p` on((`c`.`ProfessorID` = `p`.`ProfessorID`))) where `s`.`StudentID` in (select distinct `grades`.`StudentID` from `grades` where (`grades`.`Grade` < 5)) is false */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `worstsubjects`
--

/*!50001 DROP VIEW IF EXISTS `worstsubjects`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = cp866 */;
/*!50001 SET character_set_results     = cp866 */;
/*!50001 SET collation_connection      = cp866_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `worstsubjects` AS select `sub`.`SubjectName` AS `SubjectName`,count(0) AS `FailCount` from ((`subjects` `sub` join `courses` `c` on((`sub`.`SubjectID` = `c`.`SubjectID`))) join `grades` `g` on((`c`.`CourseID` = `g`.`CourseID`))) where ((`g`.`Grade` = 2) and (`c`.`Year` = year(curdate())) and (`c`.`Semester` = (select max(`courses`.`Semester`) from `courses` where (`courses`.`Year` = year(curdate()))))) group by `sub`.`SubjectID` order by `FailCount` desc limit 5 */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2024-12-15 20:29:49
