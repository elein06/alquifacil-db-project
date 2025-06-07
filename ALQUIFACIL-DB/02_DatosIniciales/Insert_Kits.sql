-- Insert Kits
-- Proyecto ALQUIFÁCIL

--Procedimiento almacenado para agregar un kit 

use ALQUIFACIL
go

create procedure sp_IngresarKit
(
    @_codigo_Kit int,
    @_nombre varchar(50),
    @_tarifa_Diaria_Especial money,
    @_num_Contrato int,
    @_id_Categoria int)
AS
    insert into Kit (codigo_Kit, nombre, tarifa_Diaria_Especial, num_Contrato, id_Categoria)
    values (@_codigo_Kit, @_nombre, @_tarifa_Diaria_Especial, @_num_Contrato, @_id_Categoria)
    PRINT 'EL KIT SE HA REGISTRADO CORRECTAMENTE'
    go


    exec sp_IngresarKit '1001', 'Kit de Jardinería', 15000, 1, 1
    go

    exec sp_IngresarKit '1002', 'Kit de Construcción', 20000, 2, 2
    go

    exec sp_IngresarKit '1003', 'Kit de Bricolaje', 12000, 3, 3
    go

    select * from Kit
    go


