USE ALQUIFACIL
GO

CREATE OR ALTER TRIGGER trg_CambiarEstadoHerramientaNoDisponible
ON Herramienta 
AFTER UPDATE
AS
BEGIN
    SET NOCOUNT ON;

    -- Solo cambia a estado 5 si el stock quedó en 0
    -- y el estado NO fue cambiado explícitamente por el UPDATE que disparó el trigger.
    UPDATE H
    SET Id_Estado = 5
    FROM Herramienta H
    INNER JOIN inserted I ON H.Id_Herramienta = I.Id_Herramienta
    INNER JOIN deleted D ON D.Id_Herramienta = I.Id_Herramienta
    WHERE 
        I.Stock_Herramientas = 0
        AND D.Stock_Herramientas <> 0 -- El stock cambió
        AND I.Id_Estado = D.Id_Estado -- El estado no fue modificado en ese UPDATE
        AND H.Id_Estado <> 5; -- Para evitar sobrescribir si ya estaba en 5
END;
GO