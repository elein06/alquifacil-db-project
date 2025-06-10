-- Creación de la base de datos
-- Proyecto ALQUIFÁCIL

USE MASTER
GO
IF EXISTS (SELECT name FROM sys.databases WHERE name = 'ALQUIFACIL')
BEGIN

	-- Forzar desconexión de todos los usuarios y cancelar transacciones
	ALTER DATABASE ALQUIFACIL
	SET SINGLE_USER
	WITH ROLLBACK IMMEDIATE;

	-- Eliminar la base de datos
	DROP DATABASE ALQUIFACIL;
	
END
go


CREATE DATABASE ALQUIFACIL
ON PRIMARY --archivo primario
(
    NAME = 'ALQUIFACIL_Data_Primary',
    FILENAME = 'C:\SQLData\ALQUIFACIL_Data_Primary.mdf',
    SIZE = 20MB,
    MAXSIZE = UNLIMITED,
    FILEGROWTH = 1MB
)
LOG ON --archivo log
(
    NAME = 'ALQUIFACIL_Log',
    FILENAME = 'C:\SQLLog\ALQUIFACIL_Log.ldf',
    SIZE = 512MB,
	MAXSIZE = UNLIMITED,
    FILEGROWTH = 64MB
)
GO

