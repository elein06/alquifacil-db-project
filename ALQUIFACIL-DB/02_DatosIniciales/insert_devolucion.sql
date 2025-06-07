USE ALQUIFACIL
GO

CREATE PROCEDURE sp_RegistrarDevolucionConHerramienta
    @_id_devolucion INT,
    @_estado VARCHAR(50),
    @_costo_reparacion MONEY,
    @_cargos_por_dia_atraso MONEY,
    @_id_cliente INT,
    @_id_herramienta INT,
    @_cantidad_herramientas INT,
    @_id_devolucion_herramienta INT
AS
BEGIN
    SET NOCOUNT ON;

    DECLARE @estadoHerramienta INT;

    -- Obtener estado actual de la herramienta
    SELECT @estadoHerramienta = Id_Estado
    FROM Herramienta
    WHERE Id_Herramienta = @_id_herramienta;

    IF @estadoHerramienta IS NULL
    BEGIN
        PRINT 'Herramienta no existe.';
        RETURN;
    END

    IF @estadoHerramienta != 2
    BEGIN
        PRINT 'La herramienta no está alquilada. No se puede registrar la devolución.';
        RETURN;
    END

    -- Insertar la devolución
    INSERT INTO Devolucion (Id_Devolucion, estado, costo_Reparacion, cargos_Por_Dia_Atraso, id_Cliente)
    VALUES (@_id_devolucion, @_estado, @_costo_reparacion, @_cargos_por_dia_atraso, @_id_cliente);

    -- Insertar en la tabla intermedia
    INSERT INTO DevolucionHerramienta (Id_DevolucionHerramienta, Id_Herramienta, Id_Devolucion, cantidad_Herramientas)
    VALUES (@_id_devolucion_herramienta, @_id_herramienta, @_id_devolucion, @_cantidad_herramientas);

    -- Cambiar el estado de la herramienta a "no alquilada" (1)
    UPDATE Herramienta
    SET Id_Estado = 1
    WHERE Id_Herramienta = @_id_herramienta;

    PRINT 'Devolución registrada correctamente y estado de herramienta actualizado.';
END
GO

EXEC sp_RegistrarDevolucionConHerramienta
    @_id_devolucion = 16,
    @_estado = 'Devuelto en buen estado',
    @_costo_reparacion = 0,
    @_cargos_por_dia_atraso = 0,
    @_id_cliente = 4,
    @_id_herramienta = 100,
    @_cantidad_herramientas = 1,
    @_id_devolucion_herramienta = 8;
