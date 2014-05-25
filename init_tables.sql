USE [bearded_lama]
GO
/****** Object:  Table [dbo].[Bans]    Script Date: 23/04/2014 7:21:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Bans](
	[userId] [bigint] NULL,
	[gameId] [bigint] NULL,
	[duration] [datetimeoffset](7) NULL
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Chat]    Script Date: 23/04/2014 7:21:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Chat](
	[userId] [bigint] NULL,
	[gameId] [bigint] NOT NULL,
	[message] [varchar](80) NULL,
	[timeStamp] [datetime] NULL
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[GameHistory]    Script Date: 23/04/2014 7:21:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[GameHistory](
	[userId] [bigint] NULL,
	[gameId] [bigint] NULL,
	[timeSpan] [datetimeoffset](7) NULL
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Games]    Script Date: 23/04/2014 7:21:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Games](
	[gameId] [bigint] IDENTITY(1,1) NOT NULL,
	[gameName] [nvarchar](50) NULL,
	[gameDesc] [nvarchar](300) NULL,
	[tags] [varchar](200) NULL,
	[category] [varchar](50) NULL,
	[publicPackage] [xml] NULL,
	[rating] [int] NULL,
	[userId] [bigint] NULL,
	[subDate] [datetime] NULL,
	[hashValue] [varchar](32) NULL,
	[restrict] [bit] NULL,
 CONSTRAINT [PK_Games] PRIMARY KEY CLUSTERED 
(
	[gameId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[GameCategories]   Script Date: 25/05/2014 4:00:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[GameCategories](
	[categoryNames] [varchar](20) NOT NULL
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Posts]    Script Date: 23/04/2014 7:21:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Posts](
	[userId] [bigint] NULL,
	[pageId] [bigint] NOT NULL,
	[content] [nvarchar](200) NULL,
	[timeStamp] [datetime] NULL,
	[postId] [bigint] NOT NULL,
 CONSTRAINT [PK_Posts] PRIMARY KEY CLUSTERED 
(
	[postId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Users]    Script Date: 23/04/2014 7:21:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Users](
	[userId] [bigint] IDENTITY(1,1) NOT NULL,
	[userName] [nvarchar](12) NULL,
	[email] [nvarchar](50) NULL,
	[userBio] [nvarchar](300) NULL,
	[avatar] [image] NULL,
	[creation] [datetime] NULL,
	[passwordHash] [varchar](32) NULL,
	[adult] [bit] NULL,
 CONSTRAINT [PK_Users] PRIMARY KEY CLUSTERED 
(
	[userId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
ALTER TABLE [dbo].[Bans]  WITH CHECK ADD  CONSTRAINT [FK_Bans_Games] FOREIGN KEY([gameId])
REFERENCES [dbo].[Games] ([gameId])
GO
ALTER TABLE [dbo].[Bans] CHECK CONSTRAINT [FK_Bans_Games]
GO
ALTER TABLE [dbo].[Bans]  WITH CHECK ADD  CONSTRAINT [FK_Bans_Users] FOREIGN KEY([userId])
REFERENCES [dbo].[Users] ([userId])
GO
ALTER TABLE [dbo].[Bans] CHECK CONSTRAINT [FK_Bans_Users]
GO
ALTER TABLE [dbo].[Chat]  WITH CHECK ADD  CONSTRAINT [FK_Chat_Games] FOREIGN KEY([gameId])
REFERENCES [dbo].[Games] ([gameId])
GO
ALTER TABLE [dbo].[Chat] CHECK CONSTRAINT [FK_Chat_Games]
GO
ALTER TABLE [dbo].[Chat]  WITH CHECK ADD  CONSTRAINT [FK_Chat_Users] FOREIGN KEY([userId])
REFERENCES [dbo].[Users] ([userId])
GO
ALTER TABLE [dbo].[Chat] CHECK CONSTRAINT [FK_Chat_Users]
GO
ALTER TABLE [dbo].[GameHistory]  WITH CHECK ADD  CONSTRAINT [FK_GameHistory_Games] FOREIGN KEY([gameId])
REFERENCES [dbo].[Games] ([gameId])
GO
ALTER TABLE [dbo].[GameHistory] CHECK CONSTRAINT [FK_GameHistory_Games]
GO
ALTER TABLE [dbo].[GameHistory]  WITH CHECK ADD  CONSTRAINT [FK_GameHistory_Users] FOREIGN KEY([userId])
REFERENCES [dbo].[Users] ([userId])
GO
ALTER TABLE [dbo].[GameHistory] CHECK CONSTRAINT [FK_GameHistory_Users]
GO
ALTER TABLE [dbo].[Posts]  WITH CHECK ADD  CONSTRAINT [FK_Posts_Games] FOREIGN KEY([pageId])
REFERENCES [dbo].[Games] ([gameId])
GO
ALTER TABLE [dbo].[Posts] CHECK CONSTRAINT [FK_Posts_Games]
GO
ALTER TABLE [dbo].[Posts]  WITH CHECK ADD  CONSTRAINT [FK_Posts_Users] FOREIGN KEY([userId])
REFERENCES [dbo].[Users] ([userId])
GO
ALTER TABLE [dbo].[Posts] CHECK CONSTRAINT [FK_Posts_Users]
GO
ALTER TABLE [dbo].[Users] ADD  CONSTRAINT [DF_Users_userBio]  DEFAULT ('') FOR [userBio]
GO
ALTER TABLE [dbo].[Users] ADD  CONSTRAINT [DF_Users_adult]  DEFAULT ((0)) FOR [adult]
GO
