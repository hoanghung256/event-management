GO
/*
<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
<<<<<<<<<< BEGIN: CREATE DATABASE <<<<<<<<<<
<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
*/
	IF NOT EXISTS(SELECT * FROM sys.databases WHERE name = 'EventManagement')
		CREATE DATABASE [EventManagement];
/*
<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
<<<<<<<<<< END: CREATE DATABASE <<<<<<<<<<
<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
*/
GO
USE [EventManagement];
GO
/*
<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
<<<<<<<<<< BEGIN: RESET DATABASE <<<<<<<<<<
<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
*/
	DECLARE @Sql NVARCHAR(500) DECLARE @Cursor CURSOR

	SET @Cursor = CURSOR FAST_FORWARD FOR
	SELECT DISTINCT sql = 'ALTER TABLE [' + tc2.TABLE_SCHEMA + '].[' +  tc2.TABLE_NAME + '] DROP [' + rc1.CONSTRAINT_NAME + '];'
	FROM INFORMATION_SCHEMA.REFERENTIAL_CONSTRAINTS rc1
	LEFT JOIN INFORMATION_SCHEMA.TABLE_CONSTRAINTS tc2 ON tc2.CONSTRAINT_NAME =rc1.CONSTRAINT_NAME

	OPEN @Cursor FETCH NEXT FROM @Cursor INTO @Sql

	WHILE (@@FETCH_STATUS = 0)
	BEGIN
	Exec sp_executesql @Sql
	FETCH NEXT FROM @Cursor INTO @Sql
	END

	CLOSE @Cursor DEALLOCATE @Cursor
	GO
	/* */
	DECLARE @tableName NVARCHAR(MAX)
	DECLARE tableCursor CURSOR FOR
	SELECT name
	FROM sys.tables

	OPEN tableCursor
	FETCH NEXT FROM tableCursor INTO @tableName

	WHILE @@FETCH_STATUS = 0
	BEGIN
		DECLARE @sql NVARCHAR(MAX)
		SET @sql = N'DROP TABLE ' + QUOTENAME(@tableName)
		EXEC sp_executesql @sql
		FETCH NEXT FROM tableCursor INTO @tableName
	END

	CLOSE tableCursor
	DEALLOCATE tableCursor
/*
>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
>>>>>>>>>> END: RESET DATABASE >>>>>>>>>>
>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
*/
GO
/*
<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
<<<<<<<<<< BEGIN: TABLES <<<<<<<<<<
<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
*/
CREATE TABLE [User] (
	[id] INT IDENTITY(1, 1),
	[fullname] NVARCHAR(50),
	[studentId] VARCHAR(8),
	[email] NVARCHAR(30) NOT NULL UNIQUE,
	[password] NVARCHAR(32) NOT NULL,
	[avatarPath] NVARCHAR(MAX),

	CONSTRAINT PK_User PRIMARY KEY ([id])
);

CREATE TABLE [EventType] (
	[id] INT IDENTITY(1, 1),
	[typeName] NVARCHAR(100),
	[description] NVARCHAR(1000),

	CONSTRAINT PK_EventType PRIMARY KEY ([id])
);

CREATE TABLE [EventLocation] (
	[id] INT IDENTITY(1, 1),
	[locationDescription] NVARCHAR(1000),

	CONSTRAINT PK_EventLocation PRIMARY KEY ([id])
);

CREATE TABLE [Organizer] (
	[id] INT IDENTITY(1, 1),
	[acronym] NVARCHAR(20) NOT NULL UNIQUE,
	[fullname] NVARCHAR(200) NOT NULL,
	[description] NVARCHAR(2000),
	[email] NVARCHAR(30) NOT NULL UNIQUE,
	[password] NVARCHAR(32) NOT NULL,
	[avatarPath] NVARCHAR(MAX),
	[isAdmin] BIT DEFAULT(0),

	CONSTRAINT PK_Organizer PRIMARY KEY ([id]),
);

CREATE TABLE [Event] (
	[id] INT IDENTITY(1, 1),
	[organizerId] INT,
	[fullname] NVARCHAR(200),
	[avatarPath] NVARCHAR(MAX),
	[description] NVARCHAR(MAX),
	[typeId] INT,
	[locationId] INT,
	[dateOfEvent] DATE,
	[startTime] TIME,
	[endTime] TIME,
	[guestRegisterLimit] INT,
	[registerDeadline] DATETIME,
	[guestAttendedCount] INT
		
	CONSTRAINT PK_Event PRIMARY KEY ([id]),
	FOREIGN KEY ([organizerId]) REFERENCES [Organizer]([id]),
	FOREIGN KEY (typeId) REFERENCES [EventType]([id]),
	FOREIGN KEY (locationId) REFERENCES [EventLocation]([id])
);

