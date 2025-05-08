USE [Bon]
GO
/****** Object:  StoredProcedure [dbo].[sp_BusinessType]    Script Date: 08-05-2025 07:29:45 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_BusinessType]
(
@UId  uniqueidentifier=null,
@action nvarchar(50),
@name nvarchar(100),
@notes nvarchar(250),
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
					INSERT INTO [BusinessType]
						VALUES (@l_GUID,@name,@notes,@actionby,GETUTCDATE(),@isactive)
				END
			IF(@action='Update')
	    		BEGIN
					SET @l_GUID=@UId;
					UPDATE [BusinessType] set	
					  Name = @name,
					  Notes=@notes,
					  Actionby=@actionby,
					  ActionDate=GETUTCDATE(),
					  Isactive=@isactive
					  where uid=@l_GUID;					  
				END
  
		IF @@TRANCOUNT > 0
		BEGIN 
			COMMIT TRANSACTION;
			select * from [BusinessType] where uid=@l_GUID
		END
	END TRY 
	BEGIN CATCH
		BEGIN 
			ROLLBACK TRANSACTION;
		END  
	END CATCH
END	

GO
/****** Object:  StoredProcedure [dbo].[sp_BusinessTypeById]    Script Date: 08-05-2025 07:29:45 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_BusinessTypeById]
(
@action nvarchar(50),
@uid uniqueidentifier,
@isActive bit =null
)
AS
BEGIN
		IF(@action='Get')
		BEGIN
			select * from [BusinessType] where uid=@uid
		END
		
		IF(@action='Delete')
		BEGIN
			Delete from [BusinessType] where uid=@uid
		END
		
		IF(@action='IsActive')
		BEGIN
			Update [BusinessType] set isActive=@isActive  where uid=@uid
			select * from [BusinessType] where uid=@uid
		END
END
GO
/****** Object:  StoredProcedure [dbo].[sp_BusinessTypeGet]    Script Date: 08-05-2025 07:29:45 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_BusinessTypeGet]
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
		SELECT count(*) as count from [BusinessType];
		SET @l_SQL = N'select * from [BusinessType] ORDER BY ' + QUOTENAME(@orderBy) + ' ' + @sortBy;
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
					
		SELECT @response = STRING_AGG(
		   CASE 
		       WHEN [key] = 'isActive' THEN 'isActive = ''' + [value] + ''''
		       ELSE [key] + ' like ''%' + [value] + '%'''
		   END,
		   ' AND '
		 )
		FROM OPENJSON(@l_Json)
		set @response=' where '+@response
		end
	
		SET @l_COUNT =N'select count(*) as count from [BusinessType]';
		SET @l_SQL = N'select * from [BusinessType]';
		EXEC sp_GetFilterJoin @l_COUNT, @l_SQL, @orderBy, @sortBy, @pageNumber, @pageSize, @response;
	END
END	

--exec sp_UserGet @action=N'Filter',@orderBy=N'id',@sortBy=N'asc',@pageNumber=1,@pageSize=10,@filterColumns='name=''gopi'' '
--exec sp_UserGet @action=N'Filter',@orderBy=N'id',@sortBy=N'asc',@pageNumber=1,@pageSize=10,@filterColumns=''
--exec sp_UserGet @action=N'Filter',@orderBy=N'id',@sortBy=N'asc',@pageNumber=1,@pageSize=10,@filterColumns=null


GO
/****** Object:  StoredProcedure [dbo].[sp_BusinessTypeValidation]    Script Date: 08-05-2025 07:29:45 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_BusinessTypeValidation]
(
@action nvarchar(50),
@uid uniqueidentifier=null,
@name nvarchar(50)=null
)
AS
BEGIN
		IF(@action='name')
		 BEGIN
		    select name from [BusinessType] where name=@name and uid = @uid
		 END		
END

GO
/****** Object:  StoredProcedure [dbo].[sp_Category]    Script Date: 08-05-2025 07:29:45 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_Category]
(
@action nvarchar(50),
@UId  uniqueidentifier=null,
@name nvarchar(100),
@notes nvarchar(250),
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
					INSERT INTO [Category]
					VALUES (@l_GUID,@name,@notes,@actionby,GETUTCDATE(),@isactive)
				END
			IF(@action='Update')
	    		BEGIN
					SET @l_GUID=@UId;
					UPDATE [Category] set	
					  Name = @name,
					  Notes = @notes,
					  ActionBy = @actionby,
					  ActionDate = GETUTCDATE(),
					  Isactive = @isactive
					  where UId = @l_GUID;					  
				END
  
		IF @@TRANCOUNT > 0
		BEGIN 
			COMMIT TRANSACTION;
			select * from Category where UId = @l_GUID;
		END
	END TRY 
	BEGIN CATCH
		BEGIN 
			ROLLBACK TRANSACTION;
		END  
	END CATCH
END	

--EXEC [sp_Category] 'Add',null,'Atlantica','Raw material supplier',1,1

GO
/****** Object:  StoredProcedure [dbo].[sp_CategoryById]    Script Date: 08-05-2025 07:29:45 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_CategoryById]
(
@action nvarchar(50),
@uid uniqueidentifier,
@isActive bit =null
)
AS
BEGIN
		IF(@action='Get')
		BEGIN
			select * from [Category] where uid=@uid
		END
		
		IF(@action='Delete')
		BEGIN
			Delete from [Category] where uid=@uid
		END
		
		IF(@action='IsActive')
		BEGIN
			Update [Category] set isActive=@isActive  where uid=@uid
			select * from [Category] where uid=@uid
		END
END
GO
/****** Object:  StoredProcedure [dbo].[sp_CategoryGet]    Script Date: 08-05-2025 07:29:45 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_CategoryGet]
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
		SELECT count(*) as count from [Category];
		SET @l_SQL = N'select * from [Category] ORDER BY ' + QUOTENAME(@orderBy) + ' ' + @sortBy;
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

		SELECT @response = STRING_AGG(
		   CASE 
		       WHEN [key] = 'isActive' THEN 'isActive = ''' + [value] + ''''
		       ELSE [key] + ' like ''%' + [value] + '%'''
		   END,
		   ' AND '
		 )
		FROM OPENJSON(@l_Json)
		set @response=' where '+@response
		end
	
		SET @l_COUNT =N'select count(*) as count from [Category]';
		SET @l_SQL = N'select * from [Category]';
		EXEC sp_GetFilterJoin @l_COUNT, @l_SQL, @orderBy, @sortBy, @pageNumber, @pageSize, @response;
	END
END	

--exec sp_CategoryeGet @action=N'Filter',@orderBy=N'id',@sortBy=N'asc',@pageNumber=1,@pageSize=10,@filterColumns='name=''gopi'' '
--exec sp_CategoryGet @action=N'Filter',@orderBy=N'id',@sortBy=N'asc',@pageNumber=1,@pageSize=10,@filterColumns=''
--exec sp_CategoryGet @action=N'Filter',@orderBy=N'id',@sortBy=N'asc',@pageNumber=1,@pageSize=10,@filterColumns=null


GO
/****** Object:  StoredProcedure [dbo].[sp_CategoryValidation]    Script Date: 08-05-2025 07:29:45 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_CategoryValidation]
(
@uid uniqueidentifier=null,
@name nvarchar(20)=null
)
AS
BEGIN
		
		select Name from [Category] where  uid =@uid and Name=ISNULL(@name,name) 		 
			
END

GO
/****** Object:  StoredProcedure [dbo].[sp_Customer]    Script Date: 08-05-2025 07:29:45 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_Customer]
(
@action nvarchar(50),
@UId  uniqueidentifier=null,
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
						VALUES (@l_GUID,@typeid,@name,@gst,@landline,@email,@contact,@mobile,@address,@actionby,GETUTCDATE(),@isactive)
				END
			IF(@action='Update')
	    		BEGIN
					SET @l_GUID=@UId;
					UPDATE [Customer] set
					  TypeId=@typeid,
					  Name = @name,
					  GST=@gst,
					  Landline=@landline,
					  Email=@email,
					  Contact=@contact,
					  Mobile=@mobile,
					  Address=@address,
					  Actionby=@actionby,
					  ActionDate=GETUTCDATE(),
					  Isactive=@isactive
					  where UId = @l_GUID;					  
				END
  
		IF @@TRANCOUNT > 0
		BEGIN 
			COMMIT TRANSACTION;
			Select C.*,T.Name as TypeName from [Customer] C join [BusinessType] T on T.Id=C.TypeId where C.UId=@l_GUID
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
/****** Object:  StoredProcedure [dbo].[sp_CustomerById]    Script Date: 08-05-2025 07:29:45 ******/
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
			select C.*,T.Name as TypeName from [Customer] C join [BusinessType] T on T.Id=C.TypeId where C.UId=@uid
		END
		
		IF(@action='Delete')
		BEGIN
			Delete from [Customer] where UId=@uid
		END
		
		IF(@action='IsActive')
		BEGIN
			Update [Customer] set isActive=@isActive  where UId=@uid
			select C.*,T.Name as TypeName from [Customer] C join [BusinessType] T on T.Id=C.TypeId where C.UId=@uid
		END
