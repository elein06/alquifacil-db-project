-- Reporte de ingresos generados por alquileres menos costos de mantenimiento y reparaciones
-- Proyecto ALQUIFÁCIL

USE ALQUIFACIL;
GO
CREATE OR ALTER PROCEDURE sp_VerReporteRentabilidadHerramientas
    @IdCategoria INT = NULL
AS
BEGIN
    SET NOCOUNT ON;

   
    WITH IngresosAlquiler AS (
        -- Cálculo de ingresos por alquileres
        SELECT 
            ah.Id_Herramienta,
            SUM(a.tarifa_Total_Diaria * ah.cantidadHerramientas) AS Total_Ingresos
        FROM 
            AlquilerHerramienta ah
        JOIN 
            Alquiler a ON ah.num_Contrato = a.num_Contrato
        GROUP BY 
            ah.Id_Herramienta
    ),
    IngresosCargos AS (
        -- Cálculo de ingresos por cargos adicionales (reparaciones y atrasos)
        SELECT 
            dh.Id_Herramienta,
            SUM(d.costo_Reparacion + d.cargos_Por_Dia_Atraso) AS Total_Cargos
        FROM 
            DevolucionHerramienta dh
        JOIN 
            Devolucion d ON dh.Id_Devolucion = d.Id_Devolucion
        GROUP BY 
            dh.Id_Herramienta
    ),
    CostosMantenimiento AS (
        -- Cálculo de costos de mantenimiento
        SELECT 
            m.Id_Herramienta,
            SUM(m.Costo) AS Total_Costos
        FROM 
            Mantenimiento m
        GROUP BY 
            m.Id_Herramienta
    )

    -- Consulta final que combina los resultados
    SELECT 
        h.Id_Herramienta AS 'Id de Herramienta',
        h.Modelo AS 'Modelo',
        e.nombreEstado AS 'Estado',
		cf.Nombre_Condicion AS 'Condición Física',
        
        -- Ingresos por alquileres 
        ISNULL(ia.Total_Ingresos, 0) AS 'Ingresos por Alquiler',
        
        -- Ingresos por cargos adicionales 
        ISNULL(ic.Total_Cargos, 0) AS 'Ingresos por Cargos Adicionales',

        -- Costos de mantenimiento 
        ISNULL(cm.Total_Costos, 0) AS 'Costos de Mantenimiento',
        
        -- Rentabilidad neta 
        (ISNULL(ia.Total_Ingresos, 0) + 
         ISNULL(ic.Total_Cargos, 0) - 
         ISNULL(cm.Total_Costos, 0)) AS 'Rentabilidad Neta'
    FROM 
        Herramienta h
	 LEFT JOIN 
        Estado e ON h.Id_Estado = e.id_Estado
	 LEFT JOIN 
        CondicionFisica cf ON h.Id_Condicion_Fisica = cf.Id_Condicion_Fisica
    LEFT JOIN 
        IngresosAlquiler ia ON h.Id_Herramienta = ia.Id_Herramienta
    LEFT JOIN 
        IngresosCargos ic ON h.Id_Herramienta = ic.Id_Herramienta
    LEFT JOIN 
        CostosMantenimiento cm ON h.Id_Herramienta = cm.Id_Herramienta
    WHERE
        (@IdCategoria IS NULL OR h.Id_Categoria = @IdCategoria)
    ORDER BY 
        'Rentabilidad Neta' DESC;
END;
GO

exec sp_VerReporteRentabilidadHerramientas 