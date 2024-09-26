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
		[studentId] VARCHAR(8) UNIQUE,
		[email] NVARCHAR(30) UNIQUE,
		[password] NVARCHAR(32),
		[avatarPath] NVARCHAR(MAX),
		[isClubPresident] BIT DEFAULT(0),
		[isAdmin] BIT DEFAULT(0)

		CONSTRAINT PK_User PRIMARY KEY ([id])
	);

	CREATE TABLE [EventType] (
		[id] INT IDENTITY(1, 1),
		[typeName] NVARCHAR(100),
		[description] NVARCHAR(500),

		CONSTRAINT PK_EventType PRIMARY KEY ([id])
	);

	CREATE TABLE [EventLocation] (
		[id] INT IDENTITY(1, 1),
		[locationDescription] NVARCHAR(200),

		CONSTRAINT PK_EventLocation PRIMARY KEY ([id])
	);

	CREATE TABLE [Event] (
		[id] INT IDENTITY(1, 1),
		[hostId] INT,
		[fullname] NVARCHAR(200),
		[description] NVARCHAR(MAX),
		[typeId] int,
		[locationId] int,
		[startDate] DATETIME,
		[endDate] DATETIME,
		[guestRegisterLimit] INT,
		[registerDeadline] DATETIME,
		
		CONSTRAINT PK_Event PRIMARY KEY ([id]),
		FOREIGN KEY ([hostId]) REFERENCES [User]([id]),
		FOREIGN KEY (typeId) REFERENCES [EventType]([id]),
		FOREIGN KEY (locationId) REFERENCES [EventLocation]([id])
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
		FOREIGN KEY ([submitterId]) REFERENCES [User]([id]),
	);

	CREATE TABLE [Notification] (
		[id] INT IDENTITY(1, 1),
		[senderId] INT,
		[content] NVARCHAR(500),

		CONSTRAINT PK_Notification PRIMARY KEY ([id]),
		FOREIGN KEY ([senderId]) REFERENCES [User]([id]),
	);

	CREATE TABLE [NotificationReceiver] (
		[notificationId] INT,
		[receiverId] INT,

		CONSTRAINT PK_NotificationReceiver PRIMARY KEY ([notificationId], [receiverId]),
		FOREIGN KEY ([receiverId]) REFERENCES [User]([id]),
		FOREIGN KEY ([notificationId]) REFERENCES [Notification]([id]),
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
/*
>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
>>>>>>>>>> END: EXAMPLE DATA >>>>>>>>>>
>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
*/

INSERT INTO [User] (fullname, studentId, email, [password], avatarPath, isClubPresident, isAdmin)
VALUES 
('Nguyen Van A', 'SV123456', 'nguyenvana@example.com', 'hashed_password_1', '/avatars/user1.png', 1, 0);

INSERT INTO [EventType] (typeName, description)
VALUES 
('Workshop', 'A session focused on hands-on practice and learning.');

INSERT INTO [EventLocation] (locationDescription)
VALUES 
('Main Hall - Building A');

INSERT INTO [Event] (hostId, fullname, description, typeId, locationId, startDate, endDate, guestRegisterLimit, registerDeadline)
VALUES 
(1, 'Introduction to AI', 'This workshop will cover the basics of Artificial Intelligence.', 1, 1, '2024-10-01 09:00:00', '2024-10-01 12:00:00', 100, '2024-09-25 23:59:59');

INSERT INTO [EventImage] (eventId, path)
VALUES 
(8, '/event-management/src/main/webapp/assets/img/user/1/avataTest.png');

INSERT INTO [File] (submitterId, fileType, path)
VALUES 
(1, 'REPORT', '/files/reports/ai_workshop_report.pdf');

INSERT INTO [Notification] (senderId, content)
VALUES 
(1, 'The AI Workshop is starting soon. Please prepare.');

INSERT INTO [NotificationReceiver] (notificationId, receiverId)
VALUES 
(1, 1);

SELECT e.id, e.fullname, e.description, et.typeName, el.locationDescription, e.startDate, e.endDate, e.registerDeadline 
FROM Event e
JOIN EventType et ON e.typeId = et.id
JOIN EventLocation el ON e.locationId = el.id
WHERE e.id = 8;