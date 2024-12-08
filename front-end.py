# cd "\Users\griff\Desktop\Database Systems - Final Project"
# python3 front-end.py

# password is root

# imports
import mysql.connector as mysql
from mysql.connector import Error
from time import sleep

# global variables
main_menu = "\nType The Number To Select The Option\n\nFull Customized Options:\n0. Enter Custom User Query\n\nSimple Information Queries:\n1. All Team's Head Coach and Stadium\n2. The Amount Of Game Series Each Team Won (minimum 1)\n3. Add Player DeAndre Jordan\n4. Delete Player DeAndre Jordan\n\nQueries With Parameter Customization:\n5. All Players Taller Than __ Inches\n6. All Players Who Averaged More Than __ Points, __ Assists, and __ Rebounds\n7. Change the PlayerID of a Player\n8. Delete An Article In Player News\n\nView Full Tables:\n9.  Player\n10. Player News\n11. Player Statistics\n12. Team\n13. Team Statistics\n14. Game Series\n15. Head Coach\n16. Stadium\n\nEnter 'quit' to exit\n"

def connect(password_string):
    try:
        db = mysql.connect(
            host = "localhost",
            user = "root",
            passwd = password_string,
            database = "nba_playoffs_2023_2024"
        )
        return db
    except Error as e:
        print(f"Error: {e}")
        return None

def queryloop(db):
    print("Welcome To the NBA Playoffs 2023-2024 Database")
    print(main_menu)
    while True:
        user_input = input("Select an option: ")
        if user_input == "quit":
            break
        elif user_input == "0":
            userQuery(db)
        elif user_input == "1":
            coachAndStadium(db)
        elif user_input == "2":
            seriesWonByTeam(db)
        elif user_input == "3":
            addDeAndreJordan(db)
        elif user_input == "4":
            deleteDeAndreJordan(db)
        elif user_input == "5":
            tallerThan(db)
        elif user_input == "6":
            averagedThan(db)
        elif user_input == "7":
            changePlayerID(db)
        elif user_input == "8":
            deleteArticle(db)
        elif user_input == "9":
            playerTable(db)
        elif user_input == "10":
            playerNewsTable(db)
        elif user_input == "11":
            playerStatisticsTable(db)
        elif user_input == "12":
            teamTable(db)
        elif user_input == "13":
            teamStatisticsTable(db)
        elif user_input == "14":
            gameSeriesTable(db)
        elif user_input == "15":
            headCoachTable(db)
        elif user_input == "16":
            stadiumTable(db)
        else:
            print("Please Insert Valid Input")
            sleep(1)

def userQuery(db):
    while True:
        query = input("Enter a Valid SQL Query (or 'quit' to return to the main menu): ")
        if query == "quit":
            print(main_menu)
            return
        try:
            cursor = db.cursor()
            cursor.execute(query)
            records = cursor.fetchall()
            if records:
                for record in records:
                    print(record)
            else:
                print("Query executed successfully but returned no results.")
            # to commit changes - db.commit()
            break
        except mysql.Error as err:
            print(f"Database Error: {err}. Please try again.")
        except Exception as e:
            print(f"Unexpected Error: {e}. Please try again.")
    cursor.close()
    sleep(2)
    returnToMenu()

def deleteArticle(db):
    print("\nPlayer News Table (NewsID, Article Title, Publish Date, PlayerID):")
    cursor = db.cursor()
    query = "SELECT * FROM Player_News"
    cursor.execute(query)
    records = cursor.fetchall()
    for record in records:
        print(record)
    sleep(1)
    while True:
        newsID = input("Enter the NewsID of the Article You Want to Delete:")
        if newsID.isdigit() and int(newsID) >= 1:
            break
        else:
            print("Invalid input. Please enter a positive integer.")
            sleep(1)
    query2 = "DELETE FROM Player_News WHERE NewsID =  %s"
    data = (newsID,)
    cursor.execute(query2, data)
    sleep(1)
    print("Deletion Successful!")
    # to commit changes - db.commit()
    cursor.close()
    sleep(2)
    returnToMenu()

