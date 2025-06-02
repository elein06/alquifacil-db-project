-- TABLAS DEL FILEGROUP MANTENIMIENTO

use alquifacil
go
create table Mantenimiento(
	Id_Mantenimiento int not null,
	Fecha_Mantenimiento datetime not null,
	Persona_Responsable varchar(50) not null,
	Observaciones varchar(256) null,
	Costo money not null,
	Modalidad_Servicio varchar(50) null,
	Id_Herramienta int null
)
on MANTENIMIENTO
go


use alquifacil
go
alter table Mantenimiento
add constraint PK_Mantenimiento_Id
primary key (Id_Mantenimiento)
go


exec sp_help Mantenimiento
go

