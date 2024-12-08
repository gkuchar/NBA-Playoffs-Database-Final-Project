# Queries For 2023-2024 NBA Playoffs Database
# Griffin Kuchar

USE nba_playoffs_2023_2024;

/* Query 1 -> basic SELECT/FROM/WHERE
1) Selects all the players who are 7 feet or taller
2) It works correctly
3) Screenshot in "Database Final Project - Query Screenshots" pdf */
SELECT FirstName, LastName, Height
FROM Player
WHERE Height >= 84;

/* Query 2 -> joins 2 or more tables
1) Selects all teams and shows their head coach and stadium
2) It works correctly
3) Screenshot in "Database Final Project - Query Screenshots" pdf */
SELECT Team.FullName AS Team, HeadCoach.FullName AS HeadCoach, Stadium.Name AS Stadium
FROM Team
INNER JOIN HeadCoach
ON Team.CoachID = HeadCoach.CoachID
INNER JOIN Stadium
ON Team.StadiumID = Stadium.StadiumID;

/* Query 3 -> subquery
1) Selects the names of players who averaged a double-double in the playoffs
	"double-double" = scored 10+ in any 2 of the statistical categories (points, assists, rebounds)
2) It works correctly
3) Screenshot in "Database Final Project - Query Screenshots" pdf */
SELECT FirstName, LastName
FROM Player
WHERE PlayerID IN (
	SELECT PlayerID
    FROM Player_Statistics
    WHERE 
		(Points_Per_Game >= 10 AND Assists_Per_Game >= 10) 
		OR (Points_Per_Game >= 10 AND Rebounds_Per_Game >= 10) 
		OR (Assists_Per_Game >= 10 AND Rebounds_Per_Game >= 10));

/* Query 4 -> aggregate function and GROUP BY
1) Shows each team and the amount of game series they won (minimum 1)
2) It works correctly
3) Screenshot in "Database Final Project - Query Screenshots" pdf */
SELECT Team.FullName AS Team, COUNT(WinningTeamID) AS Number_Of_Series_Won
FROM Team
INNER JOIN Game_Series
ON Team.TeamID = Game_Series.WinningTeamID
GROUP BY WinningTeamID
ORDER BY Number_Of_Series_Won DESC;

/* Query 5 -> add record to table
1) Adds a new player, DeAndre Jordan, to the Player and Player_Statistics tables
2) It works correctly, but can only add each player once
3) Screenshot in "Database Final Project - Query Screenshots" pdf */
DELETE FROM Player WHERE FirstName = 'DeAndre' AND LastName = 'Jordan';
INSERT INTO Player (FirstName, LastName, Age, Height, Weight, TeamID)
VALUES ('DeAndre', 'Jordan', 35, 83, 265, 15);
SET @PlayerID = LAST_INSERT_ID();
INSERT INTO Player_Statistics (PlayerID, Points_Per_Game, Assists_Per_Game, Rebounds_Per_Game, Field_Goal_Percentage)
VALUES (@PlayerID, 2.0, 0.0, 1.5, 50.0);

/* Query 6 -> delete record from table
1) Deletes the player DeAndre Jordan from Player
2) It works correctly
3) Screenshot in "Database Final Project - Query Screenshots" pdf */
DELETE FROM Player WHERE FirstName = 'DeAndre' AND LastName = 'Jordan';

/* Query 7 -> foreign key ON UPDATE
1) (CASCADE) Changes PlayerID in Player of "Lebron James" from 10 to 200, it is also changed in Player_Statistics and Player_News 
2) It works correctly
3) Screenshot in "Database Final Project - Query Screenshots" pdf */
UPDATE Player
SET PlayerID = 200
WHERE FirstName = 'Lebron' AND LastName = 'James';

SELECT Player_News.PlayerID, FirstName, LastName, ArticleTitle
FROM Player
INNER JOIN Player_News
ON Player.PlayerID = Player_News.PlayerID
WHERE Player_News.PlayerID = 200;

/* Query 8 -> foreign key ON DELETE
1) (CASCADE) When deleting "Pascal Siakam" in Player , all entries of Pascal Siakam are also deleted
in Player_Statistics and Player_News
2) It works correctly
3) Screenshot in "Database Final Project - Query Screenshots" pdf */
DELETE FROM Player WHERE PlayerID = 20;

SELECT *
FROM Player_News
WHERE PlayerID = 20;