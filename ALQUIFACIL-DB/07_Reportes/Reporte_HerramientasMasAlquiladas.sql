--Reporte de la cantidad de herramientas alquiladas

USE ALQUIFACIL;
GO
CREATE OR ALTER PROCEDURE sp_VerCantidadAlquiladas
AS
BEGIN
  SELECT
    AlquilerHerramienta.Id_Herramienta as 'ID de la herramienta',
	Herramienta.Modelo as 'Herramienta',
    COUNT(AlquilerHerramienta.id_Herramienta) AS 'Veces alquilada',
    SUM(AlquilerHerramienta.cantidadHerramientas) AS 'Total de herramientas alquiladas'
  FROM
    AlquilerHerramienta inner join Herramienta ON Herramienta.Id_Herramienta = AlquilerHerramienta.id_Herramienta
  WHERE
    AlquilerHerramienta.id_Herramienta IS NOT NULL
  GROUP BY
    AlquilerHerramienta.id_Herramienta,
	Herramienta.Modelo
  ORDER BY
    [Total de herramientas alquiladas] DESC;
END;
GO

EXEC sp_VerCantidadAlquiladas;
go