-- TABLAS DEL FILEGROUP OPERACIONES

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

use alquifacil
go
	alter table alquiler
	add constraint PK_num_Contrato
	primary key (num_Contrato)
go

use alquifacil
go
	alter table alquiler
	add constraint FK_Alquiler_IdCliente
	foreign key (Id_cliente)
	references cliente(id_cliente)
go

exec sp_help alquiler
go

use alquifacil
go
create table AlquilerHerramienta
(
	id_AlquilerHerramienta int not null,
	id_Herramienta int not null,
	num_Contrato int not null,
	cantidadHerramientas int not null
)
on OPERACIONES
go

use alquifacil
go
	alter table AlquilerHerramienta
	add constraint PK_id_AlquilerHerramienta
	primary key (id_AlquilerHerramienta)
go

use alquifacil
go
	alter table AlquilerHerramienta
	add constraint FK_id_Herramienta
	foreign key (Id_Herramienta)
	references Herramienta(Id_Herramienta);
go

use alquifacil
go
	alter table AlquilerHerramienta
	add constraint FK_num_Contrato
	foreign key (num_Contrato)
	references Alquiler(num_Contrato);
go

exec sp_help AlquilerHerramienta
go