-- Insert Clientes
-- Proyecto ALQUIFÁCIL


-- Proceso almacenado para agregar Alquiler de una Herramienta

use ALQUIFACIL
go
create or alter procedure sp_RegistrarAlquileresConHerramientas
    @_fecha_Inicio date,
    @_fecha_Dev date,
    @_tarifa_Total_Diaria money,
    @_deposito_Garantia money,
    @_estado_Contrato varchar(50),
    @_Id_cliente int,
	@_id_Herramienta int,
	@_cantidadHerramientas int
as
begin
    set nocount on;

    declare @estadoHerramienta int;
    declare @nuevoIdAlquiler int;

    -- Verificar si la herramienta existe y obtener su estado
    select @estadoHerramienta = Id_Estado
    from Herramienta
    where Id_Herramienta = @_id_herramienta;

    if @estadoHerramienta is null
    begin
        print 'Herramienta no existe.';
        return;
    end

    if @estadoHerramienta = 2
    begin
        print 'La herramienta ya está alquilada. No se puede registrar el alquiler.';
        return;
    end

	if @estadoHerramienta = 3
    begin
        print 'La herramienta está en mantenimiento. No se puede registrar el alquiler.';
        return;
    end

	if @estadoHerramienta = 4
    begin
        print 'La herramienta esta dada de baja. No se puede registrar el alquiler.';
        return;
    end

    -- Insertar el alquiler (ID autogenerado)
    insert into Alquiler(fecha_Inicio, fecha_Dev, tarifa_Total_Diaria, deposito_Garantia, estado_Contrato, Id_cliente)
    values (@_fecha_Inicio, @_fecha_Dev, @_tarifa_Total_Diaria, @_deposito_Garantia, @_estado_Contrato, @_Id_cliente);

    -- Obtener el nuevo ID de alquiler
    set @nuevoIdAlquiler = SCOPE_IDENTITY();

    -- Insertar en la tabla intermedia (ID también autogenerado)
    insert into AlquilerHerramienta(Id_Herramienta, num_Contrato, cantidadHerramientas)
    values (@_id_herramienta, @nuevoIdAlquiler, @_cantidadHerramientas);

    -- Cambiar el estado de la herramienta a "alquilada"
    update Herramienta
    set Id_Estado = 2
    where Id_Herramienta = @_id_herramienta;

    print 'Alquiler registrado correctamente y estado de herramienta actualizado.';
end
go

exec sp_RegistrarAlquileresConHerramientas
    @_fecha_Inicio = '2025-07-24',
    @_fecha_Dev = '2025-09-07',
    @_tarifa_Total_Diaria = 20000,
    @_deposito_Garantia = 15000,
    @_estado_Contrato = 'Activo',
    @_Id_cliente = 1,
	@_id_Herramienta = 1,
	@_cantidadHerramientas = 4

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