USE MASTER
GO
CREATE DATABASE [QuizIT]
GO
USE [QuizIT]
GO
/****** Object:  Table [dbo].[Category]    Script Date: 6/4/2023 11:25:52 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Category](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[CategoryName] [nvarchar](255) NOT NULL,
	[CreateAt] [datetime] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Exam]    Script Date: 6/4/2023 11:25:53 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Exam](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[CategoryId] [int] NOT NULL,
	[ExamName] [nvarchar](255) NOT NULL,
	[Time] [int] NOT NULL,
	[CreateAt] [datetime] NOT NULL,
	[CreateBy] [int] NOT NULL,
	[IsActive] [bit] NOT NULL,
 CONSTRAINT [PK__Exam__3214EC0716BD7875] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ExamDetail]    Script Date: 6/4/2023 11:25:53 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ExamDetail](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[ExamId] [int] NOT NULL,
	[QuestionId] [int] NOT NULL,
	[Order] [int] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[History]    Script Date: 6/4/2023 11:25:53 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[History](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[ExamId] [int] NOT NULL,
	[UserId] [int] NOT NULL,
	[TimeDoExam] [float] NOT NULL,
	[Point] [int] NOT NULL,
	[CreatedAt] [datetime] NOT NULL,
 CONSTRAINT [PK__History__3214EC07B7B0CB94] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[HistoryDetail]    Script Date: 6/4/2023 11:25:53 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[HistoryDetail](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[HistoryId] [int] NOT NULL,
	[QuestionId] [int] NOT NULL,
	[AnswerSelect] [varchar](1) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Question]    Script Date: 6/4/2023 11:25:53 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Question](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[CategoryId] [int] NOT NULL,
	[Content] [nvarchar](max) NOT NULL,
	[AnswerA] [nvarchar](max) NOT NULL,
	[AnswerB] [nvarchar](max) NOT NULL,
	[AnswerC] [nvarchar](max) NOT NULL,
	[AnswerD] [nvarchar](max) NOT NULL,
	[AnswerCorrect] [varchar](1) NOT NULL,
	[CreatedAt] [date] NOT NULL,
	[CreatedBy] [int] NOT NULL,
 CONSTRAINT [PK__Question__3214EC073B688396] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Rank]    Script Date: 6/4/2023 11:25:53 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Rank](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[ExamId] [int] NOT NULL,
	[UserId] [int] NOT NULL,
	[TimeDoExam] [float] NOT NULL,
	[Point] [int] NOT NULL,
 CONSTRAINT [PK__Rank__3214EC07CEA21799] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Role]    Script Date: 6/4/2023 11:25:53 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Role](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[RoleName] [nvarchar](255) NOT NULL,
	[CreateAt] [datetime] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[User]    Script Date: 6/4/2023 11:25:53 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[User](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[RoleId] [int] NOT NULL,
	[FullName] [nvarchar](255) NOT NULL,
	[UserName] [nvarchar](255) NOT NULL,
	[Password] [nvarchar](255) NOT NULL,
	[CreateAt] [datetime] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
SET IDENTITY_INSERT [dbo].[Category] ON 

INSERT [dbo].[Category] ([Id], [CategoryName], [CreateAt]) VALUES (1005, N'Cơ sở dữ liệu', CAST(N'2023-06-04T10:00:26.127' AS DateTime))
INSERT [dbo].[Category] ([Id], [CategoryName], [CreateAt]) VALUES (1006, N'Java', CAST(N'2023-06-04T10:00:30.960' AS DateTime))
INSERT [dbo].[Category] ([Id], [CategoryName], [CreateAt]) VALUES (1007, N'Mạng máy tính', CAST(N'2023-06-04T10:00:36.117' AS DateTime))
SET IDENTITY_INSERT [dbo].[Category] OFF
GO
SET IDENTITY_INSERT [dbo].[Exam] ON 

INSERT [dbo].[Exam] ([Id], [CategoryId], [ExamName], [Time], [CreateAt], [CreateBy], [IsActive]) VALUES (1, 1006, N'Đề trắc nghiệm Java số 1', 5, CAST(N'2023-06-04T10:31:13.280' AS DateTime), 3, 1)
INSERT [dbo].[Exam] ([Id], [CategoryId], [ExamName], [Time], [CreateAt], [CreateBy], [IsActive]) VALUES (2, 1006, N'Đề trắc nghiệm Java số 2', 15, CAST(N'2023-06-04T10:37:03.733' AS DateTime), 3, 1)
INSERT [dbo].[Exam] ([Id], [CategoryId], [ExamName], [Time], [CreateAt], [CreateBy], [IsActive]) VALUES (3, 1007, N'Đề trắc nghiệm Mạng máy tính số 1', 10, CAST(N'2023-06-04T10:48:19.070' AS DateTime), 3, 1)
INSERT [dbo].[Exam] ([Id], [CategoryId], [ExamName], [Time], [CreateAt], [CreateBy], [IsActive]) VALUES (4, 1007, N'Đề ôn Mạng máy tính', 15, CAST(N'2023-06-04T10:48:58.350' AS DateTime), 3, 1)
INSERT [dbo].[Exam] ([Id], [CategoryId], [ExamName], [Time], [CreateAt], [CreateBy], [IsActive]) VALUES (5, 1006, N'Đề ôn Java', 1, CAST(N'2023-06-04T10:49:57.907' AS DateTime), 3, 1)
SET IDENTITY_INSERT [dbo].[Exam] OFF
GO
SET IDENTITY_INSERT [dbo].[ExamDetail] ON 

INSERT [dbo].[ExamDetail] ([Id], [ExamId], [QuestionId], [Order]) VALUES (1, 1, 1113, 1)
INSERT [dbo].[ExamDetail] ([Id], [ExamId], [QuestionId], [Order]) VALUES (2, 1, 1114, 2)
INSERT [dbo].[ExamDetail] ([Id], [ExamId], [QuestionId], [Order]) VALUES (3, 1, 1118, 3)
INSERT [dbo].[ExamDetail] ([Id], [ExamId], [QuestionId], [Order]) VALUES (4, 1, 1117, 4)
INSERT [dbo].[ExamDetail] ([Id], [ExamId], [QuestionId], [Order]) VALUES (5, 1, 1115, 5)
INSERT [dbo].[ExamDetail] ([Id], [ExamId], [QuestionId], [Order]) VALUES (6, 1, 1125, 6)
INSERT [dbo].[ExamDetail] ([Id], [ExamId], [QuestionId], [Order]) VALUES (7, 1, 1123, 7)
INSERT [dbo].[ExamDetail] ([Id], [ExamId], [QuestionId], [Order]) VALUES (8, 1, 1121, 8)
INSERT [dbo].[ExamDetail] ([Id], [ExamId], [QuestionId], [Order]) VALUES (9, 2, 1113, 1)
INSERT [dbo].[ExamDetail] ([Id], [ExamId], [QuestionId], [Order]) VALUES (10, 2, 1125, 18)
INSERT [dbo].[ExamDetail] ([Id], [ExamId], [QuestionId], [Order]) VALUES (11, 2, 1124, 17)
INSERT [dbo].[ExamDetail] ([Id], [ExamId], [QuestionId], [Order]) VALUES (12, 2, 1126, 16)
INSERT [dbo].[ExamDetail] ([Id], [ExamId], [QuestionId], [Order]) VALUES (13, 2, 1127, 15)
INSERT [dbo].[ExamDetail] ([Id], [ExamId], [QuestionId], [Order]) VALUES (14, 2, 1128, 14)
INSERT [dbo].[ExamDetail] ([Id], [ExamId], [QuestionId], [Order]) VALUES (15, 2, 1129, 13)
INSERT [dbo].[ExamDetail] ([Id], [ExamId], [QuestionId], [Order]) VALUES (16, 2, 1130, 12)
INSERT [dbo].[ExamDetail] ([Id], [ExamId], [QuestionId], [Order]) VALUES (17, 2, 1123, 11)
INSERT [dbo].[ExamDetail] ([Id], [ExamId], [QuestionId], [Order]) VALUES (18, 2, 1122, 10)
INSERT [dbo].[ExamDetail] ([Id], [ExamId], [QuestionId], [Order]) VALUES (19, 2, 1121, 9)
INSERT [dbo].[ExamDetail] ([Id], [ExamId], [QuestionId], [Order]) VALUES (20, 2, 1120, 8)
INSERT [dbo].[ExamDetail] ([Id], [ExamId], [QuestionId], [Order]) VALUES (21, 2, 1118, 7)
INSERT [dbo].[ExamDetail] ([Id], [ExamId], [QuestionId], [Order]) VALUES (22, 2, 1119, 6)
INSERT [dbo].[ExamDetail] ([Id], [ExamId], [QuestionId], [Order]) VALUES (23, 2, 1117, 5)
INSERT [dbo].[ExamDetail] ([Id], [ExamId], [QuestionId], [Order]) VALUES (24, 2, 1116, 4)
INSERT [dbo].[ExamDetail] ([Id], [ExamId], [QuestionId], [Order]) VALUES (25, 2, 1115, 3)
INSERT [dbo].[ExamDetail] ([Id], [ExamId], [QuestionId], [Order]) VALUES (26, 2, 1114, 2)
INSERT [dbo].[ExamDetail] ([Id], [ExamId], [QuestionId], [Order]) VALUES (27, 2, 1131, 19)
INSERT [dbo].[ExamDetail] ([Id], [ExamId], [QuestionId], [Order]) VALUES (28, 2, 1132, 20)
INSERT [dbo].[ExamDetail] ([Id], [ExamId], [QuestionId], [Order]) VALUES (29, 3, 1157, 1)
INSERT [dbo].[ExamDetail] ([Id], [ExamId], [QuestionId], [Order]) VALUES (30, 3, 1156, 2)
INSERT [dbo].[ExamDetail] ([Id], [ExamId], [QuestionId], [Order]) VALUES (31, 3, 1153, 3)
INSERT [dbo].[ExamDetail] ([Id], [ExamId], [QuestionId], [Order]) VALUES (32, 3, 1155, 4)
INSERT [dbo].[ExamDetail] ([Id], [ExamId], [QuestionId], [Order]) VALUES (33, 3, 1151, 5)
INSERT [dbo].[ExamDetail] ([Id], [ExamId], [QuestionId], [Order]) VALUES (34, 3, 1149, 6)
INSERT [dbo].[ExamDetail] ([Id], [ExamId], [QuestionId], [Order]) VALUES (35, 3, 1152, 7)
INSERT [dbo].[ExamDetail] ([Id], [ExamId], [QuestionId], [Order]) VALUES (36, 3, 1146, 8)
INSERT [dbo].[ExamDetail] ([Id], [ExamId], [QuestionId], [Order]) VALUES (37, 3, 1147, 9)
INSERT [dbo].[ExamDetail] ([Id], [ExamId], [QuestionId], [Order]) VALUES (38, 3, 1148, 10)
INSERT [dbo].[ExamDetail] ([Id], [ExamId], [QuestionId], [Order]) VALUES (39, 3, 1143, 11)
INSERT [dbo].[ExamDetail] ([Id], [ExamId], [QuestionId], [Order]) VALUES (40, 3, 1145, 12)
INSERT [dbo].[ExamDetail] ([Id], [ExamId], [QuestionId], [Order]) VALUES (41, 4, 1143, 1)
INSERT [dbo].[ExamDetail] ([Id], [ExamId], [QuestionId], [Order]) VALUES (42, 4, 1144, 2)
INSERT [dbo].[ExamDetail] ([Id], [ExamId], [QuestionId], [Order]) VALUES (43, 4, 1145, 3)
INSERT [dbo].[ExamDetail] ([Id], [ExamId], [QuestionId], [Order]) VALUES (44, 4, 1146, 4)
INSERT [dbo].[ExamDetail] ([Id], [ExamId], [QuestionId], [Order]) VALUES (45, 4, 1147, 5)
INSERT [dbo].[ExamDetail] ([Id], [ExamId], [QuestionId], [Order]) VALUES (46, 4, 1148, 6)
INSERT [dbo].[ExamDetail] ([Id], [ExamId], [QuestionId], [Order]) VALUES (47, 4, 1157, 7)
INSERT [dbo].[ExamDetail] ([Id], [ExamId], [QuestionId], [Order]) VALUES (48, 4, 1156, 8)
INSERT [dbo].[ExamDetail] ([Id], [ExamId], [QuestionId], [Order]) VALUES (49, 4, 1155, 9)
INSERT [dbo].[ExamDetail] ([Id], [ExamId], [QuestionId], [Order]) VALUES (50, 4, 1154, 10)
INSERT [dbo].[ExamDetail] ([Id], [ExamId], [QuestionId], [Order]) VALUES (51, 4, 1153, 11)
INSERT [dbo].[ExamDetail] ([Id], [ExamId], [QuestionId], [Order]) VALUES (52, 4, 1152, 12)
INSERT [dbo].[ExamDetail] ([Id], [ExamId], [QuestionId], [Order]) VALUES (53, 4, 1151, 13)
INSERT [dbo].[ExamDetail] ([Id], [ExamId], [QuestionId], [Order]) VALUES (54, 4, 1150, 14)
INSERT [dbo].[ExamDetail] ([Id], [ExamId], [QuestionId], [Order]) VALUES (55, 4, 1149, 15)
INSERT [dbo].[ExamDetail] ([Id], [ExamId], [QuestionId], [Order]) VALUES (56, 5, 1113, 1)
INSERT [dbo].[ExamDetail] ([Id], [ExamId], [QuestionId], [Order]) VALUES (57, 5, 1121, 28)
INSERT [dbo].[ExamDetail] ([Id], [ExamId], [QuestionId], [Order]) VALUES (58, 5, 1120, 27)
INSERT [dbo].[ExamDetail] ([Id], [ExamId], [QuestionId], [Order]) VALUES (59, 5, 1124, 26)
INSERT [dbo].[ExamDetail] ([Id], [ExamId], [QuestionId], [Order]) VALUES (60, 5, 1123, 25)
INSERT [dbo].[ExamDetail] ([Id], [ExamId], [QuestionId], [Order]) VALUES (61, 5, 1126, 24)
INSERT [dbo].[ExamDetail] ([Id], [ExamId], [QuestionId], [Order]) VALUES (62, 5, 1127, 23)
INSERT [dbo].[ExamDetail] ([Id], [ExamId], [QuestionId], [Order]) VALUES (63, 5, 1128, 22)
INSERT [dbo].[ExamDetail] ([Id], [ExamId], [QuestionId], [Order]) VALUES (64, 5, 1129, 21)
INSERT [dbo].[ExamDetail] ([Id], [ExamId], [QuestionId], [Order]) VALUES (65, 5, 1130, 20)
INSERT [dbo].[ExamDetail] ([Id], [ExamId], [QuestionId], [Order]) VALUES (66, 5, 1131, 19)
INSERT [dbo].[ExamDetail] ([Id], [ExamId], [QuestionId], [Order]) VALUES (67, 5, 1132, 18)
INSERT [dbo].[ExamDetail] ([Id], [ExamId], [QuestionId], [Order]) VALUES (68, 5, 1133, 17)
INSERT [dbo].[ExamDetail] ([Id], [ExamId], [QuestionId], [Order]) VALUES (69, 5, 1134, 16)
INSERT [dbo].[ExamDetail] ([Id], [ExamId], [QuestionId], [Order]) VALUES (70, 5, 1135, 15)
INSERT [dbo].[ExamDetail] ([Id], [ExamId], [QuestionId], [Order]) VALUES (71, 5, 1136, 14)
INSERT [dbo].[ExamDetail] ([Id], [ExamId], [QuestionId], [Order]) VALUES (72, 5, 1137, 13)
INSERT [dbo].[ExamDetail] ([Id], [ExamId], [QuestionId], [Order]) VALUES (73, 5, 1138, 12)
INSERT [dbo].[ExamDetail] ([Id], [ExamId], [QuestionId], [Order]) VALUES (74, 5, 1139, 11)
INSERT [dbo].[ExamDetail] ([Id], [ExamId], [QuestionId], [Order]) VALUES (75, 5, 1140, 10)
INSERT [dbo].[ExamDetail] ([Id], [ExamId], [QuestionId], [Order]) VALUES (76, 5, 1142, 9)
INSERT [dbo].[ExamDetail] ([Id], [ExamId], [QuestionId], [Order]) VALUES (77, 5, 1141, 8)
INSERT [dbo].[ExamDetail] ([Id], [ExamId], [QuestionId], [Order]) VALUES (78, 5, 1119, 7)
INSERT [dbo].[ExamDetail] ([Id], [ExamId], [QuestionId], [Order]) VALUES (79, 5, 1118, 6)
INSERT [dbo].[ExamDetail] ([Id], [ExamId], [QuestionId], [Order]) VALUES (80, 5, 1117, 5)
INSERT [dbo].[ExamDetail] ([Id], [ExamId], [QuestionId], [Order]) VALUES (81, 5, 1116, 4)
INSERT [dbo].[ExamDetail] ([Id], [ExamId], [QuestionId], [Order]) VALUES (82, 5, 1115, 3)
INSERT [dbo].[ExamDetail] ([Id], [ExamId], [QuestionId], [Order]) VALUES (83, 5, 1114, 2)
INSERT [dbo].[ExamDetail] ([Id], [ExamId], [QuestionId], [Order]) VALUES (84, 5, 1122, 29)
INSERT [dbo].[ExamDetail] ([Id], [ExamId], [QuestionId], [Order]) VALUES (85, 5, 1125, 30)
SET IDENTITY_INSERT [dbo].[ExamDetail] OFF
GO
SET IDENTITY_INSERT [dbo].[History] ON 

INSERT [dbo].[History] ([Id], [ExamId], [UserId], [TimeDoExam], [Point], [CreatedAt]) VALUES (2, 5, 3, 1, 19, CAST(N'2023-06-04T11:13:42.320' AS DateTime))
INSERT [dbo].[History] ([Id], [ExamId], [UserId], [TimeDoExam], [Point], [CreatedAt]) VALUES (3, 5, 3, 1, 0, CAST(N'2023-06-04T11:16:11.557' AS DateTime))
INSERT [dbo].[History] ([Id], [ExamId], [UserId], [TimeDoExam], [Point], [CreatedAt]) VALUES (4, 1, 1, 0.16666666666666666, 3, CAST(N'2023-06-04T11:17:23.573' AS DateTime))
INSERT [dbo].[History] ([Id], [ExamId], [UserId], [TimeDoExam], [Point], [CreatedAt]) VALUES (5, 1, 3, 0.7, 2, CAST(N'2023-06-04T11:19:20.487' AS DateTime))
INSERT [dbo].[History] ([Id], [ExamId], [UserId], [TimeDoExam], [Point], [CreatedAt]) VALUES (6, 1, 3, 0.4, 7, CAST(N'2023-06-04T11:20:51.530' AS DateTime))
SET IDENTITY_INSERT [dbo].[History] OFF
GO
SET IDENTITY_INSERT [dbo].[HistoryDetail] ON 

INSERT [dbo].[HistoryDetail] ([Id], [HistoryId], [QuestionId], [AnswerSelect]) VALUES (31, 2, 1113, N'D')
INSERT [dbo].[HistoryDetail] ([Id], [HistoryId], [QuestionId], [AnswerSelect]) VALUES (32, 2, 1114, N'B')
INSERT [dbo].[HistoryDetail] ([Id], [HistoryId], [QuestionId], [AnswerSelect]) VALUES (33, 2, 1115, N'A')
INSERT [dbo].[HistoryDetail] ([Id], [HistoryId], [QuestionId], [AnswerSelect]) VALUES (34, 2, 1116, N'C')
INSERT [dbo].[HistoryDetail] ([Id], [HistoryId], [QuestionId], [AnswerSelect]) VALUES (35, 2, 1117, N'A')
INSERT [dbo].[HistoryDetail] ([Id], [HistoryId], [QuestionId], [AnswerSelect]) VALUES (36, 2, 1118, N'C')
INSERT [dbo].[HistoryDetail] ([Id], [HistoryId], [QuestionId], [AnswerSelect]) VALUES (37, 2, 1119, N'B')
INSERT [dbo].[HistoryDetail] ([Id], [HistoryId], [QuestionId], [AnswerSelect]) VALUES (38, 2, 1141, N'B')
INSERT [dbo].[HistoryDetail] ([Id], [HistoryId], [QuestionId], [AnswerSelect]) VALUES (39, 2, 1142, N'B')
INSERT [dbo].[HistoryDetail] ([Id], [HistoryId], [QuestionId], [AnswerSelect]) VALUES (40, 2, 1140, N'D')
INSERT [dbo].[HistoryDetail] ([Id], [HistoryId], [QuestionId], [AnswerSelect]) VALUES (41, 2, 1139, N'C')
INSERT [dbo].[HistoryDetail] ([Id], [HistoryId], [QuestionId], [AnswerSelect]) VALUES (42, 2, 1138, N'A')
INSERT [dbo].[HistoryDetail] ([Id], [HistoryId], [QuestionId], [AnswerSelect]) VALUES (43, 2, 1137, N'B')
INSERT [dbo].[HistoryDetail] ([Id], [HistoryId], [QuestionId], [AnswerSelect]) VALUES (44, 2, 1136, N'B')
INSERT [dbo].[HistoryDetail] ([Id], [HistoryId], [QuestionId], [AnswerSelect]) VALUES (45, 2, 1135, N'C')
INSERT [dbo].[HistoryDetail] ([Id], [HistoryId], [QuestionId], [AnswerSelect]) VALUES (46, 2, 1134, N'B')
INSERT [dbo].[HistoryDetail] ([Id], [HistoryId], [QuestionId], [AnswerSelect]) VALUES (47, 2, 1133, N'C')
INSERT [dbo].[HistoryDetail] ([Id], [HistoryId], [QuestionId], [AnswerSelect]) VALUES (48, 2, 1132, N'D')
INSERT [dbo].[HistoryDetail] ([Id], [HistoryId], [QuestionId], [AnswerSelect]) VALUES (49, 2, 1131, N'B')
INSERT [dbo].[HistoryDetail] ([Id], [HistoryId], [QuestionId], [AnswerSelect]) VALUES (50, 2, 1130, N'X')
INSERT [dbo].[HistoryDetail] ([Id], [HistoryId], [QuestionId], [AnswerSelect]) VALUES (51, 2, 1129, N'X')
INSERT [dbo].[HistoryDetail] ([Id], [HistoryId], [QuestionId], [AnswerSelect]) VALUES (52, 2, 1128, N'X')
INSERT [dbo].[HistoryDetail] ([Id], [HistoryId], [QuestionId], [AnswerSelect]) VALUES (53, 2, 1127, N'X')
INSERT [dbo].[HistoryDetail] ([Id], [HistoryId], [QuestionId], [AnswerSelect]) VALUES (54, 2, 1126, N'X')
INSERT [dbo].[HistoryDetail] ([Id], [HistoryId], [QuestionId], [AnswerSelect]) VALUES (55, 2, 1123, N'X')
INSERT [dbo].[HistoryDetail] ([Id], [HistoryId], [QuestionId], [AnswerSelect]) VALUES (56, 2, 1124, N'X')
INSERT [dbo].[HistoryDetail] ([Id], [HistoryId], [QuestionId], [AnswerSelect]) VALUES (57, 2, 1120, N'X')
INSERT [dbo].[HistoryDetail] ([Id], [HistoryId], [QuestionId], [AnswerSelect]) VALUES (58, 2, 1121, N'X')
INSERT [dbo].[HistoryDetail] ([Id], [HistoryId], [QuestionId], [AnswerSelect]) VALUES (59, 2, 1122, N'X')
INSERT [dbo].[HistoryDetail] ([Id], [HistoryId], [QuestionId], [AnswerSelect]) VALUES (60, 2, 1125, N'X')
INSERT [dbo].[HistoryDetail] ([Id], [HistoryId], [QuestionId], [AnswerSelect]) VALUES (61, 3, 1113, N'X')
INSERT [dbo].[HistoryDetail] ([Id], [HistoryId], [QuestionId], [AnswerSelect]) VALUES (62, 3, 1114, N'X')
INSERT [dbo].[HistoryDetail] ([Id], [HistoryId], [QuestionId], [AnswerSelect]) VALUES (63, 3, 1115, N'X')
INSERT [dbo].[HistoryDetail] ([Id], [HistoryId], [QuestionId], [AnswerSelect]) VALUES (64, 3, 1116, N'X')
INSERT [dbo].[HistoryDetail] ([Id], [HistoryId], [QuestionId], [AnswerSelect]) VALUES (65, 3, 1117, N'X')
INSERT [dbo].[HistoryDetail] ([Id], [HistoryId], [QuestionId], [AnswerSelect]) VALUES (66, 3, 1118, N'X')
INSERT [dbo].[HistoryDetail] ([Id], [HistoryId], [QuestionId], [AnswerSelect]) VALUES (67, 3, 1119, N'X')
INSERT [dbo].[HistoryDetail] ([Id], [HistoryId], [QuestionId], [AnswerSelect]) VALUES (68, 3, 1141, N'X')
INSERT [dbo].[HistoryDetail] ([Id], [HistoryId], [QuestionId], [AnswerSelect]) VALUES (69, 3, 1142, N'X')
INSERT [dbo].[HistoryDetail] ([Id], [HistoryId], [QuestionId], [AnswerSelect]) VALUES (70, 3, 1140, N'X')
INSERT [dbo].[HistoryDetail] ([Id], [HistoryId], [QuestionId], [AnswerSelect]) VALUES (71, 3, 1139, N'X')
INSERT [dbo].[HistoryDetail] ([Id], [HistoryId], [QuestionId], [AnswerSelect]) VALUES (72, 3, 1138, N'X')
INSERT [dbo].[HistoryDetail] ([Id], [HistoryId], [QuestionId], [AnswerSelect]) VALUES (73, 3, 1137, N'X')
INSERT [dbo].[HistoryDetail] ([Id], [HistoryId], [QuestionId], [AnswerSelect]) VALUES (74, 3, 1136, N'X')
INSERT [dbo].[HistoryDetail] ([Id], [HistoryId], [QuestionId], [AnswerSelect]) VALUES (75, 3, 1135, N'X')
INSERT [dbo].[HistoryDetail] ([Id], [HistoryId], [QuestionId], [AnswerSelect]) VALUES (76, 3, 1134, N'X')
INSERT [dbo].[HistoryDetail] ([Id], [HistoryId], [QuestionId], [AnswerSelect]) VALUES (77, 3, 1133, N'X')
INSERT [dbo].[HistoryDetail] ([Id], [HistoryId], [QuestionId], [AnswerSelect]) VALUES (78, 3, 1132, N'X')
INSERT [dbo].[HistoryDetail] ([Id], [HistoryId], [QuestionId], [AnswerSelect]) VALUES (79, 3, 1131, N'X')
INSERT [dbo].[HistoryDetail] ([Id], [HistoryId], [QuestionId], [AnswerSelect]) VALUES (80, 3, 1130, N'X')
INSERT [dbo].[HistoryDetail] ([Id], [HistoryId], [QuestionId], [AnswerSelect]) VALUES (81, 3, 1129, N'X')
INSERT [dbo].[HistoryDetail] ([Id], [HistoryId], [QuestionId], [AnswerSelect]) VALUES (82, 3, 1128, N'X')
INSERT [dbo].[HistoryDetail] ([Id], [HistoryId], [QuestionId], [AnswerSelect]) VALUES (83, 3, 1127, N'X')
INSERT [dbo].[HistoryDetail] ([Id], [HistoryId], [QuestionId], [AnswerSelect]) VALUES (84, 3, 1126, N'X')
INSERT [dbo].[HistoryDetail] ([Id], [HistoryId], [QuestionId], [AnswerSelect]) VALUES (85, 3, 1123, N'X')
INSERT [dbo].[HistoryDetail] ([Id], [HistoryId], [QuestionId], [AnswerSelect]) VALUES (86, 3, 1124, N'X')
INSERT [dbo].[HistoryDetail] ([Id], [HistoryId], [QuestionId], [AnswerSelect]) VALUES (87, 3, 1120, N'X')
INSERT [dbo].[HistoryDetail] ([Id], [HistoryId], [QuestionId], [AnswerSelect]) VALUES (88, 3, 1121, N'X')
INSERT [dbo].[HistoryDetail] ([Id], [HistoryId], [QuestionId], [AnswerSelect]) VALUES (89, 3, 1122, N'X')
INSERT [dbo].[HistoryDetail] ([Id], [HistoryId], [QuestionId], [AnswerSelect]) VALUES (90, 3, 1125, N'X')
INSERT [dbo].[HistoryDetail] ([Id], [HistoryId], [QuestionId], [AnswerSelect]) VALUES (91, 4, 1113, N'C')
INSERT [dbo].[HistoryDetail] ([Id], [HistoryId], [QuestionId], [AnswerSelect]) VALUES (92, 4, 1114, N'B')
INSERT [dbo].[HistoryDetail] ([Id], [HistoryId], [QuestionId], [AnswerSelect]) VALUES (93, 4, 1118, N'C')
INSERT [dbo].[HistoryDetail] ([Id], [HistoryId], [QuestionId], [AnswerSelect]) VALUES (94, 4, 1117, N'C')
INSERT [dbo].[HistoryDetail] ([Id], [HistoryId], [QuestionId], [AnswerSelect]) VALUES (95, 4, 1115, N'D')
INSERT [dbo].[HistoryDetail] ([Id], [HistoryId], [QuestionId], [AnswerSelect]) VALUES (96, 4, 1125, N'A')
INSERT [dbo].[HistoryDetail] ([Id], [HistoryId], [QuestionId], [AnswerSelect]) VALUES (97, 4, 1123, N'A')
INSERT [dbo].[HistoryDetail] ([Id], [HistoryId], [QuestionId], [AnswerSelect]) VALUES (98, 4, 1121, N'C')
INSERT [dbo].[HistoryDetail] ([Id], [HistoryId], [QuestionId], [AnswerSelect]) VALUES (99, 5, 1113, N'A')
INSERT [dbo].[HistoryDetail] ([Id], [HistoryId], [QuestionId], [AnswerSelect]) VALUES (100, 5, 1114, N'B')
INSERT [dbo].[HistoryDetail] ([Id], [HistoryId], [QuestionId], [AnswerSelect]) VALUES (101, 5, 1118, N'C')
INSERT [dbo].[HistoryDetail] ([Id], [HistoryId], [QuestionId], [AnswerSelect]) VALUES (102, 5, 1117, N'C')
INSERT [dbo].[HistoryDetail] ([Id], [HistoryId], [QuestionId], [AnswerSelect]) VALUES (103, 5, 1115, N'C')
INSERT [dbo].[HistoryDetail] ([Id], [HistoryId], [QuestionId], [AnswerSelect]) VALUES (104, 5, 1125, N'B')
INSERT [dbo].[HistoryDetail] ([Id], [HistoryId], [QuestionId], [AnswerSelect]) VALUES (105, 5, 1123, N'B')
INSERT [dbo].[HistoryDetail] ([Id], [HistoryId], [QuestionId], [AnswerSelect]) VALUES (106, 5, 1121, N'B')
INSERT [dbo].[HistoryDetail] ([Id], [HistoryId], [QuestionId], [AnswerSelect]) VALUES (107, 6, 1113, N'D')
INSERT [dbo].[HistoryDetail] ([Id], [HistoryId], [QuestionId], [AnswerSelect]) VALUES (108, 6, 1114, N'B')
INSERT [dbo].[HistoryDetail] ([Id], [HistoryId], [QuestionId], [AnswerSelect]) VALUES (109, 6, 1118, N'C')
INSERT [dbo].[HistoryDetail] ([Id], [HistoryId], [QuestionId], [AnswerSelect]) VALUES (110, 6, 1117, N'A')
INSERT [dbo].[HistoryDetail] ([Id], [HistoryId], [QuestionId], [AnswerSelect]) VALUES (111, 6, 1115, N'A')
INSERT [dbo].[HistoryDetail] ([Id], [HistoryId], [QuestionId], [AnswerSelect]) VALUES (112, 6, 1125, N'C')
INSERT [dbo].[HistoryDetail] ([Id], [HistoryId], [QuestionId], [AnswerSelect]) VALUES (113, 6, 1123, N'B')
INSERT [dbo].[HistoryDetail] ([Id], [HistoryId], [QuestionId], [AnswerSelect]) VALUES (114, 6, 1121, N'A')
SET IDENTITY_INSERT [dbo].[HistoryDetail] OFF
GO
SET IDENTITY_INSERT [dbo].[Question] ON 

INSERT [dbo].[Question] ([Id], [CategoryId], [Content], [AnswerA], [AnswerB], [AnswerC], [AnswerD], [AnswerCorrect], [CreatedAt], [CreatedBy]) VALUES (1113, 1006, N'Đâu là câu sai về ngôn ngữ Java?', N'Ngôn ngữ Java có phân biệt chữ hoa – chữ thường', N'Java là ngôn ngữ lập trình hướng đối tượng', N'Dấu chấm phẩy được sử dụng để kết thúc lệnh trong java', N'Chương trình viết bằng Java chỉ có thể chạy trên hệ điều hành Window', N'D', CAST(N'2023-06-04' AS Date), 3)
INSERT [dbo].[Question] ([Id], [CategoryId], [Content], [AnswerA], [AnswerB], [AnswerC], [AnswerD], [AnswerCorrect], [CreatedAt], [CreatedBy]) VALUES (1114, 1006, N'Cho xâu kí tự s=”ABCDEF”. Để lấy kỳ tự thứ ‘E’ của xâu ký tự s(String) dùng câu lệnh nào sau đây?', N's.charAt(5)', N's.charAt(4)', N's[5]', N's[4]', N'B', CAST(N'2023-06-04' AS Date), 3)
INSERT [dbo].[Question] ([Id], [CategoryId], [Content], [AnswerA], [AnswerB], [AnswerC], [AnswerD], [AnswerCorrect], [CreatedAt], [CreatedBy]) VALUES (1115, 1006, N'Phạm vi truy cập của một đối tượng khi được khai báo public là gì?', N'Có thể được truy cập từ bất kỳ vị trí nào trong chương trình', N'Có thể được truy cập từ các lớp trong cùng package', N'Có thể được truy cập từ các lớp trong cùng package và lớp con nằm trong package khác', N'Chỉ có thể truy cập từ các phương thức khác trong class đó', N'A', CAST(N'2023-06-04' AS Date), 3)
INSERT [dbo].[Question] ([Id], [CategoryId], [Content], [AnswerA], [AnswerB], [AnswerC], [AnswerD], [AnswerCorrect], [CreatedAt], [CreatedBy]) VALUES (1116, 1006, N'Phạm vi truy cập của một đối tượng khi được khai bao protected là gì?', N'Có thể được truy cập từ bất kỳ vị trí nào trong chương trình', N'Có thể được truy cập từ các lớp trong cùng package', N'Có thể được truy cập từ các lớp trong cùng package và lớp con nằm trong package khác', N'Chỉ có thể truy cập từ các phương thức khác trong class đó', N'C', CAST(N'2023-06-04' AS Date), 3)
INSERT [dbo].[Question] ([Id], [CategoryId], [Content], [AnswerA], [AnswerB], [AnswerC], [AnswerD], [AnswerCorrect], [CreatedAt], [CreatedBy]) VALUES (1117, 1006, N'Kiểu enum là gì?', N'Là kiểu dữ liệu gồm các trường chứa một tập hợp cố định các hằng số', N'Là kiểu dữ liệu liệt kê các biến số', N'Là một kiểu dữ liệu trong java', N'Tất cả đều sai', N'A', CAST(N'2023-06-04' AS Date), 3)
INSERT [dbo].[Question] ([Id], [CategoryId], [Content], [AnswerA], [AnswerB], [AnswerC], [AnswerD], [AnswerCorrect], [CreatedAt], [CreatedBy]) VALUES (1118, 1006, N'Một lớp trong Java có bao nhiêu lớp con?', N'2', N'3', N'Vô số', N'4', N'C', CAST(N'2023-06-04' AS Date), 3)
INSERT [dbo].[Question] ([Id], [CategoryId], [Content], [AnswerA], [AnswerB], [AnswerC], [AnswerD], [AnswerCorrect], [CreatedAt], [CreatedBy]) VALUES (1119, 1006, N'Một lớp trong Java có thể có bao nhiêu lớp cha?', N'2', N'1', N'3', N'4', N'B', CAST(N'2023-06-04' AS Date), 3)
INSERT [dbo].[Question] ([Id], [CategoryId], [Content], [AnswerA], [AnswerB], [AnswerC], [AnswerD], [AnswerCorrect], [CreatedAt], [CreatedBy]) VALUES (1120, 1006, N'Khi biên dịch gặp lỗi Exception in thread main java.lang.NoClassDefFoundError: myprogram. Lỗi này có nghĩa gì?', N'Đường dẫn chương trình sai', N'Không có hàm main', N'Không khai báo class', N'Không có từ khóa public tại mở đầu khai báo class', N'A', CAST(N'2023-06-04' AS Date), 3)
INSERT [dbo].[Question] ([Id], [CategoryId], [Content], [AnswerA], [AnswerB], [AnswerC], [AnswerD], [AnswerCorrect], [CreatedAt], [CreatedBy]) VALUES (1121, 1006, N'Ngôn ngữ lập trình Java cung cấp các chức năng nào sau đây?', N'Tất cả đáp án trên', N'Giao diện lập trình ứng dụng', N'Bộ công cụ giao diện người dùng', N'Thư viện tích hợp', N'A', CAST(N'2023-06-04' AS Date), 3)
INSERT [dbo].[Question] ([Id], [CategoryId], [Content], [AnswerA], [AnswerB], [AnswerC], [AnswerD], [AnswerCorrect], [CreatedAt], [CreatedBy]) VALUES (1122, 1006, N'Java chạy trên hệ điều hành nào sau đây?', N'Microsoft Windows', N'Linux', N'Sun Solaris OS', N'Tất cả các đáp án đều đúng', N'D', CAST(N'2023-06-04' AS Date), 3)
INSERT [dbo].[Question] ([Id], [CategoryId], [Content], [AnswerA], [AnswerB], [AnswerC], [AnswerD], [AnswerCorrect], [CreatedAt], [CreatedBy]) VALUES (1123, 1006, N'Java Virtual Machine là gì?', N'Là một thành phần của Java platform dùng để đọc mã bytecode trong file .class', N'Là chương trình biên dịch của java dùng để biên dịch file nguồn java thành mã bytecode', N'Là chương trình chạy cho java', N'Tất cả các đáp án đều đúng', N'A', CAST(N'2023-06-04' AS Date), 3)
INSERT [dbo].[Question] ([Id], [CategoryId], [Content], [AnswerA], [AnswerB], [AnswerC], [AnswerD], [AnswerCorrect], [CreatedAt], [CreatedBy]) VALUES (1124, 1006, N'Nếu phương thức của bạn ghi đè một trong số các phương thức của lớp cha, bạn có thể gọi phương thức bị ghi đè thông qua từ khóa nào?', N'parent', N'super', N'this', N'static', N'B', CAST(N'2023-06-04' AS Date), 3)
INSERT [dbo].[Question] ([Id], [CategoryId], [Content], [AnswerA], [AnswerB], [AnswerC], [AnswerD], [AnswerCorrect], [CreatedAt], [CreatedBy]) VALUES (1125, 1006, N'Phát biểu nào sau đây là đúng?', N'Mảng có thể lưu giữ các phần tử thuộc nhiều kiểu dữ liệu khác nhau', N'Chỉ số của mảng có thể sử dụng kiểu số thực (float, double)', N'Biểu thức array.length được sử dụng để trả về số phần tử trong mảng', N'Một phần tử của mảng không thể truyền vào trong một phương thức', N'C', CAST(N'2023-06-04' AS Date), 3)
INSERT [dbo].[Question] ([Id], [CategoryId], [Content], [AnswerA], [AnswerB], [AnswerC], [AnswerD], [AnswerCorrect], [CreatedAt], [CreatedBy]) VALUES (1126, 1006, N'Trong các khai báo sau đâu là khai báo không hợp lệ?', N'int a1[][] = new int[][3]', N'int a2[][] = new int[2][3]', N'int a3[][] = new int[2][]', N'int a4[][] = {{}, {}, {}}', N'A', CAST(N'2023-06-04' AS Date), 3)
INSERT [dbo].[Question] ([Id], [CategoryId], [Content], [AnswerA], [AnswerB], [AnswerC], [AnswerD], [AnswerCorrect], [CreatedAt], [CreatedBy]) VALUES (1127, 1006, N'Có mấy cách để truyền tham số vào cho một phương thức?', N'2', N'1', N'3', N'4', N'A', CAST(N'2023-06-04' AS Date), 3)
INSERT [dbo].[Question] ([Id], [CategoryId], [Content], [AnswerA], [AnswerB], [AnswerC], [AnswerD], [AnswerCorrect], [CreatedAt], [CreatedBy]) VALUES (1128, 1006, N'Đâu là khai báo biến hợp lệ?', N'theOne', N'the One', N'1the_One', N'$the One', N'A', CAST(N'2023-06-04' AS Date), 3)
INSERT [dbo].[Question] ([Id], [CategoryId], [Content], [AnswerA], [AnswerB], [AnswerC], [AnswerD], [AnswerCorrect], [CreatedAt], [CreatedBy]) VALUES (1129, 1006, N'Với giá trị nào của x, thì biểu thức x % 3 == 0 trả về true với x là kiểu số nguyên?', N'2', N'7', N'4', N'9', N'D', CAST(N'2023-06-04' AS Date), 3)
INSERT [dbo].[Question] ([Id], [CategoryId], [Content], [AnswerA], [AnswerB], [AnswerC], [AnswerD], [AnswerCorrect], [CreatedAt], [CreatedBy]) VALUES (1130, 1006, N'Kiểu dữ liệu nào trong Java chứa giá trị bao gồm cả chữ và số?', N'int', N'byte', N'char', N'String', N'D', CAST(N'2023-06-04' AS Date), 3)
INSERT [dbo].[Question] ([Id], [CategoryId], [Content], [AnswerA], [AnswerB], [AnswerC], [AnswerD], [AnswerCorrect], [CreatedAt], [CreatedBy]) VALUES (1131, 1006, N'Đối tượng trong Java là gì?', N'Các lớp được tạo thể hiện từ đó', N'Một thể hiện của lớp', N'Một tham chiếu đến một thuộc tính', N'Một biến', N'B', CAST(N'2023-06-04' AS Date), 3)
INSERT [dbo].[Question] ([Id], [CategoryId], [Content], [AnswerA], [AnswerB], [AnswerC], [AnswerD], [AnswerCorrect], [CreatedAt], [CreatedBy]) VALUES (1132, 1006, N'Đâu không phải là thành phần trong cấu trúc của lớp trong Java.', N'Tên lớp', N'Thuộc tính', N'Phương thức', N'Biến', N'D', CAST(N'2023-06-04' AS Date), 3)
INSERT [dbo].[Question] ([Id], [CategoryId], [Content], [AnswerA], [AnswerB], [AnswerC], [AnswerD], [AnswerCorrect], [CreatedAt], [CreatedBy]) VALUES (1133, 1006, N'Giả sử đã định nghĩa lớp XX với một phương thức thông thường là Display, sau đó sinh ra đối tượng objX từ lớp XX. Để gọi phương thức Display ta sử dụng cú pháp nào?', N'XX.Display;', N'XX.Display();', N'objX.Display();', N'Display();', N'C', CAST(N'2023-06-04' AS Date), 3)
INSERT [dbo].[Question] ([Id], [CategoryId], [Content], [AnswerA], [AnswerB], [AnswerC], [AnswerD], [AnswerCorrect], [CreatedAt], [CreatedBy]) VALUES (1134, 1006, N'Tên đầu tiên của Java là gì?', N'Java', N'Oak', N'Cafe', N'James golings', N'B', CAST(N'2023-06-04' AS Date), 3)
INSERT [dbo].[Question] ([Id], [CategoryId], [Content], [AnswerA], [AnswerB], [AnswerC], [AnswerD], [AnswerCorrect], [CreatedAt], [CreatedBy]) VALUES (1135, 1006, N'Gói nào trong java chứa lớp Scanner dùng để nhập dữ liệu từ bàn phím?', N'java.net', N'java.io', N'java.util', N'java.awt', N'C', CAST(N'2023-06-04' AS Date), 3)
INSERT [dbo].[Question] ([Id], [CategoryId], [Content], [AnswerA], [AnswerB], [AnswerC], [AnswerD], [AnswerCorrect], [CreatedAt], [CreatedBy]) VALUES (1136, 1006, N'Đâu là khai báo đúng về lớp Cat?', N'interface Cat{}', N'public class Cat{}', N'static Cat{}', N'class public Cat{}', N'B', CAST(N'2023-06-04' AS Date), 3)
INSERT [dbo].[Question] ([Id], [CategoryId], [Content], [AnswerA], [AnswerB], [AnswerC], [AnswerD], [AnswerCorrect], [CreatedAt], [CreatedBy]) VALUES (1137, 1006, N'Muốn chạy được chương trình Java, chỉ cần cài phần mền nào sau đây?', N'JDK', N'Java Platform', N'Eclipse', N'Netbeans', N'B', CAST(N'2023-06-04' AS Date), 3)
INSERT [dbo].[Question] ([Id], [CategoryId], [Content], [AnswerA], [AnswerB], [AnswerC], [AnswerD], [AnswerCorrect], [CreatedAt], [CreatedBy]) VALUES (1138, 1006, N'Phương thức next() của lớp Scanner dùng để làm gì?', N'Nhập một chuỗi', N'Nhập một số nguyên', N'Nhập một ký tự', N'Không có phương thức này', N'A', CAST(N'2023-06-04' AS Date), 3)
INSERT [dbo].[Question] ([Id], [CategoryId], [Content], [AnswerA], [AnswerB], [AnswerC], [AnswerD], [AnswerCorrect], [CreatedAt], [CreatedBy]) VALUES (1139, 1006, N'Trong câu lệnh sau: public static void main(String[] agrs) thì phần tử agrs[0] chứa giá trị gì?', N'Tên của chương trình', N'Số lượng tham số', N'Tham số đầu tiên trong danh sách tham số', N'Không câu nào đúng', N'C', CAST(N'2023-06-04' AS Date), 3)
INSERT [dbo].[Question] ([Id], [CategoryId], [Content], [AnswerA], [AnswerB], [AnswerC], [AnswerD], [AnswerCorrect], [CreatedAt], [CreatedBy]) VALUES (1140, 1006, N'Đâu không phải là một kiểu dữ liệu nguyên thủy trong Java?', N'double', N'int', N'long', N'long float', N'D', CAST(N'2023-06-04' AS Date), 3)
INSERT [dbo].[Question] ([Id], [CategoryId], [Content], [AnswerA], [AnswerB], [AnswerC], [AnswerD], [AnswerCorrect], [CreatedAt], [CreatedBy]) VALUES (1141, 1006, N'Trong Java, kiểu dữ liệu nào là một địa chỉ của đối tượng hoặc một mảng được tạo ra trong bộ nhớ?', N'Kiểu primitive', N'Kiểu reference', N'Kiểu format', N'Không có đáp án đúng', N'B', CAST(N'2023-06-04' AS Date), 3)
INSERT [dbo].[Question] ([Id], [CategoryId], [Content], [AnswerA], [AnswerB], [AnswerC], [AnswerD], [AnswerCorrect], [CreatedAt], [CreatedBy]) VALUES (1142, 1006, N'Biến dữ liệu là các biến dạng nào sau đây?', N'Biến lớp và Tham số', N'Biến cục bộ và Tham số', N'Biến cục bộ và biến lớp', N'Các đáp án đều sai', N'B', CAST(N'2023-06-04' AS Date), 3)
INSERT [dbo].[Question] ([Id], [CategoryId], [Content], [AnswerA], [AnswerB], [AnswerC], [AnswerD], [AnswerCorrect], [CreatedAt], [CreatedBy]) VALUES (1143, 1007, N'Thiết bị hub thông thường nằm ở tầng nào của mô hình OSI?', N'Tầng 1', N'Tầng 2', N'Tầng 3', N'Tất cả đều sai', N'A', CAST(N'2023-06-04' AS Date), 3)
INSERT [dbo].[Question] ([Id], [CategoryId], [Content], [AnswerA], [AnswerB], [AnswerC], [AnswerD], [AnswerCorrect], [CreatedAt], [CreatedBy]) VALUES (1144, 1007, N'Thiết bị Switch thông thường nằm ở tầng nào của mô hình OSI?', N'Tầng 1', N'Tầng 2', N'Tầng 3', N'Tất cả đều sai', N'B', CAST(N'2023-06-04' AS Date), 3)
INSERT [dbo].[Question] ([Id], [CategoryId], [Content], [AnswerA], [AnswerB], [AnswerC], [AnswerD], [AnswerCorrect], [CreatedAt], [CreatedBy]) VALUES (1145, 1007, N'Thiết bị Bridge nằm ở tầng nào của mô hình OSI?', N'Tầng 1', N'Tầng 2', N'Tầng 3', N'Tất cả đều sai', N'B', CAST(N'2023-06-04' AS Date), 3)
INSERT [dbo].[Question] ([Id], [CategoryId], [Content], [AnswerA], [AnswerB], [AnswerC], [AnswerD], [AnswerCorrect], [CreatedAt], [CreatedBy]) VALUES (1146, 1007, N'Thiết bị router có bao nhiêu Broadcast domain?', N'1 broadcast/1port', N'2', N'3', N'4', N'B', CAST(N'2023-06-04' AS Date), 3)
INSERT [dbo].[Question] ([Id], [CategoryId], [Content], [AnswerA], [AnswerB], [AnswerC], [AnswerD], [AnswerCorrect], [CreatedAt], [CreatedBy]) VALUES (1147, 1007, N'Thiết bị Router có bao nhiêu collision domain?', N'1', N'2', N'3', N'4', N'A', CAST(N'2023-06-04' AS Date), 3)
INSERT [dbo].[Question] ([Id], [CategoryId], [Content], [AnswerA], [AnswerB], [AnswerC], [AnswerD], [AnswerCorrect], [CreatedAt], [CreatedBy]) VALUES (1148, 1007, N'Cáp UTP có thể kết nối tối đa bao nhiêu mét?', N'10', N'20', N'100', N'200', N'C', CAST(N'2023-06-04' AS Date), 3)
INSERT [dbo].[Question] ([Id], [CategoryId], [Content], [AnswerA], [AnswerB], [AnswerC], [AnswerD], [AnswerCorrect], [CreatedAt], [CreatedBy]) VALUES (1149, 1007, N'Cáp quang có thể kết nối tối đa bao nhiêu mét?', N'1000', N'2000', N'500', N'Dưới 500', N'B', CAST(N'2023-06-04' AS Date), 3)
INSERT [dbo].[Question] ([Id], [CategoryId], [Content], [AnswerA], [AnswerB], [AnswerC], [AnswerD], [AnswerCorrect], [CreatedAt], [CreatedBy]) VALUES (1150, 1007, N'Để nối Router và máy tính ta phải bấm cáp kiểu nào?', N'Thẳng', N'Chéo', N'Kiểu nào cũng được', N'Tất cả đều sai', N'A', CAST(N'2023-06-04' AS Date), 3)
INSERT [dbo].[Question] ([Id], [CategoryId], [Content], [AnswerA], [AnswerB], [AnswerC], [AnswerD], [AnswerCorrect], [CreatedAt], [CreatedBy]) VALUES (1151, 1007, N'Định nghĩa giao thức (protocol) là gì?', N'Là các tín hiệu nhị phân truyền đi trước khi truyền dữ liệu thật sự', N'Là cơ chế “bắt tay ba lần” mà mọi thiết bị mạng đều phải thực hiện khi khởi động', N'Là một tập các đặc tả mà mọi nhà sản xuất sản phẩm mạng phải dựa theo để thiết kế sản phẩm của mình', N'Tất cả đáp án trên', N'A', CAST(N'2023-06-04' AS Date), 3)
INSERT [dbo].[Question] ([Id], [CategoryId], [Content], [AnswerA], [AnswerB], [AnswerC], [AnswerD], [AnswerCorrect], [CreatedAt], [CreatedBy]) VALUES (1152, 1007, N'Để kết nối hai HUB với nhau ta sử dụng kiểu bấm cáp nào?', N'Thẳng (straight-through)', N'Chéo (cross-over)', N'Console', N'Tất cả đều đúng', N'B', CAST(N'2023-06-04' AS Date), 3)
INSERT [dbo].[Question] ([Id], [CategoryId], [Content], [AnswerA], [AnswerB], [AnswerC], [AnswerD], [AnswerCorrect], [CreatedAt], [CreatedBy]) VALUES (1153, 1007, N'Subnet mask trong một cổng seria của router là 11111000. Số thập phân của nó là gì?', N'210', N'224', N'240', N'248', N'D', CAST(N'2023-06-04' AS Date), 3)
INSERT [dbo].[Question] ([Id], [CategoryId], [Content], [AnswerA], [AnswerB], [AnswerC], [AnswerD], [AnswerCorrect], [CreatedAt], [CreatedBy]) VALUES (1154, 1007, N'Chức năng chính của router là?', N'Kết nối LAN với LAN', N'Chia nhỏ broadcast domain', N'Tất cả đều đúng', N'Tất cả đều sai', N'B', CAST(N'2023-06-04' AS Date), 3)
INSERT [dbo].[Question] ([Id], [CategoryId], [Content], [AnswerA], [AnswerB], [AnswerC], [AnswerD], [AnswerCorrect], [CreatedAt], [CreatedBy]) VALUES (1155, 1007, N'Modem dùng để?', N'Giao tiếp với mạng', N'Truyền dữ liệu đi xa', N'Truyền dữ liệu trong mạng LAN', N'A và B', N'D', CAST(N'2023-06-04' AS Date), 3)
INSERT [dbo].[Question] ([Id], [CategoryId], [Content], [AnswerA], [AnswerB], [AnswerC], [AnswerD], [AnswerCorrect], [CreatedAt], [CreatedBy]) VALUES (1156, 1007, N'Dịch vụ nào cho phép người sử dụng từ một trạm làm việc của mình có thể đăng nhập vào một trạm ở xa qua mạng và có thể làm việc với hệ thống?', N'Telnet', N'Email', N'FTP', N'WWW', N'A', CAST(N'2023-06-04' AS Date), 3)
INSERT [dbo].[Question] ([Id], [CategoryId], [Content], [AnswerA], [AnswerB], [AnswerC], [AnswerD], [AnswerCorrect], [CreatedAt], [CreatedBy]) VALUES (1157, 1007, N'Phát biểu nào sau đây mô tả đúng nhất cho cấu hình Star?', N'Cần ít cáp hơn nhiều so với các cấu hình khác', N'Khi cáp đứt tại một điểm nào đó làm toàn bộ mạng ngưng hoạt động', N'Khó tái lập cấu hình hơn so với các cấu hình khác', N'Dễ kiểm soát và quản lý tập trung', N'D', CAST(N'2023-06-04' AS Date), 3)
SET IDENTITY_INSERT [dbo].[Question] OFF
GO
SET IDENTITY_INSERT [dbo].[Rank] ON 

INSERT [dbo].[Rank] ([Id], [ExamId], [UserId], [TimeDoExam], [Point]) VALUES (1, 5, 3, 1, 19)
INSERT [dbo].[Rank] ([Id], [ExamId], [UserId], [TimeDoExam], [Point]) VALUES (2, 1, 1, 0.16666666666666666, 3)
INSERT [dbo].[Rank] ([Id], [ExamId], [UserId], [TimeDoExam], [Point]) VALUES (3, 1, 3, 0.4, 7)
SET IDENTITY_INSERT [dbo].[Rank] OFF
GO
SET IDENTITY_INSERT [dbo].[Role] ON 

INSERT [dbo].[Role] ([Id], [RoleName], [CreateAt]) VALUES (1, N'Admin', CAST(N'2023-05-23T22:16:56.967' AS DateTime))
INSERT [dbo].[Role] ([Id], [RoleName], [CreateAt]) VALUES (2, N'Khách hàng', CAST(N'2023-05-23T22:17:02.637' AS DateTime))
SET IDENTITY_INSERT [dbo].[Role] OFF
GO
SET IDENTITY_INSERT [dbo].[User] ON 

INSERT [dbo].[User] ([Id], [RoleId], [FullName], [UserName], [Password], [CreateAt]) VALUES (1, 2, N'Hà Duy Anh', N'duyanh', N'202cb962ac59075b964b07152d234b70', CAST(N'2023-05-29T19:59:37.617' AS DateTime))
INSERT [dbo].[User] ([Id], [RoleId], [FullName], [UserName], [Password], [CreateAt]) VALUES (3, 1, N'Admin', N'admin', N'202cb962ac59075b964b07152d234b70', CAST(N'2023-05-29T19:59:51.413' AS DateTime))
INSERT [dbo].[User] ([Id], [RoleId], [FullName], [UserName], [Password], [CreateAt]) VALUES (4, 2, N'Văn Chiến', N'chien', N'202cb962ac59075b964b07152d234b70', CAST(N'2023-06-04T08:59:26.400' AS DateTime))
SET IDENTITY_INSERT [dbo].[User] OFF
GO
ALTER TABLE [dbo].[Category] ADD  DEFAULT (getdate()) FOR [CreateAt]
GO
ALTER TABLE [dbo].[Exam] ADD  CONSTRAINT [DF__Exam__CreateAt__34C8D9D1]  DEFAULT (getdate()) FOR [CreateAt]
GO
ALTER TABLE [dbo].[History] ADD  CONSTRAINT [DF_History_CreatedAt]  DEFAULT (getdate()) FOR [CreatedAt]
GO
ALTER TABLE [dbo].[Question] ADD  CONSTRAINT [DF__Question__Create__36B12243]  DEFAULT (getdate()) FOR [CreatedAt]
GO
ALTER TABLE [dbo].[Role] ADD  DEFAULT (getdate()) FOR [CreateAt]
GO
ALTER TABLE [dbo].[User] ADD  DEFAULT (getdate()) FOR [CreateAt]
GO
ALTER TABLE [dbo].[Exam]  WITH CHECK ADD  CONSTRAINT [FK__Exam__CategoryId__3A81B327] FOREIGN KEY([CategoryId])
REFERENCES [dbo].[Category] ([Id])
GO
ALTER TABLE [dbo].[Exam] CHECK CONSTRAINT [FK__Exam__CategoryId__3A81B327]
GO
ALTER TABLE [dbo].[Exam]  WITH CHECK ADD  CONSTRAINT [FK__Exam__CreateBy__3B75D760] FOREIGN KEY([CreateBy])
REFERENCES [dbo].[User] ([Id])
GO
ALTER TABLE [dbo].[Exam] CHECK CONSTRAINT [FK__Exam__CreateBy__3B75D760]
GO
ALTER TABLE [dbo].[ExamDetail]  WITH CHECK ADD  CONSTRAINT [FK__ExamDetai__ExamI__3C69FB99] FOREIGN KEY([ExamId])
REFERENCES [dbo].[Exam] ([Id])
GO
ALTER TABLE [dbo].[ExamDetail] CHECK CONSTRAINT [FK__ExamDetai__ExamI__3C69FB99]
GO
ALTER TABLE [dbo].[ExamDetail]  WITH CHECK ADD  CONSTRAINT [FK__ExamDetai__Quest__3D5E1FD2] FOREIGN KEY([QuestionId])
REFERENCES [dbo].[Question] ([Id])
GO
ALTER TABLE [dbo].[ExamDetail] CHECK CONSTRAINT [FK__ExamDetai__Quest__3D5E1FD2]
GO
ALTER TABLE [dbo].[History]  WITH CHECK ADD  CONSTRAINT [FK__History__ExamId__3E52440B] FOREIGN KEY([ExamId])
REFERENCES [dbo].[Exam] ([Id])
GO
ALTER TABLE [dbo].[History] CHECK CONSTRAINT [FK__History__ExamId__3E52440B]
GO
ALTER TABLE [dbo].[History]  WITH CHECK ADD  CONSTRAINT [FK__History__UserId__3F466844] FOREIGN KEY([UserId])
REFERENCES [dbo].[User] ([Id])
GO
ALTER TABLE [dbo].[History] CHECK CONSTRAINT [FK__History__UserId__3F466844]
GO
ALTER TABLE [dbo].[HistoryDetail]  WITH CHECK ADD  CONSTRAINT [FK__HistoryEx__Histo__403A8C7D] FOREIGN KEY([HistoryId])
REFERENCES [dbo].[History] ([Id])
GO
ALTER TABLE [dbo].[HistoryDetail] CHECK CONSTRAINT [FK__HistoryEx__Histo__403A8C7D]
GO
ALTER TABLE [dbo].[HistoryDetail]  WITH CHECK ADD  CONSTRAINT [FK__HistoryEx__Quest__412EB0B6] FOREIGN KEY([QuestionId])
REFERENCES [dbo].[Question] ([Id])
GO
ALTER TABLE [dbo].[HistoryDetail] CHECK CONSTRAINT [FK__HistoryEx__Quest__412EB0B6]
GO
ALTER TABLE [dbo].[Question]  WITH CHECK ADD  CONSTRAINT [FK__Question__Catego__4222D4EF] FOREIGN KEY([CategoryId])
REFERENCES [dbo].[Category] ([Id])
GO
ALTER TABLE [dbo].[Question] CHECK CONSTRAINT [FK__Question__Catego__4222D4EF]
GO
ALTER TABLE [dbo].[Question]  WITH CHECK ADD  CONSTRAINT [FK__Question__Create__4316F928] FOREIGN KEY([CreatedBy])
REFERENCES [dbo].[User] ([Id])
GO
ALTER TABLE [dbo].[Question] CHECK CONSTRAINT [FK__Question__Create__4316F928]
GO
ALTER TABLE [dbo].[Rank]  WITH CHECK ADD  CONSTRAINT [FK__Rank__ExamId__440B1D61] FOREIGN KEY([ExamId])
REFERENCES [dbo].[Exam] ([Id])
GO
ALTER TABLE [dbo].[Rank] CHECK CONSTRAINT [FK__Rank__ExamId__440B1D61]
GO
ALTER TABLE [dbo].[Rank]  WITH CHECK ADD  CONSTRAINT [FK__Rank__UserId__44FF419A] FOREIGN KEY([UserId])
REFERENCES [dbo].[User] ([Id])
GO
ALTER TABLE [dbo].[Rank] CHECK CONSTRAINT [FK__Rank__UserId__44FF419A]
GO
ALTER TABLE [dbo].[User]  WITH CHECK ADD FOREIGN KEY([RoleId])
REFERENCES [dbo].[Role] ([Id])
GO
