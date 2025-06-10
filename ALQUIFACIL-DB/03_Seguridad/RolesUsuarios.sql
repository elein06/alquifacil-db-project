-- RolesUsuarios
-- Proyecto ALQUIFÁCIL


Use master
GO

use ALQUIFACIL
GO

-- Se crean los Login's
CREATE LOGIN adminAlquifacil WITH PASSWORD = 'Admin123!';
go

CREATE LOGIN consultaAlquifacil WITH PASSWORD = 'Consulta123!';
go

CREATE LOGIN insercionAlquifacil WITH PASSWORD = 'Insercion123!';
go


--Se crean los usuarios asociados al login
USE ALQUIFACIL
GO
CREATE USER adminAlquifacil FOR LOGIN adminAlquifacil;
go

CREATE USER consultaAlquifacil FOR LOGIN consultaAlquifacil;
go

CREATE USER insercionAlquifacil FOR LOGIN insercionAlquifacil;
go


--Se crean los roles
Use ALQUIFACIL
go

CREATE ROLE RolAdministrativo;
go

CREATE ROLE RolConsulta;
go

CREATE ROLE RolInsercion;
go


--Se asignan los usuarios a los roles
Use ALQUIFACIL
go

ALTER ROLE RolAdministrativo ADD MEMBER adminAlquifacil;
go

ALTER ROLE RolConsulta ADD MEMBER consultaAlquifacil;
go

ALTER ROLE RolInsercion ADD MEMBER insercionAlquifacil;
go


/*

🗂 Crear Carpeta TriggersSeguridad/ → Archivo Auditoria_Clientes_Alquiler.sql

-- Tabla de auditoría para Cliente
CREATE TABLE Auditoria_Cliente (
    id_auditoria INT IDENTITY PRIMARY KEY,
    id_cliente INT,
    accion VARCHAR(10),
    usuario VARCHAR(100),
    fecha DATETIME DEFAULT GETDATE()
);

-- Trigger INSERT Cliente
CREATE TRIGGER trg_Insert_Cliente
ON Cliente
AFTER INSERT
AS
BEGIN
    INSERT INTO Auditoria_Cliente (id_cliente, accion, usuario)
    SELECT id_cliente, 'INSERT', SYSTEM_USER FROM inserted;
END;

-- Trigger UPDATE Cliente
CREATE TRIGGER trg_Update_Cliente
ON Cliente
AFTER UPDATE
AS
BEGIN
    INSERT INTO Auditoria_Cliente (id_cliente, accion, usuario)
    SELECT id_cliente, 'UPDATE', SYSTEM_USER FROM inserted;
END;

-- Tabla de auditoría para Alquiler
CREATE TABLE Auditoria_Alquiler (
    id_auditoria INT IDENTITY PRIMARY KEY,
    num_contrato INT,
    accion VARCHAR(10),
    usuario VARCHAR(100),
    fecha DATETIME DEFAULT GETDATE()
);

-- Trigger INSERT Alquiler
CREATE TRIGGER trg_Insert_Alquiler
ON Alquiler
AFTER INSERT
AS
BEGIN
    INSERT INTO Auditoria_Alquiler (num_contrato, accion, usuario)
    SELECT num_contrato, 'INSERT', SYSTEM_USER FROM inserted;
END;

-- Trigger DELETE Alquiler
CREATE TRIGGER trg_Delete_Alquiler
ON Alquiler
AFTER DELETE
AS
BEGIN
    INSERT INTO Auditoria_Alquiler (num_contrato, accion, usuario)
    SELECT num_contrato, 'DELETE', SYSTEM_USER FROM deleted;
END;

*/

