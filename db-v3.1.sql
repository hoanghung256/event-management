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
CREATE TABLE [Student] (
	[id] INT IDENTITY(1, 1),
	[fullname] NVARCHAR(50),
	[studentId] VARCHAR(8) UNIQUE,
	[email] NVARCHAR(30) NOT NULL UNIQUE,
	[password] NVARCHAR(64) NOT NULL,
	[gender] NVARCHAR(6), -- MALE / FEMALE / OTHER
	[avatarPath] NVARCHAR(MAX),

	CONSTRAINT PK_Student PRIMARY KEY ([id])
);

CREATE TABLE [Category] (
	[id] INT IDENTITY(1, 1),
	[categoryName] NVARCHAR(100),
	[description] NVARCHAR(1000),

	CONSTRAINT PK_Category PRIMARY KEY ([id])
);

CREATE TABLE [Location] (
	[id] INT IDENTITY(1, 1),
	[locationName] NVARCHAR(100),
	[description] NVARCHAR(1000),

	CONSTRAINT PK_Location PRIMARY KEY ([id])
);

CREATE TABLE [Organizer] (
	[id] INT IDENTITY(1, 1),
	[acronym] NVARCHAR(20) NOT NULL UNIQUE,
	[fullname] NVARCHAR(200) NOT NULL,
	[categoryId] INT,
	[description] NVARCHAR(2000),
	[email] NVARCHAR(30) NOT NULL UNIQUE,
	[password] NVARCHAR(64) NOT NULL,
	[avatarPath] NVARCHAR(MAX),
	[coverPath] NVARCHAR(MAX),
	[followerCount] INT DEFAULT(0),
	[isAdmin] BIT DEFAULT(0),

	CONSTRAINT PK_Organizer PRIMARY KEY ([id]),
	FOREIGN KEY ([categoryId]) REFERENCES [Category]([id]),
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
	[status] NVARCHAR(10), --PENDING / APPROVED / REJECTED
	[guestRegisterLimit] INT,
	[collaboratorRegisterLimit] INT,
	[guestAttendedCount] INT DEFAULT (0),
	[guestRegisterCount] INT DEFAULT (0),
	[guestRegisterCancelCount] INT DEFAULT(0),
	[collaboratorRegisterCount] INT DEFAULT (0),
	[registerDeadline] DATETIME,

	CONSTRAINT PK_Event PRIMARY KEY ([id]),
	FOREIGN KEY ([organizerId]) REFERENCES [Organizer]([id]),
	FOREIGN KEY ([typeId]) REFERENCES [Category]([id]),
	FOREIGN KEY ([locationId]) REFERENCES [Location]([id])
);

CREATE TABLE [EventImage] (
	[id] INT IDENTITY(1, 1),
	[eventId] INT,
	[path] NVARCHAR(MAX),

	CONSTRAINT PK_EventImage PRIMARY KEY ([id]),
	FOREIGN KEY ([eventId]) REFERENCES [Event]([id])
);

CREATE TABLE [File] (
	[id] INT IDENTITY(1, 1),
	[submitterId] INT,
	[fileType] NVARCHAR(30), -- 'REPORT' or 'PLAN'
	[path] NVARCHAR(MAX),

	CONSTRAINT PK_File PRIMARY KEY ([id]),
	FOREIGN KEY ([submitterId]) REFERENCES [Organizer]([id])
);

CREATE TABLE [Notification] (
	[id] INT IDENTITY(1, 1),
	[senderId] INT,
	[title] NVARCHAR(100),
	[content] NVARCHAR(300),
	[sendingTime] DATETIME DEFAULT GETDATE(),

	CONSTRAINT PK_Notification PRIMARY KEY ([id]),
	FOREIGN KEY ([senderId]) REFERENCES [Organizer]([id])
);

CREATE TABLE [NotificationReceiver] (
	[notificationId] INT,
	[receiverId] INT,

	CONSTRAINT PK_NotificationReceiver PRIMARY KEY ([notificationId], [receiverId]),
	FOREIGN KEY ([receiverId]) REFERENCES [Student]([id]),
	FOREIGN KEY ([notificationId]) REFERENCES [Notification]([id])
);