END
GO
/****** Object:  StoredProcedure [dbo].[sp_CustomerGet]    Script Date: 08-05-2025 07:29:45 ******/
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
		SET @l_SQL = N'select C.*,T.Name as TypeName from [Customer] C join [BusinessType] T on T.Id=C.TypeId ORDER BY ' + QUOTENAME(@orderBy) + ' ' + @sortBy;
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

		SELECT @response = STRING_AGG(
		   CASE 
		       WHEN [key] = 'typeName' THEN 'T.name like ''%' + [value] + '%'''
		       WHEN [key] = 'isActive' THEN 'C.isActive = ''' + [value] + ''''
		       ELSE 'C.' +  [key] + ' like ''%' + [value] + '%'''
		   END,
		   ' AND '
		 )
		FROM OPENJSON(@l_Json)
		set @response=' where '+@response
		end
	    SET @l_COUNT =N'select count(*) as count from [Customer] C join [BusinessType] T on T.Id=C.TypeId';
		SET @l_SQL = N'Select C.*,T.Name as TypeName from [Customer] C join [BusinessType] T on T.Id=C.TypeId';
		--select @l_SQL + @response
		EXEC sp_GetFilterJoin @l_COUNT, @l_SQL, @orderBy, @sortBy, @pageNumber, @pageSize, @response;
	END
END	

