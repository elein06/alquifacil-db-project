USE ALQUIFACIL
GO

CREATE OR ALTER PROCEDURE sp_RegistrarDevolucionConHerramienta
    @_estado VARCHAR(50),
    @_costo_reparacion MONEY,
    @_cargos_por_dia_atraso MONEY,
    @_id_cliente INT,
    @_id_herramienta INT,
    @_cantidad_herramientas INT,
    @_numContrato INT
AS
BEGIN
    SET NOCOUNT ON;

    DECLARE @estadoHerramienta INT;
    DECLARE @nuevoIdDevolucion INT;
	DECLARE @cantidadHerramientasAlquiladas INT;	
    DECLARE @nuevoIdCliente INT;
    DECLARE @stockHerramientas INT;
    DECLARE @nContrato INT;
    DECLARE @estadoContrato varchar(29);
	
    -- Verificar si la herramienta existe y obtener su estado
    SELECT @estadoHerramienta = Id_Estado
    FROM Herramienta
    WHERE Id_Herramienta = @_id_herramienta;
	
    SELECT @nContrato = num_Contrato
    FROM alquilerherramienta
    WHERE id_Herramienta = @_id_herramienta;
	
    SELECT @estadoContrato = estado_Contrato
    FROM alquiler
    WHERE num_Contrato = @_numContrato;
	
    SELECT @stockHerramientas = Stock_Herramientas
    FROM Herramienta
    WHERE Id_Herramienta = @_id_herramienta;

	SELECT @cantidadHerramientasAlquiladas = cantidadHerramientas
    FROM AlquilerHerramienta
    WHERE Id_Herramienta = @_id_herramienta;

	select @nuevoIdCliente = id_Cliente
	from CLIENTE 
	where id_Cliente = @_Id_cliente 

	if @estadoContrato = 'Finalizado'
	BEGIN
        PRINT 'Ese contrato ya fue cancelado.';
        RETURN;
    END

	if @nContrato != @_numContrato
	BEGIN
        PRINT 'Ese contrato no corresponde a ese alquiler.';
        RETURN;
    END

    IF @nuevoIdCliente IS NULL
    BEGIN
        PRINT 'Ese cliente no existe.';
        RETURN;
    END

    IF @estadoHerramienta IS NULL
    BEGIN
        PRINT 'Herramienta no existe.';
        RETURN;
    END

	  IF @_cantidad_herramientas != @cantidadHerramientasAlquiladas
    BEGIN
        PRINT 'Cantidad de herramientas incorrecta';
        RETURN;
    END

	if @stockHerramientas = 0
		BEGIN
			UPDATE Herramienta
			SET Id_Estado = 1
			WHERE Id_Herramienta = @_id_herramienta;
		END

    -- Insertar la devolución (ID autogenerado)
    INSERT INTO Devolucion (estado, costo_Reparacion, cargos_Por_Dia_Atraso, id_Cliente, numero_contrato_alquiler)
    VALUES (@_estado, @_costo_reparacion, @_cargos_por_dia_atraso, @_id_cliente, @_numContrato);

    -- Obtener el nuevo ID de devolución
    SET @nuevoIdDevolucion = SCOPE_IDENTITY();

    -- Insertar en la tabla intermedia (ID también autogenerado)
    INSERT INTO DevolucionHerramienta (Id_Herramienta, Id_Devolucion, cantidad_Herramientas)
    VALUES (@_id_herramienta, @nuevoIdDevolucion, @_cantidad_herramientas);

    -- Cambiar el estado de la herramienta a "disponible"
    

	Update Herramienta
	SET Stock_Herramientas = Stock_Herramientas + @cantidadHerramientasAlquiladas
    WHERE Id_Herramienta = @_id_herramienta;

    PRINT 'Devolución registrada correctamente y estado de herramienta actualizado.';
END
GO

EXEC sp_RegistrarDevolucionConHerramienta
    @_estado = 'Devuelto en buen estado',
    @_costo_reparacion = 0,
    @_cargos_por_dia_atraso = 26.000,
    @_id_cliente = 20,
    @_id_herramienta = 16,
    @_cantidad_herramientas = 3,
	@_numContrato = 11