CREATE TABLE [EventCollaborator] (
	[studentId] INT,
	[eventId] INT,
	[isCancel] INT DEFAULT(0)

	CONSTRAINT PK_EventCollaborator PRIMARY KEY ([studentId], [eventId]),
	FOREIGN KEY ([studentId]) REFERENCES [Student]([id]),
	FOREIGN KEY ([eventId]) REFERENCES [Event]([id])
);

CREATE TABLE [EventGuest] (
	[guestId] INT,
	[eventId] INT,
	[isRegistered] BIT DEFAULT(0),
	[isAttended] BIT DEFAULT(0),
	[isCancelRegister] BIT DEFAULT(0),

	CONSTRAINT PK_EventGuest PRIMARY KEY ([guestId], [eventId]),
	FOREIGN KEY ([guestId]) REFERENCES [Student]([id]),
	FOREIGN KEY ([eventId]) REFERENCES [Event]([id])
);

CREATE TABLE [Feedback] (
	[guestId] INT,
	[eventId] INT,
	[content] NVARCHAR(1000),

	CONSTRAINT PK_Feedback PRIMARY KEY ([guestId], [eventId]),
	FOREIGN KEY ([guestId]) REFERENCES [Student]([id]),
	FOREIGN KEY ([eventId]) REFERENCES [Event]([id])
);

