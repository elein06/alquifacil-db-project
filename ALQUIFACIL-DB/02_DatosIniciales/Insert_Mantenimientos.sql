-- Insert Mantenimientos
-- Proyecto ALQUIFÁCIL


-- Insert Persona Responsable
use ALQUIFACIL
go
CREATE PROCEDURE ingresoPersonaResponsable (@_Id_Persona_Responsable int, 
											@_nombre varchar(50), 
											@_apellido1 varchar(50), 
											@_apellido2 varchar(50))
AS
	insert into Persona_Responsable (Id_Persona_Responsable, nombre, apellido1, apellido2)
  							 Values (@_Id_Persona_Responsable, @_nombre, @_apellido1, @_apellido2)
PRINT 'EL REGISTRO SE HA INGRESADO CORRECTAMENTE'
GO

exec ingresoPersonaResponsable '2201','Jose Daniel','Nuñez','Villalobos'
go

exec ingresoPersonaResponsable '2202','Luis Orlando','Baltodano','Espinoza'
go

exec ingresoPersonaResponsable '2203','Axel','Badilla','Fernández'
go

exec ingresoPersonaResponsable '2204','Pablito','Pablero','Poblado'
go

select * from Persona_Responsable
go