--exec sp_CustomerGet @action=N'Filter',@orderBy=N'id',@sortBy=N'desc',@pageNumber=1,@pageSize=10,@filterColumns=N'''isActive'':''true'''
GO
/****** Object:  StoredProcedure [dbo].[sp_CustomerValidation]    Script Date: 08-05-2025 07:29:45 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_CustomerValidation]
(
@action nvarchar(50),
@uid uniqueidentifier=null,
@email nvarchar(50)=null,
@mobile nvarchar(20) =null
)
AS
BEGIN
		IF(@action='Email')
		 BEGIN
		    select email from [Customer] where email=@email and uid = ISNULL(@uid,Uid)
		 END
		
		IF(@action='Mobile')
		BEGIN
		  select mobile from [Customer] where mobile=@mobile and uid = ISNULL(@uid,Uid)
		END
		
END

GO
/****** Object:  StoredProcedure [dbo].[sp_Device]    Script Date: 08-05-2025 07:29:45 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_Device]
(
@action nvarchar(50),
@id bigint,
@uid uniqueidentifier = null,
@devicetypeid bigint,
@name nvarchar(100),
@serialnumber nvarchar(50),
@modelnumber nvarchar(50),
@manufacturer nvarchar(100),
@size nvarchar(100) = null,
@capacity nvarchar(50) = null,
@currentcount bigint = null,
@maximumcount bigint,
@notes nvarchar(500),
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
					INSERT INTO [Device]
						VALUES (@l_GUID,@devicetypeid,@name,@serialnumber,@modelnumber,@manufacturer,@size,@capacity,GETUTCDATE(),
						        @currentcount,@maximumcount,@notes,@actionby,GETUTCDATE(),@isactive)
				END
			IF(@action='Update')
	    		BEGIN
					SET @l_GUID=@UId;
					UPDATE [Device] set
					  DeviceTypeId=@devicetypeid,
					  Name = @name,
					  SerialNumber=@serialnumber,
					  ModelNumber=@modelnumber,
					  Manufacturer=@manufacturer,
					  Size=@size,
					  Capacity=@capacity,
					  PurchaseDate=GETUTCDATE(),
					  CurrentCount=@currentcount,
					  MaximumCount=@maximumcount,
					  Notes=@notes,
					  Actionby=@actionby,
					  ActionDate=GETUTCDATE(),
					  Isactive=@isactive
					  where UId = @l_GUID;					  
				END
  
		IF @@TRANCOUNT > 0
		BEGIN 
			COMMIT TRANSACTION;
			select * from [Device] where UId=@l_GUID
		END
	END TRY 
	BEGIN CATCH
		BEGIN 
			ROLLBACK TRANSACTION;
		END  
	END CATCH
END	
GO
/****** Object:  StoredProcedure [dbo].[sp_DeviceById]    Script Date: 08-05-2025 07:29:45 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_DeviceById]
(
@action nvarchar(50),
@uid uniqueidentifier,
@isActive bit =null
)
AS
BEGIN
		IF(@action='Get')
		BEGIN
			select D.*,DT.Name as DeviceName from [Device] D join [DeviceType] DT on DT.Id=D.MachineTypeId where D.UId=@uid
		END
		
		IF(@action='Delete')
		BEGIN
			Delete from [Device] where UId=@uid
		END
		
		IF(@action='IsActive')
		BEGIN
			Update [Device] set isActive=@isActive  where UId=@uid
			select D.*,DT.Name as DeviceName from [Device] D join [DeviceType] DT on DT.Id=D.MachineTypeId where D.UId=@uid
		END
END
GO
/****** Object:  StoredProcedure [dbo].[sp_DeviceGet]    Script Date: 08-05-2025 07:29:45 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_DeviceGet]
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
		SELECT count(*) as count from [Device];
		SET @l_SQL = N'select D.*,DT.Name as DeviceName from [Device] D join [DeviceType] DT on DT.Id=D.MachineTypeId  ORDER BY ' + QUOTENAME(@orderBy) + ' ' + @sortBy;
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

		SELECT @response = STRING_AGG(
		   CASE 
		       WHEN [key] = 'deviceName' THEN 'DT.name like ''%' + [value] + '%'''
		       WHEN [key] = 'isActive' THEN 'D.isActive = ''' + [value] + ''''
		       ELSE 'D.' + [key] + ' like ''%' + [value] + '%'''
		   END,
		   ' AND '
		 )
		FROM OPENJSON(@l_Json)
		set @response=' where '+@response
		end
	    SET @l_COUNT =N'select count(*) as count from [Device] D join [DeviceType] DT on DT.Id=D.MachineTypeId';
		SET @l_SQL = N'select D.*,DT.Name as DeviceName from [Device] D join [DeviceType] DT on DT.Id=D.MachineTypeId';
		EXEC sp_GetFilterJoin @l_COUNT, @l_SQL, @orderBy, @sortBy, @pageNumber, @pageSize, @response;
	END
END	

--exec sp_DeviceGet @action=N'Filter',@orderBy=N'id',@sortBy=N'asc',@pageNumber=1,@pageSize=10,@filterColumns='name=''pivikart'' '
--exec sp_DeviceGet @action=N'Filter',@orderBy=N'id',@sortBy=N'asc',@pageNumber=1,@pageSize=10,@filterColumns=''
--exec sp_DeviceGet @action=N'Filter',@orderBy=N'id',@sortBy=N'asc',@pageNumber=1,@pageSize=10,@filterColumns=null


GO
/****** Object:  StoredProcedure [dbo].[sp_DeviceMaintenance]    Script Date: 08-05-2025 07:29:45 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_DeviceMaintenance]
(
@action nvarchar(50),
@UId  uniqueidentifier=null,
@deviceid bigint,
@servicetypeid bigint,
@serviceby nvarchar(50),
@comments nvarchar(500),
@statusid bigint,
@actionby bigint,
@isactive bit
)
AS
BEGIN	
	 BEGIN TRY 
		Declare @l_GUID nvarchar(100)
		Declare @l_nextservicedate datetime
	    BEGIN TRANSACTION
			IF(@action='Add')
				BEGIN
					SET @l_GUID=NEWID();
					SET @l_nextservicedate=DATEADD(MONTH, 6, GETUTCDATE())
					INSERT INTO [DeviceMaintenance]
						VALUES (@l_GUID,@deviceid,GETUTCDATE(),@servicetypeid,@serviceby,@comments,@l_nextservicedate,@statusid,@actionby,GETUTCDATE(),@isactive)
				END
			IF(@action='Update')
	    		BEGIN
					SET @l_GUID=@UId;
					SELECT @l_nextservicedate=DATEADD(MONTH, 6, ServiceDate) from DeviceMaintenance where UId = @l_GUID;	
					UPDATE [DeviceMaintenance] set	
					  DeviceId = @deviceid,
					  ServiceDate=GETUTCDATE(),
					  ServiceTypeId=@servicetypeid,
					  ServiceBy=@serviceby,
					  Comments=@comments,
					  nextservicedate=@l_nextservicedate,
					  StatusId=@statusid,
					  Actionby=@actionby,
					  ActionDate=GETUTCDATE(),
					  Isactive=@isactive
					  where UId = @l_GUID;					  
				END
  
		IF @@TRANCOUNT > 0
		BEGIN 
			COMMIT TRANSACTION;
			select DM.*,D.Name as DeviceName from [DeviceMaintenance] DM join [Device] D on DM.DeviceId=D.Id where DM.UId=@l_GUID
		END
	END TRY 
	BEGIN CATCH
		BEGIN 
			ROLLBACK TRANSACTION;
		END  
	END CATCH
END	


GO
/****** Object:  StoredProcedure [dbo].[sp_DeviceMaintenanceById]    Script Date: 08-05-2025 07:29:45 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_DeviceMaintenanceById]
(
@action nvarchar(50),
@uid uniqueidentifier,
@isActive bit =null
)
AS
BEGIN
		IF(@action='Get')
		BEGIN
			select DM.*,D.Name as DeviceName from [DeviceMaintenance] DM join [Device] D on DM.DeviceId=D.Id where DM.UId=@uid
		END
		
		IF(@action='Delete')
		BEGIN
			Delete from [DeviceMaintenance] where UId=@uid
		END
		
		IF(@action='IsActive')
		BEGIN
			Update [DeviceMaintenance] set isActive=@isActive  where UId=@uid
			select DM.*,D.Name as DeviceName from [DeviceMaintenance] DM join [Device] D on DM.DeviceId=D.Id where DM.UId=@uid
		END
END
GO
/****** Object:  StoredProcedure [dbo].[sp_DeviceMaintenanceGet]    Script Date: 08-05-2025 07:29:45 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_DeviceMaintenanceGet]
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
		SELECT count(*) as count from [DeviceMaintenance];
		SET @l_SQL = N'select DM.*,D.Name as DeviceName from [DeviceMaintenance] DM join [Device] D on DM.DeviceId=D.Id where DM.UId=@uid  ORDER BY ' + QUOTENAME(@orderBy) + ' ' + @sortBy;
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

		SELECT @response = STRING_AGG(
		   CASE 
		       WHEN [key] = 'deviceName' THEN 'D.name like ''%' + [value] + '%'''
		       WHEN [key] = 'isActive' THEN 'DM.isActive = ''' + [value] + ''''
		       ELSE 'DM.' + [key] + ' like ''%' + [value] + '%'''
		   END,
		   ' AND '
		 )
		FROM OPENJSON(@l_Json)
		set @response=' where '+@response
		end
	    SET @l_COUNT =N'select count(*) as count from [DeviceMaintenance] DM join [Device] D on DM.DeviceId=D.Id where DM.UId=@uid';
		SET @l_SQL = N'select DM.*,D.Name as DeviceName from [DeviceMaintenance] DM join [Device] D on DM.DeviceId=D.Id where DM.UId=@uid';
		EXEC sp_GetFilterJoin @l_COUNT, @l_SQL, @orderBy, @sortBy, @pageNumber, @pageSize, @response;
	END
END	

--exec sp_DeviceMaintenanceGet @action=N'Filter',@orderBy=N'id',@sortBy=N'asc',@pageNumber=1,@pageSize=10,@filterColumns='name=''pivikart'' '
--exec sp_DeviceMaintenanceGet @action=N'Filter',@orderBy=N'id',@sortBy=N'asc',@pageNumber=1,@pageSize=10,@filterColumns=''
--exec sp_DeviceMaintenanceGet @action=N'Filter',@orderBy=N'id',@sortBy=N'asc',@pageNumber=1,@pageSize=10,@filterColumns=null


GO
/****** Object:  StoredProcedure [dbo].[sp_DeviceType]    Script Date: 08-05-2025 07:29:45 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_DeviceType]
(
@action nvarchar(50),
@id bigint,
@name nvarchar(100),
@notes nvarchar(500),
@actionby bigint,
@isactive bit
)
AS
BEGIN	
	
	 BEGIN TRY 
		BEGIN TRANSACTION
			IF(@action='Add')
				BEGIN
					   INSERT INTO [DeviceType]
						VALUES (@name,@notes,@actionby,GETUTCDATE(),@isactive)
				END
			IF(@action='Update')
	    		BEGIN
					UPDATE [DeviceType] set	
					  Name = @name,
					  Notes = @notes,
					  ActionBy = @actionby,
					  ActionDate = GETUTCDATE(),
					  Isactive = @isactive
					  where Id = @id;				  
				END
  
		IF @@TRANCOUNT > 0
		BEGIN 
			COMMIT TRANSACTION;
			select * from [DeviceType] where Id = @id;
		END
	END TRY 
	BEGIN CATCH
		BEGIN 
			ROLLBACK TRANSACTION;
		END  
	END CATCH
END	
GO
/****** Object:  StoredProcedure [dbo].[sp_DeviceTypeById]    Script Date: 08-05-2025 07:29:45 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_DeviceTypeById]
(
@action nvarchar(50),
@id bigint,
@isActive bit =null
)
AS
BEGIN
		IF(@action='Get')
		BEGIN
			select D.*,DT.Name as DeviceName from [Device] D join [DeviceType] DT on DT.Id=D.DeviceTypeId where D.Id=@id
		END
		
		IF(@action='Delete')
		BEGIN
			Delete from [DeviceType] where Id=@id
		END
		
		IF(@action='IsActive')
		BEGIN
			Update [DeviceType] set isActive=@isActive  where Id=@id
			select D.*,DT.Name as DeviceName from [Device] D join [DeviceType] DT on DT.Id=D.DeviceTypeId where D.Id=@id
		END
END
GO
/****** Object:  StoredProcedure [dbo].[sp_DeviceTypeGet]    Script Date: 08-05-2025 07:29:45 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_DeviceTypeGet]
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
		SELECT count(*) as count from [DeviceType];
		SET @l_SQL = N'select * from [DeviceType]  ORDER BY ' + QUOTENAME(@orderBy) + ' ' + @sortBy;
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

		SELECT @response = STRING_AGG(
		   CASE 
		       WHEN [key] = 'isActive' THEN 'isActive = ''' + [value] + ''''
		       ELSE [key] + ' like ''%' + [value] + '%'''
		   END,
		   ' AND '
		 )
		FROM OPENJSON(@l_Json)
		set @response=' where '+@response
		end
	
		SET @l_COUNT =N'select count(*) as count from [DeviceType]';
		SET @l_SQL = N'select * from [DeviceType]';
		EXEC sp_GetFilterJoin @l_COUNT, @l_SQL, @orderBy, @sortBy, @pageNumber, @pageSize, @response;

	END
END	


--exec sp_DeviceGet @action=N'Filter',@orderBy=N'id',@sortBy=N'asc',@pageNumber=1,@pageSize=10,@filterColumns='name=''pivikart'' '
--exec sp_DeviceGet @action=N'Filter',@orderBy=N'id',@sortBy=N'asc',@pageNumber=1,@pageSize=10,@filterColumns=''
--exec sp_DeviceGet @action=N'Filter',@orderBy=N'id',@sortBy=N'asc',@pageNumber=1,@pageSize=10,@filterColumns=null


GO
/****** Object:  StoredProcedure [dbo].[sp_GetFilterJoin]    Script Date: 08-05-2025 07:29:45 ******/
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
/****** Object:  StoredProcedure [dbo].[sp_GetFilterJsonConversion]    Script Date: 08-05-2025 07:29:45 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_GetFilterJsonConversion]
    @filterColumns NVARCHAR(MAX),
    @output NVARCHAR(MAX) OUT
AS
BEGIN
   -- Step 1: Replace doubled single quotes with regular single quotes
SET @filterColumns = REPLACE(@filterColumns, '''''', '''');

-- Now it's: 'id' : '10' AND 'name' : 'Non-Regular'

-- Step 2: Remove single quotes around keys and values
SET @filterColumns = REPLACE(@filterColumns, '''', '');

-- Step 3: Replace " AND " with commas
SET @filterColumns = REPLACE(@filterColumns, ' AND ', ',');

-- Step 4: Add braces and double quotes to make valid JSON
-- First, replace `:` with `":"`, and wrap keys in quotes
-- We'll use simple pattern conversion
SET @filterColumns = REPLACE(@filterColumns, ':', '":"');

SET @filterColumns = '"' + REPLACE(@filterColumns, ',', '","') + '"';

SET @filterColumns = '{' + @filterColumns + '}';

-- Final JSON Output
SET @output = @filterColumns;
END;


GO
/****** Object:  StoredProcedure [dbo].[sp_HSNCode]    Script Date: 08-05-2025 07:29:45 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_HSNCode]
(
@action nvarchar(50),
@UId  uniqueidentifier=null,
@categoryid bigint,
@name nvarchar(20),
@notes nvarchar(100),
@gst bigint,
@sgst bigint,
@cgst bigint,
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
					INSERT INTO [HSNCode]
					VALUES (@l_GUID,@categoryid,@name,@notes,@gst,@sgst,@cgst,@actionby,GETUTCDATE(),@isactive)

				END
			IF(@action='Update')
	    		BEGIN
					SET @l_GUID=@UId;
					UPDATE [HSNCode] set	
					  CategoryId = @categoryid,
					  Name = @name,
					  Notes = @notes,
					  GST = @gst,
					  SGST = @sgst,
					  CGST = @cgst,
					  ActionBy = @actionby,
					  ActionDate = GETUTCDATE(),
					  Isactive = @isactive
					  where UId = @l_GUID;					  
				END
  
		IF @@TRANCOUNT > 0
		BEGIN 
			COMMIT TRANSACTION;
			select H.*, C.name as CategoryName from HSNCode H join Category C on C.Id = H.CategoryId  where H.UId = @l_GUID;
		END
	END TRY 
	BEGIN CATCH
		BEGIN 
			ROLLBACK TRANSACTION;
		END  
	END CATCH
END	

--EXEC [sp_HSNCode] 'Add',null,1,'gopi','hghghhg','','','',1,1
GO
/****** Object:  StoredProcedure [dbo].[sp_HSNCodeById]    Script Date: 08-05-2025 07:29:45 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_HSNCodeById]
(
@action nvarchar(50),
@uid uniqueidentifier,
@isActive bit =null
)
AS
BEGIN
		IF(@action='Get')
		BEGIN
			select H.*, C.name as CategoryName from HSNCode H join Category C on C.Id = H.CategoryId where h.uid=@uid
		END
		
		IF(@action='Delete')
		BEGIN
			Delete from [HSNCode] where uid=@uid
		END
		
		IF(@action='IsActive')
		BEGIN
			Update [HSNCode] set isActive=@isActive  where uid=@uid
			select H.*, C.name as CategoryName from HSNCode H join Category C on C.Id = H.CategoryId  where H.UId = @uid;
		END
END
GO
/****** Object:  StoredProcedure [dbo].[sp_HSNCodeGet]    Script Date: 08-05-2025 07:29:45 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_HSNCodeGet]
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
		SELECT count(*) as count from [HSNCode];
		SET @l_SQL = N'select H.*, C.name as CategoryName from HSNCode H join Category C on C.Id = H.CategoryId ORDER BY ' + QUOTENAME(@orderBy) + ' ' + @sortBy;
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

		SELECT @response = STRING_AGG(
		   CASE 
		       WHEN [key] = 'categoryName' THEN 'C.name like ''%' + [value] + '%'''
		       WHEN [key] = 'isActive' THEN 'H.isActive = ''' + [value] + ''''
		       ELSE 'H.' + [key] + ' like ''%' + [value] + '%'''
		   END,
		   ' AND '
		 )
		FROM OPENJSON(@l_Json)
		set @response=' where '+@response
		end
	
		SET @l_COUNT =N'select count(*) as count from [HSNCode] H join Category C on C.Id = H.CategoryId';
		SET @l_SQL = N'select H.*, C.name as CategoryName from HSNCode H join Category C on C.Id = H.CategoryId';
		EXEC sp_GetFilterJoin @l_COUNT, @l_SQL, @orderBy, @sortBy, @pageNumber, @pageSize, @response;
	END
END	

--exec sp_HSNCodeGet @action=N'Filter',@orderBy=N'id',@sortBy=N'asc',@pageNumber=1,@pageSize=10,@filterColumns='name=''gopi'' '
--exec sp_HSNCodeGet @action=N'Filter',@orderBy=N'id',@sortBy=N'asc',@pageNumber=1,@pageSize=10,@filterColumns=''
--exec sp_HSNCodeGet @action=N'Filter',@orderBy=N'id',@sortBy=N'asc',@pageNumber=1,@pageSize=10,@filterColumns=null


GO
/****** Object:  StoredProcedure [dbo].[sp_HSNCodeValidation]    Script Date: 08-05-2025 07:29:45 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_HSNCodeValidation]
(
@uid uniqueidentifier=null,
@categoryid bigint null,
@name nvarchar(20)=null
)
AS
BEGIN
		
		select Name from [HSNCode] where  uid =@uid and CategoryId = ISNULL(@categoryid,CategoryId) and Name=ISNULL(@name,name) 		 
			
END

GO
/****** Object:  StoredProcedure [dbo].[sp_Login]    Script Date: 08-05-2025 07:29:45 ******/
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
			select u.*,r.Name as RoleName from [User] U join [Role] R on U.RoleId=R.Id where (u.Email=@username or u.Mobile=@username) and u.Password=@password and u.IsActive=1
		END	
		IF(@action='updatepassword')
		BEGIN
		DECLARE @l_id bigint
			select @l_id= id from [User] where (Email=@username or Mobile=@username) and Password=@password
			update [User] set Password=@newpassword, isLogin=1 where (Email=@username or Mobile=@username) and Password=@password
			select u.*,r.Name as RoleName from [User] U join [Role] R on U.RoleId=R.Id where u.id=@l_id
		END		
