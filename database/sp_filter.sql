USE [Bon]
GO
/****** Object:  StoredProcedure [dbo].[JSONConversion]    Script Date: 27-04-2025 10:11:14 ******/
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
/****** Object:  StoredProcedure [dbo].[SendSimpleJSONData]    Script Date: 27-04-2025 10:11:14 ******/
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
/****** Object:  StoredProcedure [dbo].[sp_FilterColumns]    Script Date: 27-04-2025 10:11:14 ******/
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
/****** Object:  StoredProcedure [dbo].[sp_GetFilterJoin]    Script Date: 27-04-2025 10:11:14 ******/
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
