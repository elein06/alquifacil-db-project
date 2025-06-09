-- Reporte HerramientasDevueltasEnMalEstado
-- Proyecto ALQUIFÁCIL

-- Consulta de herramientas devueltas en mal estado
use ALQUIFACIL;
go
	create or alter procedure sp_VerReporteDevolucionesMalEstado
	as
	begin
		set nocount on

			select 
				Devolucion.Id_Devolucion,
				Cliente.id_Cliente,
				Herramienta.Id_Herramienta,
				DevolucionHerramienta.cantidad_Herramientas,
				Devolucion.estado as estado_Devolucion,
				Devolucion.costo_Reparacion,
				Devolucion.cargos_Por_Dia_Atraso

			from Devolucion

				inner join Cliente on Devolucion.id_Cliente = Cliente.Id_Cliente
				inner join DevolucionHerramienta on Devolucion.Id_Devolucion = DevolucionHerramienta.Id_Devolucion
				inner join Herramienta on DevolucionHerramienta.Id_Herramienta = Herramienta.Id_Herramienta

			-- Cambiar por estado 'malo' de la herramienta
			where Devolucion.estado = 'Devuelto en buen estado'

		print 'Reporte generado correctamente'
	end
go

exec sp_ReporteDevolucionesMalEstado
go