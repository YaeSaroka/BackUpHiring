-- ================================================
-- Template generated from Template Explorer using:
-- Create Procedure (New Menu).SQL
--
-- Use the Specify Values for Template Parameters 
-- command (Ctrl-Shift-M) to fill in the parameter 
-- values below.
--
-- This block of comments will not be included in
-- the definition of the procedure.
-- ================================================
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE ActualizarCUD
	@id_cud INT, @empresa VARCHAR(MAX), @expe DATE, @cadu DATE
AS
BEGIN
	UPDATE Cud
    SET 
        empresa_emisora = @empresa,
		fecha_expedicion = @expe,
		fecha_vencimiento = @cadu
    WHERE id = @id_cud
END
GO
