USE [Hiring]
GO
/****** Object:  StoredProcedure [dbo].[InsertarInformacionPersonalEmpleado2]    Script Date: 10/7/2024 10:24:33 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER PROCEDURE [dbo].[InsertarInformacionPersonalEmpleado2]
	 @id int, @acerca_de_mi varchar(max), @profesion_actual varchar(max), @ubicacion varchar(max), @foto_perfil varchar(max)
AS
BEGIN
	UPDATE Informacion_Personal_Empleado
	SET acerca_de_mi = @acerca_de_mi , profesion_actual= @profesion_actual ,ubicacion= @ubicacion, foto_perfil= @foto_perfil 
	WHERE id = @id
END
