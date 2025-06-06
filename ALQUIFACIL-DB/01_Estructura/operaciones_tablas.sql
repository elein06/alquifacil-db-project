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

--tabla intermedia AlquilerHerramienta


--tabla intermedia AlquilerKit

use alquifacil
go
create table AlquilerKit
(
	id_AlquilerKit int not null,
	codigo_kit int not null,
	num_contrato int not null
)
on OPERACIONES
go

use alquifacil
go
alter table AlquilerKit
add constraint PK_id_AlquilerKit
primary key (id_AlquilerKit)
go

--asociar con FK a alquiler y a kit

use ALQUIFACIL
go
alter table AlquilerKit
add constraint FK_Alquilerkit_codigoKit
foreign key(codigo_kit)
references Kit(codigo_kit)
go

use ALQUIFACIL
go
alter table AlquilerKit
add constraint FK_Alquilerkit_numContrato
foreign key(num_contrato)
references Alquiler(num_contrato)
go

exec sp_help alquilerKit
go