END

--exec [sp_Login] 'employee','gopi@gmail.com','987654'

--select *from [User] where [Email]='gopi@gmail.com' and [Password]='987654'
GO
/****** Object:  StoredProcedure [dbo].[sp_Menu]    Script Date: 08-05-2025 07:29:45 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_Menu]
(
@action nvarchar(50),
@id bigint,
@userId bigint=null,
@roleId bigint=null,
@dashboard nvarchar(100)=null,
@customer nvarchar(100)=null,
@supplier nvarchar(100)=null,
@user nvarchar(100)=null,
@role nvarchar(100)=null,
@hsncode nvarchar(100)=null,
@category nvarchar(100)=null,
@businessType nvarchar(100)=null,
@menu nvarchar(100)=null,
@theme nvarchar(100)=null,
@language nvarchar(100)=null
)
AS
BEGIN	
	 BEGIN TRY 
	    BEGIN TRANSACTION
			IF(@action='Add')
				BEGIN
					INSERT INTO [Menu]
						VALUES (@userId,@roleId,@dashboard,@customer,@supplier,@user,@role,@hsncode,@category,@businessType,@menu,@theme,@language)
				END
			IF(@action='Update')
	    		BEGIN
					UPDATE [Menu] set	
					  userId = @userId,
					  roleId=@roleId,
					  dashboard=@dashboard,
					  customer=@customer,
					  supplier=@supplier,
					  [user]=@user,
					  [role]=@role,
					  hsncode=@hsncode,
					  category=@category,
					  businessType=@businessType,
					  menu=@menu,
					  theme=@theme,
					  [language]=@language
					  where id = @id;					  
				END
  
		IF @@TRANCOUNT > 0
		BEGIN 
			COMMIT TRANSACTION;
			select M.*,r.Name as RoleName from [Menu] M join [Role] R on M.RoleId=R.Id where m.id=@id
		END
	END TRY 
	BEGIN CATCH
		BEGIN 
			ROLLBACK TRANSACTION;
		END  
	END CATCH
END	

GO
/****** Object:  StoredProcedure [dbo].[sp_MenuById]    Script Date: 08-05-2025 07:29:45 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_MenuById]
(
@action nvarchar(50),
@id bigint
)
AS
BEGIN
		IF(@action='Get')
		BEGIN
			select m.*,r.Name as RoleName from [Menu] M join [Role] R on M.RoleId=R.Id where m.id=@id
		END
		
		IF(@action='Delete')
		    BEGIN
			 DELETE from [Menu] WHERE id = @id;
        END
		
END


GO
/****** Object:  StoredProcedure [dbo].[sp_MenuGet]    Script Date: 08-05-2025 07:29:45 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_MenuGet]
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
		SET @l_SQL = N'select M.*,r.Name as RoleName from [Menu] M join [Role] R on M.RoleId=R.Id ORDER BY ' + QUOTENAME(@orderBy) + ' ' + @sortBy;
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
		 
		 SELECT @response = STRING_AGG(
		   CASE 
		       WHEN [key] = 'roleName' THEN 'R.name like ''%' + [value] + '%'''
		       WHEN [key] = 'isActive' THEN 'M.isActive = ''' + [value] + ''''
		       ELSE 'M.' + [key] + ' like ''%' + [value] + '%'''
		   END,
		   ' AND '
		 )
		FROM OPENJSON(@l_Json)
		set @response=' where '+@response
		end
		SET @l_COUNT =N'select count(*) as count from [Menu] M join [Role] R on M.RoleId=R.Id';
		SET @l_SQL = N'select m.*,r.Name as RoleName from [Menu] M join [Role] R on M.RoleId=R.Id';
	
		EXEC sp_GetFilterJoin @l_COUNT, @l_SQL, @orderBy, @sortBy, @pageNumber, @pageSize, @response;
	END
END	

--exec sp_UserGet @action=N'Filter',@orderBy=N'id',@sortBy=N'asc',@pageNumber=1,@pageSize=10,@filterColumns='name=Gopi,email=gopi@gmail.com,isActive=1,roleName=Admin'
--exec sp_UserGet @action=N'Filter',@orderBy=N'id',@sortBy=N'asc',@pageNumber=1,@pageSize=10,@filterColumns=''
--exec sp_UserGet @action=N'Filter',@orderBy=N'id',@sortBy=N'asc',@pageNumber=1,@pageSize=10,@filterColumns=null

--exec sp_UserGet @action=N'Filter',@orderBy=N'id',@sortBy=N'asc',@pageNumber=1,@pageSize=10,@filterColumns=N'''name'':''g'''

 
GO
/****** Object:  StoredProcedure [dbo].[sp_Product]    Script Date: 08-05-2025 07:29:45 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_Product]
(
@action nvarchar(50),
@UId  uniqueidentifier=null,
@categoryid bigint,
@deviceid bigint,
@name nvarchar(100),
@size nvarchar(20),
@rate decimal(18,2),
@HSNcodeid bigint,
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
					INSERT INTO [Product]
						VALUES (@l_GUID,@categoryid,@deviceid,@name,@size,@rate,@HSNcodeid,@actionby,GETUTCDATE(),@isactive)
				END
			IF(@action='Update')
	    		BEGIN
					SET @l_GUID=@UId;
					UPDATE [Product] set
					  CategoryId=@categoryid,
					  DeviceId=@deviceid,
					  Name = @name,
					  Size=@size,
					  Rate=@rate,
					  HSNCodeId=HSNcodeid,
					  Actionby=@actionby,
					  ActionDate=GETUTCDATE(),
					  Isactive=@isactive
					  where UId = @l_GUID;					  
				END
  
		IF @@TRANCOUNT > 0
		BEGIN 
			COMMIT TRANSACTION;
			Select P.*,C.Name as CategoryName from [Product] P join [Category] C on C.Id=P.CategoryId where UId=@l_GUID
		END
	END TRY 
	BEGIN CATCH
		BEGIN 
			ROLLBACK TRANSACTION;
		END  
	END CATCH
END	

--EXEC [sp_Product] 'Add',null,'gopi',null,'123456','gopi@gmail.com','9876543211',1,1,1
GO
/****** Object:  StoredProcedure [dbo].[sp_ProductById]    Script Date: 08-05-2025 07:29:45 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_ProductById]
(
@action nvarchar(50),
@uid uniqueidentifier,
@isActive bit =null
)
AS
BEGIN
		IF(@action='Get')
		BEGIN
			Select P.*,C.Name as CategoryName from [Product] P join [Category] C on C.Id=P.CategoryId where P.UId=@uid
		END
		
		IF(@action='Delete')
		BEGIN
			Delete from [Product] where UId=@uid
		END
		
		IF(@action='IsActive')
		BEGIN
			Update [Product] set isActive=@isActive  where UId=@uid
			Select P.*,C.Name as CategoryName from [Product] P join [Category] C on C.Id=P.CategoryId where P.UId=@uid
		END
END
GO
/****** Object:  StoredProcedure [dbo].[sp_ProductGet]    Script Date: 08-05-2025 07:29:45 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_ProductGet]
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
		SET @l_SQL = N'Select P.*,C.Name as CategoryName from [Product] P join [Category] C on C.Id=P.CategoryId where P.UId=@uid ORDER BY ' + QUOTENAME(@orderBy) + ' ' + @sortBy;
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
		SELECT @response = STRING_AGG(
		   CASE 
		       WHEN [key] = 'categoryName' THEN 'C.name like ''%' + [value] + '%'''
		       WHEN [key] = 'isActive' THEN 'P.isActive = ''' + [value] + ''''
		       ELSE 'P.' + [key] + ' like ''%' + [value] + '%'''
		   END,
		   ' AND '
		 )
		FROM OPENJSON(@l_Json)
		set @response=' where '+@response
		end
	    SET @l_COUNT =N'select count(*) as count from [Product] P join [Category] C on C.Id=P.CategoryId where P.UId=@uid';
		SET @l_SQL = N'Select P.*,C.Name as CategoryName from [Product] P join [Category] C on C.Id=P.CategoryId where P.UId=@uid';
		EXEC sp_GetFilterJoin @l_COUNT, @l_SQL, @orderBy, @sortBy, @pageNumber, @pageSize, @response;
	END
END	

--exec sp_CustomerGet @action=N'Filter',@orderBy=N'id',@sortBy=N'asc',@pageNumber=1,@pageSize=10,@filterColumns='name=''gopi'' ' 
--exec sp_CustomerGet @action=N'Filter',@orderBy=N'id',@sortBy=N'asc',@pageNumber=1,@pageSize=10,@filterColumns=''
--exec sp_CustomerGet @action=N'Filter',@orderBy=N'id',@sortBy=N'asc',@pageNumber=1,@pageSize=10,@filterColumns=null


--select * from Customer;
GO
/****** Object:  StoredProcedure [dbo].[sp_Reference]    Script Date: 08-05-2025 07:29:45 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[sp_Reference](
@email nvarchar(50)=null,
@mobile nvarchar(20) =null,
@action nvarchar(20)=null,
@Uid uniqueidentifier=null,
@name nvarchar(20) =null,
@roleId bigint=null,
@isActive bit=null
)
AS
BEGIN
IF (@email NOT LIKE '%_@__%.__%')
            BEGIN
              RAISERROR('Invalid email format.', 16, 1);
            RETURN;
            END
		    
  IF (@mobile NOT LIKE '[0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9]')
              BEGIN
                RAISERROR('Invalid mobile number format. It must be exactly 10 digits.', 16, 1);
              RETURN;
        END



    IF (@action = 'Delete')
    BEGIN
        DELETE u
        OUTPUT DELETED.*, r.Name AS RoleName
        FROM [User] u
        JOIN [Role] r ON u.RoleId = r.Id
        WHERE u.UId = @uid;
    END

    ELSE IF (@action = 'Update')
    BEGIN
        UPDATE u
        SET
            u.Name = ISNULL(@name, u.Name),
            u.Email = ISNULL(@email, u.Email),
            u.RoleId = ISNULL(@roleId, u.RoleId)
        OUTPUT INSERTED.*, r.Name AS RoleName
        FROM [User] u
        JOIN [Role] r ON u.RoleId = r.Id
        WHERE u.UId = @uid;
    END

    ELSE IF (@action = 'ToggleActive')
    BEGIN
        UPDATE [User]
        SET IsActive = @isActive
        WHERE UId = @uid;

        SELECT u.*, r.Name AS RoleName
        FROM [User] u
        JOIN [Role] r ON u.RoleId = r.Id
        WHERE u.UId = @uid;
    END
END
GO
/****** Object:  StoredProcedure [dbo].[sp_Role]    Script Date: 08-05-2025 07:29:45 ******/
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
/****** Object:  StoredProcedure [dbo].[sp_RoleById]    Script Date: 08-05-2025 07:29:45 ******/
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
/****** Object:  StoredProcedure [dbo].[sp_RoleGet]    Script Date: 08-05-2025 07:29:45 ******/
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

		SELECT @response = STRING_AGG(
		   CASE 
		       WHEN [key] = 'isActive' THEN 'isActive = ''' + [value] + ''''
		       ELSE [key] + ' like ''%' + [value] + '%'''
		   END,
		   ' AND '
		 )
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
/****** Object:  StoredProcedure [dbo].[sp_RoleValidation]    Script Date: 08-05-2025 07:29:45 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_RoleValidation]
(
@action nvarchar(50),
@uid uniqueidentifier=null,
@name nvarchar(50)=null
)
AS
BEGIN
		IF(@action='Name')
		BEGIN
			select name from [Role] where name=@name and uid = ISNULL(@uid,Uid)
		END		
END
GO
/****** Object:  StoredProcedure [dbo].[sp_Supplier]    Script Date: 08-05-2025 07:29:45 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_Supplier]
(
@action nvarchar(50),
@UId  uniqueidentifier=null,
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
						VALUES (@l_GUID,@typeid,@name,@gst,@landline,@email,@contact,@mobile,@address,@actionby,GETUTCDATE(),@isactive)
				END
			IF(@action='Update')
	    		BEGIN
					SET @l_GUID=@UId;
					UPDATE [Supplier] set
					  TypeId=@typeid,
					  Name = @name,
					  GST=@gst,
					  Landline=@landline,
					  Email=@email,
					  Contact=@contact,
					  Mobile=@mobile,
					  Address=@address,
					  Actionby=@actionby,
					  ActionDate=GETUTCDATE(),
					  Isactive=@isactive
					  where UId = @UId;					  
				END
  
		IF @@TRANCOUNT > 0
		BEGIN 
			COMMIT TRANSACTION;
			select S.*,T.Name as TypeName from [Supplier] S join [BusinessType] T on T.Id=S.TypeId where S.UId=@l_GUID
		END
	END TRY 
	BEGIN CATCH
		BEGIN 
			ROLLBACK TRANSACTION;
		END  
	END CATCH
END
GO
/****** Object:  StoredProcedure [dbo].[sp_SupplierById]    Script Date: 08-05-2025 07:29:45 ******/
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
			select S.*,T.Name as TypeName from [Supplier] S join [BusinessType] T on T.Id=S.TypeId where S.UId=@uid
		END
		
		IF(@action='Delete')
		BEGIN
			Delete from [Supplier] where UId=@uid
		END
		
		IF(@action='IsActive')
		BEGIN
			Update [Supplier] set isActive=@isActive  where UId=@uid
			select S.*,T.Name as TypeName from [Supplier] S join [BusinessType] T on T.Id=S.TypeId where S.UId=@uid
		END
