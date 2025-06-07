USE ALQUIFACIL
GO
SELECT
  Id_Herramienta,
  COUNT(Id_Herramienta) AS Cantidad_Mantenimientos
FROM
  Mantenimiento
WHERE
  Id_Herramienta IS NOT NULL
GROUP BY
  Id_Herramienta
ORDER BY
  Cantidad_Mantenimientos DESC;
GO
