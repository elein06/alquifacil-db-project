-- Reporte de historial de penalizaciones por clientes

use ALQUIFACIL
go
create procedure sp_VerHistorialDiasDeRetraso
as
	select devolucion.cargos_Por_Dia_Atraso as 'Cargo por dias de Atraso', 
						 CLIENTE.id_Cliente as 'Id Cliente', 
			case
				when ClienteFisico.id_Cliente is not null then ClienteFisico.nombre + ' ' + ClienteFisico.apellido1 + ISNULL(' ' + ClienteFisico.apellido2, '')
				when ClienteJuridico.id_Cliente is not null then ClienteJuridico.razon_social
				else 'Desconocido' 
			end as 'Nombre del Cliente'

	from CLIENTE inner join devolucion on CLIENTE.id_Cliente = devolucion.id_Cliente
				 left join ClienteFisico on CLIENTE.id_Cliente = ClienteFisico.id_Cliente
				 left join ClienteJuridico on CLIENTE.id_Cliente = ClienteJuridico.id_Cliente
	 WHERE
        devolucion.cargos_Por_Dia_Atraso > 0;
go

exec sp_VerHistorialDiasDeRetraso