END
GO
/****** Object:  StoredProcedure [dbo].[sp_SupplierGet]    Script Date: 08-05-2025 07:29:45 ******/
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
		SET @l_SQL = N'select S.*,T.Name as TypeName from [Supplier] S join [BusinessType] T on T.Id=S.TypeId ORDER BY ' + QUOTENAME(@orderBy) + ' ' + @sortBy;
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

		SELECT @response = STRING_AGG(
		   CASE 
		       WHEN [key] = 'typeName' THEN 'T.name like ''%' + [value] + '%'''
		       WHEN [key] = 'isActive' THEN 'S.isActive = ''' + [value] + ''''
		       ELSE 'S.' +  [key] + ' like ''%' + [value] + '%'''
		   END,
		   ' AND '
		 )
		FROM OPENJSON(@l_Json)
		set @response=' where '+@response
		end
	    SET @l_COUNT =N'select count(*) as count from [Supplier] S join [BusinessType] T on T.Id=S.TypeId';
		SET @l_SQL = N'select S.*,T.Name as TypeName from [Supplier] S join [BusinessType] T on T.Id=S.TypeId';
		EXEC sp_GetFilterJoin @l_COUNT, @l_SQL, @orderBy, @sortBy, @pageNumber, @pageSize, @response;
	END
