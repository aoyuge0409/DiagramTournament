Use Master
GO

DROP TABLE IF EXISTS Tournament_CA_Andressa
go
Create DataBase Tournament_CA_Andressa
go
USE Tournament_CA_Andressa
GO

DROP SCHEMA IF EXISTS Tournaments;
go
CREATE SCHEMA Tournaments; 
GO

--CREATE TABLES

CREATE TABLE Tournaments.Tournament (
    TournamentId INT constraint PKTournament  PRIMARY KEY IDENTITY (1, 1),
    TournamentName VARCHAR (50) NOT NULL,
    DescriptionId VARCHAR (100) NOT NULL,
    TournamentAddress VARCHAR (100) NOT NULL,
    TournamentDate Date NOT NULL,
	RegistrationCost Money NOT NULL,
	SportType varchar (40) NOT NULL,
);

CREATE TABLE Tournaments.Tournament (
    TournamentId INT constraint PKTournament  PRIMARY KEY IDENTITY (1, 1),
    TournamentName VARCHAR (50) NOT NULL,
    DescriptionId VARCHAR (100) NOT NULL,
    TournamentAddress VARCHAR (100) NOT NULL,
    TournamentDate Date NOT NULL,
	RegistrationCost Money NOT NULL,
	SportType varchar (40) NOT NULL,
);
