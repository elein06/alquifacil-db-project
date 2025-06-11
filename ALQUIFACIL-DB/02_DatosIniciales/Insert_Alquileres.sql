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
        RETURN;
    END

    IF @stockDisponible IS NULL
    BEGIN
        PRINT 'Herramienta no existe.';
        RETURN;
    END

    IF @estadoHerramienta != 1
    begin
        print 'Esa herramienta no disponible.';
        return;
    end

    IF @_cantidadHerramientas > @stockDisponible
    BEGIN
        PRINT 'No hay suficientes unidades disponibles para alquilar.';
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
    

    PRINT 'Alquiler registrado correctamente.';
END;
GO

--ingreso de alquiler de herramienta
exec sp_RegistrarAlquileresConHerramientas
    @_fecha_Inicio = '2025-07-24',
    @_fecha_Dev = '2025-09-07',
    @_tarifa_Total_Diaria = 20000,
    @_deposito_Garantia = 5000,
	@_costo_alquiler = 15000,
    @_estado_Contrato = 'Activo',
    @_Id_cliente = 2,
	@_id_Herramienta = 16,
	@_cantidadHerramientas = 3


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
	@_codigo_Kit int,
	@_cantidadHerramientasEnKit int,
	@_id_Herramienta int
as
begin
    set nocount on;

	declare @estadoKit int;
    declare @nuevoIdAlquiler int;
    DECLARE @idHerramientasKit INT;
    DECLARE @_cantidadAlquilarEnKit INT;
    DECLARE @nuevoIdCliente INT;

    -- Verificar si el kit ya existe 
    select @estadoKit = Id_Estado
    from Kit
    where codigo_Kit = @_codigo_Kit;

	select @idHerramientasKit = Id_Herramienta 
	from KitHerramienta 
	where codigo_Kit = @_codigo_Kit;

	select @_cantidadAlquilarEnKit = cantidad_Herramientas 
	from KitHerramienta
	where Id_Herramienta = @_id_Herramienta;

	select @nuevoIdCliente = id_Cliente
	from CLIENTE 
	where id_Cliente = @_Id_cliente 

	
    IF @nuevoIdCliente IS NULL
    BEGIN
        PRINT 'Ese cliente no existe.';
        RETURN;
    END

    if @estadoKit is null
    begin
        print 'El kit no existe.';
        return;
    end

	if @estadoKit != 1
    begin
        print 'El kit no está disponible.';
        return;
    end

	if @idHerramientasKit is null 
	BEGIN
        PRINT 'Esa herramienta no pertenece a ese kit.';
        RETURN;
    END

	if @_id_Herramienta != @idHerramientasKit
	BEGIN
        PRINT 'Esa herramienta no pertenece a ese kit.';
        RETURN;
    END

	if @_cantidadHerramientasEnKit != @_cantidadAlquilarEnKit
	BEGIN
        PRINT 'Monto de herramientas invalido';
        RETURN;
    END

    -- Insertar el alquiler (ID autogenerado)
    insert into Alquiler(fecha_Inicio, fecha_Dev, tarifa_Total_Diaria, deposito_Garantia, costo_alquiler, estado_Contrato, Id_cliente)
    values (@_fecha_Inicio, @_fecha_Dev, @_tarifa_Total_Diaria, @_deposito_Garantia, @_costo_alquiler, @_estado_Contrato, @_Id_cliente);

    -- Obtener el nuevo ID de alquiler
    set @nuevoIdAlquiler = SCOPE_IDENTITY();

    -- Insertar en la tabla intermedia (Sin ID autogenerado)
    insert into AlquilerKit(codigo_kit, num_Contrato, cantidadHerramientasEnKit)
    values (@_codigo_kit, @nuevoIdAlquiler, @_cantidadHerramientasEnKit);

    -- Cambiar el estado del kit a "no disponible"
    update Kit
    set Id_Estado = 2
    where codigo_kit = @_codigo_kit;

	
    -- Actualizar el stock
    UPDATE Herramienta
    SET Stock_Herramientas = Stock_Herramientas - @_cantidadAlquilarEnKit
    WHERE Id_Herramienta = @_id_Herramienta;

    print 'Alquiler y estado de kit registrados correctamente.';
end
go

--ingreso de un alquiler de un kit
exec sp_RegistrarAlquileresConKits
    @_fecha_Inicio = '2025-07-24',
    @_fecha_Dev = '2025-09-07',
    @_tarifa_Total_Diaria = 20000,
    @_deposito_Garantia = 10000,
	@_costo_alquiler = 20000,
    @_estado_Contrato = 'activo',
    @_Id_cliente = 1,
	@_codigo_Kit = 1, 
	@_cantidadHerramientasEnKit = 2,
	@_id_Herramienta = 6
