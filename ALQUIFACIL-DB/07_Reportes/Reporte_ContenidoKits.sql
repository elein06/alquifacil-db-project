--Reporte para ver el contenido de un kit

use ALQUIFACIL
go

CREATE PROCEDURE sp_verKitHerramientaPorCodigo
    @CodigoKit INT
AS
BEGIN
    SELECT 
        KH.id_KitHerramienta,
        KH.codigo_Kit,
        KH.Id_Herramienta,
        KH.cantidad_Herramientas
    FROM 
        dbo.KitHerramienta KH
    WHERE 
        KH.codigo_Kit = @CodigoKit;
END;
GO

EXEC sp_ObtenerKitHerramientaPorCodigo @CodigoKit = 1;
go