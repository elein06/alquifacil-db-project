-- Reporte de mantenimientos realizados de tipo interno vs externo + costos.
-- Proyecto ALQUIFÁCIL

use ALQUIFACIL
go
create procedure sp_VerMantenimientosPorTipo
as
	select Modalidad_Servicio as 'Modalidad del servicio', count (*) as 'Mantenimientos realizados', sum(Costo) as 'Total por modalidad'
	from Mantenimiento
	group by Modalidad_Servicio
go

exec sp_VerMantenimientosPorTipo
go