END	

--exec sp_SupplierGet @action=N'Filter',@orderBy=N'id',@sortBy=N'asc',@pageNumber=1,@pageSize=10,@filterColumns='name=''pivikart'' '
--exec sp_SupplierGet @action=N'Filter',@orderBy=N'id',@sortBy=N'asc',@pageNumber=1,@pageSize=10,@filterColumns=''
--exec sp_SupplierGet @action=N'Filter',@orderBy=N'id',@sortBy=N'asc',@pageNumber=1,@pageSize=10,@filterColumns=null


GO
/****** Object:  StoredProcedure [dbo].[sp_SupplierValidation]    Script Date: 08-05-2025 07:29:45 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_SupplierValidation]
(
@action nvarchar(50),
@uid uniqueidentifier=null,
@email nvarchar(50)=null,
@mobile nvarchar(20) =null
)
AS
BEGIN
		IF(@action='Email')
		 BEGIN
		    select email from [Supplier] where email=@email and uid = ISNULL(@uid,Uid)
		 END
		
		IF(@action='Mobile')
		BEGIN
		  select mobile from [Supplier] where mobile=@mobile and uid = ISNULL(@uid,Uid)
		END
		
END

GO
/****** Object:  StoredProcedure [dbo].[sp_User]    Script Date: 08-05-2025 07:29:45 ******/
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
						VALUES (@l_GUID,@name,@lastname,'123456',@email,@mobile,@roleid,0,@actionby,GETUTCDATE(),@isactive)
				END
			IF(@action='Update')
	    		BEGIN
					SET @l_GUID=@UId;
					UPDATE [User] set	
					  Name = @name,
					  Lastname=@lastname,
					  Email=@email,
					  Mobile=@mobile,
					  RoleId=@roleid,
					  Actionby=@actionby,
					  ActionDate=GETUTCDATE(),
					  Isactive=@isactive
					  where UId = @l_GUID;					  
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
/****** Object:  StoredProcedure [dbo].[sp_UserById]    Script Date: 08-05-2025 07:29:45 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_UserById]
(
@action nvarchar(50),
@uid uniqueidentifier,
@actionby bigint=null,
@isActive bit =null
)
AS
BEGIN
		IF(@action='Get')
		BEGIN
			select U.*,R.Name as RoleName from [User] U join [Role] R on U.RoleId=R.Id where U.UId=@uid
		END
		
		IF(@action='Delete')
		    BEGIN
			 DELETE from [User] WHERE UId = @uid;
    END
		
		IF(@action='IsActive')  
		BEGIN
			UPDATE [User] SET isActive=@isActive,ActionBy=@actionby,ActionDate=GETUTCDATE() WHERE UId = @uid
			select U.*, R.Name AS RoleName FROM [User] U JOIN [Role] R 	ON U.RoleId = R.Id WHERE U.UId = @uid
		END
END


GO
/****** Object:  StoredProcedure [dbo].[sp_UserGet]    Script Date: 08-05-2025 07:29:45 ******/
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
		 
		 SELECT @response = STRING_AGG(
		   CASE 
		       WHEN [key] = 'roleName' THEN 'R.name like ''%' + [value] + '%'''
		       WHEN [key] = 'isActive' THEN 'U.isActive = ''' + [value] + ''''
		       ELSE 'U.' + [key] + ' like ''%' + [value] + '%'''
		   END,
		   ' AND '
		 )
		FROM OPENJSON(@l_Json)
		set @response=' where '+@response
		end
		SET @l_COUNT =N'select count(*) as count from [User] U join [Role] R on U.RoleId=R.Id';
		SET @l_SQL = N'select u.*,r.Name as RoleName from [User] U join [Role] R on U.RoleId=R.Id';
	
		EXEC sp_GetFilterJoin @l_COUNT, @l_SQL, @orderBy, @sortBy, @pageNumber, @pageSize, @response;
	END
