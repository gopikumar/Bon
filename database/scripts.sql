USE [Bon]
GO
/****** Object:  Table [dbo].[Building]    Script Date: 25-04-2025 12:27:01 ******/
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
 CONSTRAINT [PK_Building] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Customers]    Script Date: 25-04-2025 12:27:01 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Customers](
	[Id] [bigint] IDENTITY(1,1) NOT NULL,
	[UId] [uniqueidentifier] NULL,
	[CustomerTypeId] [bigint] NULL,
	[Name] [nvarchar](100) NULL,
	[GSTNumber] [nvarchar](50) NULL,
	[Landline] [nvarchar](20) NULL,
	[Mobile] [nvarchar](20) NULL,
	[Email] [nvarchar](50) NULL,
	[ActionBy] [bigint] NULL,
	[ActionDate] [datetime] NULL,
	[IsActive] [bit] NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[CustomerType]    Script Date: 25-04-2025 12:27:01 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[CustomerType](
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
/****** Object:  Table [dbo].[Machine]    Script Date: 25-04-2025 12:27:01 ******/
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
 CONSTRAINT [PK_Machine] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[MachineMaintenance]    Script Date: 25-04-2025 12:27:01 ******/
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
 CONSTRAINT [PK_MachineMaintenance] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Role]    Script Date: 25-04-2025 12:27:01 ******/
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
/****** Object:  Table [dbo].[User]    Script Date: 25-04-2025 12:27:01 ******/
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
	[ActionBy] [bigint] NOT NULL,
	[ActionDate] [datetime] NOT NULL,
	[IsActive] [bit] NOT NULL,
 CONSTRAINT [PK__User__C5B196629F284FAD] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[Customers]  WITH CHECK ADD  CONSTRAINT [FK_Customers_CustomerType] FOREIGN KEY([CustomerTypeId])
REFERENCES [dbo].[CustomerType] ([Id])
GO
ALTER TABLE [dbo].[Customers] CHECK CONSTRAINT [FK_Customers_CustomerType]
GO
ALTER TABLE [dbo].[User]  WITH CHECK ADD  CONSTRAINT [FK_User_Role] FOREIGN KEY([RoleId])
REFERENCES [dbo].[Role] ([Id])
GO
ALTER TABLE [dbo].[User] CHECK CONSTRAINT [FK_User_Role]
GO
/****** Object:  StoredProcedure [dbo].[NestedJsonData]    Script Date: 25-04-2025 12:27:01 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE   PROCEDURE [dbo].[NestedJsonData]
    @JsonInput NVARCHAR(MAX)
AS
BEGIN
    -- Extract values from the nested JSON input
    DECLARE @ID INT, @Name NVARCHAR(100);

    -- Extract values from the nested "Lender" object
    SET @ID = JSON_VALUE(@JsonInput, '$.ID.@ID');
    SET @Name = JSON_VALUE(@JsonInput, '$.Name.Name');

    -- Extract values from the nested "Location" object
   -- SET @ProvinceId = JSON_VALUE(@JsonInput, '$.Location.ProvinceId');
   -- SET @City = JSON_VALUE(@JsonInput, '$.Location.City');

    -- Use the extracted values
    SELECT @ID AS  ID, @Name AS Name;
END;
GO
/****** Object:  StoredProcedure [dbo].[SendSimpleJSONData]    Script Date: 25-04-2025 12:27:01 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE   PROCEDURE [dbo].[SendSimpleJSONData]
    @JsonInput NVARCHAR(MAX)
AS
BEGIN
    -- Extract values from the JSON input
    DECLARE @response NVARCHAR(max);

    SET @response = N' id=' + ISNULL(JSON_VALUE(@JsonInput, '$.Id'), 'NULL');;
    SET @response =@response + N' and name=' +ISNULL(QUOTENAME(JSON_VALUE(@JsonInput, '$.Name'), ''''), 'NULL');

    -- Use the extracted values for further processing
    SELECT @response as wherecondition;
END;
GO
/****** Object:  StoredProcedure [dbo].[sp_GetFilter]    Script Date: 25-04-2025 12:27:01 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[sp_GetFilter]
(
@tableName NVARCHAR(100),
@orderBy NVARCHAR(100),
@sortBy NVARCHAR(4),
@pageNumber INT,
@pageSize INT,
@filterColumns NVARCHAR(MAX)
)
AS
BEGIN

	DECLARE @l_Count NVARCHAR(MAX);
	DECLARE @l_Sql NVARCHAR(MAX);
	DECLARE @l_FilterColumns NVARCHAR(MAX);

	SET @l_FilterColumns = CASE
							WHEN @filterColumns is null THEN ''
							ELSE ' where '+ @filterColumns
						  END;
						  
	SET @l_Count = N'SELECT COUNT(*) FROM '+@tableName + @l_FilterColumns;

	SET @l_Sql = N'SELECT * FROM '+@tableName + @l_FilterColumns + ' ORDER BY ' + QUOTENAME(@orderBy) + ' ' + @sortBy + '  
					OFFSET (@pageNumber - 1) * @pageSize ROWS
					FETCH NEXT @pageSize ROWS ONLY';

	EXEC sp_executesql @l_Count, N'@pageNumber INT, @pageSize INT', @pageNumber, @pageSize;
	EXEC sp_executesql @l_Sql, N'@pageNumber INT, @pageSize INT', @pageNumber, @pageSize;
END

--EXEC sp_GetFilter '[User]', 'id', 'ASC', 1, 10, null;
GO
/****** Object:  StoredProcedure [dbo].[sp_GetFilterJoin]    Script Date: 25-04-2025 12:27:01 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[sp_GetFilterJoin]
(
@query NVARCHAR(100),
@orderBy NVARCHAR(100),
@sortBy NVARCHAR(4),
@pageNumber INT,
@pageSize INT
)
AS
BEGIN

	DECLARE @l_Count NVARCHAR(MAX);
	DECLARE @l_Sql NVARCHAR(MAX);

	SET @l_Count = @query;
	SET @l_Sql = @query + ' ORDER BY ' + QUOTENAME(@orderBy) + ' ' + @sortBy + '  
					OFFSET (@pageNumber - 1) * @pageSize ROWS
					FETCH NEXT @pageSize ROWS ONLY';

	EXEC sp_executesql @l_Count, N'@pageNumber INT, @pageSize INT', @pageNumber, @pageSize;
	EXEC sp_executesql @l_Sql, N'@pageNumber INT, @pageSize INT', @pageNumber, @pageSize;
END

--EXEC sp_GetFilterJoin 'select *from [User]', 'id', 'ASC', 1, 10;
GO
/****** Object:  StoredProcedure [dbo].[sp_Login]    Script Date: 25-04-2025 12:27:01 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_Login]
(
@action nvarchar(50),
@username nvarchar(50),
@password nvarchar(50),
@newpassword nvarchar(50)=null
)
AS
BEGIN
		IF(@action='employee')
		BEGIN
			select u.*,r.Name as RoleName from [User] U join [Role] R on U.RoleId=R.Id where (u.Email=@username or u.Mobile=@username) and u.Password=@password
		END	
		IF(@action='updatepassword')
		BEGIN
		DECLARE @l_id bigint
			select @l_id= id from [User] where (Email=@username or Mobile=@username) and Password=@password
			update [User] set Password=@newpassword where (Email=@username or Mobile=@username) and Password=@password
			select u.*,r.Name as RoleName from [User] U join [Role] R on U.RoleId=R.Id where u.id=@l_id
		END		
END

--exec [sp_Login] 'employee','gopi@gmail.com','987654'

--select *from [User] where [Email]='gopi@gmail.com' and [Password]='987654'
GO
/****** Object:  StoredProcedure [dbo].[sp_Role]    Script Date: 25-04-2025 12:27:01 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create PROCEDURE [dbo].[sp_Role]
(
@action nvarchar(50),
@UId  uniqueidentifier=null,
@name nvarchar(100),
@control nvarchar(100),
@notes nvarchar(30)=null,
@actionby bigint,
@isactive bit
)
AS
BEGIN	
	 BEGIN TRY 
		Declare @l_GUID nvarchar(100)
	    BEGIN TRANSACTION
			IF(@action='Add')
				BEGIN
					SET @l_GUID=NEWID();
					INSERT INTO [Role]
						VALUES (@l_GUID,@name,@control,@notes,@actionby,GETUTCDATE(),@isactive)
				END
			IF(@action='Update')
	    		BEGIN
					SET @l_GUID=@UId;
					UPDATE [Role] set	
					  Name = @name,
					  control=@control,
					  notes=@notes,
					  Actionby=@actionby,
					  ActionDate=GETUTCDATE(),
					  Isactive=@isactive
					  where UId = @UId;					  
				END
  
		IF @@TRANCOUNT > 0
		BEGIN 
			COMMIT TRANSACTION;
			select * from [Role] where UId=@l_GUID
		END
	END TRY 
	BEGIN CATCH
		BEGIN 
			ROLLBACK TRANSACTION;
		END  
	END CATCH
END	

--EXEC sp_User 'Add',null,'gopi',null,'123456','gopi@gmail.com','9876543211',1,1,1
GO
/****** Object:  StoredProcedure [dbo].[sp_RoleById]    Script Date: 25-04-2025 12:27:01 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create PROCEDURE [dbo].[sp_RoleById]
(
@action nvarchar(50),
@uid uniqueidentifier,
@isActive bit =null
)
AS
BEGIN
		IF(@action='Get')
		BEGIN
			select * from [Role] where UId=@uid
		END
		
		IF(@action='Delete')
		BEGIN
			Delete from [Role] where UId=@uid
		END
		
		IF(@action='IsActive')
		BEGIN
			Update [Role] set isActive=@isActive  where UId=@uid
			SELECT *from [Role] where UId=@uid
		END
END
GO
/****** Object:  StoredProcedure [dbo].[sp_RoleGet]    Script Date: 25-04-2025 12:27:01 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create PROCEDURE [dbo].[sp_RoleGet]
(
@action NVARCHAR(50),
@orderBy NVARCHAR(100),
@sortBy NVARCHAR(4),
@pageNumber INT=1,
@pageSize INT=10,
@filterColumns NVARCHAR(MAX) =''
)
AS
BEGIN
	DECLARE @l_SQL NVARCHAR(MAX);
	IF(@action='All')
	BEGIN 
		SELECT count(*) as count from [User];
		SET @l_SQL = N'select * from [Role] ORDER BY ' + QUOTENAME(@orderBy) + ' ' + @sortBy;
		EXEC sp_executesql @l_SQL
	END
	
	IF(@action='Filter')
	BEGIN		
		SET @l_SQL = N'select * from [Role]';
		EXEC sp_GetFilterJoin @l_SQL, @orderBy, @sortBy, @pageNumber, @pageSize;
	END
END	

--EXEC sp_UserGet 'Filter', 'id', 'ASC';
GO
/****** Object:  StoredProcedure [dbo].[sp_TestFilter]    Script Date: 25-04-2025 12:27:01 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[sp_TestFilter]
(
@tableName NVARCHAR(100),
@orderBy NVARCHAR(100),
@sortBy NVARCHAR(4),
@pageNumber INT,
@pageSize INT,
@filterColumns NVARCHAR(MAX)
)
AS
BEGIN

	DECLARE @l_Count NVARCHAR(MAX);
	DECLARE @l_Sql NVARCHAR(MAX);
	DECLARE @l_FilterColumns NVARCHAR(MAX);
	Declare @JsonData NVARCHAR(MAX);
	DECLARE @Results TABLE (JsonOutput NVARCHAR(MAX));
	
	if(@filterColumns is not null)
	begin
		INSERT INTO @Results
		EXEC SendSimpleJsonData @JsonInput = @filterColumns;
	end
		
-- Now you can pull it from @Results into a variable if needed
   SELECT TOP 1 @JsonData = JsonOutput FROM @Results;
   
   SET @l_FilterColumns = CASE
							WHEN @filterColumns is null THEN ''
							ELSE ' where '+ @JsonData
						  END;
	
	SET @l_Count = N'SELECT COUNT(*) as count FROM '+@tableName + @l_FilterColumns;

	SET @l_Sql = N'SELECT * FROM '+@tableName + @l_FilterColumns + 
				' ORDER BY ' + QUOTENAME(@orderBy) + ' ' + @sortBy + '  
				OFFSET (@pageNumber - 1) * @pageSize ROWS
				FETCH NEXT @pageSize ROWS ONLY';

    EXEC sp_executesql @l_Count;
	EXEC sp_executesql @l_Sql, N'@pageNumber INT, @pageSize INT', @pageNumber, @pageSize;
	
END

/*EXEC sp_TestFilter '[User]', 'id', 'ASC', 1, 10,N'{
		"Id": 2,
		"Name":"Gopi"
		}'*/
		
/*EXEC sp_TestFilter '[User]', 'id', 'ASC', 1, 10,N'{}'*/
			
/*EXEC sp_TestFilter '[User]', 'id', 'ASC', 1, 10, null */
GO
/****** Object:  StoredProcedure [dbo].[sp_User]    Script Date: 25-04-2025 12:27:01 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_User]
(
@action nvarchar(50),
@UId  uniqueidentifier=null,
@name nvarchar(100),
@lastname nvarchar(100),
@password nvarchar(30)=null,
@email nvarchar(50),
@mobile nvarchar(20),
@roleid bigint,
@actionby bigint,
@isactive bit
)
AS
BEGIN	
	 BEGIN TRY 
		Declare @l_GUID nvarchar(100)
	    BEGIN TRANSACTION
			IF(@action='Add')
				BEGIN
					SET @l_GUID=NEWID();
					INSERT INTO [User]
						VALUES (@l_GUID,@name,@lastname,@password,@email,@mobile,@roleid,@actionby,GETUTCDATE(),@isactive)
				END
			IF(@action='Update')
	    		BEGIN
					SET @l_GUID=@UId;
					UPDATE [User] set	
					  Name = @name,
					  Lastname=@lastname,
					  Email=@email,
					  Mobile=@mobile,
					  Actionby=@actionby,
					  ActionDate=GETUTCDATE(),
					  Isactive=@isactive
					  where UId = @UId;					  
				END
  
		IF @@TRANCOUNT > 0
		BEGIN 
			COMMIT TRANSACTION;
			select u.*,r.Name as RoleName from [User] U join [Role] R on U.RoleId=R.Id where u.UId=@l_GUID
		END
	END TRY 
	BEGIN CATCH
		BEGIN 
			ROLLBACK TRANSACTION;
		END  
	END CATCH
END	

--EXEC sp_User 'Add',null,'gopi',null,'123456','gopi@gmail.com','9876543211',1,1,1
GO
/****** Object:  StoredProcedure [dbo].[sp_UserById]    Script Date: 25-04-2025 12:27:01 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_UserById]
(
@action nvarchar(50),
@uid uniqueidentifier,
@isActive bit =null
)
AS
BEGIN
		IF(@action='Get')
		BEGIN
			select u.*,r.Name as RoleName from [User] U join [Role] R on U.RoleId=R.Id where u.UId=@uid
		END
		
		IF(@action='Delete')
		BEGIN
			Delete from [User] where UId=@uid
		END
		
		IF(@action='IsActive')
		BEGIN
			Update [User] set isActive=@isActive  where UId=@uid
			select u.*,r.Name as RoleName from [User] U join [Role] R on U.RoleId=R.Id where u.UId=@uid
		END
END
GO
/****** Object:  StoredProcedure [dbo].[sp_UserGet]    Script Date: 25-04-2025 12:27:01 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_UserGet]
(
@action NVARCHAR(50),
@orderBy NVARCHAR(100),
@sortBy NVARCHAR(4),
@pageNumber INT=1,
@pageSize INT=10,
@filterColumns NVARCHAR(MAX) =''
)
AS
BEGIN
	DECLARE @l_SQL NVARCHAR(MAX);
	IF(@action='All')
	BEGIN 
		SELECT count(*) as count from [User];
		SET @l_SQL = N'select u.*,r.Name as RoleName from [User] U join [Role] R on U.RoleId=R.Id ORDER BY ' + QUOTENAME(@orderBy) + ' ' + @sortBy;
		EXEC sp_executesql @l_SQL
	END
	
	IF(@action='Filter')
	BEGIN		
		SET @l_SQL = N'select u.*,r.Name as RoleName from [User] U join [Role] R on U.RoleId=R.Id';
		EXEC sp_GetFilterJoin @l_SQL, @orderBy, @sortBy, @pageNumber, @pageSize;
	END
END	

--EXEC sp_UserGet 'Filter', 'id', 'ASC';
GO
