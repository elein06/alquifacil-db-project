-- TABLAS DEL FILEGROUP OPERACIONES

use alquifacil
go
create table Operaciones(
	num_Contrato int not null,
	cliente_Asociado varchar(50) not null,
	fecha_Inicio date not null,
	fecha_Dev date not null,
	tarifa_Total_Diaria	money not null,
	deposito_Garantia money not null,
	estado_Contrato int not null
)
on OPERACIONES
go

use alquifacil
go
alter table Operaciones
add constraint PK_num_Contrato
primary key (num_Contrato)
go

exec sp_help Operaciones
go