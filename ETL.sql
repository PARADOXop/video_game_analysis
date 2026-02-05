/* select name
from sys.databases;

if not exists (select name from sys.databases where name = 'videogames')
BEGIN
create database videogames
END;
SELECT name FROM sys.tables;   
*/

use videogames;

--drop database videogames;

select publisher
from game_publisher
where publisher is null;




---------EVALUATION------------------------
-- Games table
SELECT title, year, COUNT(*) 
FROM games
GROUP BY title, year
HAVING COUNT(*) > 1;

-- Sales table
SELECT title, year, COUNT(*) 
FROM sales
GROUP BY title, year
HAVING COUNT(*) > 1;

SELECT COUNT(*) AS matched_rows
FROM games g
INNER JOIN sales s
ON g.title = s.title AND g.year = s.year;


-- Games without sales
SELECT COUNT(*) 
FROM games g
LEFT JOIN sales s
ON g.title = s.title AND g.year = s.year
WHERE s.title IS NULL;

-- Sales without games
SELECT COUNT(*) 
FROM sales s
LEFT JOIN games g
ON s.title = g.title AND s.year = g.year
WHERE g.title IS NULL;


-- Example: check game_teams referencing games
SELECT * 
FROM game_teams gt
LEFT JOIN games g
ON gt.title = g.title AND gt.year = g.year
WHERE g.title IS NULL;







select *
from game_platform







---------------------- Alter tables and Create Primary ---------------------------
-- 1. game table
ALTER TABLE games
ALTER COLUMN title VARCHAR(255) NOT NULL;

ALTER TABLE games
ALTER COLUMN year INT NOT NULL;

ALTER TABLE games
ADD CONSTRAINT PK_games PRIMARY KEY (title, year);
---------------------------------------------------------------------------------------------------
-- 2. sales table
ALTER TABLE sales
ALTER COLUMN title VARCHAR(255) NOT NULL;
ALTER TABLE sales
ALTER COLUMN year INT NOT NULL;

ALTER TABLE sales
ADD CONSTRAINT PK_sales PRIMARY KEY (title, year);
---------------------------------------------------------------------------------------------------
-- 3. teams table

ALTER TABLE game_teams
ALTER COLUMN title VARCHAR(255) NOT NULL;
ALTER TABLE game_teams
ALTER COLUMN year INT NOT NULL
ALTER TABLE game_teams
ALTER COLUMN team varchar(100) NOT NULL;

ALTER TABLE game_teams
ADD CONSTRAINT PK_game_teams PRIMARY KEY (title, year, team);
---------------------------------------------------------------------------------------------------

-- 4. genres table
ALTER TABLE game_genres
ALTER COLUMN title VARCHAR(255) NOT NULL;
ALTER TABLE game_genres
ALTER COLUMN year INT NOT NULL;
ALTER TABLE game_genres
ALTER COLUMN genre varchar(100) NOT NULL;
ALTER TABLE game_genres
ADD CONSTRAINT PK_game_genres PRIMARY KEY (title, year, genre);
---------------------------------------------------------------------------------------------------

-- 5. Platform table

select *
from game_platform
where platform is null;

ALTER TABLE game_platform
ALTER COLUMN title VARCHAR(255) NOT NULL;
ALTER TABLE game_platform
ALTER COLUMN year INT NOT NULL;
ALTER TABLE game_platform
ALTER COLUMN platform varchar(50) NOT NULL;
ALTER TABLE game_platform
ADD CONSTRAINT PK_game_platform PRIMARY KEY (title, year, platform);

---------------------------------------------------------------------------------------------------

--6. publisher table
ALTER TABLE game_publisher
ALTER COLUMN title VARCHAR(255) NOT NULL;
ALTER TABLE game_publisher
ALTER COLUMN year INT NOT NULL;
ALTER TABLE game_publisher
ALTER COLUMN publisher varchar(50) NOT NULL;
ALTER TABLE game_publisher
ADD CONSTRAINT PK_game_publisher PRIMARY KEY (title, year, publisher);

---------------------------------------------------------------------------------------------------
---------------------------------------------------------------------------------------------------
---------------------------------------------------------------------------------------------------


-- create foreign keys

-- Game Teams → Games
ALTER TABLE game_teams
ADD CONSTRAINT FK_game_teams_games
FOREIGN KEY (title, year) REFERENCES games(title, year);

-- Game Genres → Games
ALTER TABLE game_genres
ADD CONSTRAINT FK_game_genres_games
FOREIGN KEY (title, year) REFERENCES games(title, year);

-- Game Platform → Sales
ALTER TABLE game_platform
ADD CONSTRAINT FK_game_platform_sales
FOREIGN KEY (title, year) REFERENCES sales(title, year);

-- Game Publisher → Sales
ALTER TABLE game_publisher
ADD CONSTRAINT FK_game_publisher_sales
FOREIGN KEY (title, year) REFERENCES sales(title, year);



