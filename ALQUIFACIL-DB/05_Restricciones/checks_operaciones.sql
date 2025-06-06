-- Checks para filegroup operaciones

-- Tabla Alquiler

-- Numero de contrato mayor a 0
use ALQUIFACIL
go
ALTER TABLE Alquiler
ADD CONSTRAINT CK_Alquiler_Num_Contrato_Positivo
CHECK (num_Contrato > 0);
go

-- Que fecha de devolucion no sea menor a la de inicio
use ALQUIFACIL
go
ALTER TABLE Alquiler
ADD CONSTRAINT CK_Alquiler_Fecha_Dev_Mayor_Inicio
CHECK (fecha_Dev > fecha_Inicio);
go

-- Tarifa debe ser mayor a 0
ALTER TABLE Alquiler
ADD CONSTRAINT CK_Alquiler_Tarifa_Total_Positive
CHECK (tarifa_Total_Diaria > 0);
go

-- Deposito de garantia mayor a 0
ALTER TABLE Alquiler
ADD CONSTRAINT CK_Alquiler_Deposito_Garantia_Positive
CHECK (deposito_Garantia >= 0);
go

-- Estado de contrato solo activo o inactivo
ALTER TABLE Alquiler
ADD CONSTRAINT CK_Alquiler_Estado_Contrato_Valido
CHECK (estado_Contrato IN (0, 1));
go

-- Fecha de inicio actual o mayor a actual
use ALQUIFACIL
go
ALTER TABLE Alquiler
ADD CONSTRAINT CK_Alquiler_Fecha_Inicio_Actual_O_Futura
CHECK (fecha_Inicio >= CAST(GETDATE() AS DATE));
go

-- Fecha de devolucion no mayor a 1 a�o
use ALQUIFACIL
go
ALTER TABLE Alquiler
ADD CONSTRAINT CK_Alquiler_Fecha_Dev_Maximo_1_A�o
CHECK (fecha_Dev <= DATEADD(DAY, 365, fecha_Inicio));
go