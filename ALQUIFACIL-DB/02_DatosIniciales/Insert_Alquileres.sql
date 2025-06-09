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
