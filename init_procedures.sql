USE [bearded_lama]
GO
/****** Object:  StoredProcedure [dbo].[DeleteGame]    Script Date: 30/04/2014 5:24:28 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[DeleteGame]
(
	@Original_gameId bigint
)
AS
	SET NOCOUNT OFF;
DELETE FROM [Games] WHERE (([gameId] = @Original_gameId))
GO
/****** Object:  StoredProcedure [dbo].[DeletePost]    Script Date: 30/04/2014 5:24:28 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[DeletePost]
(
	@Original_postId bigint
)
AS
	SET NOCOUNT OFF;
DELETE FROM [Posts] WHERE (([postId] = @Original_postId))
GO
/****** Object:  StoredProcedure [dbo].[DeleteUser]    Script Date: 30/04/2014 5:24:28 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[DeleteUser]
(
	@Original_userId bigint
)
AS
	SET NOCOUNT OFF;
DELETE FROM [Users] WHERE (([userId] = @Original_userId))
GO
/****** Object:  StoredProcedure [dbo].[GetBans]    Script Date: 30/04/2014 5:24:28 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[GetBans]
AS
	SET NOCOUNT ON;
SELECT * FROM Bans
GO
/****** Object:  StoredProcedure [dbo].[GetChat]    Script Date: 30/04/2014 5:24:28 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[GetChat]
AS
	SET NOCOUNT ON;
SELECT * FROM Chat
GO
/****** Object:  StoredProcedure [dbo].[GetGameHistory]    Script Date: 30/04/2014 5:24:28 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[GetGameHistory]
AS
	SET NOCOUNT ON;
SELECT * FROM GameHistory
GO
/****** Object:  StoredProcedure [dbo].[GetGames]    Script Date: 30/04/2014 5:24:28 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[GetGames]
AS
	SET NOCOUNT ON;
SELECT * FROM Games
GO
/****** Object:  StoredProcedure [dbo].[GetPosts]    Script Date: 30/04/2014 5:24:28 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[GetPosts]
AS
	SET NOCOUNT ON;
SELECT * FROM Posts
GO
/****** Object:  StoredProcedure [dbo].[GetUsers]    Script Date: 30/04/2014 5:24:28 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[GetUsers]
AS
	SET NOCOUNT ON;
SELECT userId, userName, email, userBio, creation, adult
FROM Users
GO
/****** Object:  StoredProcedure [dbo].[NewBan]    Script Date: 30/04/2014 5:24:28 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[NewBan]
(
	@userId bigint,
	@gameId bigint,
	@duration datetimeoffset
)
AS
	SET NOCOUNT OFF;
INSERT INTO [Bans] ([userId], [gameId], [duration]) VALUES (@userId, @gameId, @duration)
GO
/****** Object:  StoredProcedure [dbo].[NewChat]    Script Date: 30/04/2014 5:24:28 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[NewChat]
(
	@userId bigint,
	@gameId bigint,
	@message varchar(80),
	@timeStamp datetime
)
AS
	SET NOCOUNT OFF;
INSERT INTO [Chat] ([userId], [gameId], [message], [timeStamp]) VALUES (@userId, @gameId, @message, @timeStamp)
GO
/****** Object:  StoredProcedure [dbo].[NewGame]    Script Date: 30/04/2014 5:24:28 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[NewGame]
(
	@gameName nvarchar(50),
	@gameDesc nvarchar(300),
	@publicPackage xml,
	@tags varchar(200),
	@rating int,
	@userId bigint,
	@subDate datetime,
	@hashValue varchar(32),
	@restrict bit
)
AS
	SET NOCOUNT OFF;
INSERT INTO [Games] ([gameName], [gameDesc], [publicPackage], [tags], [rating], [userId], [subDate], [hashValue], [restrict]) VALUES (@gameName, @gameDesc, @publicPackage, @tags, @rating, @userId, @subDate, @hashValue, @restrict);
	
SELECT gameId, gameName, gameDesc, publicPackage, tags, rating, userId, subDate, hashValue, [restrict] FROM dbo.Games WHERE (gameId = SCOPE_IDENTITY())
GO
/****** Object:  StoredProcedure [dbo].[NewGameEntry]    Script Date: 30/04/2014 5:24:28 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[NewGameEntry]
(
	@userId bigint,
	@gameId bigint,
	@timeSpan datetimeoffset
)
AS
	SET NOCOUNT OFF;
INSERT INTO [GameHistory] ([userId], [gameId], [timeSpan]) VALUES (@userId, @gameId, @timeSpan)
GO
/****** Object:  StoredProcedure [dbo].[NewPost]    Script Date: 30/04/2014 5:24:28 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[NewPost]
(
	@userId bigint,
	@pageId bigint,
	@content nvarchar(200),
	@timeStamp datetime,
	@postId bigint
)
AS
	SET NOCOUNT OFF;
INSERT INTO [Posts] ([userId], [pageId], [content], [timeStamp], [postId]) VALUES (@userId, @pageId, @content, @timeStamp, @postId);
	
SELECT userId, pageId, content, timeStamp, postId FROM dbo.Posts WHERE (postId = @postId)
GO
/****** Object:  StoredProcedure [dbo].[NewUser]    Script Date: 30/04/2014 5:24:28 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[NewUser]
(
	@userName nvarchar(12),
	@email nvarchar(50),
	@passwordHash varchar(32),
	@creation datetime
)
AS
	SET NOCOUNT OFF;
INSERT INTO [Users] ([userName], [email], [passwordHash], [creation]) VALUES (@userName, @email, @passwordHash, @creation);
	
SELECT userId, userName, email, passwordHash, creation FROM dbo.Users WHERE (userId = SCOPE_IDENTITY())
GO
/****** Object:  StoredProcedure [dbo].[UpdateGame]    Script Date: 30/04/2014 5:24:28 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[UpdateGame]
(
	@gameName nvarchar(50),
	@gameDesc nvarchar(300),
	@publicPackage xml,
	@tags varchar(200),
	@rating int,
	@userId bigint,
	@subDate datetime,
	@hashValue varchar(32),
	@restrict bit,
	@Original_gameId bigint,
	@gameId bigint
)
AS
	SET NOCOUNT OFF;
UPDATE [Games] SET [gameName] = @gameName, [gameDesc] = @gameDesc, [publicPackage] = @publicPackage, [tags] = @tags, [rating] = @rating, [userId] = @userId, [subDate] = @subDate, [hashValue] = @hashValue, [restrict] = @restrict WHERE (([gameId] = @Original_gameId));
	
SELECT gameId, gameName, gameDesc, publicPackage, tags, rating, userId, subDate, hashValue, [restrict] FROM dbo.Games WHERE (gameId = @gameId)
GO
/****** Object:  StoredProcedure [dbo].[UpdatePost]    Script Date: 30/04/2014 5:24:28 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[UpdatePost]
(
	@userId bigint,
	@pageId bigint,
	@content nvarchar(200),
	@timeStamp datetime,
	@postId bigint,
	@Original_postId bigint
)
AS
	SET NOCOUNT OFF;
UPDATE [Posts] SET [userId] = @userId, [pageId] = @pageId, [content] = @content, [timeStamp] = @timeStamp, [postId] = @postId WHERE (([postId] = @Original_postId));
	
SELECT userId, pageId, content, timeStamp, postId FROM dbo.Posts WHERE (postId = @postId)
GO
/****** Object:  StoredProcedure [dbo].[UpdateUser]    Script Date: 30/04/2014 5:24:28 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[UpdateUser]
(
	@userName nvarchar(12),
	@email nvarchar(50),
	@userBio nvarchar(300),
	@avatar image,
	@original_userId bigint,
	@adult bit
)
AS
	SET NOCOUNT OFF;
UPDATE [Users] SET [userName] = @userName, [email] = @email, [adult] = @adult, [userBio] = @userBio, [avatar] = @avatar WHERE (([userId] = @original_userId));
	
SELECT userId, userName, email, userBio, avatar, creation, adult FROM dbo.Users WHERE (userId = @original_userId)

GO
/****** Object:  StoredPROCEDURE [dbo].[GetPasswordHashFromUserName]    Script Date: 18/05/2014 5:37:27 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[GetPasswordHashFromUserName]
(
	@username nvarchar(50)
)
AS
	SET NOCOUNT ON;
SELECT        passwordHash
FROM            Users
WHERE        (userName = @username)
GO
/****** Object:  StoredPROCEDURE [dbo].[GetUserIdFromUserName]    Script Date: 18/05/2014 5:37:27 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[GetUserIdFromUserName]
(
	@username nvarchar(12)
)
AS
	SET NOCOUNT ON;
SELECT        userId
FROM            Users
WHERE        (userName = @username)
GO
/****** Object:  StoredPROCEDURE [dbo].[GetUserNameFromEmail]    Script Date: 18/05/2014 5:37:27 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[GetUserNameFromEmail]
(
	@email nvarchar(50)
)
AS
	SET NOCOUNT ON;
SELECT        userName
FROM            Users
WHERE        (email = @email)
GO
/****** Object:  StoredPROCEDURE [dbo].[UpdatePasswordHash]    Script Date: 18/05/2014 5:37:27 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[UpdatePasswordHash]
(
	@newPasswordHash varchar(32),
	@username nvarchar(50)
)
AS
	SET NOCOUNT OFF;
UPDATE       Users
SET                passwordHash = @newPasswordHash
WHERE        (userName = @username)
GO
