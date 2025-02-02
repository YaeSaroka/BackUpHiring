USE [Hiring]
GO
/****** Object:  StoredProcedure [dbo].[InsertarEducacion]    Script Date: 21/8/2024 23:55:55 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER PROCEDURE [dbo].[InsertarEducacion]
	@titulo varchar (max), @nombre_institucion varchar (max), @disciplina_academica varchar(max), @actividades_grupo varchar(max), @descripcion varchar(max), @fecha_expedicion varchar(100), @fecha_caducidad  varchar(100), @id_info_empleado int
AS
BEGIN

	INSERT INTO Educacion (titulo, nombre_institucion, disciplina_academica, actividades_grupo, descripcion, fecha_expedicion, fecha_caducidad, id_info_empleado )
    VALUES (@titulo, @nombre_institucion, @disciplina_academica, @actividades_grupo, @descripcion, @fecha_expedicion, @fecha_caducidad, @id_info_empleado);
end