-- TABLAS DEL FILEGROUP OPERACIONES

-- Crear tabla alquiler
use alquifacil
go
create table Alquiler
(
	num_Contrato int not null,
	cliente_Asociado varchar(50) not null,
	fecha_Inicio date not null,
	fecha_Dev date not null,
	tarifa_Total_Diaria	money not null,
	deposito_Garantia money not null,
	estado_Contrato int not null,
	Id_cliente int not null
)
on OPERACIONES
go


-- Llave primaria Alquiler
use alquifacil
go
alter table alquiler
add constraint PK_num_Contrato
primary key (num_Contrato)
go


-- Llave foranea cliente a alquiler
use alquifacil
go
alter table alquiler
add constraint FK_Alquiler_IdCliente
foreign key (Id_cliente)
references cliente(id_cliente)
go

exec sp_help alquiler
go