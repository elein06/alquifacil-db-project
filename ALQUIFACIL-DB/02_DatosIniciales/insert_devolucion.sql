USE ALQUIFACIL
GO
CREATE PROCEDURE sp_InsertarDevolucion (
    @_id_devolucion INT,
    @_estado VARCHAR(50),
    @_costo_reparacion MONEY,
    @_cargos_por_dia_atraso MONEY,
    @_id_cliente INT
)
AS
    -- Insertar en la tabla Devolucion
    INSERT INTO Devolucion (Id_Devolucion, estado, costo_Reparacion, cargos_Por_Dia_Atraso, id_Cliente)
    VALUES (@_id_devolucion, @_estado, @_costo_reparacion, @_cargos_por_dia_atraso, @_id_cliente)

    PRINT 'LA DEVOLUCIÓN SE HA REGISTRADO CORRECTAMENTE'
GO

EXEC sp_InsertarDevolucion 1, 'Buena', 0, 0, 10
GO

EXEC sp_InsertarDevolucion 2, 'Dañada', 20000, 1500, 5
GO

EXEC sp_InsertarDevolucion 3, 'Sucia', 0, 500, 8
GO

EXEC sp_InsertarDevolucion 4, 'Nueva', 0, 0, 2
GO

EXEC sp_InsertarDevolucion 5, 'Reparación pendiente', 18000, 1000, 7
GO

EXEC sp_InsertarDevolucion 6, 'Irrecuperable', 30000, 2000, 3
GO

EXEC sp_InsertarDevolucion 7, 'Buena', 0, 0, 6
GO

EXEC sp_InsertarDevolucion 8, 'Incompleta', 10000, 900, 1
GO

EXEC sp_InsertarDevolucion 9, 'Dañada', 15000, 700, 9
GO

EXEC sp_InsertarDevolucion 10, 'Completa', 0, 0, 4
GO
