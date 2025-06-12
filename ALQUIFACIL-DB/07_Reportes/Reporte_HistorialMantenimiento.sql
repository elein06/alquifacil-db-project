--Reporte de Cantidad de mantenimientos que ha tenido la herramienta 

USE ALQUIFACIL
GO
CREATE OR ALTER PROCEDURE sp_VerCantidadMantenimientos
AS
BEGIN
  SELECT
    Herramienta.Id_Herramienta AS 'ID de la herramienta',
    Herramienta.Modelo AS 'Herramienta',
    COUNT(Mantenimiento.Id_Herramienta) AS 'Cantidad de mantenimientos'
  FROM
    Mantenimiento
    INNER JOIN Herramienta ON Mantenimiento.Id_Herramienta = Herramienta.Id_Herramienta
  GROUP BY
    Herramienta.Id_Herramienta, Herramienta.Modelo
  ORDER BY
    'Cantidad de mantenimientos' DESC
END;
GO

EXEC sp_VerCantidadMantenimientos
go