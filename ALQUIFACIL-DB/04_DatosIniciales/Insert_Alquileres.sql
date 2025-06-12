-- Insert Alquileres 
-- Proyecto ALQUIFÁCIL

-- Proceso almacenado para agregar Alquiler de una Herramienta
USE ALQUIFACIL;
GO

CREATE OR ALTER PROCEDURE sp_RegistrarAlquileresConHerramientas
    @_fecha_Inicio DATE,
    @_fecha_Dev DATE,
    @_tarifa_Total_Diaria MONEY,
    @_deposito_Garantia MONEY,
	@_costo_alquiler money,
    @_estado_Contrato VARCHAR(50),
    @_Id_cliente INT,
    @_id_Herramienta INT,
    @_cantidadHerramientas INT
AS
BEGIN
    SET NOCOUNT ON;

	BEGIN TRY
        BEGIN TRANSACTION;

			DECLARE @stockDisponible INT;
			DECLARE @estadoHerramienta INT;
			DECLARE @nuevoIdAlquiler INT;
			DECLARE @nuevoIdCliente INT;

			-- Obtener stock y estado actual
			SELECT 
				@stockDisponible = Stock_Herramientas,
				@estadoHerramienta = Id_Estado
			FROM Herramienta
			WHERE Id_Herramienta = @_id_Herramienta;
	
			select @nuevoIdCliente = id_Cliente
			from CLIENTE 
			where id_Cliente = @_Id_cliente 

			IF @nuevoIdCliente IS NULL
			BEGIN
				PRINT 'Ese cliente no existe.';
				ROLLBACK TRANSACTION;
				RETURN;
			END

			IF @stockDisponible IS NULL
			BEGIN
				PRINT 'Herramienta no existe.';
				ROLLBACK TRANSACTION;
				RETURN;
			END

			IF @estadoHerramienta != 1
			begin
				print 'Esa herramienta no disponible.';
				ROLLBACK TRANSACTION;
				return;
			end

			IF @_cantidadHerramientas > @stockDisponible
			BEGIN
				PRINT 'No hay suficientes unidades disponibles para alquilar.';
				ROLLBACK TRANSACTION;
				RETURN;
			END

			-- Insertar contrato de alquiler
			INSERT INTO Alquiler(fecha_Inicio, fecha_Dev, tarifa_Total_Diaria, deposito_Garantia, costo_alquiler, estado_Contrato, Id_cliente)
			VALUES (@_fecha_Inicio, @_fecha_Dev, @_tarifa_Total_Diaria, @_deposito_Garantia, @_costo_alquiler, @_estado_Contrato, @_Id_cliente);

			SET @nuevoIdAlquiler = SCOPE_IDENTITY();

			-- Insertar detalle de alquiler
			INSERT INTO AlquilerHerramienta(Id_Herramienta, num_Contrato, cantidadHerramientas)
			VALUES (@_id_Herramienta, @nuevoIdAlquiler, @_cantidadHerramientas);

			-- Actualizar el stock
			UPDATE Herramienta
			SET Stock_Herramientas = Stock_Herramientas - @_cantidadHerramientas
			WHERE Id_Herramienta = @_id_Herramienta;

    -- Si ya no queda stock, actualizar estado a No Disponible (2)
		COMMIT TRANSACTION;
		PRINT 'Alquiler registrado correctamente.';
    END TRY

    BEGIN CATCH
        ROLLBACK TRANSACTION;
        PRINT 'Error: ' + ERROR_MESSAGE();
    END CATCH
END;
GO


SELECT id_cliente, tipo_cliente from CLIENTE
SELECT id_herramienta, modelo, id_estado, stock_herramientas from Herramienta

-- Ingreso de alquiler de herramienta

	exec sp_RegistrarAlquileresConHerramientas
    @_fecha_Inicio = '2025-08-11',
    @_fecha_Dev = '2025-09-23',
    @_tarifa_Total_Diaria = 7500,
    @_deposito_Garantia = 15000,
	@_costo_alquiler = 15000,
    @_estado_Contrato = 'Activo',
    @_Id_cliente = 1,
    @_id_Herramienta = 8,
    @_cantidadHerramientas = 5
    go
    
exec sp_RegistrarAlquileresConHerramientas
    @_fecha_Inicio = '2025-10-04',
    @_fecha_Dev = '2025-11-16',
    @_tarifa_Total_Diaria = 20000,
    @_deposito_Garantia = 5000,
	@_costo_alquiler = 15000,
    @_estado_Contrato = 'Activo',
    @_Id_cliente = 18,
	@_id_Herramienta = 16,
	@_cantidadHerramientas = 3
  go

exec sp_RegistrarAlquileresConHerramientas
    @_fecha_Inicio = '2025-06-13',
    @_fecha_Dev = '2025-06-20',
    @_tarifa_Total_Diaria = 15000,
    @_deposito_Garantia = 10000,
    @_costo_alquiler = 150000,
    @_estado_Contrato = 'activo',
    @_Id_cliente = 1,
    @_id_Herramienta = 11,
    @_cantidadHerramientas = 3
go

exec sp_RegistrarAlquileresConHerramientas
    @_fecha_Inicio = '2025-06-08',			-- Check para fecha actual
    @_fecha_Dev = '2025-07-08',
    @_tarifa_Total_Diaria = 30000,
    @_deposito_Garantia = 12000,
    @_costo_alquiler = 900000,
    @_estado_Contrato = 'activo',
    @_Id_cliente = 8,
    @_id_Herramienta = 12,
    @_cantidadHerramientas = 5
