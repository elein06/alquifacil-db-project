-- RolesUsuarios
-- Proyecto ALQUIFÁCIL


Use master
GO

use ALQUIFACIL
GO

-- Se crean los Logins
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

