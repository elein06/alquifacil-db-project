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

    -- Verificar si la herramienta existe y obtener su estado
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

    PRINT 'Devolución registrada correctamente y estado de herramienta actualizado.';
END
GO

EXEC sp_RegistrarDevolucionConHerramienta
    @_estado = 'Devuelto en buen estado',
    @_costo_reparacion = 100,
    @_cargos_por_dia_atraso = -12,
    @_id_cliente = 4,
    @_id_herramienta = 2,
    @_cantidad_herramientas = 10;