go

exec sp_RegistrarAlquileresConHerramientas
    @_fecha_Inicio = '2025-06-14',
    @_fecha_Dev = '2025-06-30',
    @_tarifa_Total_Diaria = 10000,
    @_deposito_Garantia = 8000,
    @_costo_alquiler = 240000,
    @_estado_Contrato = 'finalizado',
    @_Id_cliente = 2,
    @_id_Herramienta = 6,
    @_cantidadHerramientas = 3
go

exec sp_RegistrarAlquileresConHerramientas
    @_fecha_Inicio = '2025-06-13',
    @_fecha_Dev = '2025-06-15',
    @_tarifa_Total_Diaria = 25000,
    @_deposito_Garantia = 10000,
    @_costo_alquiler = 250000,
    @_estado_Contrato = 'activo',
    @_Id_cliente = 15,
    @_id_Herramienta = 7,
    @_cantidadHerramientas = 3
go

exec sp_RegistrarAlquileresConHerramientas
    @_fecha_Inicio = '2025-06-16',
    @_fecha_Dev = '2025-06-25',
    @_tarifa_Total_Diaria = 18000,
    @_deposito_Garantia = 5000,
    @_costo_alquiler = 252000,
    @_estado_Contrato = 'finalizado',
	@_Id_cliente = 10,
    @_id_Herramienta = 8,
    @_cantidadHerramientas = 3
go

exec sp_RegistrarAlquileresConHerramientas
    @_fecha_Inicio = '2025-06-12',
    @_fecha_Dev = '2025-07-12',
    @_tarifa_Total_Diaria = 40000,
    @_deposito_Garantia = 15000,
    @_costo_alquiler = 1200000,
    @_estado_Contrato = 'activo',
    @_Id_cliente = 16,
    @_id_Herramienta = 23,
    @_cantidadHerramientas = 2
go


-- Proceso almacenado para agregar un Alquiler de un Kit
use ALQUIFACIL
go
create or alter procedure sp_RegistrarAlquileresConKits
	-- Alquiler
    @_fecha_Inicio date,
    @_fecha_Dev date,
    @_tarifa_Total_Diaria money,
    @_deposito_Garantia money,
	@_costo_alquiler money,
    @_estado_Contrato varchar(50),
    @_Id_cliente int,
	-- kit
	@_codigo_Kit int
as
begin
    set nocount on;

	BEGIN TRY
        BEGIN TRANSACTION;
			declare @estadoKit int;
			declare @nuevoIdAlquiler int;
			DECLARE @nuevoIdCliente INT;


			select @estadoKit = Id_Estado
			from Kit
			where codigo_Kit = @_codigo_Kit;


			select @nuevoIdCliente = id_Cliente
			from CLIENTE 
			where id_Cliente = @_Id_cliente 

	
			IF @nuevoIdCliente IS NULL
			BEGIN
				PRINT 'Ese cliente no existe.';
				ROLLBACK TRANSACTION;
				RETURN;
			END

			if @estadoKit is null
			begin
				print 'El kit no existe.';
				ROLLBACK TRANSACTION;
				return;
			end

			if @estadoKit != 1
			begin
				print 'El kit no está disponible.';
				ROLLBACK TRANSACTION;
				return;
			end


			-- Insertar el alquiler (ID autogenerado)
			insert into Alquiler(fecha_Inicio, fecha_Dev, tarifa_Total_Diaria, deposito_Garantia, costo_alquiler, estado_Contrato, Id_cliente)
			values (@_fecha_Inicio, @_fecha_Dev, @_tarifa_Total_Diaria, @_deposito_Garantia, @_costo_alquiler, @_estado_Contrato, @_Id_cliente);

			-- Obtener el nuevo ID de alquiler
			set @nuevoIdAlquiler = SCOPE_IDENTITY();

			-- Insertar en la tabla intermedia (Sin ID autogenerado)
			insert into AlquilerKit(codigo_kit, num_Contrato)
			values (@_codigo_kit, @nuevoIdAlquiler);

			-- Cambiar el estado del kit a "no disponible"
			update Kit
			set Id_Estado = 2
			where codigo_kit = @_codigo_kit;

	

			COMMIT TRANSACTION;
        PRINT 'Alquiler y estado de kit registrados correctamente.';
    END TRY

    BEGIN CATCH
        ROLLBACK TRANSACTION;
        PRINT 'Error: ' + ERROR_MESSAGE();
    END CATCH
end
go

SELECT codigo_kit, id_estado from kit
SELECT codigo_kit, id_herramienta, cantidad_herramientas FROM kitHerramienta

--ingreso de un alquiler de un kit
exec sp_RegistrarAlquileresConKits
    @_fecha_Inicio = '2025-07-24',
    @_fecha_Dev = '2025-08-07',
    @_tarifa_Total_Diaria = 20000,
    @_deposito_Garantia = 10000,
	@_costo_alquiler = 20000,
    @_estado_Contrato = 'activo',
    @_Id_cliente = 8,
	@_codigo_Kit = 1


--ingreso de un alquiler de un kit
exec sp_RegistrarAlquileresConKits
    @_fecha_Inicio = '2025-07-24',
    @_fecha_Dev = '2025-08-07',
    @_tarifa_Total_Diaria = 20000,
    @_deposito_Garantia = 10000,
	@_costo_alquiler = 20000,
    @_estado_Contrato = 'activo',
    @_Id_cliente = 8,
	@_codigo_Kit = 3
