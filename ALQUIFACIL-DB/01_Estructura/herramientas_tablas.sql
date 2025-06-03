-- TABLAS DEL FILEGROUP HERRAMIENTAS

use ALQUIFACIL
go
create table Herramienta(
	Id_Herramienta int not null,
	Numero_Serie varchar(50) not null,
	Anio_Adquisicion int null,
	Valor_Reposicion money not null,
	Stock_Herramientas int not null,
	Id_Estado int null,
	Id_Tipo int null,
	Id_Categoria int null
)
on HERRAMIENTAS
go


use ALQUIFACIL
go
alter table Herramienta
add constraint PK_Herramienta_Id
primary key (Id_Herramienta)
go


exec sp_help Herramienta
go