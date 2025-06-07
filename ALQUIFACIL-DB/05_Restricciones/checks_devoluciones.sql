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

USE ALQUIFACIL
GO

-- CHECK para validar que la cantidad de herramientas sea mayor a 0 (si no es NULL)
ALTER TABLE DevolucionHerramienta
ADD CONSTRAINT CK_DevolucionHerramienta_CantidadPositiva
CHECK (cantidad_Herramientas IS NULL OR cantidad_Herramientas > 0)
GO
