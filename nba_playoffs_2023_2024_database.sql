# Griffin Kuchar -> 2023-2024 NBA Playoffs Database

DROP DATABASE IF EXISTS nba_playoffs_2023_2024;
CREATE DATABASE IF NOT EXISTS nba_playoffs_2023_2024;
USE nba_playoffs_2023_2024;

DROP TABLE IF EXISTS Stadium;
CREATE TABLE IF NOT EXISTS Stadium (
	StadiumID INT AUTO_INCREMENT PRIMARY KEY,
    Name VARCHAR(100) NOT NULL,
    City VARCHAR(50) NOT NULL,
    State VARCHAR(2) NOT NULL,
    Size INT
);

DROP TABLE IF EXISTS HeadCoach;
CREATE TABLE IF NOT EXISTS HeadCoach (
	CoachID INT AUTO_INCREMENT PRIMARY KEY,
    FirstName VARCHAR(50) NOT NULL,
    LastName VARCHAR(50) NOT NULL,
    FullName VARCHAR(100) AS (CONCAT(FirstName, ' ', LastName)) STORED
);

DROP TABLE IF EXISTS Team;
CREATE TABLE IF NOT EXISTS Team (
	TeamID INT AUTO_INCREMENT PRIMARY KEY,
    Name VARCHAR(100) NOT NULL,
    Location VARCHAR(50) NOT NULL,
    FullName VARCHAR(100) AS (CONCAT(Location, ' ', Name)) STORED,
    State VARCHAR(2) NOT NULL,
    FoundingYear INT,
    CoachID INT,
    StadiumID INT,
    FOREIGN KEY (CoachID) REFERENCES HeadCoach(CoachID)
		ON DELETE CASCADE
		ON UPDATE CASCADE,
    FOREIGN KEY (StadiumID) REFERENCES Stadium(StadiumID)
		ON DELETE CASCADE
		ON UPDATE CASCADE
);

DROP TABLE IF EXISTS Player;
CREATE TABLE IF NOT EXISTS Player (
	PlayerID INT AUTO_INCREMENT PRIMARY KEY,
    FirstName VARCHAR(50) NOT NULL,
    LastName VARCHAR(50) NOT NULL,
    Age INT,
    Height INT,
    Weight INT,
    TeamID INT,
    FOREIGN KEY (TeamID) REFERENCES Team(TeamID),
    UNIQUE (FirstName, LastName, Age, Height, Weight, TeamID)
);

DROP TABLE IF EXISTS Player_News;
CREATE TABLE IF NOT EXISTS Player_News (
	NewsID INT AUTO_INCREMENT PRIMARY KEY,
    ArticleTitle VARCHAR(250) NOT NULL,
    PublishDate DATE,
    PlayerID INT,
    FOREIGN KEY (PlayerID) REFERENCES Player(PlayerID)
		ON DELETE CASCADE
		ON UPDATE CASCADE
);

DROP TABLE IF EXISTS Player_Statistics;
CREATE TABLE IF NOT EXISTS Player_Statistics (
	PlayerID INT PRIMARY KEY,
    Points_Per_Game DECIMAL(3,1),
    Assists_Per_Game DECIMAL(3,1),
    Rebounds_Per_Game DECIMAL(3,1),
    Field_Goal_Percentage DECIMAL(4,1),
    FOREIGN KEY (PlayerID) REFERENCES Player(PlayerID)
		ON DELETE CASCADE
		ON UPDATE CASCADE
);

DROP TABLE IF EXISTS Team_Statistics;
CREATE TABLE IF NOT EXISTS Team_Statistics (
	TeamID INT PRIMARY KEY,
    Points_Per_Game DECIMAL(4,1),
    Assists_Per_Game DECIMAL(3,1),
    Rebounds_Per_Game DECIMAL(3,1),
    Field_Goal_Percentage DECIMAL(3,1),
    FOREIGN KEY (TeamID) REFERENCES Team(TeamID)
		ON DELETE CASCADE
		ON UPDATE CASCADE
);

