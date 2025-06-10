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
	DECLARE @existeContrato INT;
	DECLARE @costo_alquiler money;
	DECLARE @tipo_cliente int;
	DECLARE @_verificarClienteAlquiler INT;
	DECLARE @id_herramienta int;


	SELECT @id_herramienta = id_Herramienta
	from AlquilerHerramienta
	where num_Contrato = @_numContrato;

	SELECT @tipo_cliente = tipo_cliente
	from CLIENTE
	where id_Cliente = @_id_cliente;

	SELECT @costo_alquiler = costo_alquiler
	from Alquiler
	where num_Contrato = @_numContrato;
	
    SELECT @estadoHerramienta = Id_Estado
    FROM Herramienta
    WHERE Id_Herramienta = @_id_herramienta;
	
    SELECT @nContrato = num_Contrato
    FROM alquilerherramienta
    WHERE id_Herramienta = @_id_herramienta;

	SELECT @_verificarClienteAlquiler = Id_cliente
    FROM Alquiler
    WHERE num_Contrato = @_numContrato;
	
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

	SELECT @existeContrato = 1
		FROM alquiler
	WHERE num_Contrato = @_numContrato;

	IF @existeContrato IS NULL
	BEGIN
		PRINT 'No existe este número de contrato';
		RETURN;
	END

	IF @id_herramienta != @_id_herramienta
	BEGIN
		PRINT 'Esta herramienta no se encuentra en este alquiler';
		RETURN;
	END
	
	IF @_verificarClienteAlquiler != @_id_cliente
    BEGIN
        PRINT 'Este cliente no ha realizado un alquiler.';
        RETURN;
    END

	IF @tipo_cliente = 2 AND @costo_alquiler >= 5000
	BEGIN
		set @costo_alquiler = @costo_alquiler - 5000
	END

	SET @costo_alquiler = @costo_alquiler + @_cargos_por_dia_atraso;

	if @estadoContrato = 'Finalizado'
	BEGIN
        PRINT 'Ese contrato ya fue cancelado.';
        RETURN;
    END

	if @nContrato = null
	BEGIN
        PRINT 'No existe este numero de contrato';
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
    INSERT INTO Devolucion (estado, costo_Reparacion, cargos_Por_Dia_Atraso, total_a_pagar, id_Cliente, numero_contrato_alquiler)
    VALUES (@_estado, @_costo_reparacion, @_cargos_por_dia_atraso, @costo_alquiler, @_id_cliente, @_numContrato);

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
    @_cargos_por_dia_atraso = 2000,
    @_id_cliente = 2,
    @_id_herramienta = 6,
    @_cantidad_herramientas = 3,
	@_numContrato = 3

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
	DECLARE @existeContrato INT
	DECLARE @costo_alquiler money;
	DECLARE @tipo_cliente int;
	DECLARE @codigo_kit int;


	SELECT @codigo_kit = codigo_kit
	from AlquilerKit
	where num_contrato = @_num_Contrat;

    SELECT @tipo_cliente = tipo_cliente
	from CLIENTE
	where id_Cliente = @_id_cliente;

	SELECT @costo_alquiler = costo_alquiler
	from Alquiler
	where num_Contrato = @_num_Contrat;
	
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

	SELECT @existeContrato = 1
		FROM alquiler
	WHERE num_Contrato = @_num_Contrat;

	IF @tipo_cliente = 2 AND @costo_alquiler >= 5000
	BEGIN
		set @costo_alquiler = @costo_alquiler - 5000
	END

	SET @costo_alquiler = @costo_alquiler + @_cargos_por_dia_atraso;

	IF @existeContrato IS NULL
	BEGIN
		PRINT 'No existe este número de contrato';
		RETURN;
	END

	IF @_codigo_Kit != @codigo_kit 
	BEGIN
		PRINT 'Este kit no se encuentra en el alquiler registrado';
		RETURN;
	END

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
    INSERT INTO Devolucion(estado, costo_Reparacion, cargos_Por_Dia_Atraso, total_a_pagar, id_Cliente, numero_contrato_alquiler)
    VALUES (@_estado, @_costo_reparacion, @_cargos_por_dia_atraso, @costo_alquiler, @_id_cliente, @_num_Contrat);

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
    @_cargos_por_dia_atraso = 2000,
    @_id_cliente = 1,
    @_codigo_Kit = 1,
    @_num_Contrat = 7,
	@_cantidadDevolucionHerramientas = 2;