def changePlayerID(db):
    while True:
        player = input("Enter the Full Name of the player whose PlayerID you want to change (format= FirstName LastName):")
        try:
            firstname, lastname = player.strip().split(maxsplit=1)
            break
        except ValueError:
            print("Invalid format. Please enter FirstName and LastName.")
            sleep(1)
    while True:
        newID = input("Enter New PlayerID:")
        if newID.isdigit() and int(newID) >= 1:
            break
        else:
            print("Invalid input. Please enter a positive integer.")
            sleep(1)
    cursor = db.cursor()
    query = "UPDATE Player SET PlayerID = %s WHERE FirstName = %s AND LastName = %s"
    data = (newID,firstname,lastname,)
    cursor.execute(query,data)
    query2 = "SELECT FirstName, LastName, PlayerID FROM Player WHERE PlayerID = %s"
    data2 = (newID,)
    cursor.execute(query2,data2)
    records = cursor.fetchall()
    for record in records:
        print(record)
    # to commit changes - db.commit()
    cursor.close()
    sleep(2)
    returnToMenu()

def stadiumTable(db):
    print("\nStadium Table (StadiumID, Name, City, State, Size):")
    cursor = db.cursor()
    query = "SELECT * FROM Stadium"
    cursor.execute(query)
    records = cursor.fetchall()
    for record in records:
        print(record)
    cursor.close()
    sleep(2)
    returnToMenu()

def headCoachTable(db):
    print("\nHead Coach Table (CoachID, First Name, Last Name, Full Name):")
    cursor = db.cursor()
    query = "SELECT * FROM HeadCoach"
    cursor.execute(query)
    records = cursor.fetchall()
    for record in records:
        print(record)
    cursor.close()
    sleep(2)
    returnToMenu()

def gameSeriesTable(db):
    print("\nGame Series Table (SeriesID, Round, First Team Series Games Won, Second Team Series Games Won, FirstTeamID, SecondTeamID, WinningTeamID):")
    cursor = db.cursor()
    query = "SELECT * FROM Game_Series"
    cursor.execute(query)
    records = cursor.fetchall()
    for record in records:
        print(record)
    cursor.close()
    sleep(2)
    returnToMenu()

def teamStatisticsTable(db):
    print("\nTeam Statistics Table (TeamID, Points Per Game, Assists Per Game, Rebounds Per Game, Field Goal Percentage):")
    cursor = db.cursor()
    query = "SELECT * FROM Team_Statistics"
    cursor.execute(query)
    records = cursor.fetchall()
    for record in records:
        print(record)
    cursor.close()
    sleep(2)
    returnToMenu()

def teamTable(db):
    print("\nTeam Table (TeamID, Name, Location, Full Name, State, Founding Year, CoachID, StadiumID):")
    cursor = db.cursor()
    query = "SELECT * FROM Team"
    cursor.execute(query)
    records = cursor.fetchall()
    for record in records:
        print(record)
    cursor.close()
    sleep(2)
    returnToMenu()

def playerNewsTable(db):
    print("\nPlayer News Table (NewsID, Article Title, Publish Date, PlayerID):")
    cursor = db.cursor()
    query = "SELECT * FROM Player_News"
    cursor.execute(query)
    records = cursor.fetchall()
    for record in records:
        print(record)
    cursor.close()
    sleep(2)
    returnToMenu()

def playerStatisticsTable(db):
    print("\nPlayer Statistics Table (PlayerID, Points Per Game, Assists Per Game, Rebounds Per Game, Field Goal Percentage):")
    cursor = db.cursor()
    query = "SELECT * FROM Player_Statistics"
    cursor.execute(query)
    records = cursor.fetchall()
    for record in records:
        print(record)
    cursor.close()
    sleep(2)
    returnToMenu()

def averagedThan(db):
    points_input = input("How Many Points: ")
    assists_input = input("How Many Assists: ")
    rebounds_input = input("How Many Rebounds: ")
    cursor = db.cursor()
    query = "SELECT FirstName, LastName, Points_Per_Game, Assists_Per_Game, Rebounds_Per_Game FROM Player INNER JOIN Player_Statistics ON Player.PlayerID = Player_Statistics.PlayerID WHERE Player.PlayerID IN (SELECT PlayerID FROM Player_Statistics WHERE Points_Per_Game >= %s AND Assists_Per_Game >= %s AND Rebounds_Per_Game >= %s)"
    data = (points_input,assists_input,rebounds_input,)
    cursor.execute(query,data)
    records = cursor.fetchall()
    print("(FirstName, LastName, PPG, APG, RPG)")
    for record in records:
        print(record)
    cursor.close()
    sleep(2)
    returnToMenu()

