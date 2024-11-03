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
>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
>>>>>>>>> END: RESET DATABASE >>>>>>>>>>
>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
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
	[avatarPath] NVARCHAR(MAX) DEFAULT (N'/assets/img/user/default-avatar.jpg'),

	CONSTRAINT PK_Student PRIMARY KEY ([id])
);

CREATE TABLE [Category] (
	[id] INT IDENTITY(1, 1),
	[categoryName] NVARCHAR(100),
	[categoryDescription] NVARCHAR(1000),
	[isDeleted] BIT DEFAULT(0),

	CONSTRAINT PK_Category PRIMARY KEY ([id])
);

CREATE TABLE [Location] (
	[id] INT IDENTITY(1, 1),
	[locationName] NVARCHAR(100),
	[locationDescription] NVARCHAR(1000),
	[isDeleted] BIT DEFAULT(0),

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
	[avatarPath] NVARCHAR(MAX) DEFAULT (N'/assets/img/user/default-avatar.jpg'),
	[coverPath] NVARCHAR(MAX) DEFAULT (N'/assets/img/user/default-banner.png'),
	[followerCount] INT DEFAULT(0),
	[isAdmin] BIT DEFAULT(0),

	CONSTRAINT PK_Organizer PRIMARY KEY ([id]),
	CONSTRAINT FK_Organizer_Category FOREIGN KEY ([categoryId]) REFERENCES [Category]([id]) ON DELETE CASCADE
);

CREATE TABLE [Event] (
	[id] INT IDENTITY(1, 1),
	[organizerId] INT,
	[fullname] NVARCHAR(200),
	[avatarPath] NVARCHAR(MAX),
	[description] NVARCHAR(MAX),
	[categoryId] INT,
	[locationId] INT,
	[dateOfEvent] DATE,
	[startTime] TIME,
	[endTime] TIME,
	[status] NVARCHAR(15) DEFAULT('PENDING'), --PENDING / APPROVED / REJECTED / ON_GOING / ENDED
	[guestRegisterLimit] INT,
	[collaboratorRegisterLimit] INT,
	[guestAttendedCount] INT DEFAULT (0),
	[guestRegisterCount] INT DEFAULT (0),
	[guestRegisterCancelCount] INT DEFAULT(0),
	[collaboratorRegisterCount] INT DEFAULT (0),
	[guestRegisterDeadline] DATE,
	[collaboratorRegisterDeadline] DATE,

	CONSTRAINT PK_Event PRIMARY KEY ([id]),
	CONSTRAINT FK_Event_Organizer FOREIGN KEY ([organizerId]) REFERENCES [Organizer]([id]) ON DELETE CASCADE,
	CONSTRAINT FK_Event_Category FOREIGN KEY ([categoryId]) REFERENCES [Category]([id]), 
	CONSTRAINT FK_Event_Location FOREIGN KEY ([locationId]) REFERENCES [Location]([id])
);

CREATE TABLE [EventImage] (
	[id] INT IDENTITY(1, 1),
	[eventId] INT,
	[path] NVARCHAR(MAX),

	CONSTRAINT PK_EventImage PRIMARY KEY ([id]),
	CONSTRAINT FK_EventImage_Event FOREIGN KEY ([eventId]) REFERENCES [Event]([id]) ON DELETE CASCADE
);

CREATE TABLE [File] (
	[id] INT IDENTITY(1, 1),
	[submitterId] INT,
	[fileType] NVARCHAR(30), -- 'REPORT' or 'PLAN'
	[displayName] NVARCHAR(MAX), -- Display name is the file name user submitted
	[path] NVARCHAR(MAX),
	[sendTime] DATETIME DEFAULT GETDATE(),
	[status] VARCHAR(15) DEFAULT 'PENDING',	-- PENDING / REVIEWING / APPROVED / REQUEST_CHANGE
	[processNote] NVARCHAR(500),
	[processTime] DATETIME,

	CONSTRAINT PK_File PRIMARY KEY ([id]),
	CONSTRAINT FK_File_Organizer FOREIGN KEY ([submitterId]) REFERENCES [Organizer]([id]) ON DELETE CASCADE
);

CREATE TABLE [Notification] (
	[id] INT IDENTITY(1, 1),
	[senderId] INT,
	[title] NVARCHAR(100),
	[content] NVARCHAR(300),
	[sendingTime] DATETIME DEFAULT GETDATE(),

	CONSTRAINT PK_Notification PRIMARY KEY ([id]),
	CONSTRAINT FK_Notification_Organizer FOREIGN KEY ([senderId]) REFERENCES [Organizer]([id]) ON DELETE CASCADE
);

CREATE TABLE [NotificationReceiver] (
	[notificationId] INT,
	[receiverId] INT,
	[isOrganizer] BIT

	CONSTRAINT PK_NotificationReceiver PRIMARY KEY ([notificationId], [receiverId], [isOrganizer]),
	CONSTRAINT FK_NotificationReceiver_Notification FOREIGN KEY ([notificationId]) REFERENCES [Notification]([id]) ON DELETE CASCADE,
);

CREATE TABLE [EventCollaborator] (
	[studentId] INT,
	[eventId] INT,
	[isCancel] INT DEFAULT(0)

	CONSTRAINT PK_EventCollaborator PRIMARY KEY ([studentId], [eventId]),
	CONSTRAINT FK_EventCollaborator_Student FOREIGN KEY ([studentId]) REFERENCES [Student]([id]) ON DELETE CASCADE,
	CONSTRAINT FK_EventCollaborator_Event FOREIGN KEY ([eventId]) REFERENCES [Event]([id]) ON DELETE CASCADE
);

