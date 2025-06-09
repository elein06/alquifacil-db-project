USE ALQUIFACIL
GO

CREATE OR ALTER PROCEDURE sp_RegistrarDevolucionConHerramienta
    @_estado VARCHAR(50),
    @_costo_reparacion MONEY,
    @_cargos_por_dia_atraso MONEY,
    @_id_cliente INT,
    @_id_herramienta INT,
    @_cantidad_herramientas INT
AS
BEGIN
    SET NOCOUNT ON;

    DECLARE @estadoHerramienta INT;
    DECLARE @nuevoIdDevolucion INT;
	DECLARE @cantidadHerramientasAlquiladas INT;

    -- Verificar si la herramienta existe y obtener su estado
    SELECT @estadoHerramienta = Id_Estado
    FROM Herramienta
    WHERE Id_Herramienta = @_id_herramienta;

	SELECT @cantidadHerramientasAlquiladas = cantidadHerramientas
    FROM AlquilerHerramienta
    WHERE Id_Herramienta = @_id_herramienta;

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

    -- Insertar la devolución (ID autogenerado)
    INSERT INTO Devolucion (estado, costo_Reparacion, cargos_Por_Dia_Atraso, id_Cliente)
    VALUES (@_estado, @_costo_reparacion, @_cargos_por_dia_atraso, @_id_cliente);

    -- Obtener el nuevo ID de devolución
    SET @nuevoIdDevolucion = SCOPE_IDENTITY();

    -- Insertar en la tabla intermedia (ID también autogenerado)
    INSERT INTO DevolucionHerramienta (Id_Herramienta, Id_Devolucion, cantidad_Herramientas)
    VALUES (@_id_herramienta, @nuevoIdDevolucion, @_cantidad_herramientas);

    -- Cambiar el estado de la herramienta a "disponible"
    UPDATE Herramienta
    SET Id_Estado = 1
    WHERE Id_Herramienta = @_id_herramienta;

	Update Herramienta
	SET Stock_Herramientas = Stock_Herramientas + @cantidadHerramientasAlquiladas
    WHERE Id_Herramienta = @_id_herramienta;

    PRINT 'Devolución registrada correctamente y estado de herramienta actualizado.';
END
GO

EXEC sp_RegistrarDevolucionConHerramienta
    @_estado = 'Devuelto en buen estado',
    @_costo_reparacion = 0,
    @_cargos_por_dia_atraso = 12.000,
    @_id_cliente = 4,
    @_id_herramienta = 2,
    @_cantidad_herramientas = 10;

EXEC sp_RegistrarDevolucionConHerramienta
    @_estado = 'Devuelto en buen estado',
    @_costo_reparacion = 0,
    @_cargos_por_dia_atraso = 26.000,
    @_id_cliente = 20,
    @_id_herramienta = 6,
    @_cantidad_herramientas = 1;


select * from Devolucion
go

-- Devolucion de un kit
USE ALQUIFACIL
GO

CREATE OR ALTER PROCEDURE sp_RegistrarKitDevolucion
 

    @_estado VARCHAR(50),
    @_costo_reparacion MONEY,
    @_cargos_por_dia_atraso MONEY,
    @_id_cliente INT,
    @_codigo_Kit INT

AS
BEGIN
    SET NOCOUNT ON;

    DECLARE @estadoKit INT;
    DECLARE @nuevoIdDevolucionKit INT;
	

    -- Verificar si la herramienta existe y obtener su estado
    SELECT @estadoKit = Id_Estado
    FROM Kit
    WHERE codigo_Kit = @_codigo_Kit;


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

    -- Insertar la devolución (ID autogenerado)
    INSERT INTO Devolucion(estado, costo_Reparacion, cargos_Por_Dia_Atraso, id_Cliente)
    VALUES (@_estado, @_costo_reparacion, @_cargos_por_dia_atraso, @_id_cliente);

    -- Obtener el nuevo ID de devolución
    SET @nuevoIdDevolucionKit = SCOPE_IDENTITY();

    -- Insertar en la tabla intermedia (ID también autogenerado)
    INSERT INTO Kit_Devolucion (codigo_Kit, id_Devolucion)
    VALUES (@_codigo_Kit, @nuevoIdDevolucionKit);

    -- Cambiar el estado de la herramienta a "disponible"
    UPDATE Kit
    SET Id_Estado = 1
    WHERE codigo_Kit = @_codigo_Kit;

    PRINT 'Devolución registrada correctamente';
END
GO

EXEC sp_RegistrarKitDevolucion
    @_estado = 'Devuelto en buen estado',
    @_costo_reparacion = 0,
    @_cargos_por_dia_atraso = 12.000,
    @_id_cliente = 4,
	@_codigo_Kit = 2

select * from Devolucion
go
