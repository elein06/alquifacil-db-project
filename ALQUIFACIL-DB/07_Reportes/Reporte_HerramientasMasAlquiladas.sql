--Reporte de la cantidad de herramientas alquiladas

USE ALQUIFACIL;
GO
CREATE OR ALTER PROCEDURE sp_VerCantidadAlquiladas
AS
BEGIN
  SELECT
    Id_Herramienta as 'ID de la herramienta',
    COUNT(Id_Herramienta) AS 'Veces alquilada',
    SUM(cantidadHerramientas) AS 'Total de herramientas alquiladas'
  FROM
    AlquilerHerramienta
  WHERE
    Id_Herramienta IS NOT NULL
  GROUP BY
    Id_Herramienta
  ORDER BY
    [Total de herramientas alquiladas] DESC;
END;
GO

EXEC sp_VerCantidadAlquiladas;
go