CREATE TABLE [Follow] (
	[studentId] INT,
	[organizerId] INT,

	CONSTRAINT PK_Follow PRIMARY KEY ([studentId], [organizerId]),
	FOREIGN KEY ([studentId]) REFERENCES [Student]([id]),
	FOREIGN KEY ([organizerId]) REFERENCES [Organizer]([id])
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
-- Auto increase guestAttendedCount at Event table when guest check-in event that registered before
CREATE TRIGGER trg_IncreaseGuestCounts
ON [EventGuest]
AFTER UPDATE
AS
BEGIN
    UPDATE Event
    SET 
        guestAttendedCount = guestAttendedCount + (SELECT COUNT(*) FROM inserted WHERE isAttended = 1)
    WHERE id = (SELECT eventId FROM inserted WHERE isAttended = 1);
END;
GO

-- Auto increase guestRegisterCount at [Event] when guest register an event
-- Auto increase guestAttendedCount at [Event] when guest check-in an event that did not registered before
CREATE TRIGGER trg_UpdateGuestCounts
ON [EventGuest]
AFTER INSERT
AS
BEGIN
    UPDATE Event
    SET 
        guestRegisterCount = guestRegisterCount + (SELECT COUNT(*) FROM inserted WHERE isRegistered = 1),
        guestAttendedCount = guestAttendedCount + (SELECT COUNT(*) FROM inserted WHERE isAttended = 1)
    WHERE id IN (SELECT eventId FROM inserted WHERE isRegistered = 1 OR isAttended = 1);
END;
GO

-- Auto increase collaboratorRegisterCount at [Event] table when student register as collaborator 
CREATE TRIGGER trg_IncreaseCollaboratorCount
ON [EventCollaborator]
AFTER INSERT
AS
BEGIN
   UPDATE Event
   SET collaboratorRegisterCount = collaboratorRegisterCount + 1
   WHERE id IN (SELECT eventId FROM inserted);
END;
GO

-- Auto decrease collaboratorRegisterCount at [Event] table when student cancel collaborator register
CREATE TRIGGER trg_DecreaseCollaboratorCount
ON [EventCollaborator]
AFTER DELETE
AS
BEGIN
   UPDATE Event
   SET collaboratorRegisterCount = collaboratorRegisterCount - 1
   WHERE id IN (SELECT eventId FROM deleted);
END;
GO

-- Auto increase followCount at [Organizer] table when student follow
CREATE TRIGGER trg_IncreaseFollowerCount
ON [Follow]
AFTER INSERT
AS
BEGIN
   UPDATE [Organizer]
   SET followerCount = followerCount + 1
   WHERE id IN (SELECT organizerId FROM inserted);
END;
GO

-- Auto decrease followCount at Organizer table when student unfollow
CREATE TRIGGER trg_DecreaseFollowerCount
ON [Follow]
AFTER DELETE
AS
BEGIN
   UPDATE [Organizer]
   SET followerCount = followerCount - 1
   WHERE id IN (SELECT organizerId FROM deleted);
END;
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
INSERT INTO [Student] ([fullname], [studentId], [email], [password], [avatarPath])
VALUES
('Hoang Vu Hung', 'DE180038', 'hunghvde180038@fpt.edu.vn', 'c72761295946d80be670aeaea88b193b4eb33ad1edea30a0d2b4dd551a2f4fcc', NULL),
('Nguyen Quoc Anh', 'DE180064', 'anhnqde180064@fpt.edu.vn', 'c72761295946d80be670aeaea88b193b4eb33ad1edea30a0d2b4dd551a2f4fcc', NULL),
('Nguyen Minh Thang', 'DE180145', 'thangnmde180145@fpt.edu.vn', 'c72761295946d80be670aeaea88b193b4eb33ad1edea30a0d2b4dd551a2f4fcc', NULL),
('Huynh Viet Khiem', 'DE180067', 'khiemhvde180067@fpt.edu.vn', 'c72761295946d80be670aeaea88b193b4eb33ad1edea30a0d2b4dd551a2f4fcc', NULL),
('Dinh Kim Tu', 'DE180052', 'tudkde180052@fpt.edu.vn', 'c72761295946d80be670aeaea88b193b4eb33ad1edea30a0d2b4dd551a2f4fcc', NULL),
('Trinh Ba Hoang Huy', 'DE180057', 'huytbhde180057@fpt.edu.vn', 'c72761295946d80be670aeaea88b193b4eb33ad1edea30a0d2b4dd551a2f4fcc', NULL);


INSERT INTO [Organizer] ([acronym], [fullname], [description], [email], [password], [avatarPath], [isAdmin])
VALUES
('ICPDP Department', 'Study Overseas & Personal Development with FPTU Danang', 'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.', 'icpdp@gmail.com', 'c72761295946d80be670aeaea88b193b4eb33ad1edea30a0d2b4dd551a2f4fcc', NULL, 1),
('FU - Dever', 'FPT University Programming Club', 'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.', 'club.dever@gmail.com', 'c72761295946d80be670aeaea88b193b4eb33ad1edea30a0d2b4dd551a2f4fcc', NULL, 0),
('TIA', 'Traditional Instrument Abide Club', 'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.', 'tia@gmail.com', 'c72761295946d80be670aeaea88b193b4eb33ad1edea30a0d2b4dd551a2f4fcc', NULL, 0),
('FUFC', 'FPT University Football Club', 'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.', 'fufc@gmail.com', 'c72761295946d80be670aeaea88b193b4eb33ad1edea30a0d2b4dd551a2f4fcc', NULL, 0),
('FUV', 'FPT University Volleyball Club', 'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.', 'fudavolleyball@gmail.com', 'c72761295946d80be670aeaea88b193b4eb33ad1edea30a0d2b4dd551a2f4fcc', NULL, 0);

INSERT INTO [Category] ([categoryName], [description])
VALUES 
('WORKSHOP', 'A workshop for learning new skills'),
('SEMINAR', 'A seminar hosted by experts'),
('ACADEMIC', NULL),
('COMPETITION', NULL),
('SPORT', NULL);

INSERT INTO [Location] ([locationName])
VALUES 
('Room 215 - Building Alpha'),
('Room 315 - Building Blpha'),
('Penrose Hall - Building Beta'),
('Main yard');

-- Insert events with random organizers, types, and locations
DECLARE @i INT = 1;
DECLARE @randomOrganizerId INT;

WHILE @i <= 100
BEGIN
    -- Generate a random organizerId between 1 and 5
    SET @randomOrganizerId = 1 + FLOOR(RAND() * 5);

    INSERT INTO [Event] 
    ([organizerId], [fullname], [description], [typeId], [locationId], [dateOfEvent], [startTime], [endTime], [guestRegisterLimit], [registerDeadline])
    VALUES 
    (
        @randomOrganizerId,
        'Event Name Number ' + CAST(@i AS NVARCHAR(10)),
        N'<p>Whether you are interested in <b>AI</b>, <strong>Web Development</strong>, <i>Cybersecurity</strong>, or <strong>Data Science</strong>, there is something for everyone. Do not miss the chance to <b>connect with like-minded individuals</b> and <strong>learn from the best</strong> in the field!</p>',
        (SELECT TOP 1 [id] FROM [Category] ORDER BY NEWID()),
        (SELECT TOP 1 [id] FROM [Location] ORDER BY NEWID()),
		CAST(DATEADD(DAY, @i - 70, GETDATE()) AS DATE),
		CAST(DATEADD(DAY, 8, GETDATE()) AS TIME),
		CAST(DATEADD(DAY, 12, GETDATE()) AS TIME),
        100,
        DATEADD(DAY, @i, GETDATE())
    );

    SET @i = @i + 1;
END;

-- Insert notifications for organizers and send to students
DECLARE @k INT = 1;
DECLARE @organizerId INT;
DECLARE @userId INT;
DECLARE @notificationId INT;

-- Insert 10 notifications for each organizer
DECLARE organizerCursor CURSOR FOR
SELECT id FROM [Organizer];

OPEN organizerCursor;
FETCH NEXT FROM organizerCursor INTO @organizerId;

WHILE @@FETCH_STATUS = 0
BEGIN
    WHILE @k <= 10
    BEGIN
        -- Insert a new notification for the organizer
        INSERT INTO [Notification] ([senderId], [title], [content])
        VALUES (@organizerId, 'This is important notification!', 'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.');

        -- Get the ID of the inserted notification
        SET @notificationId = SCOPE_IDENTITY();

        -- Send this notification to all students
        DECLARE userCursor CURSOR FOR
        SELECT id FROM [Student];

        OPEN userCursor;
        FETCH NEXT FROM userCursor INTO @userId;

        WHILE @@FETCH_STATUS = 0
        BEGIN
            INSERT INTO [NotificationReceiver] ([notificationId], [receiverId])
            VALUES (@notificationId, @userId);

            FETCH NEXT FROM userCursor INTO @userId;
        END;

        CLOSE userCursor;
        DEALLOCATE userCursor;

        SET @k = @k + 1;
    END;

    SET @k = 1;
    FETCH NEXT FROM organizerCursor INTO @organizerId;
END;

CLOSE organizerCursor;
DEALLOCATE organizerCursor;

INSERT INTO [Feedback] ([guestId], [eventId], [content])
VALUES
(1, 3, 'Very insightful discussion, learned a lot.'),
(2, 1, 'The event was well managed, thank you!'),
(3, 4, 'Interesting event, the speaker was amazing.'),
(4, 2, 'Great event but could use better audio equipment.'),
(5, 5, 'Loved the hands-on workshop, very interactive!'),
(6, 3, 'Good experience, would attend again.'),
(2, 5, 'The event was a bit too long for me, but overall good.'),
(1, 4, 'Good learning experience, would recommend to peers.'),
(2, 3, 'Interesting content but too many interruptions.'),
(3, 5, 'Loved the event, really well organized.'),
(4, 1, 'Speaker was excellent, will attend next time too.'),
(5, 3, 'The event felt rushed, but the information was valuable.'),
(6, 4, 'Hands-on approach was really effective, good job.'),
(1, 5, 'Could improve the seating arrangement next time.');

INSERT INTO [Follow] ([studentId], [organizerId])
VALUES
(5, 1),
(6, 2),
(1, 3),
(3, 4),
(4, 5),
(2, 3),
(6, 1),
(5, 4);

INSERT INTO [EventCollaborator] ([studentId], [eventId])
VALUES
(4, 4),
(5, 1),
(6, 2),
(1, 3),
(3, 5),
(4, 2),
(5, 4),
(6, 5);

INSERT INTO [EventGuest] ([guestId], [eventId], [isRegistered], [isAttended])
VALUES
(2, 3, 1, 0),
(3, 1, 1, 1),
(4, 2, 1, 1),
(5, 4, 1, 0),
(6, 5, 1, 1),
(1, 5, 1, 0),
(2, 4, 1, 1),
(3, 2, 1, 0),
(4, 3, 1, 1),
(5, 1, 1, 1),
(6, 3, 1, 0);
/*
>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
>>>>>>>>>> END: EXAMPLE DATA >>>>>>>>>>
>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
*/