USE [Bon]
GO
/****** Object:  StoredProcedure [dbo].[sp_User]    Script Date: 26-02-2025 18:33:16 ******/
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
			select *from [User] where UId=@l_GUID
		END
	END TRY 
	BEGIN CATCH
		BEGIN 
			ROLLBACK TRANSACTION;
		END  
	END CATCH
END	
GO
/****** Object:  StoredProcedure [dbo].[sp_UserById]    Script Date: 26-02-2025 18:33:16 ******/
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
	SELECT *from [User] where UId=@uid
END

IF(@action='Delete')
BEGIN
	Delete from [User] where UId=@uid
END

IF(@action='IsActive')
BEGIN
	Update [User] set isActive=@isActive  where UId=@uid
END

END
GO
/****** Object:  StoredProcedure [dbo].[sp_UserGet]    Script Date: 26-02-2025 18:33:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_UserGet]
(
@action NVARCHAR(50),
@orderBy NVARCHAR(100) = 'id',
@sortBy NVARCHAR(4) = 'ASC',
@pageNumber INT=1,
@pageSize INT=10,
@filterColumns NVARCHAR(MAX) =null
)
AS
BEGIN
	DECLARE @l_SQL NVARCHAR(MAX);
	IF(@action='All')
	BEGIN
		SELECT 0 as count from [User]; 
		SET @l_SQL = N'SELECT *from [User] ORDER BY ' + QUOTENAME(@orderBy) + ' ' + @sortBy;
		EXEC sp_executesql @l_SQL
	END
	
	IF(@action='Filter')
	BEGIN	
		DECLARE @l_FilterColumns NVARCHAR(MAX);

		SET @l_FilterColumns = CASE
								WHEN @filterColumns is null THEN null
								ELSE @filterColumns
							  END;
		EXEC sp_GetFilter '[User]', @orderBy, @sortBy, @pageNumber, @pageSize, @l_FilterColumns;
	END
END	
GO
