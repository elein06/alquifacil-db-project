--Inserts de kits 

use ALQUIFACIL
go
CREATE OR ALTER PROCEDURE sp_IngresarKitConHerramientas
    @_nombre VARCHAR(50),
    @_tarifa_Diaria_Especial MONEY,
    @_id_Categoria INT,
    @_Id_Estado INT,
    @_Id_Herramienta1 INT,
    @_cantidad_Herramientas1 INT,
    @_Id_Herramienta2 INT,
    @_cantidad_Herramientas2 INT,
    @_Id_Herramienta3 INT,
    @_cantidad_Herramientas3 INT
AS
BEGIN
    SET NOCOUNT ON;

    BEGIN TRY
        BEGIN TRANSACTION;

        DECLARE @nuevoIdKit INT;
        DECLARE @stockDisponible INT;
		DECLARE @verificarHerramienta1 INT;
		DECLARE @verificarHerramienta2 INT;
		DECLARE @verificarHerramienta3 INT;
		DECLARE @herramientas TABLE (id INT);

    -- Insertar herramientas recibidas al "array" simulado
		INSERT INTO @herramientas (id)
		VALUES (@_Id_Herramienta1),
			   (@_Id_Herramienta2),
			   (@_Id_Herramienta3);

		IF EXISTS (
		SELECT 1
			FROM @herramientas h
				JOIN Herramienta he ON h.id = he.Id_Herramienta
			WHERE he.Id_Categoria <> @_id_Categoria
		)
		BEGIN
            PRINT 'Las herramientas y el kit deben de tener la misma categoria';
            ROLLBACK TRANSACTION;
			RETURN;
		END

		IF EXISTS (
			SELECT 1
			FROM @herramientas h
				JOIN Herramienta he ON h.id = he.Id_Herramienta
			WHERE he.Id_Estado <> 1
		)
		BEGIN
			PRINT 'Una o m�s herramientas no est�n disponibles.';
			ROLLBACK TRANSACTION;
			RETURN;
		END

		select @verificarHerramienta1 = id_herramienta
		from herramienta
		where @_Id_Herramienta1 = id_herramienta

		select @verificarHerramienta2 = id_herramienta
		from herramienta
		where @_Id_Herramienta2 = id_herramienta

		select @verificarHerramienta3 = id_herramienta
		from herramienta
		where @_Id_Herramienta3 = id_herramienta

		-- Validaciones de herramienta en stock
		IF @verificarHerramienta1 is null
        BEGIN
            PRINT 'La herramienta no 1 existe';
            ROLLBACK TRANSACTION;
            RETURN;
        END

		IF @verificarHerramienta2 is null
        BEGIN
            PRINT 'La herramienta 2 no existe';
            ROLLBACK TRANSACTION;
            RETURN;
        END

		IF @verificarHerramienta3 is null
        BEGIN
            PRINT 'La herramienta 3 no existe';
            ROLLBACK TRANSACTION;
            RETURN;
        END

        -- Validaciones de estado del Kit
        IF @_Id_Estado IN (2, 3, 4)
        BEGIN
            PRINT 'El kit no puede registrarse con este estado.';
            ROLLBACK TRANSACTION;
            RETURN;
        END

        -- Insertar Kit
        INSERT INTO Kit (nombre, tarifa_Diaria_Especial, id_Categoria, Id_Estado)
        VALUES (@_nombre, @_tarifa_Diaria_Especial, @_id_Categoria, @_Id_Estado);

        SET @nuevoIdKit = SCOPE_IDENTITY();

        -- Procedimiento para insertar cada herramienta
        DECLARE @i INT = 1;

        WHILE @i <= 3
        BEGIN
            DECLARE @idHerramienta INT;
            DECLARE @cantidad INT;

            IF @i = 1
            BEGIN
                SET @idHerramienta = @_Id_Herramienta1;
                SET @cantidad = @_cantidad_Herramientas1;
            END
            ELSE IF @i = 2
            BEGIN
                SET @idHerramienta = @_Id_Herramienta2;
                SET @cantidad = @_cantidad_Herramientas2;
            END
            ELSE IF @i = 3
            BEGIN
                SET @idHerramienta = @_Id_Herramienta3;
                SET @cantidad = @_cantidad_Herramientas3;
            END

            -- Verificar stock disponible
            SELECT @stockDisponible = Stock_Herramientas
            FROM Herramienta
            WHERE Id_Herramienta = @idHerramienta;

            IF @cantidad > @stockDisponible
            BEGIN
                PRINT 'No hay suficientes herramientas en inventario para Id: ' + CAST(@idHerramienta AS VARCHAR);
                ROLLBACK TRANSACTION;
                RETURN;
            END

            -- Insertar en KitHerramienta
            INSERT INTO KitHerramienta (codigo_Kit, Id_Herramienta, cantidad_Herramientas)
            VALUES (@nuevoIdKit, @idHerramienta, @cantidad);

            -- Actualizar stock
            UPDATE Herramienta
            SET Stock_Herramientas = Stock_Herramientas - @cantidad
            WHERE Id_Herramienta = @idHerramienta;

            SET @i = @i + 1;
        END

        COMMIT TRANSACTION;
        PRINT 'El kit se ha registrado correctamente.';
    END TRY

    BEGIN CATCH
        ROLLBACK TRANSACTION;
        PRINT 'Error: ' + ERROR_MESSAGE();
    END CATCH
