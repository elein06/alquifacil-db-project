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


exec sp_help Persona_Responsable
go

use alquifacil
go
create table Persona_Responsable(
	Id_Persona_Responsable int not null,
	nombre varchar(50) not null,
	apellido1 varchar(50) not null,
	apellido2 varchar(50) null,
)
on MANTENIMIENTO
go

use alquifacil
go
alter table Persona_Responsable
add constraint PK_Persona_Responsable_Id
primary key (Id_Persona_Responsable)
go

use alquifacil
go
alter table Mantenimiento
alter column Id_Persona_Responsable int not null
go

use alquifacil
go
alter table Mantenimiento
add constraint FK_Mantenimiento_PersonaResponsable
foreign key (Id_Persona_Responsable)
references Persona_Responsable(Id_Persona_Responsable);
go