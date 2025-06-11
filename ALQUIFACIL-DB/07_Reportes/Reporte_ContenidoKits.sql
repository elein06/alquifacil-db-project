CREATE PROCEDURE sp_ObtenerKitHerramientaPorCodigo
    @CodigoKit INT
AS
BEGIN
    SELECT 
        KH.id_KitHerramienta,
        KH.codigo_Kit,
        KH.Id_Herramienta,
        KH.cantidad_Herramientas
    FROM 
        KitHerramienta KH
    WHERE 
        KH.codigo_Kit = @CodigoKit;
END;

EXEC sp_ObtenerKitHerramientaPorCodigo @CodigoKit = 1;
