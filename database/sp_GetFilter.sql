USE [Bon]
GO
/****** Object:  StoredProcedure [dbo].[sp_GetFilter]    Script Date: 27-02-2025 19:56:02 ******/
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
@filterColumns NVARCHAR(MAX) =null
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


--EXEC sp_GetFilter '[User]', 'id', 'ASC', 1, 10;
GO
