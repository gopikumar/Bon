USE [Bon]
GO
/****** Object:  Table [dbo].[Building]    Script Date: 27-04-2025 10:09:13 ******/
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
/****** Object:  Table [dbo].[Customers]    Script Date: 27-04-2025 10:09:13 ******/
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
	[IsActive] [bit] NULL,
 CONSTRAINT [PK_Customers] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[CustomerType]    Script Date: 27-04-2025 10:09:13 ******/
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
/****** Object:  Table [dbo].[Invoices]    Script Date: 27-04-2025 10:09:13 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Invoices](
	[Id] [bigint] IDENTITY(1,1) NOT NULL,
	[JobOrderId] [bigint] NULL,
	[InvoiceDate] [datetime] NULL,
	[SubTotal] [decimal](18, 2) NULL,
	[TaxAmount] [decimal](18, 2) NULL,
	[DiscountAmount] [decimal](18, 2) NULL,
	[TotalAmount] [decimal](18, 2) NULL,
	[PaymentStatus] [nvarchar](20) NULL,
	[DueDate] [datetime] NULL,
	[ActionBy] [bigint] NULL,
PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[JobOrders]    Script Date: 27-04-2025 10:09:13 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[JobOrders](
	[Id] [bigint] IDENTITY(1,1) NOT NULL,
	[UId] [uniqueidentifier] NOT NULL,
	[CustomerId] [bigint] NULL,
	[QuotationId] [bigint] NULL,
	[JobTitle] [nvarchar](100) NULL,
	[PaperType] [nvarchar](50) NULL,
	[Color] [nvarchar](20) NULL,
	[Binding] [nvarchar](50) NULL,
	[Quantity] [int] NULL,
	[Status] [nvarchar](20) NULL,
	[DeliveryDate] [datetime] NULL,
	[AssignedTo] [nvarchar](100) NULL,
	[Notes] [nvarchar](max) NULL,
	[ActionBy] [bigint] NULL,
	[ActionDate] [datetime] NULL,
	[IsActive] [bit] NULL,
PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Machine]    Script Date: 27-04-2025 10:09:13 ******/
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
/****** Object:  Table [dbo].[MachineMaintenance]    Script Date: 27-04-2025 10:09:13 ******/
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
/****** Object:  Table [dbo].[Payments]    Script Date: 27-04-2025 10:09:13 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Payments](
	[Id] [bigint] IDENTITY(1,1) NOT NULL,
	[InvoiceId] [bigint] NULL,
	[PaymentDate] [datetime] NULL,
	[Amount] [decimal](18, 2) NULL,
	[Mode] [nvarchar](50) NULL,
	[ReferenceNumber] [nvarchar](100) NULL,
	[Notes] [nvarchar](max) NULL,
PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[QuotationItems]    Script Date: 27-04-2025 10:09:13 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[QuotationItems](
	[Id] [bigint] IDENTITY(1,1) NOT NULL,
	[UId] [uniqueidentifier] NOT NULL,
	[QuotationId] [bigint] NULL,
	[JobType] [nvarchar](100) NULL,
	[Size] [nvarchar](50) NULL,
	[Quantity] [int] NULL,
	[UnitPrice] [decimal](18, 2) NULL,
	[Description] [nvarchar](max) NULL,
	[ActionBy] [bigint] NULL,
	[ActionDate] [datetime] NULL,
	[IsActive] [bit] NULL,
PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Quotations]    Script Date: 27-04-2025 10:09:13 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Quotations](
	[Id] [bigint] IDENTITY(1,1) NOT NULL,
	[UId] [uniqueidentifier] NOT NULL,
	[CustomerId] [bigint] NULL,
	[QuoteDate] [datetime] NULL,
	[TotalAmount] [decimal](18, 2) NULL,
	[Discount] [decimal](18, 2) NULL,
	[Tax] [decimal](18, 2) NULL,
	[Status] [nvarchar](20) NULL,
	[Remarks] [nvarchar](max) NULL,
	[ActionBy] [bigint] NULL,
	[ActionDate] [datetime] NULL,
	[IsActive] [bit] NULL,
PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Role]    Script Date: 27-04-2025 10:09:13 ******/
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
/****** Object:  Table [dbo].[User]    Script Date: 27-04-2025 10:09:13 ******/
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
ALTER TABLE [dbo].[Invoices]  WITH CHECK ADD FOREIGN KEY([JobOrderId])
REFERENCES [dbo].[JobOrders] ([Id])
GO
ALTER TABLE [dbo].[JobOrders]  WITH CHECK ADD FOREIGN KEY([CustomerId])
REFERENCES [dbo].[Customers] ([Id])
GO
ALTER TABLE [dbo].[Payments]  WITH CHECK ADD FOREIGN KEY([InvoiceId])
REFERENCES [dbo].[Invoices] ([Id])
GO
ALTER TABLE [dbo].[QuotationItems]  WITH CHECK ADD FOREIGN KEY([QuotationId])
REFERENCES [dbo].[Quotations] ([Id])
GO
ALTER TABLE [dbo].[Quotations]  WITH CHECK ADD FOREIGN KEY([CustomerId])
REFERENCES [dbo].[Customers] ([Id])
GO
ALTER TABLE [dbo].[User]  WITH CHECK ADD  CONSTRAINT [FK_User_Role] FOREIGN KEY([RoleId])
REFERENCES [dbo].[Role] ([Id])
GO
ALTER TABLE [dbo].[User] CHECK CONSTRAINT [FK_User_Role]
GO
/****** Object:  StoredProcedure [dbo].[JSONConversion]    Script Date: 27-04-2025 10:09:13 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE  PROCEDURE [dbo].[JSONConversion]
    @filterColumns NVARCHAR(MAX),
	@output  NVARCHAR(MAX) OUT
AS
BEGIN
		DECLARE @json NVARCHAR(MAX) = N'{';
		
		-- Split the string into key-value pairs
		DECLARE @pair NVARCHAR(MAX), @key NVARCHAR(MAX), @value NVARCHAR(MAX);
		DECLARE cur CURSOR FOR
		SELECT value
		FROM STRING_SPLIT(@filterColumns, ',');
		
		OPEN cur;
		FETCH NEXT FROM cur INTO @pair;
		
		WHILE @@FETCH_STATUS = 0
		BEGIN
		    SET @key = TRIM(SUBSTRING(@pair, 1, CHARINDEX('=', @pair) - 1));
		    SET @value = TRIM(SUBSTRING(@pair, CHARINDEX('=', @pair) + 1, LEN(@pair)));
		
		    -- Construct the JSON key-value pair (handle single quotes and spaces)
		    SET @json = @json + N'"' + @key + N'": "' + REPLACE(@value, '''', '') + '",';
		
		    FETCH NEXT FROM cur INTO @pair;
		END;
		
		CLOSE cur;
		DEALLOCATE cur;
		
		-- Remove the trailing comma and close the JSON object
		SET @json = LEFT(@json, LEN(@json) - 1) + N'}';
		
		select @output = @json;

END;

--Declare @query NVARCHAR(max)
--exec jsonconversion 'name = ''gopi'' ' , @output = @query OUT
--Select @query
GO
/****** Object:  StoredProcedure [dbo].[SendSimpleJSONData]    Script Date: 27-04-2025 10:09:13 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[SendSimpleJSONData]
    @JsonInput NVARCHAR(MAX)
AS
BEGIN
select @JsonInput
    -- Declare a variable to store the response
    DECLARE @response NVARCHAR(MAX);
    
    -- Initialize the response to an empty string
    SET @response = '';

    -- Use OPENJSON to extract the key-value pairs from the JSON input
    -- OPENJSON returns columns: [key] (key), [value] (value), [type] (value type)
    -- We will directly extract the key-value pairs without using the WITH clause

    -- Dynamically build the WHERE condition
    SELECT @response = 
        CASE 
            WHEN LEN(@response) > 0 THEN @response + ' AND '
            ELSE ''
        END + 
        --QUOTENAME([key]) + ' = ' + QUOTENAME([value], '''')
		CASE 
            WHEN [key] = 'name' THEN 'U.' + [key] + ' = ''' + [value] + ''''
            WHEN [key] = 'role' THEN 'R.' + [key] + ' = ''' + [value] + ''''
            ELSE [key] + ' = ''' + [value] + ''''
        END
		 --CASE 
   --         WHEN [key] = 'name' THEN QUOTENAME('U.' + [key]) + ' = ' + QUOTENAME([value], '''')
   --         WHEN [key] = 'role' THEN QUOTENAME('R.' + [key]) + ' = ' + QUOTENAME([value], '''')
   --         ELSE QUOTENAME([key]) + ' = ' + QUOTENAME([value], '''')
		 --END
    FROM OPENJSON(@JsonInput)  -- OPENJSON parses the input JSON string
    -- OPENJSON by default returns key-value pairs
    WHERE [value] IS NOT NULL;

    -- Final result - output the constructed response
    SELECT @response AS wherecondition;
END;

--EXEC [dbo].[SendSimpleJSONData] @JsonInput = '{"name": "gopi"}';
GO
/****** Object:  StoredProcedure [dbo].[sp_FilterColumns]    Script Date: 27-04-2025 10:09:13 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO



CREATE PROCEDURE [dbo].[sp_FilterColumns]
(
@filterColumns NVARCHAR(MAX),
@output  NVARCHAR(MAX) OUT
)
AS
BEGIN

	DECLARE @l_FilterColumns NVARCHAR(MAX);
	Declare @JsonInput NVARCHAR(MAX);
	DECLARE @Results TABLE (JsonOutput NVARCHAR(MAX));
	
	if(@filterColumns > '' )
	begin
		INSERT INTO @Results
		EXEC SendSimpleJSONData @JsonInput = @filterColumns;
		select @JsonInput
	end		
-- Now you can pull it from @Results into a variable if needed
   SELECT TOP 1 @JsonInput = JsonOutput FROM @Results;
   
   SET @l_FilterColumns = CASE
							WHEN @filterColumns > '' THEN ' where '+ @JsonInput
							ELSE ''
						  END;

	SET @output = @l_FilterColumns;
END

--declare @output2  NVARCHAR(MAX)
--exec sp_FilterColumns @filterColumns='name=''gopi'' ',@output=@output2 OUTPUT
--select @output2
GO
/****** Object:  StoredProcedure [dbo].[sp_GetFilterJoin]    Script Date: 27-04-2025 10:09:13 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[sp_GetFilterJoin]
(
@count NVARCHAR(100),
@query NVARCHAR(100),
@orderBy NVARCHAR(100),
@sortBy NVARCHAR(4),
@pageNumber INT,
@pageSize INT,
@filterColumns NVARCHAR(MAX) =''
)
AS
BEGIN

	DECLARE @l_Count NVARCHAR(MAX);
	DECLARE @l_Sql NVARCHAR(MAX);
	DECLARE @l_WHERE NVARCHAR(MAX)='';

	SET @l_Count = @count + @filterColumns;
	SET @l_Sql = @query +@filterColumns + ' ORDER BY ' + QUOTENAME(@orderBy) + ' ' + @sortBy + '  
					OFFSET (@pageNumber - 1) * @pageSize ROWS
					FETCH NEXT @pageSize ROWS ONLY';

	EXEC sp_executesql @l_Count;
	EXEC sp_executesql @l_Sql, N'@pageNumber INT, @pageSize INT', @pageNumber, @pageSize;
END


GO
/****** Object:  StoredProcedure [dbo].[sp_Login]    Script Date: 27-04-2025 10:09:13 ******/
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
/****** Object:  StoredProcedure [dbo].[sp_Quotations]    Script Date: 27-04-2025 10:09:13 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_Quotations]
(
@action nvarchar(50),
@UId  uniqueidentifier=null,
@CustomerId bigint,
@totalamount decimal(18,2),
@discount decimal(18,2),
@tax decimal(18,2),
@status nvarchar(20),
@remarks nvarchar(max),
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
					INSERT INTO [Quotations]
						VALUES (@l_GUID,@CustomerId,GETUTCDATE(),@totalamount,@discount,@tax,@status,@remarks,@actionby,GETUTCDATE(),@isactive)
				END
			IF(@action='Update')
	    		BEGIN
					SET @l_GUID=@UId;
					UPDATE [Quotations] set	
					  CustomerId = @CustomerId,
					  TotalAmount=@totalamount,
					  Discount=@discount,
					  Tax=@tax,
					  Status=@status,
					  Remarks=@remarks,
					  Actionby=@actionby,
					  ActionDate=GETUTCDATE(),
					  Isactive=@isactive
					  where UId = @UId;					  
				END
  
		IF @@TRANCOUNT > 0
		BEGIN 
			COMMIT TRANSACTION;
			
			select * from [Quotations] where UId=@l_GUID
		END
	END TRY 
	BEGIN CATCH
		BEGIN 
			ROLLBACK TRANSACTION;
		END  
	END CATCH
END	

--EXEC sp_Quotations 'Add',null,2,1000,11,5,'draft','testing',1,1
GO
/****** Object:  StoredProcedure [dbo].[sp_Role]    Script Date: 27-04-2025 10:09:13 ******/
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
/****** Object:  StoredProcedure [dbo].[sp_RoleById]    Script Date: 27-04-2025 10:09:13 ******/
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
/****** Object:  StoredProcedure [dbo].[sp_RoleGet]    Script Date: 27-04-2025 10:09:13 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_RoleGet]
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
		SELECT count(*) as count from [Role];
		SET @l_SQL = N'select * from [Role] ORDER BY ' + QUOTENAME(@orderBy) + ' ' + @sortBy;
		EXEC sp_executesql @l_SQL
	END
	
	IF(@action='Filter')
	BEGIN		
		DECLARE @l_Count NVARCHAR(MAX);
		SET @l_COUNT = N'select count(*) from [Role]';
		SET @l_SQL = N'select * from [Role]';
		EXEC sp_GetFilterJoin @l_COUNT,@l_SQL, @orderBy, @sortBy, @pageNumber, @pageSize,@filterColumns;
	END
END	

--EXEC sp_RoleGet 'Filter', 'id', 'ASC';
GO
/****** Object:  StoredProcedure [dbo].[sp_TestFilter]    Script Date: 27-04-2025 10:09:13 ******/
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
	
	if(@filterColumns > '' )
	begin
		INSERT INTO @Results
		EXEC SendSimpleJsonData @JsonInput = @filterColumns;
	end
		