def tallerThan(db):
    height_input = "Enter A Height (in inches) to see all Players Taller Than That Height:"
    cursor = db.cursor()
    height = input(height_input)
    query = "SELECT FirstName, LastName, Height FROM Player WHERE Height >= %s"
    data = (height,)
    cursor.execute(query,data)
    records = cursor.fetchall()
    for record in records:
        print(record)
    cursor.close()
    sleep(2)
    returnToMenu()

def returnToMenu():
    while True:
        return_input = input("Enter 'q' to return to the Main Menu\n")
        if return_input.lower() == "q":
            print(main_menu)
            break

def coachAndStadium(db):
    print("\nAll Team's Head Coach and Stadium:")
    cursor = db.cursor()
    query = "SELECT Team.FullName AS Team, HeadCoach.FullName AS HeadCoach, Stadium.Name AS Stadium FROM Team INNER JOIN HeadCoach ON Team.CoachID = HeadCoach.CoachID INNER JOIN Stadium ON Team.StadiumID = Stadium.StadiumID"
    cursor.execute(query)
    records = cursor.fetchall()
    for record in records:
        print(record)
    cursor.close()
    sleep(2)
    returnToMenu()

def seriesWonByTeam(db):
    print("\nGame Series Won By Team:")
    cursor = db.cursor()
    query = "SELECT Team.FullName AS Team, COUNT(WinningTeamID) AS Number_Of_Series_Won FROM Team INNER JOIN Game_Series ON Team.TeamID = Game_Series.WinningTeamID GROUP BY WinningTeamID ORDER BY Number_Of_Series_Won DESC"
    cursor.execute(query)
    records = cursor.fetchall()
    for record in records:
        print(record)
    cursor.close()
    sleep(2)
    returnToMenu()

def addDeAndreJordan(db):
    print("\nAdding DeAndre Jordan...")
    sleep(1)
    cursor = db.cursor()
    query = "INSERT INTO Player (FirstName, LastName, Age, Height, Weight, TeamID) VALUES ('DeAndre', 'Jordan', 35, 83, 265, 15)"
    queryset = "SET @PlayerID = LAST_INSERT_ID()" 
    query2 = "INSERT INTO Player_Statistics (PlayerID, Points_Per_Game, Assists_Per_Game, Rebounds_Per_Game, Field_Goal_Percentage) VALUES (@PlayerID, 2.0, 0.0, 1.5, 50.0)"
    cursor.execute(query)
    cursor.execute(queryset)
    cursor.execute(query2)
    cursor.close()
    print("Success! DeAndre Jordan Has Been Added")
    sleep(2)
    returnToMenu()

def deleteDeAndreJordan(db):
    print("\nDeleting DeAndre Jordan...")
    sleep(1)
    cursor = db.cursor()
    query = "DELETE FROM Player WHERE FirstName = 'DeAndre' AND LastName = 'Jordan'"
    cursor.execute(query)
    cursor.close()
    print("Success! DeAndre Jordan Has Been Deleted")
    sleep(2)
    returnToMenu()

def playerTable(db):
    print("\nPlayer Table (PlayerID, FirstName, LastName, Age, Height, Weight, TeamID):")
    cursor = db.cursor()
    query = "SELECT * FROM Player"
    cursor.execute(query)
    records = cursor.fetchall()
    for record in records:
        print(record)
    cursor.close()
    sleep(2)
    returnToMenu()

def main():
    print("Connecting to the NBA Playoffs 2023-2024 Database...\n")
    sleep(1)
    password = input("Enter Password: ")
    sleep(1)
    db = connect(password)
    if db:
        print("Connection successful!\n")
        sleep(1)
        queryloop(db)
        db.close
    else:
        print("Failed to connect to the database.")

# Ensure the main function runs only when the script is executed directly
if __name__ == "__main__":
    main()
