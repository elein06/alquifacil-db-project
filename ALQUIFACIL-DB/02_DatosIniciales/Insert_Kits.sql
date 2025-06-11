-- Insert Kits
-- Proyecto ALQUIFÁCIL

--Proceso almacenado para agregar un kit con herramientas
use ALQUIFACIL
go

CREATE OR ALTER PROCEDURE sp_IngresarKitConHerramientas

    @_nombre VARCHAR(50),
    @_tarifa_Diaria_Especial MONEY,
    @_id_Categoria INT,
    @_Id_Estado INT,
    @_Id_Herramienta INT,
    @_cantidad_Herramientas INT
AS
BEGIN
    SET NOCOUNT ON;

	BEGIN TRY
        BEGIN TRANSACTION;
			DECLARE @stockDisponible INT;
			DECLARE @estadoHerramienta INT;
			DECLARE @nuevoIdKit INT;

		-- Obtener stock y estado actual 
			SELECT 
				@stockDisponible = Stock_Herramientas
				FROM Herramienta
				where @_Id_Herramienta = Id_Herramienta

			IF @_cantidad_Herramientas > @stockDisponible 
			BEGIN
				PRINT 'No hay suficientes herramientas en inventario';
				ROLLBACK TRANSACTION;
				RETURN;
			END

			   IF @_Id_Estado = 2
			BEGIN
				PRINT 'El kit no puede registrarse como alquilado. No se puede registrar el kit.';
				ROLLBACK TRANSACTION;
				RETURN;
			END

			IF @_Id_Estado = 3
			BEGIN
				PRINT 'El kit no puede registrarse como en mantenimiento. No se puede registrar el kit.';
				ROLLBACK TRANSACTION;
				RETURN;
			END

			IF @_Id_Estado = 4
			BEGIN
				PRINT 'El kit no puede registrarse como dado de baja. No se puede registrar el kit.';
				ROLLBACK TRANSACTION;
				RETURN;
			END

			INSERT INTO Kit (nombre, tarifa_Diaria_Especial, id_Categoria, Id_Estado)
			VALUES(@_nombre, @_tarifa_Diaria_Especial, @_id_Categoria, @_Id_Estado);

			SET @nuevoIdKit = SCOPE_IDENTITY();

			INSERT INTO KitHerramienta (codigo_Kit, Id_Herramienta, cantidad_Herramientas)
			VALUES						(@nuevoIdKit, @_Id_Herramienta, @_cantidad_Herramientas);

			UPDATE Herramienta
			SET Stock_Herramientas = Stock_Herramientas - @_cantidad_Herramientas
			WHERE Id_Herramienta = @_id_Herramienta; 
			COMMIT TRANSACTION;
        PRINT 'El kit se ha registrado correctamente.';
    END TRY

    BEGIN CATCH
        ROLLBACK TRANSACTION;
        PRINT 'Error: ' + ERROR_MESSAGE();
    END CATCH
END
go

exec sp_IngresarKitConHerramientas
  @_nombre = 'Kit de Construccion',
  @_tarifa_Diaria_Especial = 12000,
  @_id_Categoria = 1,
  @_Id_Estado = 1,
  @_Id_Herramienta = 6,
  @_cantidad_Herramientas = 2
 GO

exec sp_IngresarKitConHerramientas
  @_nombre = 'Kit de Abuelas',
  @_tarifa_Diaria_Especial = 22000,
  @_id_Categoria = 2,
  @_Id_Estado = 1,
  @_Id_Herramienta = 11,
  @_cantidad_Herramientas = 10
GO

exec sp_IngresarKitConHerramientas
  @_nombre = 'Kit de Pensionados',
  @_tarifa_Diaria_Especial = 50000,
  @_id_Categoria = 3,
  @_Id_Estado = 1,
  @_Id_Herramienta = 2,
  @_cantidad_Herramientas = 3
GO

select * from KitHerramienta
go
select * from Kit
go
select * from Herramienta
go
select * from Estado
go