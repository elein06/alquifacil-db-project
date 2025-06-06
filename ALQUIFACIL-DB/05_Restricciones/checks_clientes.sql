--CHECKS TABLAS CLIENTES

--------CHECKS CLIENTE FISICO

-- Validar que nombre y apellidos no sean nulos
use ALQUIFACIL
go
ALTER TABLE ClienteFisico
ADD CONSTRAINT CK_ClienteFisico_Validar_Nombre
CHECK (LTRIM(RTRIM(nombre)) <> '');
go

use ALQUIFACIL
go
ALTER TABLE ClienteFisico
ADD CONSTRAINT CK_ClienteFisico_Validar_Apellido1
CHECK (LTRIM(RTRIM(apellido1)) <> '');
go

use ALQUIFACIL
go
ALTER TABLE ClienteFisico
ADD CONSTRAINT CK_ClienteFisico_Validar_Apellido2
CHECK (LTRIM(RTRIM(apellido2)) <> '');
go

--validar que la cedula sea solo n�meros y al menos 9 d�gitos

USE ALQUIFACIL
GO
ALTER TABLE ClienteFisico
ADD CONSTRAINT CK_ClienteFisico_CedulaNumerica
CHECK (
    LEN(LTRIM(RTRIM(ced_fisica))) >= 9 AND
    ced_fisica NOT LIKE '%[^0-9]%' -- solo n�meros
);
GO

--validar que el tel�fono sea mayor a 8 digitos, si no es null

USE ALQUIFACIL
GO
ALTER TABLE ClienteFisico
ADD CONSTRAINT CK_ClienteFisico_TelefonoValido
CHECK (
    telefono IS NULL OR 
    (LEN(LTRIM(RTRIM(telefono))) >= 8 AND telefono NOT LIKE '%[^0-9]%') --solo numeros
);
GO

--validar que el correo tenga el formato de correo con @ y . si no es null

USE ALQUIFACIL
GO
ALTER TABLE ClienteFisico
ADD CONSTRAINT CK_ClienteFisico_CorreoValido
CHECK (
    correo IS NULL OR 
    (correo LIKE '%@%' AND correo LIKE '%.%')
);
GO

--validar que el tipo de cliente sea unicamente 1= recurrente, 2= ocasional

USE ALQUIFACIL
GO
ALTER TABLE ClienteFisico
ADD CONSTRAINT  CK_ClienteFisico_Tipo CHECK (tipo_cliente IN (1,2)) 
GO


---------CHECKS CLIENTE JURIDICO

-- validar que la c�dula jur�dica tenga al menos 8 d�gitos y contenga solo n�meros

ALTER TABLE ClienteJuridico
ADD CONSTRAINT CK_ClienteJuridico_CedulaNumerica
CHECK (
    LEN(LTRIM(RTRIM(ced_juridica))) >= 8 AND
    ced_juridica NOT LIKE '%[^0-9]%' --solo numeros
);
GO

--validar que la raz�n social no est� vac�a

ALTER TABLE ClienteJuridico
ADD CONSTRAINT CK_ClienteJuridico_RazonSocialValida
CHECK (LTRIM(RTRIM(razon_social)) <> '');
GO

--validar que el tel�fono tenga al menos 8 d�gitos, si no est� null
ALTER TABLE ClienteJuridico
ADD CONSTRAINT CK_ClienteJuridico_TelefonoValido
CHECK (
    telefono IS NULL OR 
    (LEN(LTRIM(RTRIM(telefono))) >= 8 AND telefono NOT LIKE '%[^0-9]%') --solo numeros
);
GO

--validar que el correo tenga un formato b�sico v�lido

ALTER TABLE ClienteJuridico
ADD CONSTRAINT CK_ClienteJuridico_CorreoValido
CHECK (
    correo IS NULL OR 
    (correo LIKE '%@%' AND correo LIKE '%.%')
);
GO

--validar que el tipo de cliente sea unicamente 1= recurrente, 2= ocasional

USE ALQUIFACIL
GO
ALTER TABLE ClienteJuridico
ADD CONSTRAINT CK_ClienteJuridico_Tipo CHECK (tipo_cliente IN (1,2)) 
GO