DROP TABLE IF EXISTS Game_Series;
CREATE TABLE IF NOT EXISTS Game_Series (
	SeriesID INT AUTO_INCREMENT PRIMARY KEY,
    Round ENUM('First', 'Second', 'Conference Finals', 'Finals') NOT NULL,
    First_Team_Series_Games_Won INT NOT NULL,
    Second_Team_Series_Games_Won INT NOT NULL,
    FirstTeamID INT NOT NULL,
    SecondTeamID INT NOT NULL,
    WinningTeamID INT,
    FOREIGN KEY (FirstTeamID) REFERENCES Team(TeamID)
		ON DELETE CASCADE
		ON UPDATE CASCADE,
    FOREIGN KEY (SecondTeamID) REFERENCES Team(TeamID)
		ON DELETE CASCADE
		ON UPDATE CASCADE,
    FOREIGN KEY (WinningTeamID) REFERENCES Team(TeamID)
		ON DELETE CASCADE
		ON UPDATE CASCADE
) AUTO_INCREMENT = 1001;

INSERT INTO HeadCoach (FirstName, LastName)
VALUES
('Joe', 'Mazzulla'),
('Erik', 'Spoelstra'),
('J.B.', 'Bickerstaff'),
('Jamahl', 'Mosley'),
('Doc', 'Rivers'),
('Rick', 'Carlisle'),
('Tom', 'Thibodeau'),
('Nick', 'Nurse'),
('Mark', 'Daigneault'),
('Willie', 'Green'),
('Tyronn', 'Lue'),
('Jason', 'Kidd'),
('Chris', 'Finch'),
('Frank', 'Vogel'),
('Michael', 'Malone'),
('Darvin', 'Ham');

INSERT INTO Stadium (Name, City, State, Size)
VALUES
('TD Garden', 'Boston', 'MA', 18624),
('Kaseya Center', 'Miami', 'FL', 19600),
('Rocket Mortgage FieldHouse', 'Cleveland', 'OH', 19432),
('Kia Center', 'Orlando', 'FL', 18846),
('Fiserv Forum', 'Milwaukee', 'WI', 17341),
('Gainbridge Fieldhouse', 'Indianapolis', 'IN', 17932),
('Madison Square Garden', 'New York', 'NY', 19812),
('Wells Fargo Center', 'Philadelphia', 'PA', 20007),
('Paycom Center', 'Oklahoma City', 'OK', 18203),
('Smoothie King Center', 'New Orleans', 'LA', 16867),
('Crypto.com Arena', 'Los Angeles', 'CA', 18997),
('American Airlines Center', 'Dallas', 'TX', 19200),
('Target Center', 'Minneapolis', 'MN', 18024),
('Footprint Center', 'Phoenix', 'AZ', 17071),
('Ball Arena', 'Denver', 'CO', 19520);

INSERT INTO Team (Name, Location, State, FoundingYear, CoachID, StadiumID)
VALUES
('Celtics', 'Boston', 'MA', 1946, 1, 1),
('Heat', 'Miami', 'FL', 1988, 2, 2),
('Cavaliers', 'Cleveland', 'OH', 1970, 3, 3),
('Magic', 'Orlando', 'FL', 1989, 4, 4),
('Bucks', 'Milwaukee', 'WI', 1968, 5, 5),
('Pacers', 'Indiana', 'IN', 1976, 6, 6),
('Knicks', 'New York', 'NY', 1946, 7, 7),
('76ers', 'Philadelphia', 'PA', 1949, 8, 8),
('Thunder', 'Oklahoma City', 'OK', 1967, 9, 9),
('Pelicans', 'New Orleans', 'LA', 2002, 10, 10),
('Clippers', 'Los Angeles', 'CA', 1970, 11, 11),
('Mavericks', 'Dallas', 'TX', 1980, 12, 12),
('Timberwolves', 'Minnesota', 'MN', 1989, 13, 13),
('Suns', 'Phoenix', 'AZ', 1968, 14, 14),
('Nuggets', 'Denver', 'CO', 1976, 15, 15),
('Lakers', 'Los Angeles', 'CA', 1948, 16, 11);

LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/Team_Statistics.csv'
INTO TABLE Team_Statistics
FIELDS TERMINATED BY ','
LINES TERMINATED BY '\n'
IGNORE 1 ROWS
(TeamID, Field_Goal_Percentage, Rebounds_Per_Game, Assists_Per_Game, Points_Per_Game);

