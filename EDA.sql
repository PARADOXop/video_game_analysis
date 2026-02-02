select name
from sys.databases;

if not exists (select name from sys.databases where name = 'videogame')
BEGIN
create database videogame
END;

