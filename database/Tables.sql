USE [BonGraphics]
GO
/****** Object:  Table [dbo].[Building]    Script Date: 24-02-2025 22:57:50 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Building](
	[Id] [bigint] IDENTITY(1,1) NOT NULL,
	[UId] [uniqueidentifier] NOT NULL,
	[Name] [nvarchar](100) NOT NULL,
	[FloorId] [bigint] NOT NULL,
	[LocationId] [bigint] NOT NULL,
	[Notes] [nvarchar](500) NULL,
	[ActionBy] [bigint] NOT NULL,
	[ActionDate] [datetime] NOT NULL,
	[IsActive] [bit] NOT NULL,
 CONSTRAINT [PK__Building__C5B1966227DC3A71] PRIMARY KEY CLUSTERED 
(
	[UId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Machine]    Script Date: 24-02-2025 22:57:50 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Machine](
	[Id] [bigint] IDENTITY(1,1) NOT NULL,
	[UId] [uniqueidentifier] NOT NULL,
	[Name] [nvarchar](100) NOT NULL,
	[TypeId] [bigint] NOT NULL,
	[SerialNumber] [nvarchar](50) NOT NULL,
	[ModelNumber] [nvarchar](50) NOT NULL,
	[Manufacturer] [nvarchar](100) NOT NULL,
	[SizeId] [bigint] NULL,
	[Capacity] [nvarchar](50) NULL,
	[PurchaseDate] [datetime] NULL,
	[LocationId] [bigint] NOT NULL,
	[CurrentCount] [bigint] NULL,
	[MaximumCount] [bigint] NULL,
	[Notes] [nvarchar](500) NULL,
	[ActionBy] [bigint] NOT NULL,
	[ActionDate] [datetime] NOT NULL,
	[IsActive] [bit] NOT NULL,
 CONSTRAINT [PK__Machine__C5B19662AB6CCB8F] PRIMARY KEY CLUSTERED 
(
	[UId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[MachineMaintenance]    Script Date: 24-02-2025 22:57:50 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[MachineMaintenance](
	[Id] [bigint] IDENTITY(1,1) NOT NULL,
	[UId] [uniqueidentifier] NOT NULL,
	[MachineId] [uniqueidentifier] NOT NULL,
	[ServiceDate] [datetime] NOT NULL,
	[ServiceTypeId] [bigint] NOT NULL,
	[ServiceBy] [nvarchar](50) NOT NULL,
	[Comments] [nvarchar](500) NULL,
	[NextServiceDate] [datetime] NULL,
	[StatusId] [bigint] NOT NULL,
	[ActionBy] [bigint] NOT NULL,
	[ActionDate] [datetime] NOT NULL,
	[IsActive] [bit] NOT NULL,
 CONSTRAINT [PK__MachineM__C5B196620717A046] PRIMARY KEY CLUSTERED 
(
	[UId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Role]    Script Date: 24-02-2025 22:57:50 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Role](
	[Id] [bigint] IDENTITY(1,1) NOT NULL,
	[UId] [uniqueidentifier] NOT NULL,
	[Name] [nvarchar](100) NOT NULL,
	[Notes] [nvarchar](500) NULL,
	[ActionBy] [bigint] NOT NULL,
	[ActionDate] [datetime] NOT NULL,
	[IsActive] [bit] NOT NULL,
 CONSTRAINT [PK__Role__C5B19662F68869C6] PRIMARY KEY CLUSTERED 
(
	[UId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[User]    Script Date: 24-02-2025 22:57:50 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[User](
	[Id] [bigint] IDENTITY(1,1) NOT NULL,
	[UId] [uniqueidentifier] NOT NULL,
	[Name] [nvarchar](100) NOT NULL,
	[LastName] [nvarchar](100) NULL,
	[Password] [nvarchar](30) NOT NULL,
	[Email] [nvarchar](50) NOT NULL,
	[Mobile] [nvarchar](20) NOT NULL,
	[RoleId] [uniqueidentifier] NOT NULL,
	[ActionBy] [bigint] NOT NULL,
	[ActionDate] [datetime] NOT NULL,
	[IsActive] [bit] NOT NULL,
 CONSTRAINT [PK__User__C5B196629F284FAD] PRIMARY KEY CLUSTERED 
(
	[UId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