INSERT INTO Game_Series (Round, First_Team_Series_Games_Won, Second_Team_Series_Games_Won, FirstTeamID, SecondTeamID, WinningTeamID)
VALUES
('First', 4, 1, 1, 2, 1),
('First', 4, 3, 3, 4, 3),
('First', 2, 4, 5, 6, 6),
('First', 4, 2, 7, 8, 7),
('First', 4, 0, 9, 10, 9),
('First', 2, 4, 11, 12, 12),
('First', 4, 0, 13, 14, 13),
('First', 4, 1, 15, 16, 15),
('Second', 4, 1, 1, 3, 1),
('Second', 3, 4, 7, 6, 6),
('Second', 2, 4, 9, 12, 12),
('Second', 3, 4, 15, 13, 13),
('Conference Finals', 4, 0, 1, 6, 1),
('Conference Finals', 1, 4, 13, 12, 12),
('Finals', 4, 1, 1, 12, 1);

LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/Players.csv'
INTO TABLE Player
FIELDS TERMINATED BY ','
LINES TERMINATED BY '\n'
IGNORE 1 ROWS
(FirstName, LastName, Age, TeamID, Height, Weight);

LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/Player_Statistics.csv'
INTO TABLE Player_Statistics
FIELDS TERMINATED BY ','
LINES TERMINATED BY '\n'
IGNORE 1 ROWS
(PlayerID, Field_Goal_Percentage, Rebounds_Per_Game, Assists_Per_Game, Points_Per_Game);

INSERT INTO Player_News (ArticleTitle, PublishDate, PlayerID)
VALUES
('LeBron James is the aging icon we all need', '2024-05-28', 10),
('Kevin Durant unsure what to expect in his return to Brooklyn', '2024-01-30', 14),
('Nuggets star Nikola Jokic ejected in second quarter against Bulls', '2023-12-12', 8),
('2024 NBA free agency: Tyrese Maxey, Sixers agree to 5-year, $204M max contract', '2024-07-01', 5),
('Luka Doncic\'s scorching start sends Mavs to NBA Finals', '2024-05-30', 7), #5
('Pravi MVP: In any language, Mavs think Doncic is the NBA’s best player', '2024-04-10', 7),
('Confusing update on Joel Embiid’s knee as he eyes return to Sixers’ lineup', '2024-01-11', 1),
('Pacers rally to top Suns, spoil Devin Booker\'s 62-point night', '2024-01-26', 12),
('Cavaliers guard Donovan Mitchell starting at New Orleans after missing seven games', '2024-03-13', 6),
('Lakers News: Anthony Davis Believes Accountability Is First Step In Winning Championship', '2024-08-20', 9), #10
('Jalen Brunson overcomes foot injury to lift Knicks once again', '2024-05-08', 2),
('Anthony Edwards featured in second episode of \'Pass The Rock\'', '2024-01-17', 11),
('Damian Lillard \'Absolutely\' Interested in Becoming Blazers Part-Owner in Future', '2024-02-10', 3),
('Orlando Magic\'s Paolo Banchero Named NBA All-Star', '2024-02-01', 13),
('Shai Gilgeous-Alexander wears all-gold outfit ahead of Mavericks-Thunder', '2024-05-07', 4), #15
('Boston Celtics to sign star Jayson Tatum to largest contract in NBA history', '2024-07-02', 15),
('Mature Jayson Tatum shows he doesn\'t need to score to help Boston Celtics win games', '2024-06-10', 15),
('The Latest On Kyrie Irving\'s Injury Status Revealed', '2024-08-28', 19),
('Jaylen Brown posts cryptic response after being passed up for Team USA in favor of Celtics teammate Derrick White', '2024-07-10', 17),
('Khris Middleton (ankle) plays and scores 42 points in Bucks\' Game 3 loss to Pacers', '2024-04-26', 16), #20
('Pacers All-Star Tyrese Haliburton (hamstring) misses Game 4 vs. Celtics', '2024-05-27', 26),
('76ers trade disgruntled guard James Harden to Clippers, AP source says', '2023-10-31', 21),
('Strike 3: Jamal Murray’s issues go beyond shaky play in the Olympics', '2024-08-16', 22),
('Karl-Anthony Towns sets Timberwolves mark with 62 points in loss to Hornets', '2024-01-23', 24),
('Pascal Siakam signs reported $189.5M max deal with Pacers', '2024-08-30', 20); #25

SELECT * FROM Player;