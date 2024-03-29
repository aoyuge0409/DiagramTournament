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


CREATE TABLE Tournaments.Participant(
	ParticipantId INT constraint PKEmployees PRIMARY KEY IDENTITY (1,1),
	NameId VARCHAR (20) NOT NULL,
	BirthDate DATE,
	EmailAddress VARCHAR (60),
	ParticipantPassword VARCHAR (20) NOT NULL,
);


CREATE TABLE Tournaments.Payment (
    PaymentId INT constraint PKPayment  PRIMARY KEY IDENTITY (1, 1),
    AmountPaid Money NOT NULL,
    TournamentId int NOT NULL,
    ParticipantId int NOT NULL,
	FOREIGN KEY (TournamentId) REFERENCES Tournaments.Tournament(TournamentId),
    FOREIGN KEY (ParticipantId) REFERENCES Tournaments.Participant(ParticipantId),
);

ALTER TABLE Tournaments.Payment
add CONSTRAINT ConsPaymentDate -- random name using constraint in it
DEFAULT GETDATE() for PaymentDate

--Participantes must be 16 or older
ALTER TABLE Tournaments.Participant --random name using birthday in it
ADD CONSTRAINT CHK_BirthDate CHECK (GETDATE()-convert(DateTime, BirthDate) > = 16);
GO  

-- FUNCTIONS

CREATE FUNCTION Tournaments.FormatDate -- random name for function for specific format required
(	@Date DATE
)
RETURNS varchar (50) --cuz numbers and letters
WITH RETURNS NULL ON NULL INPUT, 
	SCHEMABINDING 
AS
	BEGIN -- insert logic between Begin and End
		DECLARE @OutputMonth varchar (100)
		DECLARE @OutputDay varchar (20)
		DECLARE @OutputYear VARCHAR (15)
		SELECT @OutputMonth = FORMAT(@DATE,'MMMM')
		SELECT @OutputDay = DAY(@DATE)
		SELECT @OutputYear = YEAR(@DATE)
		RETURN @OutputMonth +' '+ @OutputDay +' '+ @OutputYear
			END;
	GO

	--store procedure

	SELECT TOURNAMENTS.FormatDate (GETDATE())

	GO

	CREATE PROCEDURE Tournaments.ParticipantInsert @Name varchar(20), @BirthDate DATE, 
@EmailAddress varchar(60), @Password varchar(20)
AS

INSERT INTO Tournaments.Participant(NameId, BirthDate, EmailAddress, ParticipantPassword)
VALUES (@Name, @BirthDate, @EmailAddress, @Password);
GO

EXEC Tournaments.ParticipantInsert 'Josh' , 'May 24 1980' ,'hello@gmail.com' ,'1234'

SELECT * FROM Tournaments.Participant

GO

CREATE PROCEDURE Tournaments.ParticipantUpdate @ParticipantId int, @Name varchar(20), @BirthDate DATE, 
@EmailAddress varchar(60), @Password varchar(20)
AS

UPDATE Tournaments.Participant
SET NameId = @Name, BirthDate = @BirthDate, EmailAddress = @EmailAddress, ParticipantPassword = @Password
WHERE ParticipantId = @ParticipantId;
GO

--to test if it is working

EXEC Tournaments.ParticipantUpdate 1, 'Josh' , 'May 20 1965' ,'hello@gmail.com' ,'1234'

SELECT * FROM Tournaments.Participant

GO

CREATE PROCEDURE Tournaments.ParticipantDelete @ParticipantId int 
AS
DELETE FROM Tournaments.Participant
WHERE ParticipantId = @ParticipantId;
GO

EXEC Tournaments.ParticipantDelete 1 

SELECT * FROM Tournaments.Participant

