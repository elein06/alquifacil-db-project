-- Reporte KitsPorTemporada
-- Proyecto ALQUIFÁCIL

USE ALQUIFACIL
GO

CREATE OR ALTER PROCEDURE sp_ReporteKitsPorTemporada
AS
BEGIN
    SELECT 
    kit.codigo_Kit as 'Código del kit',
    kit.nombre AS 'Nombre del kit',
    COUNT(AlquilerKit.codigo_Kit) AS 'Cantidad de kits alquilados'
   FROM
    AlquilerKit
    INNER JOIN kit ON AlquilerKit.codigo_Kit = kit.codigo_Kit
    WHERE
    AlquilerKit.codigo_Kit IS NOT NULL
    GROUP BY
    kit.codigo_Kit, kit.nombre
    ORDER BY
    'Cantidad de kits alquilados' DESC;
    
END
GO

EXEC sp_ReporteKitsPorTemporada;
go