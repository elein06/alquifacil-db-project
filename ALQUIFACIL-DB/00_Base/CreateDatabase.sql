-- Creación de la base de datos
-- Proyecto ALQUIFÁCIL

USE MASTER 
GO
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