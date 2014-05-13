USE [bearded_lama]
GO
CREATE SCHEMA [bearded_lama]
GO
/****** Object:  StoredProcedure [bearded_lama].[DeleteGame]    Script Date: 30/04/2014 5:24:28 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [bearded_lama].[DeleteGame]
(
	@Original_gameId bigint
)
AS
	SET NOCOUNT OFF;
DELETE FROM [Games] WHERE (([gameId] = @Original_gameId))
GO
/****** Object:  StoredProcedure [bearded_lama].[DeletePost]    Script Date: 30/04/2014 5:24:28 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [bearded_lama].[DeletePost]
(
	@Original_postId bigint
)
AS
	SET NOCOUNT OFF;
DELETE FROM [Posts] WHERE (([postId] = @Original_postId))
GO
/****** Object:  StoredProcedure [bearded_lama].[DeleteUser]    Script Date: 30/04/2014 5:24:28 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [bearded_lama].[DeleteUser]
(
	@Original_userId bigint
)
AS
	SET NOCOUNT OFF;
DELETE FROM [Users] WHERE (([userId] = @Original_userId))
GO
/****** Object:  StoredProcedure [bearded_lama].[GetBans]    Script Date: 30/04/2014 5:24:28 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [bearded_lama].[GetBans]
AS
	SET NOCOUNT ON;
SELECT * FROM Bans
GO
/****** Object:  StoredProcedure [bearded_lama].[GetChat]    Script Date: 30/04/2014 5:24:28 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [bearded_lama].[GetChat]
AS
	SET NOCOUNT ON;
SELECT * FROM Chat
GO
/****** Object:  StoredProcedure [bearded_lama].[GetGameHistory]    Script Date: 30/04/2014 5:24:28 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [bearded_lama].[GetGameHistory]
AS
	SET NOCOUNT ON;
SELECT * FROM GameHistory
GO
/****** Object:  StoredProcedure [bearded_lama].[GetGames]    Script Date: 30/04/2014 5:24:28 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [bearded_lama].[GetGames]
AS
	SET NOCOUNT ON;
SELECT * FROM Games
GO
/****** Object:  StoredProcedure [bearded_lama].[GetPosts]    Script Date: 30/04/2014 5:24:28 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [bearded_lama].[GetPosts]
AS
	SET NOCOUNT ON;
SELECT * FROM Posts
GO
/****** Object:  StoredProcedure [bearded_lama].[GetUsers]    Script Date: 30/04/2014 5:24:28 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [bearded_lama].[GetUsers]
AS
	SET NOCOUNT ON;
SELECT * FROM Users
GO
/****** Object:  StoredProcedure [bearded_lama].[NewBan]    Script Date: 30/04/2014 5:24:28 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [bearded_lama].[NewBan]
(
	@userId bigint,
	@gameId bigint,
	@duration datetimeoffset
)
AS
	SET NOCOUNT OFF;
INSERT INTO [Bans] ([userId], [gameId], [duration]) VALUES (@userId, @gameId, @duration)
GO
/****** Object:  StoredProcedure [bearded_lama].[NewChat]    Script Date: 30/04/2014 5:24:28 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [bearded_lama].[NewChat]
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
/****** Object:  StoredProcedure [bearded_lama].[NewGame]    Script Date: 30/04/2014 5:24:28 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [bearded_lama].[NewGame]
(
	@gameName varchar(50),
	@gameDesc varchar(300),
	@tags varchar(200),
	@category varchar(50),
	@publicPackage xml,
	@rating int,
	@userId bigint,
	@subDate datetime,
	@hashValue varchar(32),
	@restrict bit
)
AS
	SET NOCOUNT OFF;
INSERT INTO [Games] ([gameName], [gameDesc], [tags], [category], [publicPackage], [rating], [userId], [subDate], [hashValue], [restrict]) VALUES (@gameName, @gameDesc, @tags, @category, @publicPackage, @rating, @userId, @subDate, @hashValue, @restrict);
	
SELECT gameId, gameName, gameDesc, tags, category, publicPackage, rating, userId, subDate, hashValue, [restrict] FROM dbo.Games WHERE (gameId = SCOPE_IDENTITY())
GO
/****** Object:  StoredProcedure [bearded_lama].[NewGameEntry]    Script Date: 30/04/2014 5:24:28 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [bearded_lama].[NewGameEntry]
(
	@userId bigint,
	@gameId bigint,
	@timeSpan datetimeoffset
)
AS
	SET NOCOUNT OFF;
INSERT INTO [GameHistory] ([userId], [gameId], [timeSpan]) VALUES (@userId, @gameId, @timeSpan)
GO
/****** Object:  StoredProcedure [bearded_lama].[NewPost]    Script Date: 30/04/2014 5:24:28 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [bearded_lama].[NewPost]
(
	@userId bigint,
	@pageId bigint,
	@content varchar(200),
	@timeStamp datetime,
	@postId bigint
)
AS
	SET NOCOUNT OFF;
INSERT INTO [Posts] ([userId], [pageId], [content], [timeStamp], [postId]) VALUES (@userId, @pageId, @content, @timeStamp, @postId);
	
SELECT userId, pageId, [content], timeStamp, postId FROM dbo.Posts WHERE (postId = @postId)
GO
/****** Object:  StoredProcedure [bearded_lama].[NewUser]    Script Date: 30/04/2014 5:24:28 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [bearded_lama].[NewUser]
(
	@userName varchar(12),
	@email varchar(50),
	@dob date,
	@userBio varchar(300),
	@avatar image,
	@creation datetime
)
AS
	SET NOCOUNT OFF;
INSERT INTO [Users] ([userName], [email], [dob], [userBio], [avatar], [creation]) VALUES (@userName, @email, @dob, @userBio, @avatar, @creation);
	
SELECT userId, userName, email, dob, userBio, avatar, creation FROM dbo.Users WHERE (userId = SCOPE_IDENTITY())
GO
/****** Object:  StoredProcedure [bearded_lama].[UpdateGame]    Script Date: 30/04/2014 5:24:28 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [bearded_lama].[UpdateGame]
(
	@gameName varchar(50),
	@gameDesc varchar(300),
	@tags varchar(200),
	@category varchar(50),
	@publicPackage xml,
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
UPDATE [Games] SET [gameName] = @gameName, [gameDesc] = @gameDesc, [tags] = @tags, [category] = @category, [publicPackage] = @publicPackage, [rating] = @rating, [userId] = @userId, [subDate] = @subDate, [hashValue] = @hashValue, [restrict] = @restrict WHERE (([gameId] = @Original_gameId));
	
SELECT gameId, gameName, gameDesc, tags, category, publicPackage, rating, userId, subDate, hashValue, [restrict] FROM dbo.Games WHERE (gameId = @gameId)
GO
/****** Object:  StoredProcedure [bearded_lama].[UpdatePost]    Script Date: 30/04/2014 5:24:28 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [bearded_lama].[UpdatePost]
(
	@userId bigint,
	@pageId bigint,
	@content varchar(200),
	@timeStamp datetime,
	@postId bigint,
	@Original_postId bigint
)
AS
	SET NOCOUNT OFF;
UPDATE [Posts] SET [userId] = @userId, [pageId] = @pageId, [content] = @content, [timeStamp] = @timeStamp, [postId] = @postId WHERE (([postId] = @Original_postId));
	
SELECT userId, pageId, [content], timeStamp, postId FROM dbo.Posts WHERE (postId = @postId)
GO
/****** Object:  StoredProcedure [bearded_lama].[UpdateUser]    Script Date: 30/04/2014 5:24:28 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [bearded_lama].[UpdateUser]
(
	@userName varchar(12),
	@email varchar(50),
	@dob date,
	@userBio varchar(300),
	@avatar image,
	@creation datetime,
	@Original_userId bigint,
	@userId bigint
)
AS
	SET NOCOUNT OFF;
UPDATE [Users] SET [userName] = @userName, [email] = @email, [dob] = @dob, [userBio] = @userBio, [avatar] = @avatar, [creation] = @creation WHERE (([userId] = @Original_userId));
	
SELECT userId, userName, email, dob, userBio, avatar, creation FROM dbo.Users WHERE (userId = @userId)
GO
