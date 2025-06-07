-- Insert Herramientas
-- Proyecto ALQUIFÁCIL


<<<<<<< Updated upstream

=======
--Procedimiento almacenado para agregar Estado

use ALQUIFACIL
go

CREATE PROCEDURE sp_ingresoEstado @_Id_Estado int, @_nombreEstado varchar(50)
AS
	
    -- Validar si ya existe una Tipo con el mismo Id
    IF EXISTS (
        SELECT 1 FROM Estado WHERE id_Estado = @_Id_Estado
		)
    
       PRINT 'Error Ya existe una Estado con ese ID. El registro no se insertó.'
    ELSE
		insert into Estado (id_Estado, nombreEstado)
		values (@_Id_Estado, @_nombreEstado)

		PRINT 'EL ESTADO ACTUAL DE LA HERRAMIENTA SE HA INGRESADO CORRECTAMENTE'
go



--Procedimiento almacenado para agregar Tipo

use ALQUIFACIL
go

CREATE PROCEDURE sp_ingresoTipo @_Id_Tipo int, @_nombreTipo varchar(50)
AS
    -- Validar si ya existe una Tipo con el mismo Id
    IF EXISTS (
        SELECT 1 FROM Tipo WHERE id_Tipo = @_Id_Tipo
		)
    
       PRINT 'Error Ya existe una Tipo con ese ID. El registro no se insertó.'
    ELSE
		insert into Tipo (id_Tipo, nombreTipo)
		values (@_Id_Tipo, @_nombreTipo)

		PRINT 'EL TIPO DE HERRAMIENTA SE HA INGRESADO CORRECTAMENTE'
go


--Procedimiento Almacenado para agregar Herramientas

use ALQUIFACIL
go

CREATE PROCEDURE sp_ingresoHerramienta @_Id_Herramienta int,
										@_Numero_Serie varchar(50),
										@_Anio_Adquisicion int,
										@_Valor_Reposicion money,
										@_Stock_Herramientas int,
										@_Marca varchar(50),
										@_Modelo varchar(50),
										@_Id_Estado int,
										@_Id_Tipo int,
										@_Id_Condicion_Fisica int,
										@_Id_Categoria int
AS
    INSERT INTO Herramienta (Id_Herramienta, Numero_Serie, Anio_Adquisicion, Valor_Reposicion, Stock_Herramientas, Marca, Modelo,
							Id_Estado, Id_Tipo, Id_Condicion_Fisica, Id_Categoria)
	VALUES (@_Id_Herramienta, @_Numero_Serie, @_Anio_Adquisicion, @_Valor_Reposicion, @_Stock_Herramientas, @_Marca, @_Modelo, 
			@_Id_Estado, @_Id_Tipo, @_Id_Condicion_Fisica, @_Id_Categoria)

PRINT 'LA HERRAMIENTA SE HA INGRESADO CORRECTAMENTE'
go
>>>>>>> Stashed changes