END	

--exec sp_UserGet @action=N'Filter',@orderBy=N'id',@sortBy=N'asc',@pageNumber=1,@pageSize=10,@filterColumns='name=Gopi,email=gopi@gmail.com,isActive=1,roleName=Admin'
--exec sp_UserGet @action=N'Filter',@orderBy=N'id',@sortBy=N'asc',@pageNumber=1,@pageSize=10,@filterColumns=''
--exec sp_UserGet @action=N'Filter',@orderBy=N'id',@sortBy=N'asc',@pageNumber=1,@pageSize=10,@filterColumns=null

--exec sp_UserGet @action=N'Filter',@orderBy=N'id',@sortBy=N'asc',@pageNumber=1,@pageSize=10,@filterColumns=N'''name'':''g'''

 
GO
/****** Object:  StoredProcedure [dbo].[sp_UserValidation]    Script Date: 08-05-2025 07:29:45 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_UserValidation]
(
@action nvarchar(50),
@uid uniqueidentifier=null,
@email nvarchar(50)=null,
@mobile nvarchar(20) =null
)
AS
BEGIN
		IF(@action='Email')
		 BEGIN
		    select email from [User] where email=@email and uid = ISNULL(@uid,Uid)
		 END
		
		IF(@action='Mobile')
		BEGIN
		  select mobile from [User] where mobile=@mobile and uid = ISNULL(@uid,Uid)
		END
		
END

GO
