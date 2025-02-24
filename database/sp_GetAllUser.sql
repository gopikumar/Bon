USE [BonGraphics]
GO
/****** Object:  StoredProcedure [dbo].[GetAllUser]    Script Date: 24-02-2025 22:58:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[GetAllUser]
AS
BEGIN
	SELECT *from [User]
END
GO
