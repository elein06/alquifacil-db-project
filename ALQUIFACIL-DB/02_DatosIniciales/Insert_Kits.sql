-- Insert Kits
-- Proyecto ALQUIFÁCIL

--Procedimiento almacenado para agregar un kit 
use ALQUIFACIL
go
create or alter procedure sp_IngresarKit
(
    @_codigo_Kit int,
    @_nombre varchar(50),
    @_tarifa_Diaria_Especial money,
    @_id_Categoria int,
	@_Id_Estado int)
AS
	if @_Id_Estado = 3
    begin
        print 'El kit no puede registrarse como en mantenimiento. No se puede registrar el kit.';
        return;
    end

	if @_Id_Estado = 4
    begin
        print 'El kit no puede registrarse como dao de baja. No se puede registrar el kit.';
        return;
    end

    insert into Kit (codigo_Kit, nombre, tarifa_Diaria_Especial, id_Categoria, Id_Estado)
    values (@_codigo_Kit, @_nombre, @_tarifa_Diaria_Especial, @_id_Categoria, @_Id_Estado)
    PRINT 'EL KIT SE HA REGISTRADO CORRECTAMENTE'
go

exec sp_IngresarKit '1001', 'Kit de Jardinería', 15000, 1, 1
go

exec sp_IngresarKit '1002', 'Kit de Construcción', 20000, 2, 2
go

exec sp_IngresarKit '1003', 'Kit de Bricolaje', 12000, 3, 1
go

select * from Kit
go


--Procedimiento almacenado para agregar un kitHerramienta
use ALQUIFACIL
go
create or alter procedure sp_IngresarKitHerramienta
(
    @_codigo_Kit int,
    @_Id_Herramienta int,
    @_cantidad_Herramientas int)
AS
    insert into KitHerramienta (codigo_Kit, Id_Herramienta, cantidad_Herramientas)
    values (@_codigo_Kit, @_Id_Herramienta, @_cantidad_Herramientas)
    PRINT 'EL KIT DE HERRAMIENTA SE HA REGISTRADO CORRECTAMENTE'
go

exec sp_IngresarKitHerramienta '1001', '1', '2'
go

exec sp_IngresarKitHerramienta '1002', '2', '1'
go

exec sp_IngresarKitHerramienta '1003', '3', '3'
go

select * from KitHerramienta
go