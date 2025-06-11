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
	costo_alquiler money not null,
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
	num_contrato int not null,
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


---------------------Tabla devolucion
use ALQUIFACIL
go
create table Devolucion(
	Id_Devolucion int IDENTITY (1,1) not null,
	fecha_revisionTecnica date null,
	estado varchar(50) null,
	costo_Reparacion money null,
	cargos_Por_Dia_Atraso money null,
	total_a_pagar money null,
	id_Cliente int not null,
	numero_contrato_alquiler int not null
)
on OPERACIONES
go


-- Llave primaria devolucion
use ALQUIFACIL
go
alter table Devolucion
add constraint PK_Devolucion_Id
primary key (Id_Devolucion)
go

-- Llave foranea clientes a devolucion
use ALQUIFACIL
go
alter table Devolucion
add constraint FK_Devolucion_Cliente
foreign key (id_Cliente) references Cliente(Id_Cliente)
go

-- Llave foranea alquiler a devolucion
use ALQUIFACIL
go
alter table Devolucion
add constraint FK_Devolucion_Alquiler
foreign key (numero_contrato_alquiler) references Alquiler(num_Contrato)
go

exec sp_help Devolucion
go

-- Tabla intermedia devolucionHerramienta

use ALQUIFACIL
go
create table DevolucionHerramienta(
	Id_DevolucionHerramienta int IDENTITY (1,1) not null,
	Id_Herramienta int not null,
	Id_Devolucion int not null,
	cantidad_Herramientas int null
)
on OPERACIONES
go

-- Llave primaria devolucionHerramienta
use ALQUIFACIL
go
alter table DevolucionHerramienta
add constraint PK_DevolucionHerramienta_Id
primary key (Id_DevolucionHerramienta)
go


-- Llave foranea devolucionHerramienta a herramienta 
use ALQUIFACIL
go
alter table DevolucionHerramienta
add constraint FK_DevolucionHerramienta_Herramienta
foreign key (Id_Herramienta) references Herramienta(Id_Herramienta)
go


-- Llave foranea devolucionHerramienta a Devolucion	
use ALQUIFACIL
go
alter table DevolucionHerramienta
add constraint FK_DevolucionHerramienta_Devolucion
foreign key (Id_Devolucion) references Devolucion(Id_Devolucion)
go

exec sp_help DevolucionHerramienta
go


----------------Devolucion Kit

USE ALQUIFACIL
GO
CREATE TABLE DevolucionKit (
    Id_Devolucion_Kit INT IDENTITY(1,1) NOT NULL,
    codigo_Kit INT NOT NULL,
    Id_Devolucion INT NOT NULL,
	cantidadDevolucionHerramientas int not null
)
ON OPERACIONES
GO

-- PK de DevolucionKit 
USE ALQUIFACIL
GO
ALTER TABLE DevolucionKit
ADD CONSTRAINT PK_Id_Devolucion_Kit
PRIMARY KEY (Id_Devolucion_Kit)
GO

-- FK de Kit 
USE ALQUIFACIL
GO
ALTER TABLE DevolucionKit
ADD CONSTRAINT FK_Kit_Devolucion_Kit
FOREIGN KEY (codigo_Kit)
REFERENCES Kit(codigo_Kit)
GO

-- FK de Devolucion 
USE ALQUIFACIL
GO
ALTER TABLE DevolucionKit
ADD CONSTRAINT FK_Kit_Devolucion_Devolucion
FOREIGN KEY (Id_Devolucion)
REFERENCES Devolucion(Id_Devolucion)
GO

EXEC sp_help DevolucionKit
GO