CREATE TABLE [EventGuest] (
	[guestId] INT,
	[eventId] INT,
	[isRegistered] BIT DEFAULT(0),
	[isAttended] BIT DEFAULT(0),
	[isCancelRegister] BIT DEFAULT(0),

	CONSTRAINT PK_EventGuest PRIMARY KEY ([guestId], [eventId]),
	CONSTRAINT FK_EventGuest_Student FOREIGN KEY ([guestId]) REFERENCES [Student]([id]) ON DELETE CASCADE, 
	CONSTRAINT FK_EventGuest_Event FOREIGN KEY ([eventId]) REFERENCES [Event]([id]) ON DELETE CASCADE
);

CREATE TABLE [Feedback] (
	[guestId] INT,
	[eventId] INT,
	[content] NVARCHAR(1000),

	CONSTRAINT PK_Feedback PRIMARY KEY ([guestId], [eventId]),
	CONSTRAINT FK_Feedback_Student FOREIGN KEY ([guestId]) REFERENCES [Student]([id]) ON DELETE CASCADE,
	CONSTRAINT FK_Feedback_Event FOREIGN KEY ([eventId]) REFERENCES [Event]([id]) ON DELETE CASCADE
);

CREATE TABLE [Follow] (
	[studentId] INT,
	[organizerId] INT,

	CONSTRAINT PK_Follow PRIMARY KEY ([studentId], [organizerId]),
	CONSTRAINT FK_Follow_Student FOREIGN KEY ([studentId]) REFERENCES [Student]([id]) ON DELETE CASCADE,
	CONSTRAINT FK_Follow_Organizer FOREIGN KEY ([organizerId]) REFERENCES [Organizer]([id]) ON DELETE CASCADE
);
/*
>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
>>>>>>>>> END: TABLES >>>>>>>>>>
>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
*/
GO
/*
<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
<<<<<<<<<< BEGIN:TRIGGER <<<<<<<<<<
<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
*/
-- Auto update guestAttendedCount and guestRegisterCount at Event table when guest check-in event that registered before
CREATE TRIGGER trg_updateGuestCounts
ON [EventGuest]
AFTER INSERT, UPDATE
AS
BEGIN
    -- Xử lý khi INSERT
    UPDATE e
    SET 
        guestRegisterCount = guestRegisterCount + (
            SELECT COUNT(*) 
            FROM inserted i
            WHERE i.eventId = e.id AND i.isRegistered = 1 AND i.isCancelRegister = 0
        ),
        guestAttendedCount = guestAttendedCount + (
            SELECT COUNT(*) 
            FROM inserted i
            WHERE i.eventId = e.id AND i.isAttended = 1 AND i.isRegistered = 0 AND i.isCancelRegister = 0
        )
    FROM Event e
    WHERE EXISTS (
        SELECT 1 
        FROM inserted i
        WHERE i.eventId = e.id
    );

    -- Xử lý khi UPDATE
    UPDATE e
    SET 
        guestRegisterCount = guestRegisterCount + (
            SELECT COUNT(*)
            FROM inserted i
            JOIN deleted d ON i.guestId = d.guestId AND i.eventId = d.eventId
            WHERE i.eventId = e.id 
              AND i.isRegistered = 1 
              AND d.isRegistered = 0  -- Chỉ cộng khi isRegistered chuyển từ 0 sang 1
        ) - (
            SELECT COUNT(*)
            FROM inserted i
            JOIN deleted d ON i.guestId = d.guestId AND i.eventId = d.eventId
            WHERE i.eventId = e.id 
              AND i.isRegistered = 0 
              AND d.isRegistered = 1  -- Chỉ trừ khi isRegistered chuyển từ 1 sang 0
        ),
        guestAttendedCount = guestAttendedCount + (
            SELECT COUNT(*)
            FROM inserted i
            JOIN deleted d ON i.guestId = d.guestId AND i.eventId = d.eventId
            WHERE i.eventId = e.id 
              AND i.isAttended = 1 
              AND d.isAttended = 0  -- Chỉ cộng khi isAttended chuyển từ 0 sang 1
        ) - (
            SELECT COUNT(*)
            FROM inserted i
            JOIN deleted d ON i.guestId = d.guestId AND i.eventId = d.eventId
            WHERE i.eventId = e.id 
              AND i.isAttended = 0 
              AND d.isAttended = 1  -- Chỉ trừ khi isAttended chuyển từ 1 sang 0
        )
    FROM Event e
    WHERE EXISTS (
        SELECT 1 
        FROM inserted i
        JOIN deleted d ON i.guestId = d.guestId AND i.eventId = d.eventId
        WHERE i.eventId = e.id 
          AND (i.isRegistered <> d.isRegistered OR i.isAttended <> d.isAttended)
    );
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
>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
>>>>>>>>> END: TRIGGERS >>>>>>>>>>
>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
*/
GO
/*
<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
<<<<<<<<<< BEGIN: EXAMPLE DATA <<<<<<<<<<
<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
*/
/*
>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
>>>>>>>>> END: EXAMPLE DATA >>>>>>>>>>
>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
*/