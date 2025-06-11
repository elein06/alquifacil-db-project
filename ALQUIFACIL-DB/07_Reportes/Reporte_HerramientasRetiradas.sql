-- Reporte de  Herramientas Retiradas por daño irreparable
-- Proyecto ALQUIFÁCIL

USE ALQUIFACIL;
GO
CREATE PROCEDURE sp_verHerramientasRetiradas
AS
    SELECT 
        Herramienta.Id_Herramienta as 'ID de la herramienta',
        Herramienta.Numero_Serie as 'Número de serie',
        Herramienta.Anio_Adquisicion as 'Año de adquisición',
        Herramienta.Marca,
        Herramienta.Modelo as 'Herramienta',
        Categoria.Nombre_Categoria as 'Categoria',
        Tipo.nombreTipo AS Tipo,
        Estado.nombreEstado AS Estado,
        CondicionFisica.Nombre_Condicion AS 'Condición'
    FROM Herramienta
    INNER JOIN CondicionFisica ON Herramienta.Id_Condicion_Fisica = CondicionFisica.Id_Condicion_Fisica
    INNER JOIN Estado ON Herramienta.Id_Estado = Estado.id_Estado
    INNER JOIN Tipo ON Herramienta.Id_Tipo = Tipo.id_Tipo
    INNER JOIN Categoria ON Herramienta.Id_Categoria = Categoria.id_Categoria
    WHERE CondicionFisica.Nombre_Condicion = 'Daño irreparable'
    ORDER BY 'Año de adquisición' ASC
GO

EXEC sp_verHerramientasRetiradas;
go