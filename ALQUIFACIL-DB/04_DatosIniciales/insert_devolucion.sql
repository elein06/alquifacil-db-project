--INSERT DEVOLUCIONES
-- Correccion para formatos de fechas
SET DATEFORMAT YMD;
GO

--procedimiento almacenado para registrar una devolucion de una herramienta
USE ALQUIFACIL
GO
CREATE OR ALTER PROCEDURE sp_RegistrarDevolucionConHerramienta
	@_fecha_revisionTecnica DATE,
    @_estado VARCHAR(50),
    @_costo_reparacion MONEY,
    @_cargos_por_dia_atraso MONEY,
    @_id_cliente INT,
    @_id_herramienta INT,
    @_cantidad_herramientas INT,
    @_numContrato INT
AS
BEGIN
	DECLARE @estadoHerramienta INT;
	DECLARE @nuevoIdDevolucion INT;
	DECLARE @cantidadHerramientasAlquiladas INT;	
	DECLARE @nuevoIdCliente INT;
	DECLARE @stockHerramientas INT;
	DECLARE @nContrato INT;
	DECLARE @estadoContrato VARCHAR(29);
	DECLARE @existeContrato INT;
	DECLARE @costo_alquiler MONEY;
	DECLARE @tipo_cliente INT;
	DECLARE @_verificarClienteAlquiler INT;
	DECLARE @id_herramienta INT;

	SELECT @id_herramienta = id_Herramienta
	FROM AlquilerHerramienta
	WHERE num_Contrato = @_numContrato;

	SELECT @tipo_cliente = tipo_cliente
	FROM CLIENTE
	WHERE id_Cliente = @_id_cliente;

	SELECT @costo_alquiler = costo_alquiler
	FROM Alquiler
	WHERE num_Contrato = @_numContrato;

	SELECT @estadoHerramienta = Id_Estado
	FROM Herramienta
	WHERE Id_Herramienta = @_id_herramienta;

	SELECT @nContrato = num_Contrato
	FROM AlquilerHerramienta
	WHERE id_Herramienta = @_id_herramienta;

	SELECT @_verificarClienteAlquiler = Id_cliente
	FROM Alquiler
	WHERE num_Contrato = @_numContrato;

	SELECT @estadoContrato = estado_Contrato
	FROM Alquiler
	WHERE num_Contrato = @_numContrato;

	SELECT @stockHerramientas = Stock_Herramientas
	FROM Herramienta
	WHERE Id_Herramienta = @_id_herramienta;

	SELECT @cantidadHerramientasAlquiladas = cantidadHerramientas
	FROM AlquilerHerramienta
	WHERE Id_Herramienta = @_id_herramienta;

	SELECT @nuevoIdCliente = id_Cliente
	FROM CLIENTE 
	WHERE id_Cliente = @_id_cliente;

	SELECT @existeContrato = 1
	FROM Alquiler
	WHERE num_Contrato = @_numContrato;

	IF @existeContrato IS NULL
	BEGIN
		PRINT 'No existe este número de contrato';
		RETURN;
	END

	IF @id_herramienta IS NULL OR @_id_herramienta IS NULL OR @id_herramienta != @_id_herramienta
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
		SET @costo_alquiler = @costo_alquiler - 5000;
	END

	SET @costo_alquiler = @costo_alquiler + @_cargos_por_dia_atraso;

	IF @estadoContrato = 'Finalizado'
	BEGIN
		PRINT 'Ese contrato ya fue cancelado.';
		RETURN;
	END

	IF @nContrato IS NULL
	BEGIN
		PRINT 'No existe este número de contrato';
		RETURN;
	END

	IF @nContrato != @_numContrato
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

	IF @cantidadHerramientasAlquiladas IS NULL
	BEGIN
		PRINT 'Error: cantidad de herramientas alquiladas es NULL';
		RETURN;
	END

	-- Actualizar estado si no hay stock antes
	IF @stockHerramientas = 0
	BEGIN
		UPDATE Herramienta
		SET Id_Estado = 1
		WHERE Id_Herramienta = @_id_herramienta;
	END

	-- Insertar la devolución
	INSERT INTO Devolucion (
		fecha_revisionTecnica, estado, costo_Reparacion,
		cargos_Por_Dia_Atraso, total_a_pagar, id_Cliente,
		numero_contrato_alquiler
	)
	VALUES (
		@_fecha_revisionTecnica, @_estado, @_costo_reparacion,
		@_cargos_por_dia_atraso, @costo_alquiler, @_id_cliente,
		@_numContrato
	);

	-- Obtener el nuevo ID
	SET @nuevoIdDevolucion = SCOPE_IDENTITY();

	-- Insertar en DevolucionHerramienta
	INSERT INTO DevolucionHerramienta (
		Id_Herramienta, Id_Devolucion, cantidad_Herramientas
	)
	VALUES (
		@_id_herramienta, @nuevoIdDevolucion, @_cantidad_herramientas
	);

	-- Sumar al stock
	UPDATE Herramienta
	SET Stock_Herramientas = Stock_Herramientas + @cantidadHerramientasAlquiladas
	WHERE Id_Herramienta = @_id_herramienta;

	PRINT 'Devolución registrada y stock actualizado correctamente';
END
GO

SELECT num_contrato, id_cliente, fecha_Dev, estado_Contrato FROM Alquiler
SELECT num_contrato, id_herramienta, cantidadHerramientas from AlquilerHerramienta

