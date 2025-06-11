-- Triggers para filegroup devolucion
-- estado Finalizado
use ALQUIFACIL
go

create or alter trigger trg_InsertDevolucion_UpdateEstadoContrato
	on Devolucion
	after insert
as
begin
	update Alquiler
    set estado_Contrato = 'Finalizado'
    from Alquiler as A
					inner join inserted as I on A.num_Contrato = I.numero_contrato_alquiler;
end;
go
select * from Devolucion