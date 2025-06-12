-- TABLAS DEL FILEGROUP MANTENIMIENTO

-- Tabla de mantenimiento
use alquifacil
go
create table Mantenimiento
(
	Id_Mantenimiento int IDENTITY (1,1) not null,
	Costo money not null,
	Fecha_Mantenimiento datetime not null,
	Modalidad_Servicio varchar(50) null,
	Observaciones varchar(256) null,
	Id_Tipo_Mantenimiento int not null,
	Id_Persona_Responsable int not null,
	Id_Herramienta int null
)
on MANTENIMIENTO
go

-- Llave primaria de mantenimiento
use alquifacil
go
alter table Mantenimiento
add constraint PK_Mantenimiento_Id
primary key (Id_Mantenimiento)
go


---------------------------creacion de tablas persona_responsable y tipo_mantenimiento

-- Tabla de personas responsables del mantenimiento
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

-- Llave primaria de persona responsable
use alquifacil
go
alter table Persona_Responsable
add constraint PK_Persona_Responsable_Id
primary key (Id_Persona_Responsable)
go

-- Llave foranea persona responsable a mantenimiento
use alquifacil
go
alter table Mantenimiento
add constraint FK_Mantenimiento_PersonaResponsable
foreign key (Id_Persona_Responsable)
references Persona_Responsable(Id_Persona_Responsable);
go


-- Tabla tipo de mantenimiento
use alquifacil
go
create table tipo_mantenimiento
(
	Id_Tipo_Mantenimiento int not null,
	nombre_tipo_mantenimiento varchar(50) not null
)
on MANTENIMIENTO
go

-- Llave primaria tipo de mantenimiento
use alquifacil
go
alter table tipo_mantenimiento
add constraint PK_Tipo_Mantenimiento_Id
primary key (Id_Tipo_Mantenimiento)
go

-- Llave foranea tipo de mantenimiento a mantenimiento
use alquifacil
go
alter table Mantenimiento
add constraint FK_Mantenimiento_TipoMantenimiento
foreign key (Id_Tipo_Mantenimiento)
references tipo_mantenimiento(Id_Tipo_Mantenimiento);
go