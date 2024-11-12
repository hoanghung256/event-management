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
    -- Handle INSERT only
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
          AND NOT EXISTS (SELECT 1 FROM deleted d WHERE d.guestId = i.guestId AND d.eventId = i.eventId)
    );

    -- Handle UPDATE only
    UPDATE e
    SET 
        guestRegisterCount = guestRegisterCount + (
            SELECT COUNT(*)
            FROM inserted i
            JOIN deleted d ON i.guestId = d.guestId AND i.eventId = d.eventId
            WHERE i.eventId = e.id 
              AND i.isRegistered = 1 
              AND d.isRegistered = 0  -- Only count when isRegistered changes from 0 to 1
        ) - (
            SELECT COUNT(*)
            FROM inserted i
            JOIN deleted d ON i.guestId = d.guestId AND i.eventId = d.eventId
            WHERE i.eventId = e.id 
              AND i.isRegistered = 0 
              AND d.isRegistered = 1  -- Only subtract when isRegistered changes from 1 to 0
        ),
        guestAttendedCount = guestAttendedCount + (
            SELECT COUNT(*)
            FROM inserted i
            JOIN deleted d ON i.guestId = d.guestId AND i.eventId = d.eventId
            WHERE i.eventId = e.id 
              AND i.isAttended = 1 
              AND d.isAttended = 0  -- Only count when isAttended changes from 0 to 1
        ) - (
            SELECT COUNT(*)
            FROM inserted i
            JOIN deleted d ON i.guestId = d.guestId AND i.eventId = d.eventId
            WHERE i.eventId = e.id 
              AND i.isAttended = 0 
              AND d.isAttended = 1  -- Only subtract when isAttended changes from 1 to 0
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
SET IDENTITY_INSERT [dbo].[Organizer] ON 

INSERT [dbo].[Organizer] ([id], [acronym], [fullname], [categoryId], [description], [email], [password], [avatarPath], [coverPath], [followerCount], [isAdmin]) VALUES (2, N'ICPDP Department', N'Study Overseas & Personal Development with FPTU Danang', NULL, N'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.', N'khiemhvde180067@fpt.edu.vn', N'c72761295946d80be670aeaea88b193b4eb33ad1edea30a0d2b4dd551a2f4fcc', N'/assets/upload/images/d97b0e3d-6173-4f75-a8fc-bdd14aded086.jpg', N'/assets/img/user/default-banner.png', 0, 1)
INSERT [dbo].[Organizer] ([id], [acronym], [fullname], [categoryId], [description], [email], [password], [avatarPath], [coverPath], [followerCount], [isAdmin]) VALUES (3, N'FU - Dever', N'FPT University Programming Club', NULL, N'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.', N'anhnqde180064@fpt.edu.vn', N'c72761295946d80be670aeaea88b193b4eb33ad1edea30a0d2b4dd551a2f4fcc', N'/assets/upload/images/c40581bb-1171-46e0-9375-8c2cefc052cb.jpg', N'/assets/img/user/default-banner.png', 0, 0)
INSERT [dbo].[Organizer] ([id], [acronym], [fullname], [categoryId], [description], [email], [password], [avatarPath], [coverPath], [followerCount], [isAdmin]) VALUES (4, N'TIA', N'Traditional Instrument Abide Club', NULL, N'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.', N'thangnmde180145@fpt.edu.vn', N'c72761295946d80be670aeaea88b193b4eb33ad1edea30a0d2b4dd551a2f4fcc', N'/assets/img/user/default-avatar.jpg', N'/assets/img/user/default-banner.png', 0, 0)
INSERT [dbo].[Organizer] ([id], [acronym], [fullname], [categoryId], [description], [email], [password], [avatarPath], [coverPath], [followerCount], [isAdmin]) VALUES (5, N'FUFC', N'FPT University Football Club', NULL, N'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.', N'huytbhde180057@fpt.edu.vn', N'c72761295946d80be670aeaea88b193b4eb33ad1edea30a0d2b4dd551a2f4fcc', N'/assets/img/user/default-avatar.jpg', N'/assets/img/user/default-banner.png', 0, 0)
INSERT [dbo].[Organizer] ([id], [acronym], [fullname], [categoryId], [description], [email], [password], [avatarPath], [coverPath], [followerCount], [isAdmin]) VALUES (6, N'FUV', N'FPT University Volleyball Club', NULL, N'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.', N'tudkde180052@fpt.edu.vn', N'c72761295946d80be670aeaea88b193b4eb33ad1edea30a0d2b4dd551a2f4fcc', N'/assets/img/user/default-avatar.jpg', N'/assets/img/user/default-banner.png', 0, 0)
INSERT [dbo].[Organizer] ([id], [acronym], [fullname], [categoryId], [description], [email], [password], [avatarPath], [coverPath], [followerCount], [isAdmin]) VALUES (8, N'EVo', N'FUDA Event Club', NULL, N'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.', N'nhidyde180152@fpt.edu.vn', N'c72761295946d80be670aeaea88b193b4eb33ad1edea30a0d2b4dd551a2f4fcc', N'/assets/upload/images/5e1147cb-3cce-4052-8ddf-f2ab51abdbae.jpg', N'/assets/img/user/default-banner.png', 0, 0)
INSERT [dbo].[Organizer] ([id], [acronym], [fullname], [categoryId], [description], [email], [password], [avatarPath], [coverPath], [followerCount], [isAdmin]) VALUES (9, N'QHDN-FUDN', N'Phòng quan hệ doanh nghiệp FUĐN', NULL, N'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.', N'hunghvde180038@fpt.edu.vn', N'c72761295946d80be670aeaea88b193b4eb33ad1edea30a0d2b4dd551a2f4fcc', N'/assets/upload/images/e51ad08f-b341-475e-a8b6-02e2099f701a.jpg', N'/assets/img/user/default-banner.png', 0, 0)
SET IDENTITY_INSERT [dbo].[Organizer] OFF
GO
SET IDENTITY_INSERT [dbo].[Student] ON 

INSERT [dbo].[Student] ([id], [fullname], [studentId], [email], [password], [gender], [avatarPath]) VALUES (1, N'Hoang Vu Hung', N'DE180038', N'hunghvde180038@fpt.edu.vn', N'c72761295946d80be670aeaea88b193b4eb33ad1edea30a0d2b4dd551a2f4fcc', N'MALE', N'/assets/img/user/default-avatar.jpg')
INSERT [dbo].[Student] ([id], [fullname], [studentId], [email], [password], [gender], [avatarPath]) VALUES (2, N'Nguyen Quoc Anh', N'DE180064', N'anhnqde180064@fpt.edu.vn', N'c72761295946d80be670aeaea88b193b4eb33ad1edea30a0d2b4dd551a2f4fcc', N'MALE', N'/assets/upload/images/449e8864-e408-4e56-8d65-82850173c8a9.jpg')
INSERT [dbo].[Student] ([id], [fullname], [studentId], [email], [password], [gender], [avatarPath]) VALUES (3, N'Nguyen Minh Thang', N'DE180145', N'thangnmde180145@fpt.edu.vn', N'c72761295946d80be670aeaea88b193b4eb33ad1edea30a0d2b4dd551a2f4fcc', N'MALE', N'/assets/upload/images/48a0fda9-6deb-48d7-acd1-1ec047cb7de6.jpg')
INSERT [dbo].[Student] ([id], [fullname], [studentId], [email], [password], [gender], [avatarPath]) VALUES (4, N'Huynh Viet Khiem', N'DE180067', N'khiemhvde180067@fpt.edu.vn', N'c72761295946d80be670aeaea88b193b4eb33ad1edea30a0d2b4dd551a2f4fcc', N'MALE', N'/assets/upload/images/510d1170-40e3-4e1e-bc6d-bdf0f04d802d.jpg')
INSERT [dbo].[Student] ([id], [fullname], [studentId], [email], [password], [gender], [avatarPath]) VALUES (5, N'Dinh Kim Tu', N'DE180052', N'tudkde180052@fpt.edu.vn', N'c72761295946d80be670aeaea88b193b4eb33ad1edea30a0d2b4dd551a2f4fcc', N'MALE', N'/assets/upload/images/4c3a8c41-efd6-499c-9c73-926961878ccd.jpeg')
INSERT [dbo].[Student] ([id], [fullname], [studentId], [email], [password], [gender], [avatarPath]) VALUES (6, N'Trinh Ba Hoang Huy', N'DE180057', N'huytbhde180057@fpt.edu.vn', N'c72761295946d80be670aeaea88b193b4eb33ad1edea30a0d2b4dd551a2f4fcc', N'MALE', N'/assets/upload/images/198618f9-8457-4e2f-bbff-f6813e26924e.jpg')
INSERT [dbo].[Student] ([id], [fullname], [studentId], [email], [password], [gender], [avatarPath]) VALUES (7, N'Tran Thi Khanh Vy', N'DE160354', N'vyttkvde160354@fpt.edu.vn', N'c72761295946d80be670aeaea88b193b4eb33ad1edea30a0d2b4dd', N'FEMALE', N'/assets/img/user/default-avatar.jpg')
INSERT [dbo].[Student] ([id], [fullname], [studentId], [email], [password], [gender], [avatarPath]) VALUES (8, N'Nguyen Hoang Duong', N'DE180039', N'duongnhde180039@fpt.edu.vn', N'c72761295946d80be670aeaea88b193b4eb33ad1edea30a0d2b4dd', N'MALE', N'/assets/img/user/default-avatar.jpg')
INSERT [dbo].[Student] ([id], [fullname], [studentId], [email], [password], [gender], [avatarPath]) VALUES (9, N'Trinh Nguyen Hung', N'DE180058', N'hungtnde180058@fpt.edu.vn', N'c72761295946d80be670aeaea88b193b4eb33ad1edea30a0d2b4dd', N'MALE', N'/assets/img/user/default-avatar.jpg')
INSERT [dbo].[Student] ([id], [fullname], [studentId], [email], [password], [gender], [avatarPath]) VALUES (10, N'Doan Quoc Hoang Nam', N'DE180122', N'namdqde180122@fpt.edu.vn', N'c72761295946d80be670aeaea88b193b4eb33ad1edea30a0d2b4dd', N'MALE', N'/assets/img/user/default-avatar.jpg')
INSERT [dbo].[Student] ([id], [fullname], [studentId], [email], [password], [gender], [avatarPath]) VALUES (11, N'Nguyen Huu Anton Tuan Kiet', N'DE180149', N'kietnhatde180149@fpt.edu.vn', N'c72761295946d80be670aeaea88b193b4eb33ad1edea30a0d2b4dd', N'MALE', N'/assets/img/user/default-avatar.jpg')
INSERT [dbo].[Student] ([id], [fullname], [studentId], [email], [password], [gender], [avatarPath]) VALUES (12, N'Dang Yen Nhi', N'DE180152', N'nhidytde180152@fpt.edu.vn', N'c72761295946d80be670aeaea88b193b4eb33ad1edea30a0d2b4dd', N'FEMALE', N'/assets/img/user/default-avatar.jpg')
INSERT [dbo].[Student] ([id], [fullname], [studentId], [email], [password], [gender], [avatarPath]) VALUES (13, N'Ngo Tran Xuan Hoa', N'DE180175', N'hoantxde180175@fpt.edu.vn', N'c72761295946d80be670aeaea88b193b4eb33ad1edea30a0d2b4dd', N'MALE', N'/assets/img/user/default-avatar.jpg')
INSERT [dbo].[Student] ([id], [fullname], [studentId], [email], [password], [gender], [avatarPath]) VALUES (14, N'Nguyen Dinh Quoc Khoi', N'DE180179', N'khoindqde180179@fpt.edu.vn', N'c72761295946d80be670aeaea88b193b4eb33ad1edea30a0d2b4dd', N'MALE', N'/assets/img/user/default-avatar.jpg')
INSERT [dbo].[Student] ([id], [fullname], [studentId], [email], [password], [gender], [avatarPath]) VALUES (15, N'Vo Ngoc Gia Truyen', N'DE180180', N'truyenvngde180180@fpt.edu.vn', N'c72761295946d80be670aeaea88b193b4eb33ad1edea30a0d2b4dd', N'FEMALE', N'/assets/img/user/default-avatar.jpg')
INSERT [dbo].[Student] ([id], [fullname], [studentId], [email], [password], [gender], [avatarPath]) VALUES (16, N'Nguyen Thanh Tung', N'DE180205', N'tungntde180205@fpt.edu.vn', N'c72761295946d80be670aeaea88b193b4eb33ad1edea30a0d2b4dd', N'MALE', N'/assets/img/user/default-avatar.jpg')
INSERT [dbo].[Student] ([id], [fullname], [studentId], [email], [password], [gender], [avatarPath]) VALUES (17, N'Tran Nguyen Han', N'DE180278', N'hantnde180278@fpt.edu.vn', N'c72761295946d80be670aeaea88b193b4eb33ad1edea30a0d2b4dd', N'MALE', N'/assets/img/user/default-avatar.jpg')
INSERT [dbo].[Student] ([id], [fullname], [studentId], [email], [password], [gender], [avatarPath]) VALUES (18, N'Nguyen Le Dang Thanh', N'DE180280', N'thanhnldde180280@fpt.edu.vn', N'c72761295946d80be670aeaea88b193b4eb33ad1edea30a0d2b4dd', N'MALE', N'/assets/img/user/default-avatar.jpg')
INSERT [dbo].[Student] ([id], [fullname], [studentId], [email], [password], [gender], [avatarPath]) VALUES (19, N'Le Tan Dai', N'DE180285', N'dailtde180285@fpt.edu.vn', N'c72761295946d80be670aeaea88b193b4eb33ad1edea30a0d2b4dd', N'MALE', N'/assets/img/user/default-avatar.jpg')
INSERT [dbo].[Student] ([id], [fullname], [studentId], [email], [password], [gender], [avatarPath]) VALUES (20, N'Vo Nhat Nguyen', N'DE180432', N'nguyenvnde180432@fpt.edu.vn', N'c72761295946d80be670aeaea88b193b4eb33ad1edea30a0d2b4dd', N'MALE', N'/assets/img/user/default-avatar.jpg')
INSERT [dbo].[Student] ([id], [fullname], [studentId], [email], [password], [gender], [avatarPath]) VALUES (21, N'Nguyen Thanh Tuan', N'DE180464', N'tuanntde180464@fpt.edu.vn', N'c72761295946d80be670aeaea88b193b4eb33ad1edea30a0d2b4dd', N'MALE', N'/assets/img/user/default-avatar.jpg')
INSERT [dbo].[Student] ([id], [fullname], [studentId], [email], [password], [gender], [avatarPath]) VALUES (22, N'Huynh Tran Van Trong', N'DE180484', N'tronghtvde180484@fpt.edu.vn', N'c72761295946d80be670aeaea88b193b4eb33ad1edea30a0d2b4dd', N'MALE', N'/assets/img/user/default-avatar.jpg')
INSERT [dbo].[Student] ([id], [fullname], [studentId], [email], [password], [gender], [avatarPath]) VALUES (23, N'Tran Van Hoang Phuc', N'DE180493', N'phuctvhde180493@fpt.edu.vn', N'c72761295946d80be670aeaea88b193b4eb33ad1edea30a0d2b4dd', N'MALE', N'/assets/img/user/default-avatar.jpg')
INSERT [dbo].[Student] ([id], [fullname], [studentId], [email], [password], [gender], [avatarPath]) VALUES (24, N'Nguyen Nam Phong', N'DE180501', N'phongnnde180501@fpt.edu.vn', N'c72761295946d80be670aeaea88b193b4eb33ad1edea30a0d2b4dd', N'MALE', N'/assets/img/user/default-avatar.jpg')
INSERT [dbo].[Student] ([id], [fullname], [studentId], [email], [password], [gender], [avatarPath]) VALUES (25, N'Nguyen Tuan Khai', N'DE180521', N'khainntde180521@fpt.edu.vn', N'c72761295946d80be670aeaea88b193b4eb33ad1edea30a0d2b4dd', N'MALE', N'/assets/img/user/default-avatar.jpg')
INSERT [dbo].[Student] ([id], [fullname], [studentId], [email], [password], [gender], [avatarPath]) VALUES (26, N'Le Hoang Trung Kien', N'DE180570', N'kienlhtde180570@fpt.edu.vn', N'c72761295946d80be670aeaea88b193b4eb33ad1edea30a0d2b4dd', N'MALE', N'/assets/img/user/default-avatar.jpg')
INSERT [dbo].[Student] ([id], [fullname], [studentId], [email], [password], [gender], [avatarPath]) VALUES (27, N'Dinh Bao Han', N'DE180661', N'handbdde180661@fpt.edu.vn', N'c72761295946d80be670aeaea88b193b4eb33ad1edea30a0d2b4dd', N'MALE', N'/assets/img/user/default-avatar.jpg')
INSERT [dbo].[Student] ([id], [fullname], [studentId], [email], [password], [gender], [avatarPath]) VALUES (28, N'Vo Tuan Kiet', N'DE180701', N'kietvde180701@fpt.edu.vn', N'c72761295946d80be670aeaea88b193b4eb33ad1edea30a0d2b4dd', N'MALE', N'/assets/img/user/default-avatar.jpg')
INSERT [dbo].[Student] ([id], [fullname], [studentId], [email], [password], [gender], [avatarPath]) VALUES (29, N'Phan Xuan Hoang', N'DE180791', N'hoangpxde180791@fpt.edu.vn', N'c72761295946d80be670aeaea88b193b4eb33ad1edea30a0d2b4dd', N'MALE', N'/assets/img/user/default-avatar.jpg')
INSERT [dbo].[Student] ([id], [fullname], [studentId], [email], [password], [gender], [avatarPath]) VALUES (30, N'Nguyen Van Hoang Phuc', N'DE181024', N'phucnvhde181024@fpt.edu.vn', N'c72761295946d80be670aeaea88b193b4eb33ad1edea30a0d2b4dd', N'MALE', N'/assets/img/user/default-avatar.jpg')
INSERT [dbo].[Student] ([id], [fullname], [studentId], [email], [password], [gender], [avatarPath]) VALUES (31, N'Truong Quoc Cuong', N'DE181075', N'cuongtqde181075@fpt.edu.vn', N'c72761295946d80be670aeaea88b193b4eb33ad1edea30a0d2b4dd', N'MALE', N'/assets/img/user/default-avatar.jpg')
INSERT [dbo].[Student] ([id], [fullname], [studentId], [email], [password], [gender], [avatarPath]) VALUES (32, N'Le The Bao', N'DE181078', N'baoltde181078@fpt.edu.vn', N'c72761295946d80be670aeaea88b193b4eb33ad1edea30a0d2b4dd', N'MALE', N'/assets/img/user/default-avatar.jpg')
INSERT [dbo].[Student] ([id], [fullname], [studentId], [email], [password], [gender], [avatarPath]) VALUES (33, N'Nguyen Anh Khoa', N'QE180035', N'khoanaqe180035@fpt.edu.vn', N'c72761295946d80be670aeaea88b193b4eb33ad1edea30a0d2b4dd', N'MALE', N'/assets/img/user/default-avatar.jpg')
INSERT [dbo].[Student] ([id], [fullname], [studentId], [email], [password], [gender], [avatarPath]) VALUES (34, N'Ha Huy Hoang', N'QE180106', N'hoanghhde180106@fpt.edu.vn', N'c72761295946d80be670aeaea88b193b4eb33ad1edea30a0d2b4dd', N'MALE', N'/assets/img/user/default-avatar.jpg')
INSERT [dbo].[Student] ([id], [fullname], [studentId], [email], [password], [gender], [avatarPath]) VALUES (35, N'Nguyen Trung Tin', N'SE62275', N'tinntse62275@fpt.edu.vn', N'c72761295946d80be670aeaea88b193b4eb33ad1edea30a0d2b4dd', N'MALE', N'/assets/img/user/default-avatar.jpg')
SET IDENTITY_INSERT [dbo].[Student] OFF
GO
SET IDENTITY_INSERT [dbo].[Category] ON 

INSERT [dbo].[Category] ([id], [categoryName], [categoryDescription], [isDeleted]) VALUES (1, N'WORKSHOP', N'A workshop for learning new skills', 0)
INSERT [dbo].[Category] ([id], [categoryName], [categoryDescription], [isDeleted]) VALUES (2, N'SEMINAR', N'A seminar hosted by experts', 0)
INSERT [dbo].[Category] ([id], [categoryName], [categoryDescription], [isDeleted]) VALUES (3, N'ACADEMIC', NULL, 0)
INSERT [dbo].[Category] ([id], [categoryName], [categoryDescription], [isDeleted]) VALUES (4, N'COMPETITION', NULL, 0)
INSERT [dbo].[Category] ([id], [categoryName], [categoryDescription], [isDeleted]) VALUES (5, N'SPORT', NULL, 0)
INSERT [dbo].[Category] ([id], [categoryName], [categoryDescription], [isDeleted]) VALUES (6, N'TALKSHOW', NULL, 0)
INSERT [dbo].[Category] ([id], [categoryName], [categoryDescription], [isDeleted]) VALUES (7, N'FIELD TRIP', NULL, 0)
INSERT [dbo].[Category] ([id], [categoryName], [categoryDescription], [isDeleted]) VALUES (8, N'CELEBRATION', NULL, 0)
SET IDENTITY_INSERT [dbo].[Category] OFF
GO
SET IDENTITY_INSERT [dbo].[Location] ON 

INSERT [dbo].[Location] ([id], [locationName], [locationDescription], [isDeleted]) VALUES (1, N'Room 215 - Building Alpha', NULL, 0)
INSERT [dbo].[Location] ([id], [locationName], [locationDescription], [isDeleted]) VALUES (2, N'Room 315 - Building Blpha', NULL, 0)
INSERT [dbo].[Location] ([id], [locationName], [locationDescription], [isDeleted]) VALUES (3, N'Penrose Hall - Building Beta', NULL, 0)
INSERT [dbo].[Location] ([id], [locationName], [locationDescription], [isDeleted]) VALUES (4, N'Main yard', NULL, 0)
INSERT [dbo].[Location] ([id], [locationName], [locationDescription], [isDeleted]) VALUES (5, N'Outside', NULL, 0)
INSERT [dbo].[Location] ([id], [locationName], [locationDescription], [isDeleted]) VALUES (6, N'5th Floor - Building Alpha', NULL, 0)
INSERT [dbo].[Location] ([id], [locationName], [locationDescription], [isDeleted]) VALUES (7, N'Room 103 - Building Alpha', NULL, 0)
SET IDENTITY_INSERT [dbo].[Location] OFF
GO
SET IDENTITY_INSERT [dbo].[Event] ON 

INSERT [dbo].[Event] ([id], [organizerId], [fullname], [avatarPath], [description], [categoryId], [locationId], [dateOfEvent], [startTime], [endTime], [status], [guestRegisterLimit], [collaboratorRegisterLimit], [guestAttendedCount], [guestRegisterCount], [guestRegisterCancelCount], [collaboratorRegisterCount], [guestRegisterDeadline], [collaboratorRegisterDeadline]) VALUES (2, 2, N'FUDA SUMMER JAMBOREE 2024 ', N'/assets/upload/images/eb4d9d38-9ec1-4d4f-be93-bdb473976fd8.jpg', N'FUDA SUMMER JAMBOREE là trại họp bạn dành cho thanh thiếu niên đến từ khắp nơi, quốc tế và Việt Nam. Trại họp bạn này là cơ hội để các thanh thiếu niên có 4 ngày 3 đêm sống tự lập dưới sự huấn luyện của cán bộ chuyên gia từ Đại học FPT nhằm giúp các bạn trẻ có những ngày hè thật ý nghĩa thông qua các hoạt động nêu bật những giá trị, kỹ năng cần có trong Thế kỷ XXI.

 

Từ trại họp bạn này, các bạn sẽ có thêm nhiều kết nối mới, nhiều trải nghiệm mới để tiếp tục hoàn thiện bản thân trở thành những thế hệ lãnh đạo trẻ sống tử tế và lan tỏa những điều tích cực đến cộng đồng. Chúng tôi tin rằng, một bạn trẻ thành công là một người có nhiều trải nghiệm. Vì vậy, chúng tôi tạo ra những trải nghiệm ở FUDA SUMMER JAMBOREE, chờ bạn đến khám phá.', 1, 1, CAST(N'2024-11-08' AS Date), CAST(N'07:30:00' AS Time), CAST(N'14:30:00' AS Time), N'END', 200, 20, 5, 178, 33, 18, CAST(N'2024-11-20' AS Date), CAST(N'2024-11-15' AS Date))
INSERT [dbo].[Event] ([id], [organizerId], [fullname], [avatarPath], [description], [categoryId], [locationId], [dateOfEvent], [startTime], [endTime], [status], [guestRegisterLimit], [collaboratorRegisterLimit], [guestAttendedCount], [guestRegisterCount], [guestRegisterCancelCount], [collaboratorRegisterCount], [guestRegisterDeadline], [collaboratorRegisterDeadline]) VALUES (3, 2, N'SPOOKY SCENES - A HALLOWEEN CELEBRATION', N'/assets/upload/images/f36630c8-f37e-4885-8c82-7c7548c4e51c.jpg', N'🎞️ 𝐒𝐏𝐎𝐎𝐊𝐘 𝐒𝐂𝐄𝐍𝐄𝐒 - Sự kiện được phối hợp tổ chức bởi Bộ môn Tiếng Anh dự bị và Phòng Công tác sinh viên ĐH FPT Đà Nẵng, nơi những bộ phim kinh dị do chính sinh viên nhà F lên ý tưởng và quay dựng. Đây không chỉ là sân chơi để các bạn thể hiện tài năng sáng tạo mà còn là cơ hội để trau dồi vốn tiếng anh của mình. ', 4, 3, CAST(N'2024-10-31' AS Date), CAST(N'17:40:00' AS Time), CAST(N'20:30:00' AS Time), N'END', 100, 0, 79, 64, 0, 0, CAST(N'2024-10-31' AS Date), CAST(N'1970-01-01' AS Date))
INSERT [dbo].[Event] ([id], [organizerId], [fullname], [avatarPath], [description], [categoryId], [locationId], [dateOfEvent], [startTime], [endTime], [status], [guestRegisterLimit], [collaboratorRegisterLimit], [guestAttendedCount], [guestRegisterCount], [guestRegisterCancelCount], [collaboratorRegisterCount], [guestRegisterDeadline], [collaboratorRegisterDeadline]) VALUES (4, 2, N'FUDA FEST 2024 - LỄ HỘI MÙA XUÂN FUDA', N'/assets/upload/images/26ab206a-b2b8-45df-9e6b-13078fa58c15.jpg', N'MÀ LÀ .... NHÌN XEM FUDA MUSIC SHOW QUAY TRỞ LẠI NÈ💥
Nếu bạn đã từng đắm chìm trong không khí đại nhạc hội cùng FPTU hoặc rất hào hứng quẩy tại sự kiện tới thì đọc kỹ post này nhaaa! 
Năm 2024, ĐẠI NHẠC HỘI QUAY TRỞ LẠI VỚI DIỆN MẠO HOÀN TOÀN MỚI - 𝙵𝚄𝙳𝙰 𝙵𝙴𝚂𝚃
💥𝑫𝒂̀𝒏 𝒍𝒊𝒏𝒆-𝒖𝒑 𝒍𝒂̀𝒎 𝑮𝒆𝒏𝒁 𝒔𝒂𝒚 𝒎𝒆̂
Cho tôi con beat, tôi sẽ lên cho anh em một dàn line-up với nhiều nghệ sĩ đang sở hữu số lượng hit khủng trên bảng xếp hạng âm nhạc. Mạnh dạn đoán nghệ sĩ nào sẽ xuất hiện ở bên dưới phần comment nha mấy ní ơiiii 😍
💥𝑸𝒖𝒂̂̉𝒚 𝒉𝒆̂́𝒕 𝒏𝒂̂́𝒄 𝒕𝒓𝒐𝒏𝒈 𝒎𝒐̣̂𝒕 𝒏𝒈𝒂̀𝒚
Một ngày với nhiều hoạt động vui chơi đa dạng trước dịp Tết Nguyên Đán đang chờ chúng ta. Những hoạt động đó là gì, chờ những bản tin sau nhaaa!
Nếu bạn là người yêu Pop, Rap và Rock, còn chần chừ gì nữa mà không nhanh tay đăng ký vé ngay hôm nay: https://fudafest.com/
💥𝑴𝒐̣̂𝒕 𝒏𝒈𝒂̀𝒚 𝒅𝒖𝒚 𝒏𝒉𝒂̂́𝒕: 𝟸𝟷.𝟶𝟷.𝟸𝟶𝟸𝟺 tại Đại học FPT Đà Nẵng. 
👉Lên kế hoạch quẩy tưng bừng cùng Ad đi các bạn ơi!', 1, 1, CAST(N'2024-11-20' AS Date), CAST(N'17:50:00' AS Time), CAST(N'21:55:00' AS Time), N'APPROVED', 100, 30, 0, 99, 11, 23, CAST(N'2024-11-08' AS Date), CAST(N'2024-11-16' AS Date))
INSERT [dbo].[Event] ([id], [organizerId], [fullname], [avatarPath], [description], [categoryId], [locationId], [dateOfEvent], [startTime], [endTime], [status], [guestRegisterLimit], [collaboratorRegisterLimit], [guestAttendedCount], [guestRegisterCount], [guestRegisterCancelCount], [collaboratorRegisterCount], [guestRegisterDeadline], [collaboratorRegisterDeadline]) VALUES (5, 2, N'WORKSHOP TÔ TƯỢNG', N'/assets/upload/images/e7f1b274-7554-4fda-aec6-447e632644e4.jpg', N'👉 Từ lâu, tô tượng đã là một thú vui không thể thiếu của các bạn nhỏ nhưng dần bị lu mờ theo năm tháng. Giờ thì nhiều bạn trẻ lại thích quay về tuổi thơ và tích cực lăng xê "bộ môn" đầy sáng tạo này nên tô tượng đã trở thành HOT TREND của năm 2023. Đến với Workshop tô tượng, bạn có thể tự tay chọn lựa những em tượng vô cùng xinh xẻo và biến tấu cho những em ấy theo sở thích của mình! 
👉 Vậy thì còn chần chừ gì nữa mà không đu ngay cho kịp bạn bè đi nào !!! Và như thường lệ, các bạn sẽ được tận tay đem những em tượng xinh xắn về nữa nha !!! FVA hẹn gặp các bạn tại buổi Workshop lần nàyy ✨✨✨ ', 1, 1, CAST(N'2024-11-08' AS Date), CAST(N'17:30:00' AS Time), CAST(N'19:30:00' AS Time), N'END', 50, 0, 5, 30, 4, 0, CAST(N'2024-11-08' AS Date), CAST(N'1970-01-01' AS Date))
INSERT [dbo].[Event] ([id], [organizerId], [fullname], [avatarPath], [description], [categoryId], [locationId], [dateOfEvent], [startTime], [endTime], [status], [guestRegisterLimit], [collaboratorRegisterLimit], [guestAttendedCount], [guestRegisterCount], [guestRegisterCancelCount], [collaboratorRegisterCount], [guestRegisterDeadline], [collaboratorRegisterDeadline]) VALUES (6, 2, N'Hội nghị khoa học quốc tế International Conference on Intelligence of Things 2024 (ICIT 2024) ', N'/assets/upload/images/fd178a66-54ce-4457-b407-9076a5aad4f9.jpg', N'Ngày 12 - 14/9, Hội nghị khoa học quốc tế International Conference on Intelligence of Things 2024 (ICIT 2024) diễn ra tại Trường Đại học FPT phân hiệu Đà Nẵng. Hội nghị có sự tham gia của các diễn giả là chuyên gia đầu ngành trên thế giới và tại Việt Nam về các lĩnh vực IoT, Vi mạch bán dẫn, Trí tuệ nhân tạo, Blockchain. 

Trước bối cảnh công nghệ đang phát triển với tốc độ nhanh chóng, Trường Đại học FPT cùng khoa Công nghệ Thông tin của các Học viện và Trường ĐH: Học viện Nông nghiệp Việt Nam, Trường Đại học Bách Khoa TP. HCM, Trường Đại học Mở TP.HCM, Trường Đại học Mỏ Địa chất và Trường Đại học Quy Nhơn đồng sáng lập hội nghị quốc tế thường niên về Vạn vật thông minh.

Năm nay, Hội thảo có chủ đề “International Conference on Intelligence of Things 2024” - Hội thảo quốc tế về Vạn vật thông minh 2024 (ICIT 2024). ', 1, 1, CAST(N'2024-11-14' AS Date), CAST(N'09:30:00' AS Time), CAST(N'11:30:00' AS Time), N'APPROVED', 100, 0, 0, 92, 5, 0, CAST(N'2024-11-23' AS Date), CAST(N'1970-01-01' AS Date))
INSERT [dbo].[Event] ([id], [organizerId], [fullname], [avatarPath], [description], [categoryId], [locationId], [dateOfEvent], [startTime], [endTime], [status], [guestRegisterLimit], [collaboratorRegisterLimit], [guestAttendedCount], [guestRegisterCount], [guestRegisterCancelCount], [collaboratorRegisterCount], [guestRegisterDeadline], [collaboratorRegisterDeadline]) VALUES (7, 2, N'FPT HAPPY RUN 2024', N'/assets/upload/images/10743e2f-2945-43f7-ace9-5547f9684a45.jpg', N'Giải chạy ảo “FPT – Sải Cánh Vươn Xa” được tổ chức nhằm hướng đến mục tiêu duy trì sức khỏe xuyên suốt 1 năm dành cho đội ngũ cán bộ, hội viên, thanh niên, tình nguyện viên Tập đoàn FPT; các tổ chức, doanh nghiệp, cộng đồng yêu thể thao và đông đảo nhân dân trong và ngoài nước. 

Giải đấu diễn ra với 3 chặng gồm: Chặng 1 “Sải cánh vươn xa” từ ngày 27/2-31/5; Chặng 2 “Hành trình khám phá” từ ngày 1/6-30/9; Chặng 3 “Nhịp đập trái tim” từ ngày 1/10-31/12.

Thời gian đăng ký tham gia chiến dịch và ghi nhận bắt đầu từ 00 giờ ngày 29/02/2024. Các vận động viên vẫn có thể tiếp tục đăng ký theo hình thức cá nhân hoặc theo Nhóm trong suốt quá trình Chiến dịch diễn ra.', 1, 1, CAST(N'2024-11-27' AS Date), CAST(N'06:00:00' AS Time), CAST(N'09:30:00' AS Time), N'APPROVED', 100, 0, 0, 79, 17, 0, CAST(N'2024-11-27' AS Date), CAST(N'1970-01-01' AS Date))
INSERT [dbo].[Event] ([id], [organizerId], [fullname], [avatarPath], [description], [categoryId], [locationId], [dateOfEvent], [startTime], [endTime], [status], [guestRegisterLimit], [collaboratorRegisterLimit], [guestAttendedCount], [guestRegisterCount], [guestRegisterCancelCount], [collaboratorRegisterCount], [guestRegisterDeadline], [collaboratorRegisterDeadline]) VALUES (8, 9, N'TALKSHOW - FUNDRAISING FOR STARTUPS', N'/assets/upload/images/da97e807-9570-4fde-9bb7-7c4bb878a85a.jpg', N'𝐓𝐚𝐥𝐤𝐬𝐡𝐨𝐰 "𝐅𝐮𝐧𝐝𝐫𝐚𝐢𝐬𝐢𝐧𝐠 𝐟𝐨𝐫 𝐒𝐭𝐚𝐫𝐭𝐮𝐩𝐬" thuộc chuỗi sự kiện 𝑇𝑟𝑎̉𝑖 𝑛𝑔ℎ𝑖𝑒̣̂𝑚 𝐾ℎ𝑜̛̉𝑖 𝑛𝑔ℎ𝑖𝑒̣̂𝑝 đã được tổ chức thành công.

Chương trình có sự tham gia của anh 𝑽𝒖̃ 𝑿𝒖𝒂̂𝒏 𝑻𝒓𝒖̛𝒐̛̀𝒏𝒈 - Business Innovation Manager đến từ công ty ENOUVO. Qua phần trình bày đầy thông tin nhưng không kém phần hài hước của anh Trường, nhiều kiến thức bổ ích đã được truyền tải đến các bạn sinh viên. Những câu chuyện thực tế từ diễn giả làm phần thuyết trình thêm sinh động, đúc kết nhiều kinh nghiệm quý báu cho việc kêu gọi vốn cũng như lựa chọn nhà đầu tư phù hợp.
Các sinh viên quan tâm đến chủ đề đã sôi nổi đặt câu hỏi cho diễn giả. Với những khó khăn cụ thể mà sinh viên gặp phải từ chính dự án của mình, diễn giả đã đưa ra lời khuyên hữu ích, giúp các bạn hiểu rõ hơn về các vấn đề phát sinh và biết được hướng đi tiếp theo.

Cùng xem lại những hình ảnh của Talkshow cuối cùng của chuỗi sự kiện 𝑇𝑟𝑎̉𝑖 𝑛𝑔ℎ𝑖𝑒̣̂𝑚 𝐾ℎ𝑜̛̉𝑖 𝑛𝑔ℎ𝑖𝑒̣̂𝑝 trong học kỳ Fall 2024. 

Sắp tới sẽ là lúc những sản phẩm của các bạn sinh viên được "lên sàn" tại sự kiện Pitching của bộ môn, hãy cùng đón chờ nhé!', 1, 1, CAST(N'2024-11-10' AS Date), CAST(N'08:00:00' AS Time), CAST(N'10:00:00' AS Time), N'APPROVED', 200, 0, 0, 0, 0, 0, CAST(N'2024-11-10' AS Date), CAST(N'1970-01-01' AS Date))
INSERT [dbo].[Event] ([id], [organizerId], [fullname], [avatarPath], [description], [categoryId], [locationId], [dateOfEvent], [startTime], [endTime], [status], [guestRegisterLimit], [collaboratorRegisterLimit], [guestAttendedCount], [guestRegisterCount], [guestRegisterCancelCount], [collaboratorRegisterCount], [guestRegisterDeadline], [collaboratorRegisterDeadline]) VALUES (9, 2, N'PITCHING CHALLENGE - THUYẾT TRÌNH GỌI VỐN CHO DỰ ÁN KHỞI NGHIỆP', N'/assets/upload/images/e4d8c520-828c-4ca7-be92-37091f887609.jpg', N'ằm trong chuỗi hoạt động nổi bật tại FPTU Career Fair 2024, Pitching Challenge: “Thuyết trình gọi vốn cho dự án khởi nghiệp” là một thử thách dành cho các bạn có đam mê khởi nghiệp. 
🌿 Với nhiều dự án đột phá nhưng cũng đầy ý nghĩa, các nhóm sinh viên tham dự đã có cơ hội cọ xát thực tế, đưa ra những lý lẽ để thuyết phục với các “Sharks” đầu tư. ', 1, 1, CAST(N'2024-11-11' AS Date), CAST(N'09:30:00' AS Time), CAST(N'23:30:00' AS Time), N'APPROVED', 100, 0, 0, 16, 0, 0, CAST(N'2024-11-16' AS Date), CAST(N'1970-01-01' AS Date))
INSERT [dbo].[Event] ([id], [organizerId], [fullname], [avatarPath], [description], [categoryId], [locationId], [dateOfEvent], [startTime], [endTime], [status], [guestRegisterLimit], [collaboratorRegisterLimit], [guestAttendedCount], [guestRegisterCount], [guestRegisterCancelCount], [collaboratorRegisterCount], [guestRegisterDeadline], [collaboratorRegisterDeadline]) VALUES (10, 3, N'TALKSHOW CON ĐƯỜNG SINH VIÊN', N'/assets/upload/images/8ed4c09c-9a76-493c-9a5e-050e1ff6184b.jpg', N', TALKSHOW “CON ĐƯỜNG SINH VIÊN - BỨC TRANH ĐA SẮC CHO HÀNH TRÌNH SINH VIÊN“ đã mang đến cho các cóc nhà F những chủ đề thú vị về hành trình sinh viên.
📈 Qua buổi talkshow này, các bạn sinh viên đã có cơ hội khám phá bản thân và mang về cho mình định hướng tương lai rõ ràng thông qua các thông tin thực tế . Dưới góc độ của của 3 sinh viên tài năng góp mặt ngày hôm nay, chúng ta đã có những chia sẻ vô cùng cần thiết và ý nghĩa về lĩnh vực này.
📝 Hy vọng qua buổi talkshow, các bạn đã thu nhặt được những kiến thức hữu ích cho bản thân.
📸 Hãy cùng lướt lại những hình ảnh mà các bạn sinh viên đã trải qua tại TALKSHOW về “ CON ĐƯỜNG SINH VIÊN” ngay dưới đây nhé!', 6, 2, CAST(N'2024-11-01' AS Date), CAST(N'21:30:00' AS Time), CAST(N'23:30:00' AS Time), N'END', 100, 0, 83, 86, 30, 0, CAST(N'2024-11-01' AS Date), CAST(N'1970-01-01' AS Date))
INSERT [dbo].[Event] ([id], [organizerId], [fullname], [avatarPath], [description], [categoryId], [locationId], [dateOfEvent], [startTime], [endTime], [status], [guestRegisterLimit], [collaboratorRegisterLimit], [guestAttendedCount], [guestRegisterCount], [guestRegisterCancelCount], [collaboratorRegisterCount], [guestRegisterDeadline], [collaboratorRegisterDeadline]) VALUES (11, 9, N'HÀNH TRANG - CHUẨN BỊ CHO KỲ OJT SPRING 2025', N'/assets/upload/images/b4acdf5b-81aa-40f1-bec2-b8573cf5003f.png', N'OJT (On-the-Job Training) là thời điểm mà sinh viên được đào tạo và trải nghiệm thực tế trong môi trường doanh nghiệp, tiếp xúc trực tiếp với văn hóa làm việc. Đây cũng là quãng thời gian đáng nhớ, mang lại nhiều niềm vui và phấn khích, nhưng cũng không thiếu thử thách và sự lo lắng.
Để chuẩn bị sẵn sàng cho học kỳ thực tế tại doanh nghiệp, hãy tham gia ngay chương trình "Định Hướng OJT" để hiểu rõ hơn về các quy định và cách chọn vị trí phù hợp.', 1, 1, CAST(N'2024-11-08' AS Date), CAST(N'07:15:00' AS Time), CAST(N'11:00:00' AS Time), N'APPROVED', 100, 0, 0, 2, 0, 0, CAST(N'2024-11-10' AS Date), CAST(N'1970-01-01' AS Date))
INSERT [dbo].[Event] ([id], [organizerId], [fullname], [avatarPath], [description], [categoryId], [locationId], [dateOfEvent], [startTime], [endTime], [status], [guestRegisterLimit], [collaboratorRegisterLimit], [guestAttendedCount], [guestRegisterCount], [guestRegisterCancelCount], [collaboratorRegisterCount], [guestRegisterDeadline], [collaboratorRegisterDeadline]) VALUES (12, 9, N'[FIELD TRIP] TRẢI NGHIỆP HỌC TẬP VỚI TÁC PHẨM MỸ THUẬT VIỆT NAM', N'/assets/upload/images/9be922bf-6a28-4e74-b59d-8bd27170088c.jpg', N'🌤SINH VIÊN CHUYÊN NGÀNH GRAPHIC DESIGN "CHỮA LÀNH" TẠI HỘI AN
📸 Trường Đại học FPT đã tổ chức thành công chuyến field trip "Nghiên cứu và thực hành nhiếp ảnh đường phố" tại Phố Cổ Hội An và Làng gốm Thanh Hà. Hơn 100 sinh viên chuyên ngành Thiết kế Đồ họa (Graphic Design) đã có cơ hội học tập và trải nghiệm thực tế về tư duy bố cục nhiếp ảnh. 
📸 Chuyến đi còn mang lại cho các bạn cái nhìn sâu sắc hơn về nét văn hóa cổ xưa của miền Trung, đặc biệt là nghệ thuật truyền thống tại Làng gốm Thanh Hà.
💯 Chương trình kết thúc với nhiều trải nghiệm quý báu, hứa hẹn sẽ giúp các bạn có tư liệu phong phú để hoàn thành tốt các bài tập và nhiệm vụ mà môn học giao phó.', 1, 1, CAST(N'2024-11-06' AS Date), CAST(N'14:00:00' AS Time), CAST(N'18:00:00' AS Time), N'END', 70, 0, 64, 55, 8, 0, CAST(N'2024-11-01' AS Date), CAST(N'1970-01-01' AS Date))
INSERT [dbo].[Event] ([id], [organizerId], [fullname], [avatarPath], [description], [categoryId], [locationId], [dateOfEvent], [startTime], [endTime], [status], [guestRegisterLimit], [collaboratorRegisterLimit], [guestAttendedCount], [guestRegisterCount], [guestRegisterCancelCount], [collaboratorRegisterCount], [guestRegisterDeadline], [collaboratorRegisterDeadline]) VALUES (13, 3, N'THIẾT LẬP WORKFLOWS, CI/CD PIPELINE CHO DỰ ÁN .NET', N'/assets/upload/images/13a87a29-ab84-4c2d-8f6c-791428cefbd9.jpg', N'Vòng chung kết cuộc thi "Thiết lập CI/CD Pipeline cho dự án .NET" vừa diễn ra vào ngày 05/10/2024 tại Trường Đại học FPT Đà Nẵng. Sự kiện đã thu hút sự tham gia của 12 nhóm sinh viên. Sự kiện này là một phần trong chuỗi Workshop & Practical "Thiết lập Workflows, CI/CD Pipeline cho dự án .NET". 
✨ Các nhóm sinh viên đã trình bày và triển khai các dự án bằng những kiến thức đã học từ workshop ngày 27/9, tạo nên không khí cạnh tranh sôi nổi và đầy sáng tạo. Bộ ba giám khảo đáng kính - anh Nguyễn Xuân Long, cô Trần Thị Tố Tâm, và anh Lê Thiện Nhật Quang - đã đưa ra những đánh giá và góp ý sâu sắc, giúp các bạn nhận ra khuyết điểm và cải thiện kỹ năng của mình. ', 1, 2, CAST(N'2024-10-30' AS Date), CAST(N'09:30:00' AS Time), CAST(N'11:10:00' AS Time), N'END', 100, 0, 88, 90, 17, 0, CAST(N'2024-10-30' AS Date), CAST(N'1970-01-01' AS Date))
INSERT [dbo].[Event] ([id], [organizerId], [fullname], [avatarPath], [description], [categoryId], [locationId], [dateOfEvent], [startTime], [endTime], [status], [guestRegisterLimit], [collaboratorRegisterLimit], [guestAttendedCount], [guestRegisterCount], [guestRegisterCancelCount], [collaboratorRegisterCount], [guestRegisterDeadline], [collaboratorRegisterDeadline]) VALUES (14, 3, N'CẤU TRÚC DỮ LIỆU VÀ GIẢI THUẬT TRONG MÔ HÌNH AI', N'/assets/upload/images/afcb94c6-34b5-4402-a988-2954206eaa73.jpg', N'Workshop “Cấu trúc dữ liệu và giải thuật trong mô hình AI” đã diễn ra vô cùng thành công vào ngày 03/10/2024 với sự tham gia của các bạn sinh viên Đại học FPT Đà Nẵng. 
Với những chia sẻ đầy bổ ích đến từ diễn giả Phạm Phú Thành - Chuyên gia AI, FPT Software, các bạn sinh viên đã có cơ hội nắm bắt được tầm quan trọng của cấu trúc dữ liệu và giải thuật trong mô hình AI cũng như các ứng dụng thực tế của chúng. Những kinh nghiệm thực tế từ diễn giả chắc chắn sẽ là hành trang quý báu cho các bạn trong tương lai.', 1, 1, CAST(N'2024-11-16' AS Date), CAST(N'09:20:00' AS Time), CAST(N'11:20:00' AS Time), N'PENDING', 100, 0, 0, 0, 0, 0, CAST(N'2024-11-11' AS Date), CAST(N'1970-01-01' AS Date))
INSERT [dbo].[Event] ([id], [organizerId], [fullname], [avatarPath], [description], [categoryId], [locationId], [dateOfEvent], [startTime], [endTime], [status], [guestRegisterLimit], [collaboratorRegisterLimit], [guestAttendedCount], [guestRegisterCount], [guestRegisterCancelCount], [collaboratorRegisterCount], [guestRegisterDeadline], [collaboratorRegisterDeadline]) VALUES (15, 9, N'WORKSHOP - SOFTWARE DESIGN', N'/assets/upload/images/9ed81b08-be5f-480d-afa3-4ae5a14a7609.jpg', N'📢𝑾𝑶𝑹𝑲𝑺𝑯𝑶𝑷 "𝑺𝑶𝑭𝑻𝑾𝑨𝑹𝑬 𝑫𝑬𝑺𝑰𝑮𝑵" | 𝑪𝒉𝒊𝒂 𝒔𝒆̉ 𝒌𝒊𝒆̂́𝒏 𝒕𝒉𝒖̛́𝒄 𝒗𝒆̂̀ 𝒕𝒉𝒊𝒆̂́𝒕 𝒌𝒆̂́ 𝒑𝒉𝒂̂̀𝒏 𝒎𝒆̂̀𝒎.
 
✨ Software design là một trong những kỹ năng quan trọng trong ngành công nghệ phần mềm. Để giúp các bạn sinh viên hoàn thành tốt môn học SWP391, workshop lần này sẽ mang đến những kiến thức bổ ích và thực tiễn về thiết kế phần mềm.

👥 Diễn giả của chúng ta, 𝑴𝒓. 𝑵𝒈𝒖𝒚𝒆̂̃𝒏 𝑽𝒂̆𝒏 𝑳𝒊𝒆̂𝒎, hiện đang là Training Manager, Senior SPM của FPT Software với nhiều năm kinh nghiệm trong lĩnh vực kỹ thuật phần mềm. Với sự dẫn dắt của anh, các bạn sẽ có cơ hội học hỏi và nắm bắt được những kỹ năng cần thiết để thiết kế và phát triển phần mềm một cách hiệu quả.', 1, 1, CAST(N'2024-11-15' AS Date), CAST(N'08:00:00' AS Time), CAST(N'10:00:00' AS Time), N'APPROVED', 50, 0, 0, 0, 0, 0, CAST(N'2024-11-10' AS Date), CAST(N'1970-01-01' AS Date))
INSERT [dbo].[Event] ([id], [organizerId], [fullname], [avatarPath], [description], [categoryId], [locationId], [dateOfEvent], [startTime], [endTime], [status], [guestRegisterLimit], [collaboratorRegisterLimit], [guestAttendedCount], [guestRegisterCount], [guestRegisterCancelCount], [collaboratorRegisterCount], [guestRegisterDeadline], [collaboratorRegisterDeadline]) VALUES (16, 3, N'Talkshow - Be Successful In Your Own Way', N'/assets/upload/images/85136908-2128-416d-ba09-0d1db06f8ca6.jpg', N'Talkshow "Be Successful In Your Own Way" sẽ được tổ chức với sự tham gia của hơn 400 sinh viên FPT (online & offline) cùng với các Khách mời là chuyên gia về các khía cạnh của "Khởi nghiệp". Chương trình đã giúp các bạn sinh viên dần hiểu và tiếp cận gần hơn với "Khởi nghiệp", truyền cảm hứng và củng cố sự tin đến các bạn.
Talkshow mở đầu bằng một mini game thú vị từ Giám đốc bán hàng Selly - Ms. Lê Thị Cẩm Trinh. Qua đó, chị có thể phần nào nắm thêm thông tin và hiểu biết của các bạn sinh viên về Khởi nghiệp. Từ đó, chị khéo léo truyền tải "Những giá trị của Khởi nghiệp" đến cho các bạn sinh viên một cách hệ thống và khoa học. 
Tiếp sau đó, Thầy Lê Thiện Nhật Quang đã chia sẽ các nghiên cứu tâm huyết của mình về "Triển khai dự án trên không gian số". Với việc cung cấp những nền tảng triển khai và quản lý dự án, kèm với đó là sự đánh giá so sánh chi tiết, các bạn sinh viên đã có sự chuẩn bị đầy đủ cho mình trong các dự án của mình trong tương lai.
Đối mặt với các câu đố hóc búa của diễn giả, các bạn sinh viên đã có câu trả lời chính xác, thể hiện được là có sự tìm hiểu và hứng thú với môn học.', 1, 1, CAST(N'2024-11-22' AS Date), CAST(N'09:30:00' AS Time), CAST(N'11:20:00' AS Time), N'PENDING', 100, 0, 0, 0, 0, 0, CAST(N'2024-11-16' AS Date), CAST(N'1970-01-01' AS Date))
INSERT [dbo].[Event] ([id], [organizerId], [fullname], [avatarPath], [description], [categoryId], [locationId], [dateOfEvent], [startTime], [endTime], [status], [guestRegisterLimit], [collaboratorRegisterLimit], [guestAttendedCount], [guestRegisterCount], [guestRegisterCancelCount], [collaboratorRegisterCount], [guestRegisterDeadline], [collaboratorRegisterDeadline]) VALUES (17, 9, N'|TALKSHOW| FINTECH - Xu hướng tài chính của tương lai', N'/assets/upload/images/6ba83b25-69bd-455f-b384-4d9ef2d68082.jpg', N'✨ Fintech đang thay đổi cách chúng ta sử dụng các dịch vụ tài chính. Talkshow lần này sẽ mang đến cho sinh viên cái nhìn sâu sắc về Fintech, từ những ứng dụng thực tế đến các xu hướng mới nhất, cùng các cơ hội nghề nghiệp và kỹ năng cần thiết trong lĩnh vực này.

Buổi talkshow được dẫn dắt bởi diễn giả: 
👥 Thầy Võ An Hải – Giảng viên bộ môn Business, Đại học FPT Đà Nẵng.
👥 Anh Đỗ Khắc Thành Nhân – Chuyên gia Phân tích tài chính cấp cao, Finance Service của FPT Software.
Tại talkshow, bạn sẽ có cơ hội:
 Tìm hiểu về Fintech từ những ứng dụng thực tế đến các xu hướng mới nhất.
 Khám phá các kỹ năng cần thiết để phát triển trong lĩnh vực này.
 Tìm hiểu cơ hội nghề nghiệp và tương lai của Fintech tại Việt Nam và trên thế giới.', 1, 1, CAST(N'2024-11-13' AS Date), CAST(N'15:00:00' AS Time), CAST(N'18:00:00' AS Time), N'APPROVED', 150, 0, 135, 119, 22, 0, CAST(N'2024-11-04' AS Date), CAST(N'1970-01-01' AS Date))
INSERT [dbo].[Event] ([id], [organizerId], [fullname], [avatarPath], [description], [categoryId], [locationId], [dateOfEvent], [startTime], [endTime], [status], [guestRegisterLimit], [collaboratorRegisterLimit], [guestAttendedCount], [guestRegisterCount], [guestRegisterCancelCount], [collaboratorRegisterCount], [guestRegisterDeadline], [collaboratorRegisterDeadline]) VALUES (18, 8, N'EVo:LUTION FASHION SHOW', N'/assets/upload/images/7d3460df-cc17-4569-8685-a58866ec1beb.jpg', N' 𝐄𝐕𝐨:𝐥𝐮𝐭𝐢𝐨𝐧 𝐅𝐚𝐬𝐡𝐢𝐨𝐧 𝐒𝐡𝐨𝐰 đã khép lại thành công rực rỡ, để lại dư âm khó phai với những màn trình diễn mãn nhãn, tỏa sáng phong cách riêng. Mỗi bước catwalk uyển chuyển, mỗi thần thái tự tin cùng những bộ trang phục độc đáo đã tạo nên bức tranh thời trang đa sắc, sống động và đầy cảm hứng. 
📸 Dàn thí sinh "trai xinh gái đẹp" đã thực sự "cháy" hết mình, tỏa sáng rực rỡ trên sàn diễn, phô diễn kỹ năng catwalk chuyên nghiệp hứa hẹn một 𝐄𝐕𝐨:𝐥𝐮𝐭𝐢𝐨𝐧 𝐅𝐚𝐬𝐡𝐢𝐨𝐧 𝐒𝐡𝐨𝐰 bùng nổ và đáng mong chờ. Xin chân thành cảm ơn các bạn đã dành thời gian quan tâm đến sự kiện của chúng mình. 
✨ Đừng đi đâu nhé, EVo sẽ quay trở lại ngay. Hãy chuẩn bị tinh thần để đón chờ sân khấu chất ngất tại 𝐄𝐕𝐨:𝐥𝐮𝐭𝐢𝐨𝐧 𝐅𝐚𝐬𝐡𝐢𝐨𝐧 𝐒𝐡𝐨𝐰!!!', 1, 1, CAST(N'2024-11-23' AS Date), CAST(N'17:30:00' AS Time), CAST(N'20:30:00' AS Time), N'PENDING', 100, 0, 0, 2, 0, 0, CAST(N'2024-11-16' AS Date), CAST(N'1970-01-01' AS Date))
INSERT [dbo].[Event] ([id], [organizerId], [fullname], [avatarPath], [description], [categoryId], [locationId], [dateOfEvent], [startTime], [endTime], [status], [guestRegisterLimit], [collaboratorRegisterLimit], [guestAttendedCount], [guestRegisterCount], [guestRegisterCancelCount], [collaboratorRegisterCount], [guestRegisterDeadline], [collaboratorRegisterDeadline]) VALUES (19, 8, N'VẦNG TRĂNG YÊU THƯƠNG SS2 | ẤM LÒNG MÙA TRUNG THU', N'/assets/upload/images/05e5e6ad-af32-47f9-b4d1-98ed5ff42d87.jpg', N' CLB F2K cùng CLB EVo đã mang sự kiện Trung thu đáng nhớ đến với các em nhỏ ở Làng Hy Vọng. Cùng tham gia workshop trang trí đèn lồng, cùng chơi đùa và nhận những món quà thật ý nghĩa, những khoảnh khắc ấy sẽ mãi là ký ức đẹp trong trái tim mỗi em nhỏ cũng như thành viên F2K và EVo.
🥮 EVo x F2K xin cảm ơn tất cả những tấm lòng hảo tâm đã cùng vẽ nên cái tết đoàn viên thật đặc biệt này. Hy vọng rằng, tình yêu thương sẽ mãi soi sáng những ước mơ và hy vọng nơi các em.
“Trung Thu qua đi, nhưng niềm vui ở lại.”', 1, 5, CAST(N'2024-11-01' AS Date), CAST(N'09:35:00' AS Time), CAST(N'11:35:00' AS Time), N'END', 100, 0, 0, 86, 27, 0, CAST(N'2024-11-16' AS Date), CAST(N'1970-01-01' AS Date))
INSERT [dbo].[Event] ([id], [organizerId], [fullname], [avatarPath], [description], [categoryId], [locationId], [dateOfEvent], [startTime], [endTime], [status], [guestRegisterLimit], [collaboratorRegisterLimit], [guestAttendedCount], [guestRegisterCount], [guestRegisterCancelCount], [collaboratorRegisterCount], [guestRegisterDeadline], [collaboratorRegisterDeadline]) VALUES (20, 8, N'TALKSHOW NGHỀ SỰ KIỆN', N'/assets/upload/images/cc74dae2-8498-418c-a7f9-ce5bc21355be.jpg', N'𝐓𝐚𝐥𝐤𝐬𝐡𝐨𝐰 “𝐍𝐠𝐡𝐞̂̀ 𝐬𝐮̛̣ 𝐤𝐢𝐞̣̂𝐧” diễn ra thành công rực rỡ với sự góp mặt của  diễn giả 𝐏𝐡𝐚̣𝐦 𝐓𝐫𝐮̛𝐨̛̀𝐧𝐠 𝐐𝐮𝐨̂́𝐜 𝐕𝐮̛𝐨̛𝐧𝐠 và diễn giả 𝐒𝐚𝐦 𝐍𝐠𝐮𝐲𝐞̂̃𝐧 với những kinh nghiệm và câu chuyện trong nghề sự kiện, để lại những lắng đọng trong lòng thính giả.
💌 Một lần nữa EVo xin cảm ơn hai khách mời diễn giả đã đến chia sẻ câu chuyện, và đặc biệt hơn, EVo xin gửi lời cảm ơn chân thành đến các bạn thính giả đã dành thời gian đến tham dự Talkshow. Dự án này đã góp phần giúp các bạn trẻ có cái nhìn rõ hơn về nghề sự kiện và khơi dậy đam mê phát triển trong ngành nghề thú vị này. 
💖 Sự ủng hộ của các bạn là động lực để EVo phát triển hơn nữa, cùng đón chờ những sự kiện tiếp theo của EVo nhé. Và bây giờ cùng nhìn ngắm những hình ảnh đáng nhớ của 𝐓𝐚𝐥𝐤𝐬𝐡𝐨𝐰 “𝐍𝐠𝐡𝐞̂̀ 𝐬𝐮̛̣ 𝐤𝐢𝐞̣̂𝐧” thôi nào!', 1, 1, CAST(N'2024-11-05' AS Date), CAST(N'17:30:00' AS Time), CAST(N'19:30:00' AS Time), N'END', 100, 0, 0, 0, 0, 0, CAST(N'2024-11-16' AS Date), CAST(N'1970-01-01' AS Date))
INSERT [dbo].[Event] ([id], [organizerId], [fullname], [avatarPath], [description], [categoryId], [locationId], [dateOfEvent], [startTime], [endTime], [status], [guestRegisterLimit], [collaboratorRegisterLimit], [guestAttendedCount], [guestRegisterCount], [guestRegisterCancelCount], [collaboratorRegisterCount], [guestRegisterDeadline], [collaboratorRegisterDeadline]) VALUES (22, 9, N'[FIELD TRIP] TRẢI NGHIỆM THỰC TẾ TẠI FURAMA RESORT DANANG', N'/assets/upload/images/d7c026a2-fa38-433b-8d78-d80fa91febf5.jpg', N'✨Môi trường học tập tại Đại học FPT không chỉ dừng lại ở giảng đường mà còn mở rộng ra những chuyến đi thực tế đầy thú vị. Hãy tham gia ngay chuyến tham quan thực tế tại Furama Resort Danang để khám phá môi trường làm việc chuyên nghiệp, mang tính quốc tế trong ngành du lịch và khách sạn, do bộ môn Ngôn ngữ Anh tổ chức!

Chuyến tham quan này nhằm tạo cơ hội cho sinh viên hiểu rõ hơn về môi trường làm việc thực tế, mang đến góc nhìn đa chiều về ngành du lịch và khách sạn. Đồng thời, chương trình truyền động lực và mở rộng lựa chọn nghề nghiệp cho sinh viên chuyên ngành Ngôn Ngữ Anh.', 1, 1, CAST(N'2024-11-23' AS Date), CAST(N'09:30:00' AS Time), CAST(N'11:45:00' AS Time), N'APPROVED', 100, 0, 0, 15, 0, 0, CAST(N'2024-11-16' AS Date), CAST(N'1970-01-01' AS Date))
INSERT [dbo].[Event] ([id], [organizerId], [fullname], [avatarPath], [description], [categoryId], [locationId], [dateOfEvent], [startTime], [endTime], [status], [guestRegisterLimit], [collaboratorRegisterLimit], [guestAttendedCount], [guestRegisterCount], [guestRegisterCancelCount], [collaboratorRegisterCount], [guestRegisterDeadline], [collaboratorRegisterDeadline]) VALUES (23, 9, N'Seminar về Digital Marketing - Corporate and Personal Branding: The Power of Digital Marketing', N'/assets/upload/images/51002e3a-cab8-4fda-bed0-ef9f636e8a2f.jpg', N'NHỮNG GÓC NHÌN MỚI LẠ VỀ VIỆC PHÁT TRIỂN THƯƠNG HIỆU KHƠI DẬY VÀ THỔI BÙNG NGỌN LỬA CẢM HỨNG TRONG LĨNH VỰC DIGITAL MARKETING.
✨Sự kiện Seminar về Digital Marketing "Corporate and Personal Branding: The Power of Digital Marketing" được phòng QHDN cùng bộ môn Quản trị kinh doanh Đại học FPT Đà Nẵng tổ chức thành công tốt đẹp.
✨Chị Nguyễn Phương Dung và anh Trang Lê Hà Nam đã mang lại nhiều thông tin quý báu qua những phần trình bày về thương hiệu doanh nghiệp, thương hiệu cá nhân. Qua phần trình bày của hai vị diễn giả uy tín đã giúp củng cố kiến thức và cập nhật các xu hướng mới trong việc áp dụng digital marketing để xây dựng thương hiệu của doanh nghiệp. Sinh viên được trang bị kiến thức và kỹ năng sử dụng digital marketing để tạo dựng thương hiệu cá nhân cho bản thân, từ đó tăng cơ hội phát triển nghề nghiệp trong tương lai. 
✨Những câu trả lời của anh chị qua phần Q&A giúp nhiều bạn sinh viên gỡ rối những vấn đề đang gặp phải, định hướng con đường phát triển sự nghiệp của mình trong tương lai.', 1, 1, CAST(N'2024-11-30' AS Date), CAST(N'15:00:00' AS Time), CAST(N'17:00:00' AS Time), N'PENDING', 100, 0, 0, 56, 3, 0, CAST(N'2024-11-23' AS Date), CAST(N'1970-01-01' AS Date))
INSERT [dbo].[Event] ([id], [organizerId], [fullname], [avatarPath], [description], [categoryId], [locationId], [dateOfEvent], [startTime], [endTime], [status], [guestRegisterLimit], [collaboratorRegisterLimit], [guestAttendedCount], [guestRegisterCount], [guestRegisterCancelCount], [collaboratorRegisterCount], [guestRegisterDeadline], [collaboratorRegisterDeadline]) VALUES (24, 3, N'FPT Career Fair 2024 ', N'/assets/upload/images/269ee2af-1f66-41cd-a76d-227edde21816.jpg', N'FPTU Career Fair 2024 - Crossway Station là tuần lễ việc làm với nhiều hoạt động trải nghiệm đa dạng dành cho toàn bộ sinh viên Trường Đại học FPT.
Tham gia chương trình, sinh viên sẽ có cơ hội trải nghiệm môi trường làm việc thực tế tại các tập đoàn, doanh nghiệp hàng đầu; gặp gỡ trực tiếp các nhà tuyển dụng; được phỏng vấn; tìm hiểu về các chương trình thực tập, đào tạo, việc làm sau khi tốt nghiệp và các cơ hội nghề nghiệp hấp dẫn khác. Ngoài ra, sinh viên còn có cơ hội sửa CV trực tiếp cùng các chuyên gia từ doanh nghiệp, giúp tăng cơ hội thành công trong quá trình ứng tuyển.
', 1, 1, CAST(N'2024-11-24' AS Date), CAST(N'10:33:00' AS Time), CAST(N'11:34:00' AS Time), N'APPROVED', 100, 0, 0, 0, 0, 0, CAST(N'2024-11-17' AS Date), CAST(N'1970-01-01' AS Date))
SET IDENTITY_INSERT [dbo].[Event] OFF
GO
INSERT [dbo].[EventGuest] ([guestId], [eventId], [isRegistered], [isAttended], [isCancelRegister]) VALUES (2, 2, 0, 1, 0)
INSERT [dbo].[EventGuest] ([guestId], [eventId], [isRegistered], [isAttended], [isCancelRegister]) VALUES (2, 5, 0, 1, 0)
INSERT [dbo].[EventGuest] ([guestId], [eventId], [isRegistered], [isAttended], [isCancelRegister]) VALUES (3, 2, 0, 1, 0)
INSERT [dbo].[EventGuest] ([guestId], [eventId], [isRegistered], [isAttended], [isCancelRegister]) VALUES (3, 5, 0, 1, 0)
INSERT [dbo].[EventGuest] ([guestId], [eventId], [isRegistered], [isAttended], [isCancelRegister]) VALUES (4, 2, 0, 1, 0)
INSERT [dbo].[EventGuest] ([guestId], [eventId], [isRegistered], [isAttended], [isCancelRegister]) VALUES (4, 4, 1, 0, 0)
INSERT [dbo].[EventGuest] ([guestId], [eventId], [isRegistered], [isAttended], [isCancelRegister]) VALUES (4, 5, 0, 1, 0)
INSERT [dbo].[EventGuest] ([guestId], [eventId], [isRegistered], [isAttended], [isCancelRegister]) VALUES (4, 7, 1, 0, 0)
INSERT [dbo].[EventGuest] ([guestId], [eventId], [isRegistered], [isAttended], [isCancelRegister]) VALUES (4, 23, 1, 0, 0)
INSERT [dbo].[EventGuest] ([guestId], [eventId], [isRegistered], [isAttended], [isCancelRegister]) VALUES (5, 2, 0, 1, 0)
INSERT [dbo].[EventGuest] ([guestId], [eventId], [isRegistered], [isAttended], [isCancelRegister]) VALUES (5, 5, 0, 1, 0)
INSERT [dbo].[EventGuest] ([guestId], [eventId], [isRegistered], [isAttended], [isCancelRegister]) VALUES (6, 2, 0, 1, 0)
INSERT [dbo].[EventGuest] ([guestId], [eventId], [isRegistered], [isAttended], [isCancelRegister]) VALUES (6, 5, 0, 1, 0)
GO
SET IDENTITY_INSERT [dbo].[EventImage] ON 

INSERT [dbo].[EventImage] ([id], [eventId], [path]) VALUES (16, 3, N'/assets/upload/images/77acd1e2-be81-47f0-83e5-e910661a1315.jpg')
INSERT [dbo].[EventImage] ([id], [eventId], [path]) VALUES (17, 3, N'/assets/upload/images/39434161-ad0c-4bc2-99a1-b43fdcefb80a.jpg')
INSERT [dbo].[EventImage] ([id], [eventId], [path]) VALUES (18, 3, N'/assets/upload/images/2f59a9e9-7ff6-4f29-9d68-89d6cd84014e.jpg')
INSERT [dbo].[EventImage] ([id], [eventId], [path]) VALUES (19, 3, N'/assets/upload/images/d7ff0de9-b2e6-4d8a-9e18-5e72cadc228e.jpg')
INSERT [dbo].[EventImage] ([id], [eventId], [path]) VALUES (20, 3, N'/assets/upload/images/667b198e-3ce1-4bfc-809b-2cb14b5e1baa.jpg')
INSERT [dbo].[EventImage] ([id], [eventId], [path]) VALUES (21, 3, N'/assets/upload/images/fc0040e5-f92e-4e82-ba41-13d6c474d152.jpg')
INSERT [dbo].[EventImage] ([id], [eventId], [path]) VALUES (22, 3, N'/assets/upload/images/bb399903-dd5b-4a08-baec-2cb2f9805aad.jpg')
INSERT [dbo].[EventImage] ([id], [eventId], [path]) VALUES (23, 3, N'/assets/upload/images/bd2e26af-2b81-4684-9f63-284f1de42c71.jpg')
INSERT [dbo].[EventImage] ([id], [eventId], [path]) VALUES (70, 10, N'/assets/upload/images/ecb45c29-4535-45ce-9cf3-2d8fb7a49af5.jpg')
INSERT [dbo].[EventImage] ([id], [eventId], [path]) VALUES (71, 10, N'/assets/upload/images/0bc2313d-719e-4dcb-8597-fbeb7653be60.jpg')
INSERT [dbo].[EventImage] ([id], [eventId], [path]) VALUES (72, 10, N'/assets/upload/images/e1e4ac68-8376-4f74-8cd4-563522e781f1.jpg')
INSERT [dbo].[EventImage] ([id], [eventId], [path]) VALUES (73, 10, N'/assets/upload/images/d7446c5c-8362-4f04-92f4-17eceb5f1592.jpg')
INSERT [dbo].[EventImage] ([id], [eventId], [path]) VALUES (74, 10, N'/assets/upload/images/b22bb6fd-78d6-4dbc-b02f-2cd7f3e7d158.jpg')
INSERT [dbo].[EventImage] ([id], [eventId], [path]) VALUES (75, 10, N'/assets/upload/images/c9ee3e94-270e-4687-8bae-847d6544697b.jpg')
INSERT [dbo].[EventImage] ([id], [eventId], [path]) VALUES (87, 13, N'/assets/upload/images/f20011b7-e1f0-43d7-8306-4395f9fa04e1.jpg')
INSERT [dbo].[EventImage] ([id], [eventId], [path]) VALUES (88, 13, N'/assets/upload/images/77b0894b-23d0-43a2-9cf0-5313c1150f55.jpg')
INSERT [dbo].[EventImage] ([id], [eventId], [path]) VALUES (89, 13, N'/assets/upload/images/d94f53e0-397e-4ebf-83ce-4307b2c78cee.jpg')
INSERT [dbo].[EventImage] ([id], [eventId], [path]) VALUES (90, 13, N'/assets/upload/images/39ff2733-5bf7-4db5-a549-6eed607c03c4.jpg')
INSERT [dbo].[EventImage] ([id], [eventId], [path]) VALUES (91, 13, N'/assets/upload/images/acd17a6d-cf6c-4750-a5b2-79f35dc6e158.jpg')
INSERT [dbo].[EventImage] ([id], [eventId], [path]) VALUES (92, 13, N'/assets/upload/images/5b960a13-903e-49aa-bcf5-64e364136586.jpg')
INSERT [dbo].[EventImage] ([id], [eventId], [path]) VALUES (93, 13, N'/assets/upload/images/45e023c7-2ba2-452c-94ef-2844fbbfac96.jpg')
INSERT [dbo].[EventImage] ([id], [eventId], [path]) VALUES (94, 13, N'/assets/upload/images/185aa4d1-7e76-48f7-809f-d637e3d32bb9.jpg')
INSERT [dbo].[EventImage] ([id], [eventId], [path]) VALUES (95, 13, N'/assets/upload/images/21c9fcf7-59fd-41e4-adc5-a64ab2dee712.jpg')
INSERT [dbo].[EventImage] ([id], [eventId], [path]) VALUES (128, 19, N'/assets/upload/images/3d8f0983-cb72-45d8-8fa3-28a2ec5c93f4.jpg')
INSERT [dbo].[EventImage] ([id], [eventId], [path]) VALUES (129, 19, N'/assets/upload/images/600c3e41-d288-40a0-a72d-f05e07e8170b.jpg')
INSERT [dbo].[EventImage] ([id], [eventId], [path]) VALUES (130, 19, N'/assets/upload/images/e16f5ea8-d121-46de-b131-c01b562878a7.jpg')
INSERT [dbo].[EventImage] ([id], [eventId], [path]) VALUES (131, 19, N'/assets/upload/images/1b8d7801-57ab-4e64-9e4b-491b6dbe32e1.jpg')
INSERT [dbo].[EventImage] ([id], [eventId], [path]) VALUES (179, 15, N'/assets/upload/images/9ed81b08-be5f-480d-afa3-4ae5a14a7609.jpg')
INSERT [dbo].[EventImage] ([id], [eventId], [path]) VALUES (180, 15, N'/assets/upload/images/ff469e3a-a6d3-4d36-8b43-93dd2649b3b8.jpg')
INSERT [dbo].[EventImage] ([id], [eventId], [path]) VALUES (181, 15, N'/assets/upload/images/cde9fcf2-f8bb-48ec-8c09-9432f45252d4.jpg')
INSERT [dbo].[EventImage] ([id], [eventId], [path]) VALUES (182, 15, N'/assets/upload/images/798ab53e-31d8-4532-9bb6-6ed152b16860.jpg')
INSERT [dbo].[EventImage] ([id], [eventId], [path]) VALUES (183, 15, N'/assets/upload/images/50749bc9-855e-4fcd-a260-3b91f51d6818.jpg')
INSERT [dbo].[EventImage] ([id], [eventId], [path]) VALUES (184, 15, N'/assets/upload/images/96209334-f2e2-4da3-8c61-7d844bef06d2.jpg')
INSERT [dbo].[EventImage] ([id], [eventId], [path]) VALUES (185, 8, N'/assets/upload/images/da97e807-9570-4fde-9bb7-7c4bb878a85a.jpg')
INSERT [dbo].[EventImage] ([id], [eventId], [path]) VALUES (186, 8, N'/assets/upload/images/959fefa8-7e58-46f7-82d9-5de46ce665a8.jpg')
INSERT [dbo].[EventImage] ([id], [eventId], [path]) VALUES (187, 8, N'/assets/upload/images/3670865a-f81f-45fe-a373-b013409dfbcc.jpg')
INSERT [dbo].[EventImage] ([id], [eventId], [path]) VALUES (188, 8, N'/assets/upload/images/cd50b81a-c5fb-4569-9831-412e239e356d.jpg')
INSERT [dbo].[EventImage] ([id], [eventId], [path]) VALUES (189, 5, N'/assets/upload/images/204bf75e-5cb1-4ccc-9e68-45ec027a8bfd.jpg')
INSERT [dbo].[EventImage] ([id], [eventId], [path]) VALUES (190, 5, N'/assets/upload/images/2b3729ad-2b77-4ca4-91f8-b9343bffdc16.jpg')
INSERT [dbo].[EventImage] ([id], [eventId], [path]) VALUES (191, 5, N'/assets/upload/images/c150b746-d4f2-4053-bb70-41f90f59e497.jpg')
INSERT [dbo].[EventImage] ([id], [eventId], [path]) VALUES (192, 5, N'/assets/upload/images/7b005c5c-d4fb-43fe-b6ac-3053ec5878b8.jpg')
INSERT [dbo].[EventImage] ([id], [eventId], [path]) VALUES (193, 5, N'/assets/upload/images/000d89dc-36ca-461e-a40b-3f44a43104a2.jpg')
INSERT [dbo].[EventImage] ([id], [eventId], [path]) VALUES (194, 15, N'/assets/upload/images/ff469e3a-a6d3-4d36-8b43-93dd2649b3b8.jpg')
INSERT [dbo].[EventImage] ([id], [eventId], [path]) VALUES (195, 15, N'/assets/upload/images/cde9fcf2-f8bb-48ec-8c09-9432f45252d4.jpg')
INSERT [dbo].[EventImage] ([id], [eventId], [path]) VALUES (196, 15, N'/assets/upload/images/798ab53e-31d8-4532-9bb6-6ed152b16860.jpg')
INSERT [dbo].[EventImage] ([id], [eventId], [path]) VALUES (197, 15, N'/assets/upload/images/50749bc9-855e-4fcd-a260-3b91f51d6818.jpg')
INSERT [dbo].[EventImage] ([id], [eventId], [path]) VALUES (198, 15, N'/assets/upload/images/96209334-f2e2-4da3-8c61-7d844bef06d2.jpg')
INSERT [dbo].[EventImage] ([id], [eventId], [path]) VALUES (199, 8, N'/assets/upload/images/959fefa8-7e58-46f7-82d9-5de46ce665a8.jpg')
INSERT [dbo].[EventImage] ([id], [eventId], [path]) VALUES (200, 8, N'/assets/upload/images/3670865a-f81f-45fe-a373-b013409dfbcc.jpg')
INSERT [dbo].[EventImage] ([id], [eventId], [path]) VALUES (201, 8, N'/assets/upload/images/cd50b81a-c5fb-4569-9831-412e239e356d.jpg')
INSERT [dbo].[EventImage] ([id], [eventId], [path]) VALUES (202, 2, N'/assets/upload/images/f91eec29-79d1-41f9-9fa8-16f5b4923d0c.jpg')
INSERT [dbo].[EventImage] ([id], [eventId], [path]) VALUES (203, 2, N'/assets/upload/images/e9f01775-1e01-4c8f-9401-f7c8cdbb41f4.jpg')
INSERT [dbo].[EventImage] ([id], [eventId], [path]) VALUES (204, 2, N'/assets/upload/images/a54813ab-0cd9-4cb6-94e3-1729e996e9ec.jpg')
INSERT [dbo].[EventImage] ([id], [eventId], [path]) VALUES (205, 2, N'/assets/upload/images/ed5c0b49-220a-408e-a77f-e94d2b32adee.jpg')
INSERT [dbo].[EventImage] ([id], [eventId], [path]) VALUES (206, 2, N'/assets/upload/images/6f375fab-8286-4fa6-88be-89ed3a8c605f.jpg')
INSERT [dbo].[EventImage] ([id], [eventId], [path]) VALUES (207, 2, N'/assets/upload/images/a2358ee9-cb5d-4257-853e-43184772ce22.jpg')
INSERT [dbo].[EventImage] ([id], [eventId], [path]) VALUES (208, 2, N'/assets/upload/images/981ccc99-92be-4102-b329-c59e510eabdb.jpg')
INSERT [dbo].[EventImage] ([id], [eventId], [path]) VALUES (209, 2, N'/assets/upload/images/a71f939a-657c-4f1a-9c09-d0b8a652ac55.jpg')
INSERT [dbo].[EventImage] ([id], [eventId], [path]) VALUES (210, 2, N'/assets/upload/images/77b3746e-7b41-4116-af77-730294b6dcb7.jpg')
INSERT [dbo].[EventImage] ([id], [eventId], [path]) VALUES (211, 2, N'/assets/upload/images/e1e7fe36-25d0-446a-b173-229a76fdafd2.jpg')
INSERT [dbo].[EventImage] ([id], [eventId], [path]) VALUES (212, 2, N'/assets/upload/images/1bd91734-3c83-453c-b3e5-06ced7c92bc4.jpg')
INSERT [dbo].[EventImage] ([id], [eventId], [path]) VALUES (213, 2, N'/assets/upload/images/dcaedaba-d70f-4aee-9f2a-9f01e8d37ad0.jpg')
INSERT [dbo].[EventImage] ([id], [eventId], [path]) VALUES (214, 2, N'/assets/upload/images/05fbf6b9-5f8d-4a7b-82c9-20557dd54e28.jpg')
INSERT [dbo].[EventImage] ([id], [eventId], [path]) VALUES (215, 2, N'/assets/upload/images/1b42f48a-a20c-47b3-9207-1a8096f9e524.jpg')
INSERT [dbo].[EventImage] ([id], [eventId], [path]) VALUES (216, 2, N'/assets/upload/images/5d7c0dfa-b735-425e-9c86-6886a0c97968.jpg')
INSERT [dbo].[EventImage] ([id], [eventId], [path]) VALUES (223, 9, N'/assets/upload/images/e1d17c1c-8f17-400b-a706-0cfc43039e0c.jpg')
INSERT [dbo].[EventImage] ([id], [eventId], [path]) VALUES (224, 9, N'/assets/upload/images/829b61e6-2f23-4f14-a9f0-726bd8ce431e.jpg')
INSERT [dbo].[EventImage] ([id], [eventId], [path]) VALUES (225, 9, N'/assets/upload/images/63ff4637-80fd-4fc1-b490-0360f66c78c3.jpg')
INSERT [dbo].[EventImage] ([id], [eventId], [path]) VALUES (226, 9, N'/assets/upload/images/5d88d4ca-fa5b-4a48-9f44-c586290a0481.jpg')
INSERT [dbo].[EventImage] ([id], [eventId], [path]) VALUES (227, 9, N'/assets/upload/images/85d2efee-6dae-41d2-b547-e5b64fba4ffc.jpg')
INSERT [dbo].[EventImage] ([id], [eventId], [path]) VALUES (228, 9, N'/assets/upload/images/4011b70c-e189-4694-b2dd-44492fd4aa3d.jpg')
INSERT [dbo].[EventImage] ([id], [eventId], [path]) VALUES (229, 6, N'/assets/upload/images/2ba497ad-44a6-499f-a6e6-1024548d845a.jpg')
INSERT [dbo].[EventImage] ([id], [eventId], [path]) VALUES (230, 6, N'/assets/upload/images/c8cbf878-fa59-4352-ad60-6bc6fab5d943.jpg')
INSERT [dbo].[EventImage] ([id], [eventId], [path]) VALUES (231, 6, N'/assets/upload/images/78368d09-3deb-4fc4-bebe-27172f04dfbc.jpg')
INSERT [dbo].[EventImage] ([id], [eventId], [path]) VALUES (232, 6, N'/assets/upload/images/1a809e2e-1f47-4cfa-985e-7c005c639723.jpg')
INSERT [dbo].[EventImage] ([id], [eventId], [path]) VALUES (233, 6, N'/assets/upload/images/98572da4-3184-4c12-b842-fe2d9685c9ce.jpg')
INSERT [dbo].[EventImage] ([id], [eventId], [path]) VALUES (234, 6, N'/assets/upload/images/4caec5e3-89e0-4115-a266-88063a4beaa7.jpg')
INSERT [dbo].[EventImage] ([id], [eventId], [path]) VALUES (235, 6, N'/assets/upload/images/013bdacc-c5b4-4c8a-a0f1-9b10ec6d58a8.jpg')
INSERT [dbo].[EventImage] ([id], [eventId], [path]) VALUES (236, 6, N'/assets/upload/images/c0fb8774-4c6b-4f2a-b803-b816a7998e8b.jpg')
INSERT [dbo].[EventImage] ([id], [eventId], [path]) VALUES (237, 6, N'/assets/upload/images/4bac35e1-abf4-4ff9-97ac-43ce34451c58.jpg')
INSERT [dbo].[EventImage] ([id], [eventId], [path]) VALUES (238, 6, N'/assets/upload/images/e557b0f5-97a7-447f-87ab-7ea1fd320f0a.jpg')
INSERT [dbo].[EventImage] ([id], [eventId], [path]) VALUES (239, 17, N'/assets/upload/images/d6458d41-6f3e-4755-a603-9df1eaa29930.jpg')
INSERT [dbo].[EventImage] ([id], [eventId], [path]) VALUES (240, 17, N'/assets/upload/images/8b42e5e8-03ff-41da-9f6c-57c5caa7cfb8.jpg')
INSERT [dbo].[EventImage] ([id], [eventId], [path]) VALUES (241, 17, N'/assets/upload/images/7a2a779f-44e6-41a1-b5b3-00663d33afa4.jpg')
INSERT [dbo].[EventImage] ([id], [eventId], [path]) VALUES (242, 17, N'/assets/upload/images/5af2ee0e-179e-4921-82ce-474bf63689af.jpg')
INSERT [dbo].[EventImage] ([id], [eventId], [path]) VALUES (243, 17, N'/assets/upload/images/5c58b2e2-def4-4be9-891d-83c98402f6a6.jpg')
INSERT [dbo].[EventImage] ([id], [eventId], [path]) VALUES (244, 7, N'/assets/upload/images/c8cabe81-38e4-4bdf-be98-37b49d89258d.jpg')
INSERT [dbo].[EventImage] ([id], [eventId], [path]) VALUES (245, 7, N'/assets/upload/images/8fbca388-2614-4900-8032-18d7a1a6e97e.jpg')
INSERT [dbo].[EventImage] ([id], [eventId], [path]) VALUES (246, 7, N'/assets/upload/images/804bbaf1-ef66-4080-8f32-a8d775ef8072.jpg')
INSERT [dbo].[EventImage] ([id], [eventId], [path]) VALUES (247, 7, N'/assets/upload/images/ba7cd84a-e6c5-4840-b686-1e645c11d3b8.jpg')
INSERT [dbo].[EventImage] ([id], [eventId], [path]) VALUES (248, 7, N'/assets/upload/images/2ba9ce66-8635-4781-93f7-2d7f85fef040.jpg')
INSERT [dbo].[EventImage] ([id], [eventId], [path]) VALUES (249, 7, N'/assets/upload/images/d351e6d3-9fbb-4570-8c70-562ccde331df.jpg')
INSERT [dbo].[EventImage] ([id], [eventId], [path]) VALUES (250, 7, N'/assets/upload/images/fcdd9fe7-af09-4eef-8e6b-6dc246a70d6e.jpg')
INSERT [dbo].[EventImage] ([id], [eventId], [path]) VALUES (251, 16, N'/assets/upload/images/0798ab57-c78d-4c58-88a7-f8e51a783c78.jpg')
INSERT [dbo].[EventImage] ([id], [eventId], [path]) VALUES (252, 16, N'/assets/upload/images/0e84f3c8-5ca4-4d99-bdaa-142bde8d3901.jpg')
INSERT [dbo].[EventImage] ([id], [eventId], [path]) VALUES (253, 16, N'/assets/upload/images/d8402e3c-69b7-4e86-b38d-b3edf3a9daa9.jpg')
INSERT [dbo].[EventImage] ([id], [eventId], [path]) VALUES (254, 16, N'/assets/upload/images/3ee1a87d-9a6a-47f2-b9ad-25eeef3f581d.jpg')
INSERT [dbo].[EventImage] ([id], [eventId], [path]) VALUES (255, 16, N'/assets/upload/images/26ce73e9-00f6-4c8b-a44e-38bbaf0b178e.jpg')
INSERT [dbo].[EventImage] ([id], [eventId], [path]) VALUES (256, 16, N'/assets/upload/images/9c59b37b-fb3d-495c-987a-c8b0a0057b85.jpg')
GO
INSERT [dbo].[EventImage] ([id], [eventId], [path]) VALUES (257, 16, N'/assets/upload/images/796c6de6-6a09-441d-83ff-058d1c694987.jpg')
INSERT [dbo].[EventImage] ([id], [eventId], [path]) VALUES (258, 12, N'/assets/upload/images/7b55b46e-c747-4d04-a3c9-c88cb8d97b92.jpg')
INSERT [dbo].[EventImage] ([id], [eventId], [path]) VALUES (259, 12, N'/assets/upload/images/4dd32c2d-41a1-4427-bac9-685afadfd1a7.jpg')
INSERT [dbo].[EventImage] ([id], [eventId], [path]) VALUES (260, 12, N'/assets/upload/images/dc968f26-bfd7-4258-8ed9-b3871c1beaa4.jpg')
INSERT [dbo].[EventImage] ([id], [eventId], [path]) VALUES (261, 12, N'/assets/upload/images/3df5936d-588e-4694-b220-351c769aff23.jpg')
INSERT [dbo].[EventImage] ([id], [eventId], [path]) VALUES (262, 12, N'/assets/upload/images/af575a3c-2db4-4d9a-a681-cdf9067c86aa.jpg')
INSERT [dbo].[EventImage] ([id], [eventId], [path]) VALUES (267, 18, N'/assets/upload/images/2d0ef4a7-e374-4e87-a6f8-8bf96c61bcbc.jpg')
INSERT [dbo].[EventImage] ([id], [eventId], [path]) VALUES (268, 18, N'/assets/upload/images/e6427f4e-6f4f-49c3-833a-08a695656bd3.jpg')
INSERT [dbo].[EventImage] ([id], [eventId], [path]) VALUES (269, 18, N'/assets/upload/images/7d2bd1ae-d31d-4504-b2c1-792e10df050b.jpg')
INSERT [dbo].[EventImage] ([id], [eventId], [path]) VALUES (270, 18, N'/assets/upload/images/5acda1c4-4684-44f8-aaf0-ff13f9c87ec5.jpg')
INSERT [dbo].[EventImage] ([id], [eventId], [path]) VALUES (271, 18, N'/assets/upload/images/5768244c-6891-44b2-ad5f-6f090f6f6950.jpg')
INSERT [dbo].[EventImage] ([id], [eventId], [path]) VALUES (272, 18, N'/assets/upload/images/f7b881a0-fed4-4f5c-84bb-2266c654b58d.jpg')
INSERT [dbo].[EventImage] ([id], [eventId], [path]) VALUES (273, 18, N'/assets/upload/images/ef8300b6-70e9-4e86-8928-4b33876cc791.jpg')
INSERT [dbo].[EventImage] ([id], [eventId], [path]) VALUES (274, 18, N'/assets/upload/images/7490c191-09ad-4d80-81a3-5ef4b86f2c6d.jpg')
INSERT [dbo].[EventImage] ([id], [eventId], [path]) VALUES (275, 18, N'/assets/upload/images/1adb1322-a68a-4343-8ef8-d6bda1e2dd78.jpg')
INSERT [dbo].[EventImage] ([id], [eventId], [path]) VALUES (276, 18, N'/assets/upload/images/ad8c4862-5cda-483b-9967-c60ed2c1cca6.jpg')
INSERT [dbo].[EventImage] ([id], [eventId], [path]) VALUES (277, 20, N'/assets/upload/images/c84b1cfd-abf5-495f-8d8c-3edc0e30f287.jpg')
INSERT [dbo].[EventImage] ([id], [eventId], [path]) VALUES (278, 20, N'/assets/upload/images/54f6b05a-5f3b-4932-9687-6661ff61be5b.jpg')
INSERT [dbo].[EventImage] ([id], [eventId], [path]) VALUES (279, 20, N'/assets/upload/images/cec509e6-c4c3-45e0-9a2f-63226d1048b4.jpg')
INSERT [dbo].[EventImage] ([id], [eventId], [path]) VALUES (280, 20, N'/assets/upload/images/2e095859-21b3-40ff-bf89-0d0d407e08de.jpg')
INSERT [dbo].[EventImage] ([id], [eventId], [path]) VALUES (281, 20, N'/assets/upload/images/355cf0b3-4081-467b-800e-267b7abed514.jpg')
INSERT [dbo].[EventImage] ([id], [eventId], [path]) VALUES (282, 20, N'/assets/upload/images/d18b39d7-01d5-4133-8415-545a7513b2f4.jpg')
INSERT [dbo].[EventImage] ([id], [eventId], [path]) VALUES (283, 11, N'/assets/upload/images/e572ee81-67c1-4605-ae6b-8e4a635522b4.jpg')
INSERT [dbo].[EventImage] ([id], [eventId], [path]) VALUES (284, 11, N'/assets/upload/images/d69f6937-3b2c-4370-a760-0885feaefd7c.jpg')
INSERT [dbo].[EventImage] ([id], [eventId], [path]) VALUES (285, 11, N'/assets/upload/images/dfc4cd54-9f71-4490-b32c-6f6148e40908.jpg')
INSERT [dbo].[EventImage] ([id], [eventId], [path]) VALUES (286, 11, N'/assets/upload/images/798d50a1-3fe4-4721-96ea-85db0b9c882f.jpg')
INSERT [dbo].[EventImage] ([id], [eventId], [path]) VALUES (287, 11, N'/assets/upload/images/0926dc88-56a6-4ec6-9377-254d100ec5b7.jpg')
INSERT [dbo].[EventImage] ([id], [eventId], [path]) VALUES (288, 22, N'/assets/upload/images/e9192366-40e4-44d8-8108-accdffc303b9.jpg')
INSERT [dbo].[EventImage] ([id], [eventId], [path]) VALUES (289, 22, N'/assets/upload/images/012e71ea-ec58-4ff3-b923-f78ab1b2d397.jpg')
INSERT [dbo].[EventImage] ([id], [eventId], [path]) VALUES (290, 22, N'/assets/upload/images/4bd37a91-8f92-4c24-a52b-ec81408c083d.jpg')
INSERT [dbo].[EventImage] ([id], [eventId], [path]) VALUES (291, 22, N'/assets/upload/images/da13abee-15f1-42b5-87b0-01eb3f9313fd.jpg')
INSERT [dbo].[EventImage] ([id], [eventId], [path]) VALUES (292, 23, N'/assets/upload/images/7bd61365-8bdc-4f3a-a2ee-e3369b9ba148.jpg')
INSERT [dbo].[EventImage] ([id], [eventId], [path]) VALUES (293, 23, N'/assets/upload/images/02465d77-b584-4e98-879e-425f4486e035.jpg')
INSERT [dbo].[EventImage] ([id], [eventId], [path]) VALUES (294, 23, N'/assets/upload/images/e5e4e1a6-2969-462b-8309-1eaa73535d57.jpg')
INSERT [dbo].[EventImage] ([id], [eventId], [path]) VALUES (295, 23, N'/assets/upload/images/b25617b2-99eb-4c05-a3a2-09f70ca9d4ad.jpg')
INSERT [dbo].[EventImage] ([id], [eventId], [path]) VALUES (296, 23, N'/assets/upload/images/0c4b11e8-5253-4e0b-8db9-d94be347afb2.jpg')
INSERT [dbo].[EventImage] ([id], [eventId], [path]) VALUES (297, 23, N'/assets/upload/images/1d9ba00b-dce6-4a31-bdc1-5272d12ad290.jpg')
INSERT [dbo].[EventImage] ([id], [eventId], [path]) VALUES (298, 23, N'/assets/upload/images/dcb54198-d040-4868-aaf1-43b4b36c6bca.jpg')
INSERT [dbo].[EventImage] ([id], [eventId], [path]) VALUES (299, 4, N'/assets/upload/images/7b09bcbd-a189-4c6d-a8f5-d084474d5ea3.jpg')
INSERT [dbo].[EventImage] ([id], [eventId], [path]) VALUES (300, 4, N'/assets/upload/images/7e639cf5-833f-4c3a-a992-fb4912f8ec0f.jpg')
INSERT [dbo].[EventImage] ([id], [eventId], [path]) VALUES (301, 4, N'/assets/upload/images/90576d52-a3a7-4299-a0e8-4e9431a5da8d.jpg')
INSERT [dbo].[EventImage] ([id], [eventId], [path]) VALUES (302, 4, N'/assets/upload/images/4f33908a-2287-4bbe-a321-1091783d5be7.jpg')
INSERT [dbo].[EventImage] ([id], [eventId], [path]) VALUES (303, 4, N'/assets/upload/images/b41d6496-9827-4530-9298-91fe691d9c53.jpg')
INSERT [dbo].[EventImage] ([id], [eventId], [path]) VALUES (304, 4, N'/assets/upload/images/5b173929-2c66-4bc5-9454-089d40eb40fd.jpg')
INSERT [dbo].[EventImage] ([id], [eventId], [path]) VALUES (305, 4, N'/assets/upload/images/ff26358c-e421-4151-b9c7-ed70f79519e3.jpg')
INSERT [dbo].[EventImage] ([id], [eventId], [path]) VALUES (306, 4, N'/assets/upload/images/756394c6-2f7b-488b-ae9e-abc4fa69e6b9.jpg')
INSERT [dbo].[EventImage] ([id], [eventId], [path]) VALUES (307, 4, N'/assets/upload/images/8b708737-6edc-4607-9073-13d589a1045e.jpg')
INSERT [dbo].[EventImage] ([id], [eventId], [path]) VALUES (308, 4, N'/assets/upload/images/1bf62448-bbcd-4cdf-a5da-6c30e171d1ae.jpg')
INSERT [dbo].[EventImage] ([id], [eventId], [path]) VALUES (309, 4, N'/assets/upload/images/9c122ec2-138e-4796-917c-e76f56c25fd6.jpg')
INSERT [dbo].[EventImage] ([id], [eventId], [path]) VALUES (310, 4, N'/assets/upload/images/0c84ab41-901b-4498-abc4-a7f320807713.jpg')
INSERT [dbo].[EventImage] ([id], [eventId], [path]) VALUES (311, 4, N'/assets/upload/images/0831da9b-9828-40f8-bea4-814b4dad9191.jpg')
INSERT [dbo].[EventImage] ([id], [eventId], [path]) VALUES (312, 4, N'/assets/upload/images/41286ecd-3adb-4eb8-84ed-006492df1228.jpg')
INSERT [dbo].[EventImage] ([id], [eventId], [path]) VALUES (313, 14, N'/assets/upload/images/cadcee85-ef34-436d-b142-296a137e019e.jpg')
INSERT [dbo].[EventImage] ([id], [eventId], [path]) VALUES (314, 14, N'/assets/upload/images/8731c080-8e73-4f8c-92d8-b2d6d04de9c9.jpg')
INSERT [dbo].[EventImage] ([id], [eventId], [path]) VALUES (315, 14, N'/assets/upload/images/eca9c765-05ed-450d-aa70-f177768b4131.jpg')
INSERT [dbo].[EventImage] ([id], [eventId], [path]) VALUES (316, 14, N'/assets/upload/images/09e3fcab-aef2-4064-92a1-6f91642076a9.jpg')
INSERT [dbo].[EventImage] ([id], [eventId], [path]) VALUES (317, 24, N'/assets/upload/images/9b88a0c8-1c20-49e8-ac00-b2c571f82d32.jpg')
INSERT [dbo].[EventImage] ([id], [eventId], [path]) VALUES (318, 24, N'/assets/upload/images/405b431e-e87d-429b-aecf-997837fb3a00.jpg')
SET IDENTITY_INSERT [dbo].[EventImage] OFF
GO
INSERT [dbo].[Feedback] ([guestId], [eventId], [content]) VALUES (2, 5, N'Quá đìn')
INSERT [dbo].[Feedback] ([guestId], [eventId], [content]) VALUES (3, 5, N'Gud')
INSERT [dbo].[Feedback] ([guestId], [eventId], [content]) VALUES (4, 5, N'khhkhkhkhkkhkhkhkhkkh')
INSERT [dbo].[Feedback] ([guestId], [eventId], [content]) VALUES (5, 5, N'Quá tuyệt vời 🥰')
INSERT [dbo].[Feedback] ([guestId], [eventId], [content]) VALUES (6, 5, N'Tô đẹp quá, tượng thấy cũng đẹp too. Anh chị club support quá tuyệt vời. Một sự kiện có ích. 😘')
GO
SET IDENTITY_INSERT [dbo].[File] ON 

INSERT [dbo].[File] ([id], [submitterId], [fileType], [displayName], [path], [sendTime], [status], [processNote], [processTime]) VALUES (992, 8, N'REPORT', N'Report-Thang-8.docx', N'/assets/upload/documents/7006f582-e612-4246-95bd-10ed3f254313.docx', CAST(N'2024-11-07T18:48:49.840' AS DateTime), N'PENDING', NULL, NULL)
SET IDENTITY_INSERT [dbo].[File] OFF
GO
SET IDENTITY_INSERT [dbo].[Notification] ON 

INSERT [dbo].[Notification] ([id], [senderId], [title], [content], [sendingTime]) VALUES (1, 2, NULL, N'Các CLBs gửi report trước 19h ngày 20/11/2024', CAST(N'2024-11-08T01:57:09.757' AS DateTime))
INSERT [dbo].[Notification] ([id], [senderId], [title], [content], [sendingTime]) VALUES (2, 2, NULL, N'Vì lí do thời tiết, nhiều sự kiện có thể bị hoãn hoặc hủy. Các bạn sinh viên chú ý check mail', CAST(N'2024-11-08T01:58:34.580' AS DateTime))
SET IDENTITY_INSERT [dbo].[Notification] OFF
GO
INSERT [dbo].[NotificationReceiver] ([notificationId], [receiverId], [isOrganizer]) VALUES (1, 3, 1)
INSERT [dbo].[NotificationReceiver] ([notificationId], [receiverId], [isOrganizer]) VALUES (1, 4, 1)
INSERT [dbo].[NotificationReceiver] ([notificationId], [receiverId], [isOrganizer]) VALUES (1, 5, 1)
INSERT [dbo].[NotificationReceiver] ([notificationId], [receiverId], [isOrganizer]) VALUES (1, 6, 1)
INSERT [dbo].[NotificationReceiver] ([notificationId], [receiverId], [isOrganizer]) VALUES (1, 8, 1)
INSERT [dbo].[NotificationReceiver] ([notificationId], [receiverId], [isOrganizer]) VALUES (1, 9, 1)
INSERT [dbo].[NotificationReceiver] ([notificationId], [receiverId], [isOrganizer]) VALUES (2, 1, 0)
INSERT [dbo].[NotificationReceiver] ([notificationId], [receiverId], [isOrganizer]) VALUES (2, 2, 0)
INSERT [dbo].[NotificationReceiver] ([notificationId], [receiverId], [isOrganizer]) VALUES (2, 3, 0)
INSERT [dbo].[NotificationReceiver] ([notificationId], [receiverId], [isOrganizer]) VALUES (2, 4, 0)
INSERT [dbo].[NotificationReceiver] ([notificationId], [receiverId], [isOrganizer]) VALUES (2, 5, 0)
INSERT [dbo].[NotificationReceiver] ([notificationId], [receiverId], [isOrganizer]) VALUES (2, 6, 0)
INSERT [dbo].[NotificationReceiver] ([notificationId], [receiverId], [isOrganizer]) VALUES (2, 7, 0)
INSERT [dbo].[NotificationReceiver] ([notificationId], [receiverId], [isOrganizer]) VALUES (2, 8, 0)
INSERT [dbo].[NotificationReceiver] ([notificationId], [receiverId], [isOrganizer]) VALUES (2, 9, 0)
INSERT [dbo].[NotificationReceiver] ([notificationId], [receiverId], [isOrganizer]) VALUES (2, 10, 0)
INSERT [dbo].[NotificationReceiver] ([notificationId], [receiverId], [isOrganizer]) VALUES (2, 11, 0)
INSERT [dbo].[NotificationReceiver] ([notificationId], [receiverId], [isOrganizer]) VALUES (2, 12, 0)
INSERT [dbo].[NotificationReceiver] ([notificationId], [receiverId], [isOrganizer]) VALUES (2, 13, 0)
INSERT [dbo].[NotificationReceiver] ([notificationId], [receiverId], [isOrganizer]) VALUES (2, 14, 0)
INSERT [dbo].[NotificationReceiver] ([notificationId], [receiverId], [isOrganizer]) VALUES (2, 15, 0)
INSERT [dbo].[NotificationReceiver] ([notificationId], [receiverId], [isOrganizer]) VALUES (2, 16, 0)
INSERT [dbo].[NotificationReceiver] ([notificationId], [receiverId], [isOrganizer]) VALUES (2, 17, 0)
INSERT [dbo].[NotificationReceiver] ([notificationId], [receiverId], [isOrganizer]) VALUES (2, 18, 0)
INSERT [dbo].[NotificationReceiver] ([notificationId], [receiverId], [isOrganizer]) VALUES (2, 19, 0)
INSERT [dbo].[NotificationReceiver] ([notificationId], [receiverId], [isOrganizer]) VALUES (2, 20, 0)
INSERT [dbo].[NotificationReceiver] ([notificationId], [receiverId], [isOrganizer]) VALUES (2, 21, 0)
INSERT [dbo].[NotificationReceiver] ([notificationId], [receiverId], [isOrganizer]) VALUES (2, 22, 0)
INSERT [dbo].[NotificationReceiver] ([notificationId], [receiverId], [isOrganizer]) VALUES (2, 23, 0)
INSERT [dbo].[NotificationReceiver] ([notificationId], [receiverId], [isOrganizer]) VALUES (2, 24, 0)
INSERT [dbo].[NotificationReceiver] ([notificationId], [receiverId], [isOrganizer]) VALUES (2, 25, 0)
INSERT [dbo].[NotificationReceiver] ([notificationId], [receiverId], [isOrganizer]) VALUES (2, 26, 0)
INSERT [dbo].[NotificationReceiver] ([notificationId], [receiverId], [isOrganizer]) VALUES (2, 27, 0)
INSERT [dbo].[NotificationReceiver] ([notificationId], [receiverId], [isOrganizer]) VALUES (2, 28, 0)
INSERT [dbo].[NotificationReceiver] ([notificationId], [receiverId], [isOrganizer]) VALUES (2, 29, 0)
INSERT [dbo].[NotificationReceiver] ([notificationId], [receiverId], [isOrganizer]) VALUES (2, 30, 0)
INSERT [dbo].[NotificationReceiver] ([notificationId], [receiverId], [isOrganizer]) VALUES (2, 31, 0)
INSERT [dbo].[NotificationReceiver] ([notificationId], [receiverId], [isOrganizer]) VALUES (2, 32, 0)
INSERT [dbo].[NotificationReceiver] ([notificationId], [receiverId], [isOrganizer]) VALUES (2, 33, 0)
INSERT [dbo].[NotificationReceiver] ([notificationId], [receiverId], [isOrganizer]) VALUES (2, 34, 0)
INSERT [dbo].[NotificationReceiver] ([notificationId], [receiverId], [isOrganizer]) VALUES (2, 35, 0)
GO

/*
>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
>>>>>>>>> END: EXAMPLE DATA >>>>>>>>>>
>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
*/