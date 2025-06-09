-- TABLAS DEL FILEGROUP OPERACIONES

-- Crear tabla Alquiler
use alquifacil
go
create table Alquiler
(
	num_Contrato int IDENTITY(1,1) not null,
	fecha_Inicio date not null,
	fecha_Dev date not null,
	tarifa_Total_Diaria	money not null,
	deposito_Garantia money not null,
	estado_Contrato varchar(50) not null,
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

-- Llave foranea Cliente a Alquiler
use alquifacil
go
	alter table alquiler
	add constraint FK_Alquiler_IdCliente
	foreign key (Id_cliente)
	references cliente(id_cliente)
go

exec sp_help alquiler
go

-- Tabla intermedia AlquilerHerramienta
use alquifacil
go
create table AlquilerHerramienta
(
	id_AlquilerHerramienta int IDENTITY(1,1) not null,
	id_Herramienta int not null,
	num_Contrato int not null,
	cantidadHerramientas int not null
)
on OPERACIONES
go

-- Llave primaria AlquilerHerramienta
use alquifacil
go
alter table AlquilerHerramienta
	add constraint PK_id_AlquilerHerramienta
	primary key (id_AlquilerHerramienta)
go

-- Llave foranea Herramienta a AlquilerHerramienta
use alquifacil
go
	alter table AlquilerHerramienta
	add constraint FK_id_Herramienta
	foreign key (Id_Herramienta)
	references Herramienta(Id_Herramienta);
go

-- Llave foranea Alquiler a AlquilerHerramienta
use alquifacil
go
	alter table AlquilerHerramienta
	add constraint FK_num_Contrato
	foreign key (num_Contrato)
	references Alquiler(num_Contrato);
go

exec sp_help AlquilerHerramienta
go

-- Tabla intermedia AlquilerKit
use alquifacil
go
create table AlquilerKit
(
	id_AlquilerKit int IDENTITY(1,1) not null,
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

-- Asociar con FK a alquiler y a kit
use alquifacil
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



-- Kit_Devolucion

USE ALQUIFACIL
GO

CREATE TABLE Kit_Devolucion (
    Id_Kit_Devolucion INT IDENTITY(1,1) NOT NULL,
    codigo_Kit INT NOT NULL,
    Id_Devolucion INT NOT NULL
)
ON OPERACIONES
GO


ALTER TABLE Kit_Devolucion
ADD CONSTRAINT PK_Kit_Devolucion
PRIMARY KEY (Id_Kit_Devolucion)
GO


ALTER TABLE Kit_Devolucion
ADD CONSTRAINT FK_Kit_Devolucion_Kit
FOREIGN KEY (codigo_Kit)
REFERENCES Kit(codigo_Kit)
GO


ALTER TABLE Kit_Devolucion
ADD CONSTRAINT FK_Kit_Devolucion_Devolucion
FOREIGN KEY (Id_Devolucion)
REFERENCES Devolucion(Id_Devolucion)
GO


EXEC sp_help Kit_Devolucion
GO
