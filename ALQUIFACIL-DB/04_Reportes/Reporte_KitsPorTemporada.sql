-- Reporte KitsPorTemporada
-- Proyecto ALQUIFÁCIL

USE ALQUIFACIL
GO

CREATE OR ALTER PROCEDURE ReporteKitsPorTemporada
AS
BEGIN
    SELECT 
    k.codigo_Kit,
    k.nombre AS Nombre_Kit,
    COUNT(ak.codigo_Kit) AS Cantidad_Kits
   FROM
    AlquilerKit ak
    INNER JOIN kit k ON ak.codigo_Kit = k.codigo_Kit
    WHERE
    ak.codigo_Kit IS NOT NULL
    GROUP BY
    k.codigo_Kit, k.nombre
    ORDER BY
    Cantidad_Kits DESC;
    
END
GO

EXEC ReporteKitsPorTemporada;