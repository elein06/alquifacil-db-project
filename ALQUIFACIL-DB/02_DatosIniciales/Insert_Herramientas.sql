-- Insert Herramientas
-- Proyecto ALQUIFÁCIL


--procedimiento almacenado para insertar categorias

USE ALQUIFACIL
GO
CREATE PROCEDURE sp_InsertarCategoria (
	@id_Categoria INT,
	@nombre_categoria VARCHAR(50)
)
AS
	-- Validar si ya existe una Categoria con el mismo Id
		IF EXISTS (SELECT 1 FROM Categoria WHERE id_Categoria = @id_Categoria)
		begin
			  PRINT 'Error Ya existe una Categoria con ese ID. El registro no se insertó.'
		end

		ELSE
		begin
				INSERT INTO Categoria (id_Categoria, nombre_categoria)
				VALUES (@id_Categoria, @nombre_categoria)

				PRINT 'LA CATEGORÍA SE HA REGISTRADO CORRECTAMENTE'
		end
GO

--insertas las 3 categorias

EXEC sp_InsertarCategoria 1, 'Construccion'
GO

EXEC sp_InsertarCategoria 2, 'Jardineria'
GO

EXEC sp_InsertarCategoria 3, 'Hogar'
GO

--Procedimiento almacenado para agregar Estado

use ALQUIFACIL
go

CREATE PROCEDURE sp_ingresoEstado @_Id_Estado int, @_nombreEstado varchar(50)
AS
begin
	
	-- Validar si ya existe un Estado con el mismo Id
	IF EXISTS (SELECT 1 FROM Estado WHERE id_Estado = @_Id_Estado)
	begin
		PRINT 'Error Ya existe un Estado con ese ID. El registro no se insertó.'
	end

	ELSE
	begin
		insert into Estado (id_Estado, nombreEstado)
		values (@_Id_Estado, @_nombreEstado)

		PRINT 'EL ESTADO ACTUAL DE LA HERRAMIENTA SE HA INGRESADO CORRECTAMENTE'
	end
end
go

--Ingreso de Estado 

exec sp_ingresoEstado 1, 'Disponible'
go

exec sp_ingresoEstado 2, 'Alquilada'
go 

exec sp_ingresoEstado 3, 'En mantenimiento'
go

exec sp_ingresoEstado 4, 'Dada de baja'
go 

--Procedimiento almacenado para agregar Tipo

use ALQUIFACIL
go

CREATE PROCEDURE sp_ingresoTipo @_Id_Tipo int, @_nombreTipo varchar(50)
AS
	begin
		-- Validar si ya existe un Tipo con el mismo Id
		IF EXISTS (SELECT 1 FROM Tipo WHERE id_Tipo = @_Id_Tipo)
		begin
			  PRINT 'Error Ya existe un Tipo con ese ID. El registro no se insertó.'
		end

		ELSE
		begin
				insert into Tipo (id_Tipo, nombreTipo)
				values (@_Id_Tipo, @_nombreTipo)

				PRINT 'EL TIPO DE HERRAMIENTA SE HA INGRESADO CORRECTAMENTE'
		end
	end
go


--Ingreso de Tipo 

exec sp_ingresoTipo 1, 'Eléctrica'
go

exec sp_ingresoTipo 2, 'Manual'
go 

exec sp_ingresoTipo 3, 'Motorizada'
go



--Procedimiento almacenado para agregar Condicion Fisica

use ALQUIFACIL
go

CREATE PROCEDURE sp_ingresoCondicionFisica @_Id_CondicionF int, @_nombreCondicion varchar(50)
AS
begin
    -- Validar si ya existe una Condicion Física de la HERRAMIENTA con el mismo Id
    IF EXISTS (SELECT 1 FROM CondicionFisica WHERE Id_Condicion_Fisica = @_Id_CondicionF)
    begin
       PRINT 'Error Ya existe una Condicion FIsica con ese ID. El registro no se insertó.'
	end

    ELSE
	begin
		insert into CondicionFisica(Id_Condicion_Fisica, Nombre_Condicion)
		values (@_Id_CondicionF, @_nombreCondicion)

		PRINT 'LA CONDICION FISICA DE DE HERRAMIENTA SE HA INGRESADO CORRECTAMENTE'
	end
end
go

--Ingreso de Condicion FIsica 

exec sp_ingresoCondicionFisica 1, 'Excelente'
go

exec sp_ingresoCondicionFisica 2, 'Buena'
go 

exec sp_ingresoCondicionFisica 3, 'Regular'
go

exec sp_ingresoCondicionFisica 4, 'Defectuosa'
go 



--Procedimiento Almacenado para agregar Herramientas

use ALQUIFACIL
go
CREATE PROCEDURE sp_ingresoHerramienta (
										@_Numero_Serie varchar(50),
										@_Anio_Adquisicion int,
										@_Valor_Reposicion money,
										@_Stock_Herramientas int,
										@_Marca varchar(50),
										@_Modelo varchar(50),
										@_Id_Estado int,
										@_Id_Tipo int,
										@_Id_Condicion_Fisica int,
										@_Id_Categoria int)
AS
    INSERT INTO Herramienta (Numero_Serie, Anio_Adquisicion, Valor_Reposicion, Stock_Herramientas, Marca, Modelo,
							Id_Estado, Id_Tipo, Id_Condicion_Fisica, Id_Categoria)
	VALUES (@_Numero_Serie, @_Anio_Adquisicion, @_Valor_Reposicion, @_Stock_Herramientas, @_Marca, @_Modelo, 
			@_Id_Estado, @_Id_Tipo, @_Id_Condicion_Fisica, @_Id_Categoria)

PRINT 'LA HERRAMIENTA SE HA INGRESADO CORRECTAMENTE'
go

--Creacion de Herraminetas

exec sp_ingresoHerramienta 'AC11', 2020, 25000, 5, 'Patito', 'Martillo', 1, 2, 2, 1
go

exec sp_ingresoHerramienta 'BD12', 2021, 45000, 3, 'Thruper', 'Podadora', 2, 1, 1, 2
go

exec sp_ingresoHerramienta 'CD13', 2022, 55000, 6, 'Thruper', 'Aspiradora', 3, 2, 2, 3
go

exec sp_ingresoHerramienta 'MD14', 2012, 10000, 4, 'Patito', 'Tijeras', 2, 2, 2, 1
go

exec sp_ingresoHerramienta 'JK15', 2016, 15000, 6, 'Thruper', 'Taladro', 3, 1, 4, 1
go

exec sp_ingresoHerramienta 'GD16', 2016, 15000, 6, 'Thruper', 'Bonba Fumigadora', 4, 3, 4, 2
go


select * from Categoria
Select * from Estado
Select * from Tipo
select * from CondicionFisica
Select * from Herramienta