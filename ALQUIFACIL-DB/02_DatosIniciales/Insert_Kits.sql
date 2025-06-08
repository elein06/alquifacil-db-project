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
    @_id_Categoria int)
AS
    insert into Kit (codigo_Kit, nombre, tarifa_Diaria_Especial, id_Categoria)
    values (@_codigo_Kit, @_nombre, @_tarifa_Diaria_Especial, @_id_Categoria)
    PRINT 'EL KIT SE HA REGISTRADO CORRECTAMENTE'
    go


    exec sp_IngresarKit '1001', 'Kit de Jardinería', 15000, 1
    go

    exec sp_IngresarKit '1002', 'Kit de Construcción', 20000, 2
    go

    exec sp_IngresarKit '1003', 'Kit de Bricolaje', 12000, 3
    go

	exec sp_IngresarKit 1004, 'Kit de Demolición Ligera', 35000, 1
go

exec sp_IngresarKit 1005, 'Kit de Instalación Eléctrica', 22000, 3
go

exec sp_IngresarKit 1006, 'Kit de Poda Avanzada', 18000, 2
go

exec sp_IngresarKit 1007, 'Kit de Fontanería Básica', 16500, 3
go

    select * from Kit
    go


--Procedimiento almacenado para agregar un kitHerramienta

use ALQUIFACIL
go
create procedure sp_IngresarKitHerramienta
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

	-- Asociaciones para el Kit de Jardinería (código_Kit 1001)
exec sp_IngresarKitHerramienta 1001, 2, 1 -- Podadora Eléctrica GX200
go
exec sp_IngresarKitHerramienta 1001, 6, 1 -- Tijera de Podar PowerGear
go
exec sp_IngresarKitHerramienta 1001, 7, 1 -- Desbrozadora FS 250
go

-- Asociaciones para el Kit de Construcción (código_Kit 1002)
exec sp_IngresarKitHerramienta 1002, 1, 2 -- Martillo (2 unidades)
go
exec sp_IngresarKitHerramienta 1002, 4, 1 -- Compactador de Placa HR500
go
exec sp_IngresarKitHerramienta 1002, 5, 1 -- Taladro Percutor DCD999
go

-- Asociaciones para el Kit de Bricolaje (código_Kit 1003)
exec sp_IngresarKitHerramienta 1003, 3, 1 -- Set de Destornilladores
go
exec sp_IngresarKitHerramienta 1003, 8, 1 -- Sierra Caladora KS500
go

-- Asociaciones para el nuevo Kit de Demolición Ligera (código_Kit 1004)
exec sp_IngresarKitHerramienta 1004, 1, 1 -- Martillo (para demolición)
go
exec sp_IngresarKitHerramienta 1004, 5, 1 -- Taladro Percutor (para demolición ligera)
go

-- Asociaciones para el nuevo Kit de Instalación Eléctrica (código_Kit 1005)
exec sp_IngresarKitHerramienta 1005, 3, 1 -- Set de Destornilladores (para electricidad)
go
exec sp_IngresarKitHerramienta 1005, 8, 1 -- Sierra Caladora (para cortar aberturas)
go

-- Asociaciones para el nuevo Kit de Poda Avanzada (código_Kit 1006)
exec sp_IngresarKitHerramienta 1006, 6, 1 -- Tijera de Podar PowerGear (principal)
go
exec sp_IngresarKitHerramienta 1006, 7, 1 -- Desbrozadora FS 250 (para áreas más grandes)
go
exec sp_IngresarKitHerramienta 1006, 10, 1 -- Soplador de Hojas G-MAX 40V (para limpieza)
go

select * from KitHerramienta
go

    select * from KitHerramienta
    go