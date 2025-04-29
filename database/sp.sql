USE [Bon]
GO
/****** Object:  StoredProcedure [dbo].[sp_Customer]    Script Date: 30-04-2025 05:11:49 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_Customer]
(
@action nvarchar(50),
@UId  uniqueidentifier=null,
@referenceid bigint,
@typeid bigint,
@name nvarchar(100),
@gst nvarchar(50),
@landline nvarchar(20),
@email nvarchar(50),
@address nvarchar(500),
@contact nvarchar(50),
@mobile nvarchar(20),
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
					INSERT INTO [Customer]
						VALUES (@l_GUID,@referenceid,@typeid,@name,@gst,@landline,@contact,@mobile,@email,@address,@actionby,GETUTCDATE(),@isactive)
				END
			IF(@action='Update')
	    		BEGIN
					SET @l_GUID=@UId;
					UPDATE [Customer] set
					  ReferenceId=@referenceid,
					  TypeId=@typeid,
					  Name = @name,
					  GST=@gst,
					  Landline=@landline,
					  Email=@email,
					  Contact=@contact,
					  Mobile=@mobile,
					  Actionby=@actionby,
					  ActionDate=GETUTCDATE(),
					  Isactive=@isactive
					  where UId = @UId;					  
				END
  
		IF @@TRANCOUNT > 0
		BEGIN 
			COMMIT TRANSACTION;
			select * from [Customer] where UId=@l_GUID
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
/****** Object:  StoredProcedure [dbo].[sp_CustomerById]    Script Date: 30-04-2025 05:11:49 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_CustomerById]
(
@action nvarchar(50),
@uid uniqueidentifier,
@isActive bit =null
)
AS
BEGIN
		IF(@action='Get')
		BEGIN
			select C.*,T.Name as TypeName from [Customer] C join [Type] T on T.Id=C.TypeId where C.UId=@uid
		END
		
		IF(@action='Delete')
		BEGIN
			Delete from [Customer] where UId=@uid
		END
		
		IF(@action='IsActive')
		BEGIN
			Update [Customer] set isActive=@isActive  where UId=@uid
			select C.*,T.Name as TypeName from [Customer] C join [Type] T on T.Id=C.TypeId where C.UId=@uid
		END
END
GO
/****** Object:  StoredProcedure [dbo].[sp_CustomerGet]    Script Date: 30-04-2025 05:11:49 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_CustomerGet]
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
		SELECT count(*) as count from [Customer];
		SET @l_SQL = N'select C.*,T.Name as TypeName from [Customer] C join [Type] T on T.Id=C.TypeId ORDER BY ' + QUOTENAME(@orderBy) + ' ' + @sortBy;
		EXEC sp_executesql @l_SQL
	END
	
	IF(@action='Filter')
	BEGIN
		DECLARE @l_COUNT NVARCHAR(MAX);
		DECLARE @l_Json NVARCHAR(MAX);
	    DECLARE @response NVARCHAR(MAX)='';

		if(@filterColumns > '' )
		begin
			EXEC sp_GetFilterJsonConversion @filterColumns,@l_Json OUTPUT;

		SELECT @response=
		CASE 
            WHEN LEN(@response) > 0 THEN @response + ' AND '
            ELSE ''
        END + 
		CASE 
            WHEN [key] = 'name' THEN 'C.' + [key] + ' = ''' + [value] + ''''
            WHEN [key] = 'type' THEN 'T.name = ''' + [value] + ''''
			ELSE [key] + ' = ''' + [value] + ''''
        END
        FROM OPENJSON(@l_Json)
		set @response=' where '+@response
		end
	    SET @l_COUNT =N'select count(*) as count from [Customer] C join [Type] T on T.Id=C.TypeId';
		SET @l_SQL = N'Select C.*,T.Name as TypeName from [Customer] C join [Type] T on T.Id=C.TypeId';
		EXEC sp_GetFilterJoin @l_COUNT, @l_SQL, @orderBy, @sortBy, @pageNumber, @pageSize, @response;
	END
END	

--exec sp_CustomerGet @action=N'Filter',@orderBy=N'id',@sortBy=N'asc',@pageNumber=1,@pageSize=10,@filterColumns='name=''gopi'' ' 
--exec sp_CustomerGet @action=N'Filter',@orderBy=N'id',@sortBy=N'asc',@pageNumber=1,@pageSize=10,@filterColumns=''
--exec sp_CustomerGet @action=N'Filter',@orderBy=N'id',@sortBy=N'asc',@pageNumber=1,@pageSize=10,@filterColumns=null


--select * from Customer;
GO
/****** Object:  StoredProcedure [dbo].[sp_GetFilterJoin]    Script Date: 30-04-2025 05:11:49 ******/
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
/****** Object:  StoredProcedure [dbo].[sp_GetFilterJsonConversion]    Script Date: 30-04-2025 05:11:49 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create  PROCEDURE [dbo].[sp_GetFilterJsonConversion]
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
GO
/****** Object:  StoredProcedure [dbo].[sp_Login]    Script Date: 30-04-2025 05:11:49 ******/
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
/****** Object:  StoredProcedure [dbo].[sp_Role]    Script Date: 30-04-2025 05:11:49 ******/
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
/****** Object:  StoredProcedure [dbo].[sp_RoleById]    Script Date: 30-04-2025 05:11:49 ******/
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
/****** Object:  StoredProcedure [dbo].[sp_RoleGet]    Script Date: 30-04-2025 05:11:49 ******/
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
		DECLARE @l_Json NVARCHAR(MAX);
	    DECLARE @response NVARCHAR(MAX)='';

		if(@filterColumns > '' )
		begin
			EXEC sp_GetFilterJsonConversion @filterColumns,@l_Json OUTPUT;

		SELECT @response=
		CASE 
            WHEN LEN(@response) > 0 THEN @response + ' AND '
            ELSE ''
        END + [key] + ' = ''' + [value] + ''''
        FROM OPENJSON(@l_Json)
		set @response=' where '+@response
		end

		SET @l_COUNT = N'select count(*) from [Role]';
		SET @l_SQL = N'select * from [Role]';
		EXEC sp_GetFilterJoin @l_COUNT,@l_SQL, @orderBy, @sortBy, @pageNumber, @pageSize,@response;
	END
END	

--EXEC sp_RoleGet 'Filter', 'id', 'ASC';
GO
/****** Object:  StoredProcedure [dbo].[sp_RoleValidation]    Script Date: 30-04-2025 05:11:49 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_RoleValidation]
(
@action nvarchar(50),
@uid nvarchar(50)=null,
@name nvarchar(50)=null
)
AS
BEGIN
		IF(@action='Name')
		BEGIN
			select name from [Role] where name=@name
		END		
END
GO
/****** Object:  StoredProcedure [dbo].[sp_Supplier]    Script Date: 30-04-2025 05:11:49 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_Supplier]
(
@action nvarchar(50),
@UId  uniqueidentifier=null,
@referenceid bigint,
@typeid bigint,
@name nvarchar(100),
@gst nvarchar(50),
@landline nvarchar(20),
@email nvarchar(50),
@address nvarchar(500),
@contact nvarchar(50),
@mobile nvarchar(20),
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
					INSERT INTO [Supplier]
						VALUES (@l_GUID,@referenceid,@typeid,@name,@gst,@landline,@contact,@mobile,@email,@address,@actionby,GETUTCDATE(),@isactive)
				END
			IF(@action='Update')
	    		BEGIN
					SET @l_GUID=@UId;
					UPDATE [Supplier] set
					  ReferenceId=@referenceid,
					  TypeId=@typeid,
					  Name = @name,
					  GST=@gst,
					  Landline=@landline,
					  Email=@email,
					  Address=@address,
					  Contact=@contact,
					  Mobile=@mobile,
					  Actionby=@actionby,
					  ActionDate=GETUTCDATE(),
					  Isactive=@isactive
					  where UId = @UId;					  
				END
  
		IF @@TRANCOUNT > 0
		BEGIN 
			COMMIT TRANSACTION;
			select * from [Supplier] where UId=@l_GUID
		END
	END TRY 
	BEGIN CATCH
		BEGIN 
			ROLLBACK TRANSACTION;
		END  
	END CATCH
END
GO
/****** Object:  StoredProcedure [dbo].[sp_SupplierById]    Script Date: 30-04-2025 05:11:49 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_SupplierById]
(
@action nvarchar(50),
@uid uniqueidentifier,
@isActive bit =null
)
AS
BEGIN
		IF(@action='Get')
		BEGIN
			select S.*,T.Name as TypeName from [Supplier] S join [Type] T on T.Id=S.TypeId where S.UId=@uid
		END
		
		IF(@action='Delete')
		BEGIN
			Delete from [Supplier] where UId=@uid
		END
		
		IF(@action='IsActive')
		BEGIN
			Update [Supplier] set isActive=@isActive  where UId=@uid
			select S.*,T.Name as TypeName from [Supplier] S join [Type] T on T.Id=S.TypeId where S.UId=@uid
		END
END
GO
/****** Object:  StoredProcedure [dbo].[sp_SupplierGet]    Script Date: 30-04-2025 05:11:49 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_SupplierGet]
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
		SELECT count(*) as count from [Supplier];
		SET @l_SQL = N'select S.*,T.Name as TypeName from [Supplier] S join [Type] T on T.Id=S.TypeId ORDER BY ' + QUOTENAME(@orderBy) + ' ' + @sortBy;
		EXEC sp_executesql @l_SQL
	END
	
	IF(@action='Filter')
	BEGIN
		DECLARE @l_COUNT NVARCHAR(MAX);
		DECLARE @l_Json NVARCHAR(MAX);
	    DECLARE @response NVARCHAR(MAX)='';

		if(@filterColumns > '' )
		begin
			EXEC sp_GetFilterJsonConversion @filterColumns,@l_Json OUTPUT;

		SELECT @response=
		CASE 
            WHEN LEN(@response) > 0 THEN @response + ' AND '
            ELSE ''
        END + 
		CASE 
            WHEN [key] = 'name' THEN 'S.' + [key] + ' = ''' + [value] + ''''
            WHEN [key] = 'type' THEN 'T.name = ''' + [value] + ''''
			ELSE [key] + ' = ''' + [value] + ''''
        END
        FROM OPENJSON(@l_Json)
		set @response=' where '+@response
		end
	    SET @l_COUNT =N'select count(*) as count from [Supplier] S join [Type] T on T.Id=S.TypeId';
		SET @l_SQL = N'select S.*,T.Name as TypeName from [Supplier] S join [Type] T on T.Id=S.TypeId';
		EXEC sp_GetFilterJoin @l_COUNT, @l_SQL, @orderBy, @sortBy, @pageNumber, @pageSize, @response;
	END
END	

--exec sp_SupplierGet @action=N'Filter',@orderBy=N'id',@sortBy=N'asc',@pageNumber=1,@pageSize=10,@filterColumns='name=''pivikart'' '
--exec sp_SupplierGet @action=N'Filter',@orderBy=N'id',@sortBy=N'asc',@pageNumber=1,@pageSize=10,@filterColumns=''
--exec sp_SupplierGet @action=N'Filter',@orderBy=N'id',@sortBy=N'asc',@pageNumber=1,@pageSize=10,@filterColumns=null


GO
/****** Object:  StoredProcedure [dbo].[sp_User]    Script Date: 30-04-2025 05:11:49 ******/
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
/****** Object:  StoredProcedure [dbo].[sp_UserById]    Script Date: 30-04-2025 05:11:49 ******/
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
/****** Object:  StoredProcedure [dbo].[sp_UserGet]    Script Date: 30-04-2025 05:11:49 ******/
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
			EXEC sp_GetFilterJsonConversion @filterColumns,@l_Json OUTPUT;

		SELECT @response=
		CASE 
            WHEN LEN(@response) > 0 THEN @response + ' AND '
            ELSE ''
        END + 
		CASE 
            WHEN [key] = 'id' THEN 'U.' + [key] + ' = ''' + [value] + ''''
            WHEN [key] = 'name' THEN 'U.' + [key] + ' = ''' + [value] + ''''
            WHEN [key] = 'roleName' THEN 'R.name = ''' + [value] + ''''
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
/****** Object:  StoredProcedure [dbo].[sp_UserValidation]    Script Date: 30-04-2025 05:11:49 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_UserValidation]
(
@action nvarchar(50),
@uid nvarchar(50)=null,
@email nvarchar(50)=null,
@mobile nvarchar(20) =null
)
AS
BEGIN
		IF(@action='Email')
		BEGIN
			select email from [User] where email=@email
		END
		
		IF(@action='Mobile')
		BEGIN
			select mobile from [User] where mobile=@mobile
		END
		
END
GO
