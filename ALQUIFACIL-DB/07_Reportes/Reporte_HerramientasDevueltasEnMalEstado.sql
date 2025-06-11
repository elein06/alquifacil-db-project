-- Reporte HerramientasDevueltasEnMalEstado
-- Proyecto ALQUIFÁCIL

-- Consulta de herramientas devueltas en mal estado
use ALQUIFACIL
go
	create or alter procedure sp_VerReporteDevolucionesMalEstado
	as
	begin
		set nocount on

			select 
				Devolucion.Id_Devolucion as 'ID de la devolución',
				Cliente.id_Cliente as 'ID del cliente',
				Herramienta.Id_Herramienta as 'ID de la herramienta',
				DevolucionHerramienta.cantidad_Herramientas as 'Cantidad de herramientas',
				Devolucion.estado as 'Estado al ser devuelta',
				Devolucion.costo_Reparacion as 'Costo de la reparación',
				Devolucion.cargos_Por_Dia_Atraso as 'Cargos por día de atraso'

			from Devolucion

				inner join Cliente on Devolucion.id_Cliente = Cliente.Id_Cliente
				inner join DevolucionHerramienta on Devolucion.Id_Devolucion = DevolucionHerramienta.Id_Devolucion
				inner join Herramienta on DevolucionHerramienta.Id_Herramienta = Herramienta.Id_Herramienta

			where Devolucion.estado = 'Devuelto en mal estado'

		print 'Reporte generado correctamente'
	end
go

exec sp_VerReporteDevolucionesMalEstado
go