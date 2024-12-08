-- MySQL dump 10.13  Distrib 8.0.40, for Win64 (x86_64)
--
-- Host: localhost    Database: nba_playoffs_2023_2024
-- ------------------------------------------------------
-- Server version	8.0.40

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `game_series`
--

DROP TABLE IF EXISTS `game_series`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `game_series` (
  `SeriesID` int NOT NULL AUTO_INCREMENT,
  `Round` enum('First','Second','Conference Finals','Finals') NOT NULL,
  `First_Team_Series_Games_Won` int NOT NULL,
  `Second_Team_Series_Games_Won` int NOT NULL,
  `FirstTeamID` int NOT NULL,
  `SecondTeamID` int NOT NULL,
  `WinningTeamID` int DEFAULT NULL,
  PRIMARY KEY (`SeriesID`),
  KEY `FirstTeamID` (`FirstTeamID`),
  KEY `SecondTeamID` (`SecondTeamID`),
  KEY `WinningTeamID` (`WinningTeamID`),
  CONSTRAINT `game_series_ibfk_1` FOREIGN KEY (`FirstTeamID`) REFERENCES `team` (`TeamID`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `game_series_ibfk_2` FOREIGN KEY (`SecondTeamID`) REFERENCES `team` (`TeamID`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `game_series_ibfk_3` FOREIGN KEY (`WinningTeamID`) REFERENCES `team` (`TeamID`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=1016 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `game_series`
--

LOCK TABLES `game_series` WRITE;
/*!40000 ALTER TABLE `game_series` DISABLE KEYS */;
INSERT INTO `game_series` VALUES (1001,'First',4,1,1,2,1),(1002,'First',4,3,3,4,3),(1003,'First',2,4,5,6,6),(1004,'First',4,2,7,8,7),(1005,'First',4,0,9,10,9),(1006,'First',2,4,11,12,12),(1007,'First',4,0,13,14,13),(1008,'First',4,1,15,16,15),(1009,'Second',4,1,1,3,1),(1010,'Second',3,4,7,6,6),(1011,'Second',2,4,9,12,12),(1012,'Second',3,4,15,13,13),(1013,'Conference Finals',4,0,1,6,1),(1014,'Conference Finals',1,4,13,12,12),(1015,'Finals',4,1,1,12,1);
/*!40000 ALTER TABLE `game_series` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `headcoach`
--

DROP TABLE IF EXISTS `headcoach`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `headcoach` (
  `CoachID` int NOT NULL AUTO_INCREMENT,
  `FirstName` varchar(50) NOT NULL,
  `LastName` varchar(50) NOT NULL,
  `FullName` varchar(100) GENERATED ALWAYS AS (concat(`FirstName`,_utf8mb4' ',`LastName`)) STORED,
  PRIMARY KEY (`CoachID`)
) ENGINE=InnoDB AUTO_INCREMENT=17 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `headcoach`
--

LOCK TABLES `headcoach` WRITE;
/*!40000 ALTER TABLE `headcoach` DISABLE KEYS */;
INSERT INTO `headcoach` (`CoachID`, `FirstName`, `LastName`) VALUES (1,'Joe','Mazzulla'),(2,'Erik','Spoelstra'),(3,'J.B.','Bickerstaff'),(4,'Jamahl','Mosley'),(5,'Doc','Rivers'),(6,'Rick','Carlisle'),(7,'Tom','Thibodeau'),(8,'Nick','Nurse'),(9,'Mark','Daigneault'),(10,'Willie','Green'),(11,'Tyronn','Lue'),(12,'Jason','Kidd'),(13,'Chris','Finch'),(14,'Frank','Vogel'),(15,'Michael','Malone'),(16,'Darvin','Ham');
/*!40000 ALTER TABLE `headcoach` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `player`
--

DROP TABLE IF EXISTS `player`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `player` (
  `PlayerID` int NOT NULL AUTO_INCREMENT,
  `FirstName` varchar(50) NOT NULL,
  `LastName` varchar(50) NOT NULL,
  `Age` int DEFAULT NULL,
  `Height` int DEFAULT NULL,
  `Weight` int DEFAULT NULL,
  `TeamID` int DEFAULT NULL,
  PRIMARY KEY (`PlayerID`),
  UNIQUE KEY `FirstName` (`FirstName`,`LastName`,`Age`,`Height`,`Weight`,`TeamID`),
  KEY `TeamID` (`TeamID`),
  CONSTRAINT `player_ibfk_1` FOREIGN KEY (`TeamID`) REFERENCES `team` (`TeamID`)
) ENGINE=InnoDB AUTO_INCREMENT=1010 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `player`
--

LOCK TABLES `player` WRITE;
/*!40000 ALTER TABLE `player` DISABLE KEYS */;
INSERT INTO `player` VALUES (146,'A.J.','Green',24,76,190,5),(49,'Aaron','Gordon',28,79,235,15),(70,'Aaron','Nesmith',24,77,215,6),(102,'Aaron','Wiggins',25,78,200,9),(75,'Al','Horford',37,81,240,1),(45,'Alec','Burks',32,78,214,7),(145,'Amir','Coffey',26,79,210,11),(44,'Andrew','Nembhard',24,76,191,6),(138,'Anthony','Black',20,79,210,4),(9,'Anthony','Davis',30,82,253,16),(11,'Anthony','Edwards',22,77,239,13),(34,'Austin','Reaves',25,77,206,16),(18,'Bam','Adebayo',26,81,255,2),(114,'Ben','Sheppard',22,77,190,6),(37,'Bobby','Portis',28,82,250,5),(104,'Bojan','Bogdanovic',34,79,220,7),(130,'Bones','Hyland',23,75,173,11),(36,'Bradley','Beal',30,76,207,14),(50,'Brandon','Ingram',26,80,190,10),(30,'Brook','Lopez',35,84,282,5),(109,'Buddy','Hield',31,76,220,8),(64,'Caleb','Martin',28,77,205,2),(108,'Cameron','Payne',29,75,183,8),(71,'Caris','LeVert',29,78,205,3),(126,'Cason','Wallace',20,76,193,9),(42,'Chet','Holmgren',21,84,208,9),(116,'Christian','Braun',22,78,220,15),(142,'Chuma','Okeke',25,80,229,4),(29,'CJ','McCollum',32,75,190,10),(115,'Cole','Anthony',23,74,185,4),(3,'Damian','Lillard',33,74,195,5),(51,'DAngelo','Russell',27,76,193,16),(77,'Daniel','Gafford',25,81,234,12),(143,'Daniel','Theis',31,81,245,11),(129,'Danilo','Gallinari',35,82,236,5),(41,'Darius','Garland',24,73,192,3),(132,'Dean','Wade',27,81,230,3),(86,'Delon','Wright',31,76,185,2),(87,'Dereck','Lively II',19,85,230,12),(76,'Derrick','Jones Jr.',26,78,210,12),(35,'Derrick','White',29,76,190,1),(12,'Devin','Booker',27,77,206,14),(6,'Donovan','Mitchell',27,73,215,3),(28,'Donte','DiVincenzo',27,76,203,7),(107,'Drew','Eubanks',26,82,245,14),(149,'Duncan','Robinson',29,79,215,2),(85,'Eric','Gordon',35,75,215,14),(39,'Evan','Mobley',22,83,215,3),(25,'Franz','Wagner',22,81,220,4),(125,'Gary','Harris',29,76,210,4),(147,'Georges','Niang',30,79,230,3),(133,'Grayson','Allen',28,77,198,14),(119,'Haywood','Highsmith',27,79,220,2),(54,'Herbert','Jones',25,79,206,10),(110,'Isaac','Okoro',23,78,225,3),(82,'Isaiah','Hartenstein',25,83,250,7),(128,'Isaiah','Jackson',22,80,206,6),(95,'Isaiah','Joe',24,76,165,9),(38,'Ivica','Zubac',26,84,240,11),(124,'Jaden','Hardy',21,76,198,12),(59,'Jaden','McDaniels',23,81,185,13),(56,'Jaime','Jaquez Jr.',22,79,220,2),(2,'Jalen','Brunson',27,74,190,7),(46,'Jalen','Suggs',22,76,205,4),(27,'Jalen','Williams',22,78,211,9),(22,'Jamal','Murray',26,76,215,15),(21,'James','Harden',34,77,220,11),(31,'Jarrett','Allen',25,82,243,3),(17,'Jaylen','Brown',27,78,223,1),(122,'Jaylin','Williams',21,80,240,9),(15,'Jayson','Tatum',25,80,210,1),(150,'Jett','Howard',20,78,215,4),(1,'Joel','Embiid',29,84,280,8),(48,'Jonas','Valanciunas',31,83,265,10),(98,'Jonathan','Isaac',26,82,230,4),(81,'Josh','Giddey',21,80,210,9),(117,'Josh','Green',23,77,200,12),(47,'Josh','Hart',28,77,215,7),(135,'Josh','Okogie',25,76,213,14),(52,'Jrue','Holiday',33,76,205,1),(144,'Justin','Holiday',34,80,181,15),(89,'Jusuf','Nurkic',29,83,290,14),(24,'Karl-Anthony','Towns',28,83,248,13),(61,'Kawhi','Leonard',32,79,225,11),(53,'Kelly','Oubre Jr.',28,79,203,8),(84,'Kentavious','Caldwell-Pope',30,77,204,15),(14,'Kevin','Durant',35,81,240,14),(16,'Khris','Middleton',32,79,222,5),(58,'Kristaps','Porzingis',28,87,240,1),(123,'Kyle','Anderson',30,81,230,13),(93,'Kyle','Lowry',37,72,196,8),(19,'Kyrie','Irving',31,74,195,12),(99,'Larry','Nance Jr.',31,79,245,10),(200,'LeBron','James',39,81,250,16),(69,'Luguentz','Dort',24,75,220,9),(7,'Luka','Doncic',24,79,230,12),(127,'Luka','Garza',25,82,240,13),(140,'Luke','Kornet',28,85,250,1),(80,'Malik','Beasley',27,76,187,5),(103,'Marcus','Morris',34,81,218,3),(94,'Markelle','Fultz',25,77,210,4),(141,'Markieff','Morris',34,81,245,12),(137,'Mason','Plumlee',33,84,254,11),(72,'Max','Strus',27,77,215,3),(131,'Maxi','Kleber',32,82,240,12),(40,'Michael','Porter Jr.',25,82,218,15),(63,'Mike','Conley',36,73,175,13),(67,'Miles','McBride',23,73,195,7),(148,'Mitchell','Robinson',25,84,240,7),(100,'Moritz','Wagner',26,84,245,4),(32,'Myles','Turner',27,83,250,6),(79,'Naji','Marshall',26,79,220,10),(66,'Naz','Reid',24,81,264,13),(92,'Nickeil','Alexander-Walker',25,78,204,13),(97,'Nicolas','Batum',35,80,230,8),(8,'Nikola','Jokic',28,83,284,15),(73,'Nikola','Jovic',20,82,223,2),(57,'Norman','Powell',30,76,215,11),(68,'Obi','Toppin',25,81,220,6),(43,'OG','Anunoby',26,79,232,7),(111,'P.J.','Tucker',38,77,245,11),(55,'P.J.','Washington',25,80,230,12),(13,'Paolo','Banchero',21,82,250,4),(120,'Pat','Connaughton',31,77,214,5),(83,'Patrick','Beverley',35,74,180,5),(106,'Patty','Mills',35,73,180,2),(23,'Paul','George',33,80,220,11),(96,'Payton','Pritchard',26,73,195,1),(113,'Precious','Achiuwa',24,80,235,7),(134,'Reggie','Jackson',33,74,208,15),(118,'Royce','ONeale',30,77,220,14),(60,'Rudy','Gobert',31,85,258,13),(88,'Rui','Hachimura',25,80,230,16),(101,'Russell','Westbrook',35,75,200,11),(112,'Sam','Hauser',26,79,215,1),(136,'Sam','Merrill',27,77,205,3),(4,'Shai','Gilgeous-Alexander',25,78,195,9),(139,'Spencer','Dinwiddie',30,78,215,16),(62,'T.J.','McConnell',31,73,190,6),(91,'Taurean','Prince',29,79,218,16),(74,'Terance','Mann',27,77,215,11),(105,'Thomas','Bryant',26,82,248,2),(121,'Tim','Hardaway Jr.',31,77,205,12),(78,'Tobias','Harris',31,80,226,8),(65,'Trey','Murphy III',23,81,206,10),(33,'Tyler','Herro',24,77,195,2),(26,'Tyrese','Haliburton',23,77,185,6),(5,'Tyrese','Maxey',23,74,200,8),(90,'Wendell','Carter Jr.',24,81,265,4);
/*!40000 ALTER TABLE `player` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `player_news`
--

DROP TABLE IF EXISTS `player_news`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `player_news` (
  `NewsID` int NOT NULL AUTO_INCREMENT,
  `ArticleTitle` varchar(250) NOT NULL,
  `PublishDate` date DEFAULT NULL,
  `PlayerID` int DEFAULT NULL,
  PRIMARY KEY (`NewsID`),
  KEY `PlayerID` (`PlayerID`),
  CONSTRAINT `player_news_ibfk_1` FOREIGN KEY (`PlayerID`) REFERENCES `player` (`PlayerID`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=26 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `player_news`
--

LOCK TABLES `player_news` WRITE;
/*!40000 ALTER TABLE `player_news` DISABLE KEYS */;
INSERT INTO `player_news` VALUES (1,'LeBron James is the aging icon we all need','2024-05-28',200),(2,'Kevin Durant unsure what to expect in his return to Brooklyn','2024-01-30',14),(3,'Nuggets star Nikola Jokic ejected in second quarter against Bulls','2023-12-12',8),(4,'2024 NBA free agency: Tyrese Maxey, Sixers agree to 5-year, $204M max contract','2024-07-01',5),(5,'Luka Doncic\'s scorching start sends Mavs to NBA Finals','2024-05-30',7),(6,'Pravi MVP: In any language, Mavs think Doncic is the NBA’s best player','2024-04-10',7),(7,'Confusing update on Joel Embiid’s knee as he eyes return to Sixers’ lineup','2024-01-11',1),(8,'Pacers rally to top Suns, spoil Devin Booker\'s 62-point night','2024-01-26',12),(9,'Cavaliers guard Donovan Mitchell starting at New Orleans after missing seven games','2024-03-13',6),(10,'Lakers News: Anthony Davis Believes Accountability Is First Step In Winning Championship','2024-08-20',9),(11,'Jalen Brunson overcomes foot injury to lift Knicks once again','2024-05-08',2),(12,'Anthony Edwards featured in second episode of \'Pass The Rock\'','2024-01-17',11),(13,'Damian Lillard \'Absolutely\' Interested in Becoming Blazers Part-Owner in Future','2024-02-10',3),(14,'Orlando Magic\'s Paolo Banchero Named NBA All-Star','2024-02-01',13),(15,'Shai Gilgeous-Alexander wears all-gold outfit ahead of Mavericks-Thunder','2024-05-07',4),(16,'Boston Celtics to sign star Jayson Tatum to largest contract in NBA history','2024-07-02',15),(17,'Mature Jayson Tatum shows he doesn\'t need to score to help Boston Celtics win games','2024-06-10',15),(18,'The Latest On Kyrie Irving\'s Injury Status Revealed','2024-08-28',19),(19,'Jaylen Brown posts cryptic response after being passed up for Team USA in favor of Celtics teammate Derrick White','2024-07-10',17),(20,'Khris Middleton (ankle) plays and scores 42 points in Bucks\' Game 3 loss to Pacers','2024-04-26',16),(21,'Pacers All-Star Tyrese Haliburton (hamstring) misses Game 4 vs. Celtics','2024-05-27',26),(22,'76ers trade disgruntled guard James Harden to Clippers, AP source says','2023-10-31',21),(23,'Strike 3: Jamal Murray’s issues go beyond shaky play in the Olympics','2024-08-16',22),(24,'Karl-Anthony Towns sets Timberwolves mark with 62 points in loss to Hornets','2024-01-23',24);
/*!40000 ALTER TABLE `player_news` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `player_statistics`
--

DROP TABLE IF EXISTS `player_statistics`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `player_statistics` (
  `PlayerID` int NOT NULL,
  `Points_Per_Game` decimal(3,1) DEFAULT NULL,
  `Assists_Per_Game` decimal(3,1) DEFAULT NULL,
  `Rebounds_Per_Game` decimal(3,1) DEFAULT NULL,
  `Field_Goal_Percentage` decimal(4,1) DEFAULT NULL,
  PRIMARY KEY (`PlayerID`),
  CONSTRAINT `player_statistics_ibfk_1` FOREIGN KEY (`PlayerID`) REFERENCES `player` (`PlayerID`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `player_statistics`
--

LOCK TABLES `player_statistics` WRITE;
/*!40000 ALTER TABLE `player_statistics` DISABLE KEYS */;
INSERT INTO `player_statistics` VALUES (1,33.0,5.7,10.8,44.4),(2,32.4,7.5,3.3,44.4),(3,31.3,5.0,3.3,42.0),(4,30.2,6.4,7.2,49.6),(5,29.8,6.8,5.2,47.8),(6,29.6,4.7,5.4,47.6),(7,28.9,8.1,9.5,44.6),(8,28.7,8.7,13.4,54.5),(9,27.8,4.0,15.6,63.4),(11,27.6,6.5,7.0,48.1),(12,27.5,6.0,3.3,49.2),(13,27.0,4.0,8.6,45.6),(14,26.8,3.3,6.5,55.2),(15,25.0,6.3,9.7,42.7),(16,24.7,4.7,9.2,48.2),(17,23.9,3.3,5.9,51.6),(18,22.6,3.8,9.4,49.5),(19,22.1,5.1,3.7,46.7),(21,21.2,8.0,4.5,44.9),(22,20.6,5.6,4.3,40.2),(23,19.5,4.8,6.8,41.1),(24,19.1,2.6,9.0,46.6),(25,18.9,4.4,6.9,40.8),(26,18.7,8.2,4.8,48.8),(27,18.7,5.4,6.8,46.9),(28,17.8,2.6,4.0,41.9),(29,17.8,4.8,4.8,41.9),(30,17.7,1.8,4.3,58.7),(31,17.0,1.3,13.8,67.6),(32,17.0,2.1,6.6,51.7),(33,16.8,5.4,3.6,38.5),(34,16.8,3.6,3.8,47.6),(35,16.7,4.1,4.3,45.2),(36,16.5,4.5,2.8,44.1),(37,16.5,1.0,11.3,48.4),(38,16.2,1.0,9.3,60.0),(39,16.0,2.3,9.3,55.5),(40,15.8,1.1,6.8,46.6),(41,15.7,5.8,3.6,42.7),(42,15.6,2.1,7.2,49.6),(43,15.1,1.1,6.0,50.5),(44,14.9,5.5,3.3,56.0),(45,14.8,1.0,3.3,50.0),(46,14.7,3.3,5.1,40.2),(47,14.5,4.5,11.5,44.0),(48,14.5,1.3,11.0,52.4),(49,14.3,4.4,7.3,58.5),(50,14.3,3.3,4.5,34.5),(51,14.2,4.2,2.8,38.4),(52,13.2,4.4,6.1,50.3),(53,13.2,1.7,4.0,48.4),(54,13.0,2.5,5.0,39.0),(55,13.0,1.4,6.6,42.7),(56,12.8,3.0,3.3,40.4),(57,12.8,0.3,2.8,42.6),(58,12.3,1.1,4.4,46.7),(59,12.2,1.1,3.8,51.4),(60,12.1,1.6,9.8,61.5),(61,12.0,2.0,8.0,45.8),(62,11.8,5.1,3.1,48.6),(63,11.6,5.7,3.9,42.8),(64,11.6,1.4,3.6,46.7),(65,11.5,2.3,6.5,37.5),(66,11.1,1.0,3.7,45.8),(67,11.0,1.9,2.2,43.5),(68,10.9,1.7,4.4,54.1),(69,10.7,2.0,4.6,36.3),(70,10.5,2.2,4.9,43.3),(71,10.1,2.3,3.6,43.1),(72,9.5,2.9,5.3,40.8),(73,9.4,2.2,6.6,44.4),(74,9.3,1.8,5.0,41.3),(75,9.2,2.1,7.0,47.8),(76,9.1,1.2,3.5,48.1),(77,9.0,0.7,5.5,63.4),(78,9.0,1.5,7.2,43.1),(79,9.0,1.3,2.8,42.9),(80,8.8,0.7,2.5,51.2),(81,8.7,2.1,3.6,45.3),(82,8.5,3.5,7.8,59.2),(83,8.2,5.5,3.3,41.0),(84,8.1,2.6,2.9,39.5),(85,8.0,1.3,1.8,32.1),(86,8.0,1.8,3.0,60.0),(87,7.9,1.3,7.4,67.4),(88,7.8,0.8,3.8,39.5),(89,7.8,2.8,8.3,50.0),(90,7.6,1.3,6.3,40.4),(91,7.4,0.6,2.4,41.4),(92,7.3,2.3,1.8,36.6),(93,7.0,4.0,3.5,34.4),(94,6.4,1.1,2.0,58.8),(95,6.4,1.0,2.2,44.4),(96,6.4,2.1,1.9,41.9),(97,6.3,1.3,5.8,41.4),(98,6.3,0.4,4.9,41.0),(99,6.3,1.8,8.3,58.8),(100,6.3,0.3,4.4,44.4),(101,6.3,1.7,4.2,26.0),(102,6.2,1.0,3.2,48.9),(103,6.1,0.3,2.8,45.8),(104,6.0,1.0,3.0,29.2),(105,6.0,0.5,2.5,71.4),(106,6.0,1.0,0.3,35.3),(107,5.7,0.0,1.3,58.3),(108,5.6,1.4,1.2,40.0),(109,5.5,0.5,1.3,41.2),(110,5.5,1.1,1.8,35.7),(111,5.5,0.0,1.5,66.7),(112,5.4,0.6,2.2,42.9),(113,5.2,0.6,4.2,48.8),(114,5.2,1.0,3.0,43.7),(115,5.1,1.3,2.1,31.7),(116,5.1,0.8,2.7,42.6),(117,5.0,1.0,2.5,42.4),(118,5.0,1.0,4.8,31.8),(119,4.8,1.6,2.8,35.7),(120,4.5,2.2,3.8,44.0),(121,4.4,0.4,1.8,37.9),(122,4.4,1.5,3.2,48.5),(123,4.3,2.5,2.7,45.6),(124,4.2,0.9,0.8,42.6),(125,4.2,0.7,2.0,28.6),(126,4.2,1.0,1.3,39.0),(127,4.1,0.1,0.9,83.3),(128,3.8,0.5,3.2,53.5),(129,3.7,0.7,3.0,50.0),(130,3.7,1.3,0.7,42.9),(131,3.7,1.0,1.9,41.0),(132,3.7,1.7,2.0,30.8),(133,3.5,1.0,4.0,20.0),(134,3.5,1.0,1.3,33.3),(135,3.5,0.5,1.0,55.6),(136,3.3,0.9,1.2,34.5),(137,3.2,0.7,3.3,38.9),(138,3.0,1.0,1.0,42.9),(139,3.0,1.6,1.4,35.7),(140,3.0,0.5,3.2,66.7),(141,3.0,0.0,4.0,20.0),(142,3.0,0.5,0.0,66.7),(143,3.0,0.0,1.0,100.0),(144,2.9,0.3,1.7,31.4),(145,2.8,0.3,1.7,31.8),(146,2.8,0.3,1.5,37.5),(147,2.8,0.4,1.2,22.0),(148,2.8,0.5,6.8,50.0),(149,2.6,1.2,1.0,31.3),(150,2.5,0.5,0.5,66.7),(200,27.8,8.8,6.8,56.6);
/*!40000 ALTER TABLE `player_statistics` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `stadium`
--

DROP TABLE IF EXISTS `stadium`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `stadium` (
  `StadiumID` int NOT NULL AUTO_INCREMENT,
  `Name` varchar(100) NOT NULL,
  `City` varchar(50) NOT NULL,
  `State` varchar(2) NOT NULL,
  `Size` int DEFAULT NULL,
  PRIMARY KEY (`StadiumID`)
) ENGINE=InnoDB AUTO_INCREMENT=16 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `stadium`
--

LOCK TABLES `stadium` WRITE;
/*!40000 ALTER TABLE `stadium` DISABLE KEYS */;
INSERT INTO `stadium` VALUES (1,'TD Garden','Boston','MA',18624),(2,'Kaseya Center','Miami','FL',19600),(3,'Rocket Mortgage FieldHouse','Cleveland','OH',19432),(4,'Kia Center','Orlando','FL',18846),(5,'Fiserv Forum','Milwaukee','WI',17341),(6,'Gainbridge Fieldhouse','Indianapolis','IN',17932),(7,'Madison Square Garden','New York','NY',19812),(8,'Wells Fargo Center','Philadelphia','PA',20007),(9,'Paycom Center','Oklahoma City','OK',18203),(10,'Smoothie King Center','New Orleans','LA',16867),(11,'Crypto.com Arena','Los Angeles','CA',18997),(12,'American Airlines Center','Dallas','TX',19200),(13,'Target Center','Minneapolis','MN',18024),(14,'Footprint Center','Phoenix','AZ',17071),(15,'Ball Arena','Denver','CO',19520);
/*!40000 ALTER TABLE `stadium` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `team`
--

DROP TABLE IF EXISTS `team`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `team` (
  `TeamID` int NOT NULL AUTO_INCREMENT,
  `Name` varchar(100) NOT NULL,
  `Location` varchar(50) NOT NULL,
  `FullName` varchar(100) GENERATED ALWAYS AS (concat(`Location`,_utf8mb4' ',`Name`)) STORED,
  `State` varchar(2) NOT NULL,
  `FoundingYear` int DEFAULT NULL,
  `CoachID` int DEFAULT NULL,
  `StadiumID` int DEFAULT NULL,
  PRIMARY KEY (`TeamID`),
  KEY `CoachID` (`CoachID`),
  KEY `StadiumID` (`StadiumID`),
  CONSTRAINT `team_ibfk_1` FOREIGN KEY (`CoachID`) REFERENCES `headcoach` (`CoachID`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `team_ibfk_2` FOREIGN KEY (`StadiumID`) REFERENCES `stadium` (`StadiumID`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=17 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `team`
--

LOCK TABLES `team` WRITE;
/*!40000 ALTER TABLE `team` DISABLE KEYS */;
INSERT INTO `team` (`TeamID`, `Name`, `Location`, `State`, `FoundingYear`, `CoachID`, `StadiumID`) VALUES (1,'Celtics','Boston','MA',1946,1,1),(2,'Heat','Miami','FL',1988,2,2),(3,'Cavaliers','Cleveland','OH',1970,3,3),(4,'Magic','Orlando','FL',1989,4,4),(5,'Bucks','Milwaukee','WI',1968,5,5),(6,'Pacers','Indiana','IN',1976,6,6),(7,'Knicks','New York','NY',1946,7,7),(8,'76ers','Philadelphia','PA',1949,8,8),(9,'Thunder','Oklahoma City','OK',1967,9,9),(10,'Pelicans','New Orleans','LA',2002,10,10),(11,'Clippers','Los Angeles','CA',1970,11,11),(12,'Mavericks','Dallas','TX',1980,12,12),(13,'Timberwolves','Minnesota','MN',1989,13,13),(14,'Suns','Phoenix','AZ',1968,14,14),(15,'Nuggets','Denver','CO',1976,15,15),(16,'Lakers','Los Angeles','CA',1948,16,11);
/*!40000 ALTER TABLE `team` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `team_statistics`
--

DROP TABLE IF EXISTS `team_statistics`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `team_statistics` (
  `TeamID` int NOT NULL,
  `Points_Per_Game` decimal(4,1) DEFAULT NULL,
  `Assists_Per_Game` decimal(3,1) DEFAULT NULL,
  `Rebounds_Per_Game` decimal(3,1) DEFAULT NULL,
  `Field_Goal_Percentage` decimal(3,1) DEFAULT NULL,
  PRIMARY KEY (`TeamID`),
  CONSTRAINT `team_statistics_ibfk_1` FOREIGN KEY (`TeamID`) REFERENCES `team` (`TeamID`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `team_statistics`
--

LOCK TABLES `team_statistics` WRITE;
/*!40000 ALTER TABLE `team_statistics` DISABLE KEYS */;
INSERT INTO `team_statistics` VALUES (1,108.8,23.8,43.1,46.9),(2,92.2,21.2,36.2,43.8),(3,98.1,21.3,38.8,44.9),(4,100.3,19.3,45.0,42.0),(5,110.2,22.2,42.7,47.3),(6,113.9,29.9,41.4,50.7),(7,109.9,22.5,42.8,45.3),(8,108.2,23.0,41.2,44.4),(9,105.7,23.1,41.5,45.9),(10,89.5,19.5,45.5,39.6),(11,100.3,20.2,42.0,43.4),(12,106.0,21.1,43.1,46.8),(13,107.5,23.9,42.4,46.8),(14,103.3,19.8,32.5,46.5),(15,102.2,24.9,42.5,45.7),(16,106.4,24.4,40.6,49.2);
/*!40000 ALTER TABLE `team_statistics` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2024-12-08 11:33:46
