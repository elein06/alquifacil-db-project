-- Triggers para filegroup Mantenimiento

use ALQUIFACIL
go

create trigger trg_InsertMantenimiento_UpdateEstadoHerramienta
	on Mantenimiento
	after insert
as
begin
	update Herramienta
    set Id_Estado = 3 -- 3 es el Id_Estado para 'En Mantenimiento'
    from Herramienta as Herramienta
    inner join inserted as I on Herramienta.Id_Herramienta = I.Id_Herramienta;
end;
go
