-- Insert Mantenimientos
-- Proyecto ALQUIFÁCIL


-- Insert Persona Responsable
use ALQUIFACIL
go
CREATE PROCEDURE sp_ingresoPersonaResponsable (@_Id_Persona_Responsable int, 
											@_nombre varchar(50), 
											@_apellido1 varchar(50), 
											@_apellido2 varchar(50))
AS
	insert into Persona_Responsable (Id_Persona_Responsable, nombre, apellido1, apellido2)
  							 Values (@_Id_Persona_Responsable, @_nombre, @_apellido1, @_apellido2)
PRINT 'EL REGISTRO SE HA INGRESADO CORRECTAMENTE'
GO

exec sp_ingresoPersonaResponsable '2201','Jose Daniel','Nuñez','Villalobos'
go

exec sp_ingresoPersonaResponsable '2202','Luis Orlando','Baltodano','Espinoza'
go

exec sp_ingresoPersonaResponsable '2203','Axel','Badilla','Fernández'
go

exec sp_ingresoPersonaResponsable '2204','Pablito','Pablero','Poblado'
go

select * from Persona_Responsable
go

----procedimiento almacenado para ingresar los tipos de mantenimiento

USE ALQUIFACIL
GO
CREATE PROCEDURE sp_InsertarTipoMantenimiento (
	@Id_Tipo_Mantenimiento INT,
	@nombre_tipo_mantenimiento VARCHAR(50)
)
AS
	INSERT INTO tipo_mantenimiento (Id_Tipo_Mantenimiento, nombre_tipo_mantenimiento)
	VALUES (@Id_Tipo_Mantenimiento, @nombre_tipo_mantenimiento);

	PRINT 'TIPO DE MANTENIMIENTO REGISTRADO CORRECTAMENTE';
GO


--insertar los 2 tipos de mantenimiento

EXEC sp_InsertarTipoMantenimiento 1, 'Preventivo'
GO

EXEC sp_InsertarTipoMantenimiento 2, 'Correctivo'
GO

select * from tipo_mantenimiento
go