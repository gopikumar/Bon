CREATE PROCEDURE [dbo].[sp_GetFilter]
(
@tableName NVARCHAR(100),
@orderBy NVARCHAR(100),
@sortBy NVARCHAR(4),
@pageNumber INT,
@pageSize INT,
@filterColumn NVARCHAR(MAX) =null
)
AS
BEGIN

	DECLARE @l_SQL NVARCHAR(MAX);
	DECLARE @l_FilterColumn NVARCHAR(MAX);

	SET @l_FilterColumn = CASE
							WHEN @filterColumn is null THEN ''
							ELSE ' where '+ @filterColumn
						  END;
						  
	SET @l_SQL = N'SELECT * FROM '+@tableName + @l_FilterColumn + ' ORDER BY ' + QUOTENAME(@orderBy) + ' ' + @sortBy + '  
					OFFSET (@pageNumber - 1) * @pageSize ROWS
					FETCH NEXT @pageSize ROWS ONLY';

	EXEC sp_executesql @l_SQL, N'@pageNumber INT, @pageSize INT', @pageNumber, @pageSize;
END


--EXEC sp_GetFilter '[User]', 'id', 'ASC', 1, 10;
GO