-- Now you can pull it from @Results into a variable if needed
   SELECT TOP 1 @JsonData = JsonOutput FROM @Results;
   
   SET @l_FilterColumns = CASE
							WHEN @filterColumns > '' THEN ' where '+ @JsonData
							ELSE ''
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
/****** Object:  StoredProcedure [dbo].[sp_User]    Script Date: 27-04-2025 10:09:13 ******/
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
/****** Object:  StoredProcedure [dbo].[sp_UserById]    Script Date: 27-04-2025 10:09:13 ******/
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
/****** Object:  StoredProcedure [dbo].[sp_UserGet]    Script Date: 27-04-2025 10:09:13 ******/
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
		DECLARE @l_COUNT NVARCHAR(MAX);
		DECLARE @l_Json NVARCHAR(MAX);
	    DECLARE @response NVARCHAR(MAX)='';

		if(@filterColumns > '' )
		begin
			EXEC JSONConversion @filterColumns,@l_Json OUTPUT;

		SELECT @response=
		CASE 
            WHEN LEN(@response) > 0 THEN @response + ' AND '
            ELSE ''
        END + 
		CASE 
            WHEN [key] = 'id' THEN 'U.' + [key] + ' = ''' + [value] + ''''
            WHEN [key] = 'name' THEN 'U.' + [key] + ' = ''' + [value] + ''''
            WHEN [key] = 'role' THEN 'R.' + [key] + ' = ''' + [value] + ''''
            ELSE [key] + ' = ''' + [value] + ''''
        END
        FROM OPENJSON(@l_Json)
		set @response=' where '+@response
		end
	
		SET @l_COUNT =N'select count(*) as count from [User] U join [Role] R on U.RoleId=R.Id';
		SET @l_SQL = N'select u.*,r.Name as RoleName from [User] U join [Role] R on U.RoleId=R.Id';
		EXEC sp_GetFilterJoin @l_COUNT, @l_SQL, @orderBy, @sortBy, @pageNumber, @pageSize, @response;
	END
END	

--exec sp_UserGet @action=N'Filter',@orderBy=N'id',@sortBy=N'asc',@pageNumber=1,@pageSize=10,@filterColumns='name=''gopi'' '
--exec sp_UserGet @action=N'Filter',@orderBy=N'id',@sortBy=N'asc',@pageNumber=1,@pageSize=10,@filterColumns=''
--exec sp_UserGet @action=N'Filter',@orderBy=N'id',@sortBy=N'asc',@pageNumber=1,@pageSize=10,@filterColumns=null


GO
