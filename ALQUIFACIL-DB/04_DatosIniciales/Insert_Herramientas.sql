-- Insert Herramientas
-- Proyecto ALQUIFÁCIL 

--								procedimiento almacenado para insertar categorias

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
		END
GO

--								insertas las 3 categorias

EXEC sp_InsertarCategoria 1, 'Construccion'
GO

EXEC sp_InsertarCategoria 2, 'Jardineria'
GO

EXEC sp_InsertarCategoria 3, 'Hogar'
GO

--								Procedimiento almacenado para agregar Estado

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

--									Ingreso de Estado 

exec sp_ingresoEstado 1, 'Disponible'
go

exec sp_ingresoEstado 2, 'Alquilada'
go 

exec sp_ingresoEstado 3, 'En mantenimiento'
go

exec sp_ingresoEstado 4, 'Dada de baja'
go 

exec sp_ingresoEstado 5, 'No disponible'
go 



--								Procedimiento almacenado para agregar Tipo

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


--								Ingreso de Tipo 

exec sp_ingresoTipo 1, 'Eléctrica'
go

exec sp_ingresoTipo 2, 'Manual'
go 

exec sp_ingresoTipo 3, 'Motorizada'
go




--								Procedimiento almacenado para agregar Condicion Fisica

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

--									Ingreso de Condicion FIsica 

exec sp_ingresoCondicionFisica 1, 'Excelente'
go

exec sp_ingresoCondicionFisica 2, 'Buena'
go 

exec sp_ingresoCondicionFisica 3, 'Regular'
go

exec sp_ingresoCondicionFisica 4, 'Defectuosa'
go 

exec sp_ingresoCondicionFisica 5, 'Daño irreparable'
go 


--									Procedimiento Almacenado para agregar Herramientas

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

--										Creacion de Herraminetas

exec sp_ingresoHerramienta 'BD12', 2021, 45000, 8, 'Thruper', 'Podadora', 2, 1, 1, 2
go

exec sp_ingresoHerramienta 'CD13', 2022, 55000, 12, 'Thruper', 'Aspiradora', 3, 2, 2, 3
go

exec sp_ingresoHerramienta 'MD14', 2012, 10000, 10, 'Patito', 'Tijeras', 2, 2, 2, 1
go

exec sp_ingresoHerramienta 'JK15', 2016, 15000, 9, 'Thruper', 'Taladro', 3, 1, 4, 1
go

exec sp_ingresoHerramienta 'GD16', 2016, 15000, 8, 'Thruper', 'Bomba Fumigadora', 4, 3, 4, 2
go

exec sp_ingresoHerramienta 'AC11', 2020, 25000, 7, 'Patito', 'Martillo', 1, 2, 2, 1
go

-- Herramienta eléctrica de jardinería
exec sp_ingresoHerramienta 'ELJARD001', 2022, 120000, 8, 'Bosch', 'Podadora Eléctrica GX200', 1, 1, 1, 2
go

-- Herramienta manual para hogar
exec sp_ingresoHerramienta 'HOGARMAN02', 2019, 15000, 10, 'Truper', 'Set de Destornilladores', 1, 2, 2, 3
go

-- Herramienta motorizada de construcción (en mantenimiento)
exec sp_ingresoHerramienta 'MOTCON03', 2021, 500000, 6, 'Honda', 'Compactador de Placa HR500', 3, 3, 3, 1
go

-- Herramienta eléctrica de construcción (alquilada)
exec sp_ingresoHerramienta 'ELCON04', 2023, 85000, 4, 'DeWalt', 'Taladro Percutor DCD999', 2, 1, 1, 1
go

-- Herramienta manual de jardinería (buena condición)
exec sp_ingresoHerramienta 'MANJARD05', 2018, 8000, 15, 'Fiskars', 'Tijera de Podar PowerGear', 1, 2, 2, 2
go

-- Herramienta motorizada de jardinería (disponible)
exec sp_ingresoHerramienta 'MOTJARD06', 2024, 250000, 22, 'Stihl', 'Desbrozadora FS 250', 1, 3, 1, 2
go

-- Herramienta eléctrica para hogar (regular)
exec sp_ingresoHerramienta 'ELHOGAR07', 2020, 45000, 4, 'Black+Decker', 'Sierra Caladora KS500', 1, 1, 3, 3
go

-- Herramienta manual de construcción (dada de baja)
exec sp_ingresoHerramienta 'MANCON08', 2017, 10000, 0, 'Bellota', 'Nivel de Burbuja 60cm', 4, 2, 5, 1
go

-- Herramienta eléctrica de jardinería (en mantenimiento)
exec sp_ingresoHerramienta 'ELJARD09', 2021, 95000, 2, 'Greenworks', 'Soplador de Hojas G-MAX 40V', 3, 1, 3, 2
go

-- Construcción, eléctrica, excelente
exec sp_ingresoHerramienta 'CONEL01', 2023, 110000, 5, 'Makita', 'Rotomartillo HR2475', 1, 1, 1, 1
go

-- Jardinería, motorizada, buena
exec sp_ingresoHerramienta 'JARMOT02', 2022, 210000, 4, 'Husqvarna', 'Cortacésped LC 151', 1, 3, 2, 2
go

-- Hogar, manual, regular
exec sp_ingresoHerramienta 'HOGMAN03', 2019, 7000, 15, 'Stanley', 'Cinta Métrica 8m', 1, 2, 3, 3
go

-- Construcción, motorizada, defectuosa
exec sp_ingresoHerramienta 'CONMOT04', 2020, 420000, 1, 'Wacker Neuson', 'Apisonador BS60-4', 3, 3, 4, 1
go

-- Jardinería, eléctrica, excelente
exec sp_ingresoHerramienta 'JAREL05', 2024, 125000, 2, 'Ryobi', 'Cortasetos RHT36C60R15', 1, 1, 1, 2
go

-- Hogar, eléctrica, buena
exec sp_ingresoHerramienta 'HOGEL06', 2021, 52000, 6, 'Bosch', 'Lijadora GSS 23 AE', 1, 1, 2, 3
go

-- Construcción, manual, buena
exec sp_ingresoHerramienta 'CONMAN07', 2018, 18000, 7, 'Tramontina', 'Pala cuadrada reforzada', 1, 2, 2, 1
go

-- Jardinería, manual, regular
exec sp_ingresoHerramienta 'JARMAN08', 2017, 9500, 10, 'Bellota', 'Rastrillo metálico', 1, 2, 3, 2
go

-- Hogar, motorizada, defectuosa
exec sp_ingresoHerramienta 'HOGMOT09', 2022, 160000, 1, 'Einhell', 'Mini compresor TH-AC 190', 3, 3, 4, 3
go

-- Construcción, eléctrica, daño irreparable
exec sp_ingresoHerramienta 'CONEL10', 2015, 78000, 0, 'Black+Decker', 'Sierra circular CS1004', 4, 1, 5, 1
go

exec sp_ingresoHerramienta 'MQSLD06', 2016, 175000, 2, 'Thruper', 'Maquina para soldar', 4, 2, 5, 1
go