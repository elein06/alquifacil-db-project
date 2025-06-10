-- Checks para filegroup operaciones

-- Tabla Alquiler

-- Numero de contrato mayor a 0
use ALQUIFACIL
go
ALTER TABLE Alquiler
ADD CONSTRAINT CK_Alquiler_Num_Contrato_Positivo
CHECK (num_Contrato > 0)
go

-- Que fecha de devolucion no sea menor a la de inicio
use ALQUIFACIL
go
ALTER TABLE Alquiler
ADD CONSTRAINT CK_Alquiler_Fecha_Dev_Mayor_Inicio
CHECK (fecha_Dev > fecha_Inicio)
go

-- Tarifa debe ser mayor a 0
ALTER TABLE Alquiler
ADD CONSTRAINT CK_Alquiler_Tarifa_Total_Positive
CHECK (tarifa_Total_Diaria > 0)
go

-- Deposito de garantia mayor a 0
ALTER TABLE Alquiler
ADD CONSTRAINT CK_Alquiler_Deposito_Garantia_Positive
CHECK (deposito_Garantia >= 0)
go

-- Validar que num_Contrato sea un valor valido (positivo)
use ALQUIFACIL
go
ALTER TABLE AlquilerKit
ADD CONSTRAINT CK_Kit_Validar_num_Contrato
CHECK (num_Contrato > 0)
go

-- Estado de contrato solo activo, finalizado o con penalizacion
use ALQUIFACIL
go
ALTER TABLE Alquiler
ADD CONSTRAINT CK_Alquiler_Estado_Contrato_Valido
CHECK (estado_Contrato IN ('Activo', 'Finalizado', 'Con penalizacion'))
go

-- Fecha de inicio actual o mayor a actual
use ALQUIFACIL
go
ALTER TABLE Alquiler
ADD CONSTRAINT CK_Alquiler_Fecha_Inicio_Actual_O_Futura
CHECK (fecha_Inicio >= CAST(GETDATE() AS DATE))
go

-- Fecha de devolucion no mayor a 1 año
use ALQUIFACIL
go
ALTER TABLE Alquiler
ADD CONSTRAINT CK_Alquiler_Fecha_Dev_Maximo_1_Anio
CHECK (fecha_Dev <= DATEADD(DAY, 365, fecha_Inicio))
go

-- Tabla AlquilerHerramienta

-- Cantidad herramientas mayor a 0
use ALQUIFACIL
go
ALTER TABLE AlquilerHerramienta
ADD CONSTRAINT CK_Cantidad_Herramientas
CHECK (cantidadHerramientas > 0)
go

------Checks de la tabla devolucion 
--validar que el costo de reparación no sea negativo 
USE ALQUIFACIL
GO
ALTER TABLE Devolucion
ADD CONSTRAINT CK_Devolucion_CostoReparacionPositivo
CHECK (costo_Reparacion IS NULL OR costo_Reparacion >= 0);
GO

--validar que los cargos por dia de atraso no sean negativos 
USE ALQUIFACIL
GO
ALTER TABLE Devolucion
ADD CONSTRAINT CK_Devolucion_CargosAtrasoPositivos
CHECK (cargos_Por_Dia_Atraso IS NULL OR cargos_Por_Dia_Atraso >= 0);
GO

-- CHECK para validar que la cantidad de herramientas sea mayor a 0 (si no es NULL)
USE ALQUIFACIL
GO
ALTER TABLE DevolucionHerramienta
ADD CONSTRAINT CK_DevolucionHerramienta_CantidadPositiva
CHECK (cantidad_Herramientas IS NULL OR cantidad_Herramientas > 0)
GO
