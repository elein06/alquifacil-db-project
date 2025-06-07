---------------CHECKS Y DEFAULTS PARA TABLAS DEL FILEGROUP CLIENTES

--DEFAULT TABLA CLIENTE

--que guarde como default el cliente como 2= ocasional

USE ALQUIFACIL
GO
ALTER TABLE CLIENTE
ADD CONSTRAINT DF_TipoCliente DEFAULT 2 FOR tipo_cliente;
GO

--------CHECKS TABLA CLIENTE

--validar que el teléfono tenga al menos 8 dígitos, si no está null

USE ALQUIFACIL
GO
ALTER TABLE CLIENTE
ADD CONSTRAINT CK_Cliente_TelefonoValido
CHECK (
    telefono IS NULL OR 
    (LEN(LTRIM(RTRIM(telefono))) >= 8 AND telefono NOT LIKE '%[^0-9]%') --solo numeros
)
GO

--validar que el correo tenga el formato de correo con @ y . si no es null

USE ALQUIFACIL
GO
ALTER TABLE CLIENTE
ADD CONSTRAINT CK_Cliente_CorreoValido
CHECK (
    correo IS NULL OR 
    (correo LIKE '%@%' AND correo LIKE '%.%')
)
GO

--validar que el tipo de cliente sea 1= recurrente 2= ocasional
USE ALQUIFACIL
GO
ALTER TABLE CLIENTE
ADD CONSTRAINT CK_TipoCliente CHECK (tipo_cliente IN (1, 2))
GO

--------CHECKS CLIENTE FISICO

-- Validar que nombre y apellidos no sean nulos
use ALQUIFACIL
go
ALTER TABLE ClienteFisico
ADD CONSTRAINT CK_ClienteFisico_Validar_Nombre
CHECK (LTRIM(RTRIM(nombre)) <> '')
go

use ALQUIFACIL
go
ALTER TABLE ClienteFisico
ADD CONSTRAINT CK_ClienteFisico_Validar_Apellido1
CHECK (LTRIM(RTRIM(apellido1)) <> '')
go

use ALQUIFACIL
go
ALTER TABLE ClienteFisico
ADD CONSTRAINT CK_ClienteFisico_Validar_Apellido2
CHECK (LTRIM(RTRIM(apellido2)) <> '')
go

--validar que la cedula sea solo números y al menos 9 dígitos

USE ALQUIFACIL
GO
ALTER TABLE ClienteFisico
ADD CONSTRAINT CK_ClienteFisico_CedulaNumerica
CHECK (
    LEN(LTRIM(RTRIM(ced_fisica))) >= 9 AND
    ced_fisica NOT LIKE '%[^0-9]%' -- solo números
)
GO


---------CHECKS CLIENTE JURIDICO

-- validar que la cédula jurídica tenga al menos 8 dígitos y contenga solo números

ALTER TABLE ClienteJuridico
ADD CONSTRAINT CK_ClienteJuridico_CedulaNumerica
CHECK (
    LEN(LTRIM(RTRIM(ced_juridica))) >= 8 AND
    ced_juridica NOT LIKE '%[^0-9]%' --solo numeros
)
GO

--validar que la razón social no esté vacía

ALTER TABLE ClienteJuridico
ADD CONSTRAINT CK_ClienteJuridico_RazonSocialValida
CHECK (LTRIM(RTRIM(razon_social)) <> '')
GO