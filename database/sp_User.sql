USE [Bon]
GO

/****** Object:  StoredProcedure [dbo].[sp_UserById]    Script Date: 25-02-2025 23:53:47 ******/
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
/****** Object:  StoredProcedure [dbo].[sp_UserGet]    Script Date: 25-02-2025 23:53:47 ******/
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
@filterColumn NVARCHAR(MAX) =null
)
AS
BEGIN
	DECLARE @l_SQL NVARCHAR(MAX);
	IF(@action='All')
	BEGIN
		SET @l_SQL = N'SELECT *from [User] ORDER BY ' + QUOTENAME(@orderBy) + ' ' + @sortBy;
		EXEC sp_executesql @l_SQL
	END
	
	IF(@action='Filter')
	BEGIN	
		DECLARE @l_FilterColumn NVARCHAR(MAX);

		SET @l_FilterColumn = CASE
								WHEN @filterColumn is null THEN null
								ELSE @filterColumn
							  END;
		EXEC sp_GetFilter '[User]', @orderBy, @sortBy, @pageNumber, @pageSize, @l_FilterColumn;
	END
END	
GO
