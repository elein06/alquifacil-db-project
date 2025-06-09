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

    -- Obtener stock y estado actual
    SELECT 
        @stockDisponible = Stock_Herramientas,
        @estadoHerramienta = Id_Estado
    FROM Herramienta
    WHERE Id_Herramienta = @_id_Herramienta;

    IF @stockDisponible IS NULL
    BEGIN
        PRINT 'Herramienta no existe.';
        RETURN;
    END

    IF @estadoHerramienta IN (3, 4)
    BEGIN
        PRINT 'La herramienta está en mantenimiento o dada de baja. No se puede alquilar.';
        RETURN;
    END

    IF @_cantidadHerramientas > @stockDisponible
    BEGIN
        PRINT 'No hay suficientes unidades disponibles para alquilar.';
        RETURN;
    END

    -- Insertar contrato de alquiler
    INSERT INTO Alquiler(fecha_Inicio, fecha_Dev, tarifa_Total_Diaria, deposito_Garantia, estado_Contrato, Id_cliente)
    VALUES (@_fecha_Inicio, @_fecha_Dev, @_tarifa_Total_Diaria, @_deposito_Garantia, @_estado_Contrato, @_Id_cliente);

    SET @nuevoIdAlquiler = SCOPE_IDENTITY();

    -- Insertar detalle de alquiler
    INSERT INTO AlquilerHerramienta(Id_Herramienta, num_Contrato, cantidadHerramientas)
    VALUES (@_id_Herramienta, @nuevoIdAlquiler, @_cantidadHerramientas);

    -- Actualizar el stock
    UPDATE Herramienta
    SET Stock_Herramientas = Stock_Herramientas - @_cantidadHerramientas
    WHERE Id_Herramienta = @_id_Herramienta;

    -- Si ya no queda stock, actualizar estado a No Disponible (2)
    IF (@stockDisponible - @_cantidadHerramientas) = 0
    BEGIN
        UPDATE Herramienta
        SET Id_Estado = 2
        WHERE Id_Herramienta = @_id_Herramienta;
    END

    PRINT 'Alquiler registrado correctamente.';
END;
GO

exec sp_RegistrarAlquileresConHerramientas
    @_fecha_Inicio = '2025-07-24',
    @_fecha_Dev = '2025-09-07',
    @_tarifa_Total_Diaria = 20000,
    @_deposito_Garantia = 15000,
    @_estado_Contrato = 'Activo',
    @_Id_cliente = 1,
	@_id_Herramienta = 17,
	@_cantidadHerramientas = 2


-- Proceso almacenado para agregar un Alquiler de un Kit

use ALQUIFACIL
go
create or alter procedure sp_RegistrarAlquileresConKits
	-- Alquiler
    @_fecha_Inicio date,
    @_fecha_Dev date,
    @_tarifa_Total_Diaria money,
    @_deposito_Garantia money,
    @_estado_Contrato varchar(50),
    @_Id_cliente int,
	-- kit
	@_codigo_Kit int
as
begin
    set nocount on;

	declare @estadoKit int;
    declare @nuevoIdAlquiler int;

    -- Verificar si el kit ya existe 
    select @estadoKit = Id_Estado
    from Kit
    where codigo_Kit = @_codigo_Kit;

    if @estadoKit is null
    begin
        print 'El kit no existe.';
        return;
    end

	if @estadoKit != 1
    begin
        print 'El kit ya esta alquilado.';
        return;
    end

    -- Insertar el alquiler (ID autogenerado)
    insert into Alquiler(fecha_Inicio, fecha_Dev, tarifa_Total_Diaria, deposito_Garantia, estado_Contrato, Id_cliente)
    values (@_fecha_Inicio, @_fecha_Dev, @_tarifa_Total_Diaria, @_deposito_Garantia, @_estado_Contrato, @_Id_cliente);

    -- Obtener el nuevo ID de alquiler
    set @nuevoIdAlquiler = SCOPE_IDENTITY();

    -- Insertar en la tabla intermedia (Sin ID autogenerado)
    insert into AlquilerKit(codigo_kit, num_Contrato)
    values (@_codigo_kit, @nuevoIdAlquiler);

    -- Cambiar el estado del kit a "no disponible"
    update Kit
    set Id_Estado = 2
    where codigo_kit = @_codigo_kit;

    print 'Alquiler y estado de kit registrados correctamente.';
end
go

exec sp_RegistrarAlquileresConKits
    @_fecha_Inicio = '2025-07-24',
    @_fecha_Dev = '2025-09-07',
    @_tarifa_Total_Diaria = 20000,
    @_deposito_Garantia = 15000,
    @_estado_Contrato = 'activo',
    @_Id_cliente = 3,
	@_codigo_Kit = 3
