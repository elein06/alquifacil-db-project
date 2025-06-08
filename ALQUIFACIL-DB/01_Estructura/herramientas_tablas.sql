-- TABLAS DEL FILEGROUP HERRAMIENTAS

use ALQUIFACIL
go
create table Herramienta
(
	Id_Herramienta int IDENTITY (1,1) not null,
	Numero_Serie varchar(50) not null,
	Anio_Adquisicion int null,
	Valor_Reposicion money not null,
	Stock_Herramientas int not null,
	Marca varchar(50) not null,
	Modelo varchar(50) not null,
	Id_Estado int not null,
	Id_Tipo int not null,
	Id_Condicion_Fisica int not null,
	Id_Categoria int not null
)
on HERRAMIENTAS
go

-----PK id_herramienta
use ALQUIFACIL
go
alter table Herramienta
add constraint PK_Herramienta_Id
primary key (Id_Herramienta)
go

exec sp_help herramienta
go

--------------Creación de tablas Estado, Tipo, Categoria y CondicionFisica

--Creacion de tabla Estado
use ALQUIFACIL
go 
create table Estado
(
id_Estado int not null,
nombreEstado varchar (50) not null
)
on HERRAMIENTAS
go

--Creacion de PK en la tabla Estado
use ALQUIFACIL
GO
alter table Estado
add constraint PK_Estado_id_Estado
primary key (id_Estado)
GO

exec sp_help Estado
go

--Creacion de tabla Tipo
use ALQUIFACIL
go 
create table Tipo
(
id_Tipo int not null,
nombreTipo varchar (50) not null
)
on HERRAMIENTAS
go

--Creacion de PK en la tabla Tipo
use ALQUIFACIL
GO
alter table Tipo
add constraint PK_Tipo_id_Tipo
primary key (id_Tipo)
GO

exec sp_help Tipo
go

--Creacion de tabla Categoria
use ALQUIFACIL
go 
create table Categoria
(
	id_Categoria int not null,
	nombre_categoria varchar (50) not null
)
on HERRAMIENTAS
go

--Creacion de PK 
use ALQUIFACIL
GO
alter table Categoria
add constraint PK_Categoria_id
primary key (id_Categoria)
GO

exec sp_help Categoria
go

--Creacion de tabla CondicionFisica
use ALQUIFACIL
go 
create table CondicionFisica
(
	Id_Condicion_Fisica int not null,
	Nombre_Condicion varchar (50) not null
)
on HERRAMIENTAS
go

--Creacion de la PK
use ALQUIFACIL
GO
alter table CondicionFisica
add constraint PK_CondicionFisica_Id
primary key (Id_Condicion_Fisica)
GO

exec sp_help CondicionFisica
go

--------------Creacion de FKs de estas tablas en Herramineta

--FK de id_Estado
use ALQUIFACIL
GO
alter table Herramienta
add constraint FK_Herramienta_id_Estado
Foreign key (Id_Estado)
REFERENCES Estado(id_Estado)
GO

--FK de Id_Condicion
use ALQUIFACIL
GO
alter table Herramienta
add constraint FK_Herramienta_id_Condicion_Fisica
Foreign key (Id_Condicion_Fisica)
REFERENCES CondicionFisica(Id_Condicion_Fisica )
GO

--FK de id_categoria
use ALQUIFACIL
GO
alter table Herramienta
add constraint FK_Herramienta_Categoria_id
Foreign key (Id_Categoria)
REFERENCES Categoria(id_Categoria)
GO

--FK de id_Tipo
use ALQUIFACIL
GO
alter table Herramienta
add constraint FK_Herramienta_id_Tipo
Foreign key (Id_Tipo)
REFERENCES Tipo(id_Tipo)
GO

exec sp_help Herramienta
go

-- Creación tabla Kit
use ALQUIFACIL
GO
CREATE TABLE Kit
(
codigo_Kit INT NOT NULL,
nombre VARCHAR(50) NOT NULL,
tarifa_Diaria_Especial MONEY NOT NULL,
id_Categoria INT NOT NULL,
Id_Estado int not null
)
On HERRAMIENTAS
GO

--Agrego llave PK a Kit
use ALQUIFACIL
GO
alter table Kit
add constraint PK_Kit_codigo_Kit
primary key (codigo_Kit)
GO

exec sp_help Kit
go

--FK de id_Estado a kit
use ALQUIFACIL
GO
alter table Kit
add constraint FK_Kit_id_Estado
Foreign key (Id_Estado)
REFERENCES Estado(id_Estado)
GO

--FK de id_categoria a kit
use alquifacil
go
alter table kit
add constraint FK_Kit_Categoria_id
foreign key (Id_Categoria)
references Categoria(Id_Categoria)
go

----------------Creación tabla intermedia Kit-Herramienta--
use ALQUIFACIL
go
create table KitHerramienta
(
id_KitHerramienta INT IDENTITY(1,1) NOT NULL,
codigo_Kit INT NOT NULL,
Id_Herramienta INT NOT NULL,
cantidad_Herramientas INT NOT NULL
)
on HERRAMIENTAS
go

--Agrego PK a KitHerramienta--
use ALQUIFACIL
go
alter table KitHerramienta
add constraint PK_KitHerramienta_id_KitHerramienta
primary key (id_KitHerramienta)
go

-- Agrego FKs a la tabla KitHerramienta
use ALQUIFACIL
go
alter table KitHerramienta
add constraint FK_KitHerramienta_codigo_Kit
foreign key (codigo_Kit)
references Kit(codigo_Kit)
go

use ALQUIFACIL
go
alter table KitHerramienta
add constraint FK_KitHerramienta_Id_Herramienta
foreign key (Id_Herramienta)
references Herramienta(Id_Herramienta)
go

exec sp_help KitHerramienta
go