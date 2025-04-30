USE [Bon]
GO
/****** Object:  Table [dbo].[Category]    Script Date: 30-04-2025 06:41:13 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Category](
	[Id] [bigint] NOT NULL,
	[Name] [nvarchar](100) NOT NULL,
	[Notes] [nvarchar](250) NULL,
	[ActionBy] [bigint] NULL,
	[ActionDate] [datetime] NULL,
	[IsActive] [bit] NULL,
 CONSTRAINT [PK__Category__3214EC0789A8E033] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Customer]    Script Date: 30-04-2025 06:41:13 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Customer](
	[Id] [bigint] IDENTITY(1,1) NOT NULL,
	[UId] [uniqueidentifier] NULL,
	[TypeId] [bigint] NULL,
	[Name] [nvarchar](100) NULL,
	[GST] [nvarchar](50) NULL,
	[Landline] [nvarchar](20) NULL,
	[Email] [nvarchar](50) NULL,
	[Contact] [nvarchar](50) NULL,
	[Mobile] [nvarchar](20) NULL,
	[Address] [nvarchar](500) NULL,
	[ActionBy] [bigint] NULL,
	[ActionDate] [datetime] NULL,
	[IsActive] [bit] NULL,
 CONSTRAINT [PK_Customers] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Device]    Script Date: 30-04-2025 06:41:13 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Device](
	[Id] [bigint] IDENTITY(1,1) NOT NULL,
	[UId] [uniqueidentifier] NOT NULL,
	[MachineTypeId] [bigint] NOT NULL,
	[Name] [nvarchar](100) NOT NULL,
	[SerialNumber] [nvarchar](50) NOT NULL,
	[ModelNumber] [nvarchar](50) NOT NULL,
	[Manufacturer] [nvarchar](100) NOT NULL,
	[Size] [nvarchar](100) NULL,
	[Capacity] [nvarchar](50) NULL,
	[PurchaseDate] [datetime] NULL,
	[CurrentCount] [bigint] NULL,
	[MaximumCount] [bigint] NULL,
	[Notes] [nvarchar](500) NULL,
	[ActionBy] [bigint] NOT NULL,
	[ActionDate] [datetime] NOT NULL,
	[IsActive] [bit] NOT NULL,
 CONSTRAINT [PK_Machine] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[DeviceMaintenance]    Script Date: 30-04-2025 06:41:13 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[DeviceMaintenance](
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
 CONSTRAINT [PK_MachineMaintenance] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[DeviceType]    Script Date: 30-04-2025 06:41:13 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[DeviceType](
	[Id] [bigint] NOT NULL,
	[Name] [nvarchar](100) NOT NULL,
	[Notes] [nvarchar](250) NULL,
	[ActionBy] [bigint] NULL,
	[ActionDate] [datetime] NULL,
	[IsActive] [bit] NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[HSNCode]    Script Date: 30-04-2025 06:41:13 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[HSNCode](
	[Id] [bigint] IDENTITY(1,1) NOT NULL,
	[CategoryId] [bigint] NULL,
	[Name] [nvarchar](20) NULL,
	[Notes] [nvarchar](100) NULL,
	[GST] [bigint] NULL,
	[SGST] [bigint] NULL,
	[CGST] [bigint] NULL,
	[ActionBy] [bigint] NULL,
	[ActionDate] [datetime] NULL,
	[IsActive] [bit] NOT NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Product]    Script Date: 30-04-2025 06:41:13 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Product](
	[Id] [bigint] IDENTITY(1,1) NOT NULL,
	[UId] [uniqueidentifier] NULL,
	[CategoryId] [bigint] NULL,
	[MachineId] [bigint] NULL,
	[Name] [nvarchar](100) NULL,
	[Size] [nvarchar](20) NULL,
	[Rate] [decimal](18, 2) NULL,
	[HSNCodeId] [bigint] NULL,
	[ActionBy] [bigint] NULL,
	[ActionDate] [datetime] NULL,
	[IsActive] [bit] NOT NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[PurchaseOrder]    Script Date: 30-04-2025 06:41:13 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PurchaseOrder](
	[Id] [bigint] NOT NULL,
	[SKUId] [nvarchar](50) NULL,
	[Name] [nvarchar](300) NULL,
	[TypeId] [bigint] NULL,
	[CaegoryId] [bigint] NULL,
	[Unit] [nvarchar](30) NULL,
	[Description] [nvarchar](max) NULL,
	[SupplierId] [bigint] NULL,
	[CostPrice] [decimal](18, 2) NULL,
	[SalePrice] [decimal](18, 2) NULL,
	[Stock] [bigint] NULL,
	[HSNId] [nvarchar](30) NULL,
	[ActionBy] [bigint] NOT NULL,
	[ActionDate] [datetime] NOT NULL,
	[IsActive] [bit] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Role]    Script Date: 30-04-2025 06:41:13 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Role](
	[Id] [bigint] IDENTITY(1,1) NOT NULL,
	[UId] [uniqueidentifier] NOT NULL,
	[Name] [nvarchar](100) NOT NULL,
	[Control] [nvarchar](50) NULL,
	[Notes] [nvarchar](500) NULL,
	[ActionBy] [bigint] NOT NULL,
	[ActionDate] [datetime] NOT NULL,
	[IsActive] [bit] NOT NULL,
 CONSTRAINT [PK__Role__C5B19662F68869C6] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Supplier]    Script Date: 30-04-2025 06:41:13 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Supplier](
	[Id] [bigint] IDENTITY(1,1) NOT NULL,
	[UId] [uniqueidentifier] NULL,
	[TypeId] [bigint] NULL,
	[Name] [nvarchar](100) NULL,
	[GST] [nvarchar](50) NULL,
	[Landline] [nvarchar](20) NULL,
	[Email] [nvarchar](50) NULL,
	[Contact] [nvarchar](50) NULL,
	[Mobile] [nvarchar](20) NULL,
	[Address] [nvarchar](500) NULL,
	[ActionBy] [bigint] NULL,
	[ActionDate] [datetime] NULL,
	[IsActive] [bit] NOT NULL,
 CONSTRAINT [PK__Supplier__3214EC07FD28B525] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Type]    Script Date: 30-04-2025 06:41:13 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Type](
	[Id] [bigint] NOT NULL,
	[Name] [nvarchar](50) NULL,
	[Notes] [nvarchar](250) NULL,
	[IsActive] [bit] NULL,
 CONSTRAINT [PK_CustomerType] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[User]    Script Date: 30-04-2025 06:41:13 ******/
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
	[RoleId] [bigint] NOT NULL,
	[IsLogin] [bit] NOT NULL,
	[ActionBy] [bigint] NOT NULL,
	[ActionDate] [datetime] NOT NULL,
	[IsActive] [bit] NOT NULL,
 CONSTRAINT [PK__User__C5B196629F284FAD] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[PurchaseOrder]  WITH CHECK ADD  CONSTRAINT [FK__Product__Caegory__540C7B00] FOREIGN KEY([CaegoryId])
REFERENCES [dbo].[Category] ([Id])
GO
ALTER TABLE [dbo].[PurchaseOrder] CHECK CONSTRAINT [FK__Product__Caegory__540C7B00]
GO
ALTER TABLE [dbo].[PurchaseOrder]  WITH CHECK ADD  CONSTRAINT [FK__Product__Supplie__55009F39] FOREIGN KEY([SupplierId])
REFERENCES [dbo].[Supplier] ([Id])
GO
ALTER TABLE [dbo].[PurchaseOrder] CHECK CONSTRAINT [FK__Product__Supplie__55009F39]
GO
ALTER TABLE [dbo].[PurchaseOrder]  WITH CHECK ADD FOREIGN KEY([TypeId])
REFERENCES [dbo].[Type] ([Id])
GO
ALTER TABLE [dbo].[User]  WITH CHECK ADD  CONSTRAINT [FK_User_Role] FOREIGN KEY([RoleId])
REFERENCES [dbo].[Role] ([Id])
GO
ALTER TABLE [dbo].[User] CHECK CONSTRAINT [FK_User_Role]
GO
