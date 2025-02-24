USE [BonGraphics]
GO
/****** Object:  StoredProcedure [dbo].[GetUserById]    Script Date: 24-02-2025 23:10:55 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER PROCEDURE [dbo].[GetUserById]
(
@uid uniqueidentifier
)
AS
BEGIN
	SELECT *from [User] where UId=@uid
END
