USE [Bon]
GO
/****** Object:  StoredProcedure [dbo].[sp_Login]    Script Date: 27-04-2025 10:11:46 ******/
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
/****** Object:  StoredProcedure [dbo].[sp_Quotations]    Script Date: 27-04-2025 10:11:46 ******/
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
/****** Object:  StoredProcedure [dbo].[sp_Role]    Script Date: 27-04-2025 10:11:46 ******/
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
/****** Object:  StoredProcedure [dbo].[sp_RoleById]    Script Date: 27-04-2025 10:11:46 ******/
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
/****** Object:  StoredProcedure [dbo].[sp_RoleGet]    Script Date: 27-04-2025 10:11:46 ******/
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
/****** Object:  StoredProcedure [dbo].[sp_TestFilter]    Script Date: 27-04-2025 10:11:46 ******/
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
/****** Object:  StoredProcedure [dbo].[sp_User]    Script Date: 27-04-2025 10:11:46 ******/
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
/****** Object:  StoredProcedure [dbo].[sp_UserById]    Script Date: 27-04-2025 10:11:46 ******/
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
/****** Object:  StoredProcedure [dbo].[sp_UserGet]    Script Date: 27-04-2025 10:11:46 ******/
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
