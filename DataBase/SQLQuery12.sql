USE [Hiring]
GO
/****** Object:  StoredProcedure [dbo].[ActualizarEducacion]    Script Date: 2/12/2024 00:18:48 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER PROCEDURE [dbo].[ActualizarEducacion]
    @id_empleado INT,
    @titulo NVARCHAR(100),
    @nombre_institucion NVARCHAR(100),
    @disciplina_academica NVARCHAR(100),
    @actividades_grupo NVARCHAR(100),
    @descripcion NVARCHAR(MAX),
    @fecha_expedicion DATE,
    @fecha_caducidad DATE,
    @mes_expedicion NVARCHAR(10),
    @mes_caducidad NVARCHAR(10)
AS
BEGIN
    UPDATE Educacion
    SET 
        titulo = @titulo,
        nombre_institucion = @nombre_institucion,
        disciplina_academica = @disciplina_academica,
        actividades_grupo = @actividades_grupo,
        descripcion = @descripcion,
        fecha_expedicion = @fecha_expedicion,
        fecha_caducidad = @fecha_caducidad,
        mes_expedicion = @mes_expedicion,
        mes_caducidad = @mes_caducidad
    WHERE id_info_empleado = @id_empleado
END
