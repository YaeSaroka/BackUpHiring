USE [Hiring]
GO
/****** Object:  StoredProcedure [dbo].[InsertarMultimedia]    Script Date: 9/8/2024 09:43:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER PROCEDURE [dbo].[InsertarMultimedia]
	@URL varchar(MAX), @Id_Info_Empleado int
AS 
BEGIN
	INSERT INTO Multimedia(url, id_info_empleado)
	VALUES (@URL, @Id_Info_Empleado)
END 