CREATE TABLE [OrganizerImage] (
	[id] INT IDENTITY(1, 1),
	[organizerId] INT,
	[path] INT,
	[type] NVARCHAR(50),

	CONSTRAINT PK_OrganizerImage PRIMARY KEY ([id]),
	FOREIGN KEY ([organizerId]) REFERENCES [Organizer]([id])
);

CREATE TABLE [EventImage] (
	[id] INT IDENTITY(1, 1),
	[eventId] INT,
	[path] NVARCHAR(MAX),

	CONSTRAINT PK_EventImage PRIMARY KEY ([id]),
	FOREIGN KEY ([eventId]) REFERENCES [Event]([id]),
);

CREATE TABLE [File] (
	[id] INT IDENTITY(1, 1),
	[submitterId] INT,
	[fileType] NVARCHAR(30), --'REPORT' or 'PLAN'
	[path] NVARCHAR(MAX),

	CONSTRAINT PK_File PRIMARY KEY ([id]),
	FOREIGN KEY ([submitterId]) REFERENCES [Organizer]([id]),
);

CREATE TABLE [Notification] (
	[id] INT IDENTITY(1, 1),
	[senderId] INT,
	[content] NVARCHAR(500),
<<<<<<< HEAD
	[sendingTime] DATETIME DEFAULT GETDATE(),
=======
>>>>>>> master

	CONSTRAINT PK_Notification PRIMARY KEY ([id]),
	FOREIGN KEY ([senderId]) REFERENCES [Organizer]([id]),
);

CREATE TABLE [NotificationReceiver] (
	[notificationId] INT,
	[receiverId] INT,

	CONSTRAINT PK_NotificationReceiver PRIMARY KEY ([notificationId], [receiverId]),
	FOREIGN KEY ([receiverId]) REFERENCES [User]([id]),
	FOREIGN KEY ([notificationId]) REFERENCES [Notification]([id]),
);

CREATE TABLE [EventCollaborator] (
	[studentId] INT,
	[eventId] INT,

	CONSTRAINT PK_EventCollaborator PRIMARY KEY ([studentId], [eventId]),
	FOREIGN KEY ([studentId]) REFERENCES [User]([id]),
	FOREIGN KEY ([eventId]) REFERENCES [Event]([id]),
);

CREATE TABLE [EventGuest] (
	[studentId] INT,
	[eventId] INT,

	CONSTRAINT PK_EventGuest PRIMARY KEY ([studentId], [eventId]),
	FOREIGN KEY ([studentId]) REFERENCES [User]([id]),
	FOREIGN KEY ([eventId]) REFERENCES [Event]([id]),
);

CREATE TABLE [Feedback] (
	[guestId] INT,
	[eventId] INT,
	[content] NVARCHAR(1000),

	CONSTRAINT PK_Feedback PRIMARY KEY ([guestId], [eventId]),
	FOREIGN KEY ([guestId]) REFERENCES [User]([id]),
	FOREIGN KEY ([eventId]) REFERENCES [Event]([id]),
);

CREATE TABLE [Follow] (
	[followerId] INT, -- User who follow
	[followedId] INT, -- Organizer who be followed

	CONSTRAINT PK_Follow PRIMARY KEY ([followerId], [followedId]),
	FOREIGN KEY ([followerId]) REFERENCES [User]([id]),
	FOREIGN KEY ([followedId]) REFERENCES [Organizer]([id]),
);
/*
>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
>>>>>>>>>> END: TABLES >>>>>>>>>>
>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
*/
GO
/*
<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
<<<<<<<<<< BEGIN:TRIGGER <<<<<<<<<<
<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
*/
-- trigger count Event.guestAttendedCount when new record inserted into EventGuest table	
/*
>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
>>>>>>>>>> END: TRIGGERS >>>>>>>>>>
>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
*/
GO
/*
<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
<<<<<<<<<< BEGIN: EXAMPLE DATA <<<<<<<<<<
<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
*/
INSERT INTO [User] ([fullname], [studentId], [email], [password], [avatarPath])
VALUES
('Hoang Vu Hung', 'DE180038', 'hunghvde180038@fpt.edu.vn', '123', NULL),
('Nguyen Quoc Anh', 'DE180064', 'anhnqde180064@fpt.edu.vn', '123', NULL),
('Nguyen Minh Thang', 'DE180145', 'thangnmde180145@fpt.edu.vn', '123', NULL),
('Huynh Viet Khiem', 'DE180067', 'khiemhvde180067@fpt.edu.vn', '123', NULL),
('Dinh Kim Tu', 'DE180052', 'tudkde180052@fpt.edu.vn', '123', NULL),
('Trinh Ba Hoang Huy', 'DE180057', 'huytbhde180057@fpt.edu.vn', '123', NULL);


