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



-- Procedimiento almacenado para agregar Mantenimientos
use ALQUIFACIL
go
CREATE PROCEDURE sp_ingresoMantenimiento (
										  @_Costo money,
										  @_Fecha_Mantenimiento datetime,
										  @_Modalidad_Servicio varchar(50),
										  @_Observaciones varchar(256),
										  @_Id_Tipo_Mantenimiento int,
										  @_Id_Persona_Responsable int,
										  @_Id_Herramienta int)
AS
	insert into Mantenimiento	(
								 Costo,
								 Fecha_Mantenimiento,
								 Modalidad_Servicio,
								 Observaciones,
								 Id_Tipo_Mantenimiento,
								 Id_Persona_Responsable,
								 Id_Herramienta)

  						Values  (
								 @_Costo,
								 @_Fecha_Mantenimiento,
						   	     @_Modalidad_Servicio,
								 @_Observaciones,
								 @_Id_Tipo_Mantenimiento,
								 @_Id_Persona_Responsable,
								 @_Id_Herramienta
								)

PRINT 'SE HA INGRESADO CORRECTAMENTE UN NUEVO MANTENIMIENTO'
GO



-- Insert Mantenimientos

								  --AAAA-DD-MM
exec sp_ingresoMantenimiento 20000, '2024-07-01', 'Interno', 'Lubricación completa y limpieza.', 1, 2202, 1;
go

exec sp_ingresoMantenimiento 20000, '2024-04-10', 'Interno', 'Lubricación completa y limpieza', 1, 2201, 2;
go

exec sp_ingresoMantenimiento 12500, '2024-03-10', 'Externo', 'Reemplazo de cuchillas oxidadas', 2, 2203, 2
go

exec sp_ingresoMantenimiento 7000, '2024-05-12', 'Interno', 'Cambio de escobillas', 1, 2201, 5
go

exec sp_ingresoMantenimiento 28000, '2024-06-04', 'Externo', 'Cambio de aceite y ajuste del carburador', 2, 2202, 6
go

exec sp_ingresoMantenimiento 40000, '2024-01-16', 'Externo', 'Verificación de presión y limpieza', 2, 2202, 5;
go

exec sp_ingresoMantenimiento 40000, '2024-01-16', 'Interno', 'Lubricación de motor', 2, 2202, 3;
go

exec sp_ingresoMantenimiento 10000, '2024-06-19', 'Interno', 'Afilado de hojas', 2, 2204, 4;
go

select * from Mantenimiento
go
