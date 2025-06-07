USE ALQUIFACIL
GO
ALTER TABLE Devolucion
ADD CONSTRAINT CK_Devolucion_CostoReparacionPositivo
CHECK (costo_Reparacion IS NULL OR costo_Reparacion >= 0);
GO

USE ALQUIFACIL
GO
ALTER TABLE Devolucion
ADD CONSTRAINT CK_Devolucion_CargosAtrasoPositivos
CHECK (cargos_Por_Dia_Atraso IS NULL OR cargos_Por_Dia_Atraso >= 0);
GO