select * from Herramienta
go
select * from alquiler
go


-- Devolucion de un kit
USE ALQUIFACIL
GO

CREATE OR ALTER PROCEDURE sp_RegistrarKitDevolucion
    @_estado VARCHAR(50),
    @_costo_reparacion MONEY,
    @_cargos_por_dia_atraso MONEY,
    @_id_cliente INT,
    @_codigo_Kit INT,
	@_num_Contrat int,
	@_cantidadDevolucionHerramientas int
AS
BEGIN
    SET NOCOUNT ON;

    DECLARE @estadoKit INT;
    DECLARE @nuevoIdDevolucionKit INT;	
    DECLARE @nuevoIdCliente INT;
	DECLARE @cantidadHerramientasAlquiladas INT;
	DECLARE @_id_herramienta INT;
	DECLARE @_verificarClienteAlquiler INT

    -- Verificar si la herramienta existe y obtener su estado
    SELECT @_id_herramienta = Id_Herramienta
    FROM KitHerramienta
    WHERE codigo_Kit = @_codigo_Kit;

	SELECT @_verificarClienteAlquiler = Id_cliente
    FROM Alquiler
    WHERE num_Contrato = @_num_Contrat;

	SELECT @estadoKit = Id_Estado
    FROM Kit
    WHERE codigo_Kit = @_codigo_Kit;

	select @nuevoIdCliente = id_Cliente
	from CLIENTE 
	where id_Cliente = @_Id_cliente 

	SELECT @cantidadHerramientasAlquiladas = cantidadHerramientasEnKit
    FROM AlquilerKit
    WHERE num_contrato = @_num_Contrat;

    IF @nuevoIdCliente IS NULL
    BEGIN
        PRINT 'Ese cliente no existe.';
        RETURN;
    END

	IF @_verificarClienteAlquiler != @_id_cliente
    BEGIN
        PRINT 'Este cliente no ha realizado un alquiler.';
        RETURN;
    END

    IF @estadoKit IS NULL
    BEGIN
        PRINT 'Kit no existe.';
        RETURN;
    END

	  IF @estadoKit = 1
    BEGIN
        PRINT 'El kit no se ha prestado. Error al registrar devolucion';
        RETURN;
    END

	  IF @_cantidadDevolucionHerramientas != @cantidadHerramientasAlquiladas
    BEGIN
        PRINT 'Cantidad de herramientas incorrecta';
        RETURN;
    END

    -- Insertar la devolución (ID autogenerado)
    INSERT INTO Devolucion(estado, costo_Reparacion, cargos_Por_Dia_Atraso, id_Cliente, numero_contrato_alquiler)
    VALUES (@_estado, @_costo_reparacion, @_cargos_por_dia_atraso, @_id_cliente, @_num_Contrat);

    -- Obtener el nuevo ID de devolución
    SET @nuevoIdDevolucionKit = SCOPE_IDENTITY();

    -- Insertar en la tabla intermedia (ID también autogenerado)
    INSERT INTO DevolucionKit (codigo_Kit, id_Devolucion, cantidadDevolucionHerramientas)
    VALUES (@_codigo_Kit, @nuevoIdDevolucionKit, @_cantidadDevolucionHerramientas);

    -- Cambiar el estado de la herramienta a "disponible"
    UPDATE Kit
    SET Id_Estado = 1
    WHERE codigo_Kit = @_codigo_Kit;

	UPDATE Herramienta
    SET Stock_Herramientas = Stock_Herramientas + @_cantidadDevolucionHerramientas
    WHERE Id_Herramienta = @_id_herramienta;

END
GO

EXEC sp_RegistrarKitDevolucion
    @_estado = 'Devuelto en mal estado',
    @_costo_reparacion = 0,
    @_cargos_por_dia_atraso = 12.000,
    @_id_cliente = 1,
    @_codigo_Kit = 1,
    @_num_Contrat = 12,
	@_cantidadDevolucionHerramientas = 2;

select * from alquiler
go
select * from AlquilerKit
select * from Herramienta
select * from KitHerramienta
select * from Alquiler
