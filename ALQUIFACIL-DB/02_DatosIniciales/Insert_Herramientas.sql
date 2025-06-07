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
	INSERT INTO Categoria (id_Categoria, nombre_categoria)
	VALUES (@id_Categoria, @nombre_categoria)

	PRINT 'LA CATEGORÍA SE HA REGISTRADO CORRECTAMENTE'
GO

--insertas las 3 categorias

EXEC sp_InsertarCategoria 1, 'Construccion'
GO

EXEC sp_InsertarCategoria 2, 'Jardineria'
GO

EXEC sp_InsertarCategoria 3, 'Hogar'
GO