--ingresar una devolucion de herramienta
EXEC sp_RegistrarDevolucionConHerramienta
	@_fecha_revisionTecnica = '2025-08-09',
    @_estado = 'Devuelto en mal estado',
    @_costo_reparacion = 5000,
    @_cargos_por_dia_atraso = 1500,
    @_id_cliente = 16,
    @_id_herramienta = 23,
    @_cantidad_herramientas = 2,
	@_numContrato = 8


--procedimiento almacenado para registrar una devolucion de un kit
USE ALQUIFACIL
GO
CREATE OR ALTER PROCEDURE sp_RegistrarKitDevolucion
    @_fecha_revisionTecnica date,
	@_estado VARCHAR(50),
    @_costo_reparacion MONEY,
    @_cargos_por_dia_atraso MONEY,
    @_id_cliente INT,
    @_codigo_Kit INT,
	@_num_Contrat int
AS
BEGIN
    SET NOCOUNT ON;

	BEGIN TRY
        BEGIN TRANSACTION;

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
			DECLARE @estadoContrato varchar(20);

			
			SELECT @estadoContrato = estado_Contrato
			from Alquiler
			where num_Contrato = @_num_Contrat;

			SELECT @codigo_kit = codigo_kit
			from AlquilerKit
			where num_contrato = @_num_Contrat;

			SELECT @tipo_cliente = tipo_cliente
			from CLIENTE
			where id_Cliente = @_id_cliente;

			SELECT @costo_alquiler = costo_alquiler
			from Alquiler
			where num_Contrato = @_num_Contrat;

			SELECT @_verificarClienteAlquiler = Id_cliente
			FROM Alquiler
			WHERE num_Contrato = @_num_Contrat;

			SELECT @estadoKit = Id_Estado
			FROM Kit
			WHERE codigo_Kit = @_codigo_Kit;

			select @nuevoIdCliente = id_Cliente
			from CLIENTE 
			where id_Cliente = @_Id_cliente

			SELECT @existeContrato = 1
			FROM alquiler
			WHERE num_Contrato = @_num_Contrat;



			IF @estadoContrato = 'Finalizado'
			BEGIN
				PRINT 'Ese contrato ya esta finalizado. ';
				ROLLBACK TRANSACTION;
				RETURN;
			END

			IF @tipo_cliente = 2 AND @costo_alquiler >= 5000
			BEGIN
				set @costo_alquiler = @costo_alquiler - 5000
			END

			SET @costo_alquiler = @costo_alquiler + @_cargos_por_dia_atraso;

			IF @existeContrato IS NULL
			BEGIN
				PRINT 'No existe este número de contrato';
				ROLLBACK TRANSACTION;
				RETURN;
			END

			IF @_codigo_Kit != @codigo_kit 
			BEGIN
				PRINT 'Este kit no se encuentra en el alquiler registrado';
				ROLLBACK TRANSACTION;
				RETURN;
			END

			IF @nuevoIdCliente IS NULL
			BEGIN
				PRINT 'Ese cliente no existe.';
				ROLLBACK TRANSACTION;
				RETURN;
			END

			IF @_verificarClienteAlquiler != @_id_cliente
			BEGIN
				PRINT 'Este cliente no ha realizado un alquiler.';
				ROLLBACK TRANSACTION;
				RETURN;
			END

			IF @estadoKit IS NULL
			BEGIN
				PRINT 'Kit no existe.';
				ROLLBACK TRANSACTION;
				RETURN;
			END


			-- Insertar la devolución (ID autogenerado)
			INSERT INTO Devolucion(fecha_revisionTecnica, estado, costo_Reparacion, cargos_Por_Dia_Atraso, total_a_pagar, id_Cliente, numero_contrato_alquiler)
			VALUES (@_fecha_revisionTecnica, @_estado, @_costo_reparacion, @_cargos_por_dia_atraso, @costo_alquiler, @_id_cliente, @_num_Contrat);


			-- Obtener el nuevo ID de devolución
			SET @nuevoIdDevolucionKit = SCOPE_IDENTITY();

			-- Insertar en la tabla intermedia (ID también autogenerado)
			INSERT INTO DevolucionKit (codigo_Kit, id_Devolucion)
			VALUES (@_codigo_Kit, @nuevoIdDevolucionKit);

			-- Cambiar el estado del kit a "disponible"
			UPDATE Kit
			SET Id_Estado = 1
			WHERE codigo_Kit = @_codigo_Kit;

			UPDATE H
			SET H.Stock_Herramientas = H.Stock_Herramientas + K.cantidad_Herramientas
			FROM Herramienta H
			INNER JOIN kitherramienta K ON H.Id_Herramienta = K.id_Herramienta
			WHERE K.codigo_Kit = @_codigo_Kit;

			COMMIT TRANSACTION;
		PRINT 'Devolucion registrada correctamente.';
    END TRY

    BEGIN CATCH
        ROLLBACK TRANSACTION;
        PRINT 'Error: ' + ERROR_MESSAGE();
    END CATCH
END
GO

SELECT num_contrato, id_cliente, fecha_Dev, estado_Contrato FROM Alquiler
SELECT num_contrato, codigo_kit from AlquilerKit
SELECT codigo_kit, id_herramienta, cantidad_herramientas FROM kitHerramienta

EXEC sp_RegistrarKitDevolucion
	@_fecha_revisionTecnica = '2025-08-08',
    @_estado = 'Devuelto en buen estado',
    @_costo_reparacion = 0,
    @_cargos_por_dia_atraso = 700,
    @_id_cliente = 8,
    @_codigo_Kit = 3,
    @_num_Contrat = 10
