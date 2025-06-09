-- Triggers para filegroup operaciones


use ALQUIFACIL
go

CREATE OR ALTER TRIGGER trg_CambiarEstadoHerramientaNoDisponible
ON Herramienta 
AFTER UPDATE
AS
BEGIN
    SET NOCOUNT ON;

    UPDATE H
    SET Id_Estado = 5
    FROM Herramienta H
    INNER JOIN inserted I ON H.Id_Herramienta = I.Id_Herramienta
    WHERE I.Stock_Herramientas = 0
      AND H.Id_Estado <> 5; -- Evita update si ya está en 5
END;
GO