INSERT INTO [Organizer] ([acronym], [fullname], [description], [email], [password], [avatarPath], [isAdmin])
VALUES
<<<<<<< HEAD
('ICPDP Department', 'Study Overseas & Personal Development with FPTU Danang', 'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.', 'icpdp@gmail.com', '123', NULL, 1),
('FU - Dever', 'FPT University Programming Club', 'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.', 'club.dever@gmail.com', '123', NULL, 0),
('TIA', 'Traditional Instrument Abide Club', 'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.', 'tia@gmail.com', '123', NULL, 0),
('FUFC', 'FPT University Football Club', 'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.', 'fufc@gmail.com', '123', NULL, 0),
('FUV', 'FPT University Volleyball Club', 'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.', 'fudavolleyball@gmail.com', '123', NULL, 0);
=======
('ICPDP Department', 'Study Overseas & Personal Development with FPTU Danang', 'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.', 'icpdp@gmail.com', '123', 'assets\img\user\1\logo-icpdp.jpg', 1),
('FU - Dever', 'FPT University Programming Club', 'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.', 'club.dever@gmail.com', '123', 'assets\img\user\1\logo-club-dever.jpg', 0),
('TIA', 'Traditional Instrument Abide Club', 'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.', 'tia@gmail.com', '123', 'assets\img\user\1\logo-club-tia.jpg', 0),
('FUFC', 'FPT University Football Club', 'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.', 'fufc@gmail.com', '123', 'assets\img\user\1\logo-club-fufc.jpg', 0),
('FUV', 'FPT University Volleyball Club', 'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.', 'fudavolleyball@gmail.com', '123', 'assets\img\user\1\logo-club-fuv.jpg', 0);
>>>>>>> master

INSERT INTO [EventType] ([typeName], [description])
VALUES 
('WORKSHOP', 'A workshop for learning new skills'),
('SEMINAR', 'A seminar hosted by experts'),
('ACADEMIC', NULL),
('COMPETITION', NULL),
('SPORT', NULL);

INSERT INTO [EventLocation] ([locationDescription])
VALUES 
('Room 215 - Building Alpha'),
('Room 315 - Building Blpha'),
('Penrose Hall - Building Beta'),
('Main yard');

DECLARE @i INT = 1;
DECLARE @randomOrganizerId INT;

WHILE @i <= 500
BEGIN
    -- Generate a random organizerId between 1 and 4
    SET @randomOrganizerId = 1 + FLOOR(RAND() * (5 - 1 + 1));

    INSERT INTO [Event] 
    ([organizerId], [fullname], [description], [typeId], [locationId], [dateOfEvent], [startTime], [endTime], [guestRegisterLimit], [registerDeadline], [guestAttendedCount])
    VALUES 
    (
        @randomOrganizerId,
        'Event ' + CAST(@i AS NVARCHAR(10)),
        'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.',
        (SELECT TOP 1 [id] FROM [EventType] ORDER BY NEWID()),
        (SELECT TOP 1 [id] FROM [EventLocation] ORDER BY NEWID()),
		CAST(DATEADD(DAY, @i, GETDATE()) AS DATE),
		CAST(DATEADD(DAY, 8, GETDATE()) AS TIME),
		CAST(DATEADD(DAY, 12, GETDATE()) AS TIME),
        100,
        DATEADD(DAY, @i, GETDATE()),
		50
    );

    SET @i = @i + 1;
END;

<<<<<<< HEAD
=======
INSERT INTO [EventGuest] (studentId, eventId)
VALUES 
    (1, 1),
    (1, 2),
    (2, 1),
    (3, 2),
    (4, 3);


DECLARE @a INT = 1;

WHILE @a <= 200
BEGIN
    INSERT INTO [EventGuest] (studentId, eventId)
    VALUES 
        (FLOOR(1 + (RAND() * 6)),
        FLOOR(1 + (RAND() * 100))
		);
		
    SET @a = @a + 1;
END

>>>>>>> master
/*
>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
>>>>>>>>>> END: EXAMPLE DATA >>>>>>>>>>
>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
*/

<<<<<<< HEAD
select * from [Notification]
 SELECT n.id, n.senderId, n.content, n.sendingTime, o.acronym AS senderName
                FROM Notification n 
                JOIN NotificationReceiver nr ON n.id = nr.notificationId
                JOIN Organizer o ON n.senderId = o.id
                WHERE nr.receiverId = 1

INSERT INTO Notification (senderId, content)
VALUES
(1, 'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.')

INSERT INTO NotificationReceiver (notificationId, receiverId)
VALUES
(67, 1)
=======
SELECT 
    E.fullname AS eventName,
    O.acronym AS organizerName,
	O.avatarPath AS avatarPath,
    E.dateOfEvent AS eventDate
FROM 
    [EventGuest] EG
JOIN 
    [Event] E ON EG.eventId = E.id
JOIN 
    [Organizer] O ON E.organizerId = O.id
JOIN 
    [User] U ON EG.studentId = U.id
WHERE 
    EG.studentId = 4 
    AND E.dateOfEvent < '2024-10-31'
ORDER BY 
    E.dateOfEvent DESC;
>>>>>>> master