END
GO

SELECT Id_Categoria, nombre_categoria from Categoria
SELECT Id_estado, nombreEstado from Estado
SELECT id_herramienta, modelo, id_estado, id_categoria, stock_herramientas FROM Herramienta

--ingresar kits
EXEC sp_IngresarKitConHerramientas
  @_nombre = 'Kit Hada Jardinera',
  @_tarifa_Diaria_Especial = 25000,
  @_id_Categoria = 2,
  @_Id_Estado = 1,
  @_Id_Herramienta1 = 7, @_cantidad_Herramientas1 = 2,   
  @_Id_Herramienta2 = 11, @_cantidad_Herramientas2 = 10,   
  @_Id_Herramienta3 = 12, @_cantidad_Herramientas3 = 12
GO

EXEC sp_IngresarKitConHerramientas
  @_nombre = 'Kit Bob el Constructor',
  @_tarifa_Diaria_Especial = 25000,
  @_id_Categoria = 1,
  @_Id_Estado = 1,
  @_Id_Herramienta1 = 6, @_cantidad_Herramientas1 = 2,   
  @_Id_Herramienta2 = 16, @_cantidad_Herramientas2 = 1,   
  @_Id_Herramienta3 = 22, @_cantidad_Herramientas3 = 2
GO

EXEC sp_IngresarKitConHerramientas
  @_nombre = 'Kit Pr�ctico de Hogar',
  @_tarifa_Diaria_Especial = 25000,
  @_id_Categoria = 3,
  @_Id_Estado = 1,
  @_Id_Herramienta1 = 8, @_cantidad_Herramientas1 = 2,   
  @_Id_Herramienta2 = 13, @_cantidad_Herramientas2 = 1,   
  @_Id_Herramienta3 = 18, @_cantidad_Herramientas3 = 5
GO

EXEC sp_IngresarKitConHerramientas
  @_nombre = 'SuperKit de Jardineria',
  @_tarifa_Diaria_Especial = 25000,
  @_id_Categoria = 2,
  @_Id_Estado = 1,
  @_Id_Herramienta1 = 17, @_cantidad_Herramientas1 = 1,   
  @_Id_Herramienta2 = 20, @_cantidad_Herramientas2 = 1,   
  @_Id_Herramienta3 = 23, @_cantidad_Herramientas3 = 2
GO