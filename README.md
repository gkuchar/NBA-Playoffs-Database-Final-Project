# NBA-Playoffs-Database-Final-Project
This is a database for the NBA 2023_2024 Playoffs. I got my data from general google searches, Kaggle.com, and basketballreference.com.
After getting the database server set up and working, run front-end.py on an IDE or terminal. All .sql and .csv files are provided.
Database details:

Entities + Attributes:

Player - S
PlayerID (PK)
First Name
Last Name
Age
Height
Weight
TeamID (FK)

Player Playoff Statistics - W
PlayerID (FK)
Point Per Game
Assists Per Game
Rebounds Per Game
Field Goal Percentage

Player News - S
NewsID (PK)
PlayerID (FK)
Article Title
Publish Date

Team - S
TeamID (PK)
Name
Location
Full Name
State
Founding Year
CoachID (FK)
StadiumID (FK)

Team Playoff Statistics - W
TeamID (FK)
Point Per Game
Assists Per Game
Rebounds Per Game
Field Goal Percentage

Head Coach - S
CoachID (PK)
First Name
Last Name

Stadium - S
StadiumID (PK)
Name
City
State
Size

Game Series - S
SeriesID (PK)
First Team ID (FK)
Second Team ID (FK)
Round
WinnerID (FK)
FirstTeamSeriesGamesWon
SecondTeamSeriesGamesWon


Relationships:
Player “Has” Player News
Player “Records” Player Statistics (W)
Player “Belongs To” Team
Team “Records” Team Statistics (W)
Team “Plays Home Games At” Stadium
Head Coach “Coaches” Team
Team “Occurs Between” Game Series
Team “Wins” Game Series
