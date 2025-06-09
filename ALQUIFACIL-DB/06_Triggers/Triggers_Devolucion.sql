-- Triggers para filegroup devolucion

-- trigger para cambiar el estado de las herramientas a 'Disponible'
-- una vez que se ha registrado una actualización en su proceso de devolución.

use ALQUIFACIL
go

CREATE TRIGGER trg_AfterUpdateDevolucionHerramienta_UpdateEstadoHerramienta
	ON DevolucionHerramienta 
	AFTER UPDATE
AS
BEGIN
    
    UPDATE Herramienta
    SET Id_Estado = 1		 -- Establece el estado de la herramienta a 'Disponible'
    FROM Herramienta
    INNER JOIN INSERTED AS I ON Herramienta.Id_Herramienta = I.Id_Herramienta
    WHERE Herramienta.Id_Estado = 2; 
END;
go

