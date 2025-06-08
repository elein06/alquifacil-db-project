USE ALQUIFACIL;
GO

CREATE OR ALTER PROCEDURE ObtenerCantidadAlquiladas
AS
BEGIN
  SELECT
    Id_Herramienta,
    COUNT(Id_Herramienta) AS Veces_Alquiladas,
    SUM(cantidadHerramientas) AS Total_Herramientas_Alquiladas
  FROM
    AlquilerHerramienta
  WHERE
    Id_Herramienta IS NOT NULL
  GROUP BY
    Id_Herramienta
  ORDER BY
    Total_Herramientas_Alquiladas DESC;
END;
GO


EXEC ObtenerCantidadAlquiladas;
