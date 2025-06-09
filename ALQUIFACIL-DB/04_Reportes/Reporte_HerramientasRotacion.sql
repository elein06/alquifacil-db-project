-- Reporte HerramientasRotacion
-- Proyecto ALQUIFÁCIL
USE ALQUIFACIL;
GO

CREATE PROCEDURE ObtenerCantidadDevoluciones
AS
BEGIN
  SELECT
    h.Id_Herramienta,
    COUNT(dh.Id_DevolucionHerramienta) AS Cantidad_Devoluciones,
    SUM(dh.cantidad_Herramientas) AS Total_Herramientas_Devueltas
  FROM
    Herramienta h
  LEFT JOIN
    DevolucionHerramienta dh ON h.Id_Herramienta = dh.Id_Herramienta
  WHERE
    h.Id_Herramienta IS NOT NULL
  GROUP BY
    h.Id_Herramienta
  ORDER BY
    Total_Herramientas_Devueltas DESC;
END;
GO

USE ALQUIFACIL;
GO

CREATE PROCEDURE sp_ReporteRotacionHerramientas
    @FechaInicio DATETIME,
    @FechaFin DATETIME,
    @IdCategoria INT
AS
BEGIN
    SET NOCOUNT ON;

    -- Si no se especifican fechas, usar todo el rango disponible
    IF @FechaInicio IS NULL
        SET @FechaInicio = '2025-07-24';
    
    IF @FechaFin IS NULL
        SET @FechaFin = GETDATE();

    -- Crear tablas temporales para almacenar los resultados de cada procedimiento
    CREATE TABLE #TempAlquiladas (
        Id_Herramienta INT,
        Veces_Alquiladas INT,
        Total_Herramientas_Alquiladas INT
    );

    CREATE TABLE #TempMantenimientos (
        Id_Herramienta INT,
        Cantidad_Mantenimientos INT
    );

    CREATE TABLE #TempDevoluciones (
        Id_Herramienta INT,
        Cantidad_Devoluciones INT,
        Total_Herramientas_Devueltas INT
    );

    -- Insertar datos en las tablas temporales
    INSERT INTO #TempAlquiladas
    EXEC ObtenerCantidadAlquiladas;

    INSERT INTO #TempMantenimientos
    EXEC ObtenerCantidadMantenimientos;

    INSERT INTO #TempDevoluciones
    EXEC ObtenerCantidadDevoluciones;

    -- Consulta final que combina los resultados
    SELECT 
        h.Id_Herramienta,
        h.Marca as 'Marca',
		h.Modelo as 'Modelo',
		h.Numero_Serie as 'Número de Serie',
        t.nombreTipo AS 'Tipo',
        c.nombre_categoria AS 'Categoría',
        e.nombreEstado AS 'Estado Actual',
        cf.Nombre_Condicion AS 'Condición Física',
        h.Stock_Herramientas AS 'Cantidad en stock',
        ISNULL(a.Veces_Alquiladas, 0) AS 'Veces Alquilada',
        ISNULL(m.Cantidad_Mantenimientos, 0) AS 'Cantidad de Mantenimientos',
        ISNULL(d.Cantidad_Devoluciones, 0) AS 'Cantidad de Devoluciones',
        -- Índice de rotación suma de los tres indicadores
        (ISNULL(a.Veces_Alquiladas, 0) + 
         ISNULL(m.Cantidad_Mantenimientos, 0) + 
         ISNULL(d.Cantidad_Devoluciones, 0)) AS 'Índice de Rotación'
    FROM 
        Herramienta h
    LEFT JOIN 
        Estado e ON h.Id_Estado = e.id_Estado
    LEFT JOIN 
        Tipo t ON h.Id_Tipo = t.id_Tipo
    LEFT JOIN 
        Categoria c ON h.Id_Categoria = c.id_Categoria
    LEFT JOIN 
        CondicionFisica cf ON h.Id_Condicion_Fisica = cf.Id_Condicion_Fisica
    LEFT JOIN 
        #TempAlquiladas a ON h.Id_Herramienta = a.Id_Herramienta
    LEFT JOIN 
        #TempMantenimientos m ON h.Id_Herramienta = m.Id_Herramienta
    LEFT JOIN 
        #TempDevoluciones d ON h.Id_Herramienta = d.Id_Herramienta
    WHERE
        (@IdCategoria IS NULL OR h.Id_Categoria = @IdCategoria)
    ORDER BY 
        'Índice de Rotación' DESC;

END;
GO

exec sp_ReporteRotacionHerramientas 
go
drop procedure sp_ReporteRotacionHerramientas