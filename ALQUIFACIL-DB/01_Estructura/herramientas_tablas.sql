-- TABLAS DEL FILEGROUP HERRAMIENTAS

use ALQUIFACIL
go
create table Herramienta
(
	Id_Herramienta int not null,
	Numero_Serie varchar(50) not null,
	Anio_Adquisicion int null,
	Valor_Reposicion money not null,
	Stock_Herramientas int not null,
	Marca varchar(50) not null,
	Modelo varchar(50) not null,
	Id_Estado int null,
	Id_Tipo int null,
	Id_Condicion_Fisica int not null,
	Id_Categoria int null,

)
on HERRAMIENTAS
go

use ALQUIFACIL
go
alter table Herramienta
add constraint PK_Herramienta_Id
primary key (Id_Herramienta)
go

--Creacion de tablas Estado y Tipo y sus llaves primarias junto con las llaves foraneas en la tabla Herramienta By Orlando

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

--Creacion de Primary key en la tabla Estado
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

--Creacion de Primary key en la tabla Tipo

use ALQUIFACIL
GO
alter table Tipo
add constraint PK_Tipo_id_Tipo
primary key (id_Tipo)
GO

exec sp_help Tipo
go

--Creacion de tabla Categoria y su primary key by Elein

use ALQUIFACIL
go 
create table Categoria
(
	id_Categoria int not null,
	nombre_categoria varchar (50) not null
)
on HERRAMIENTAS
go


use ALQUIFACIL
GO
alter table Categoria
add constraint PK_Categoria_id
primary key (id_Categoria)
GO

exec sp_help Categoria
go

--Creacion de tabla CondicionFisica y su primary key 

use ALQUIFACIL
go 
create table CondicionFisica
(
	Id_Condicion_Fisica int not null,
	Nombre_Condicion varchar (50) not null
)
on HERRAMIENTAS
go


use ALQUIFACIL
GO
alter table CondicionFisica
add constraint PK_CondicionFisica_Id
primary key (Id_Condicion_Fisica)
GO

exec sp_help CondicionFisica
go

--Creacion de Foreign Keys en Herramineta

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

--FK de id_categoria by Elein
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

--Creaci�n tabla Kit--
use ALQUIFACIL
GO
CREATE TABLE Kit
(
codigo_Kit INT NOT NULL,
nombre VARCHAR(50) NOT NULL,
tarifa_Diaria_Especial MONEY NOT NULL,
num_Contrato INT NOT NULL,
id_Categoria INT NOT NULL
)
On HERRAMIENTAS
GO


--Agrego llave primaria a Kit--
use ALQUIFACIL
GO
alter table Kit
add constraint PK_Kit_codigo_Kit
primary key (codigo_Kit)
GO

exec sp_help Kit
go

--FK de id_categoria a KIT
use alquifacil
go
alter table kit
add constraint FK_Kit_Categoria_id
foreign key (Id_Categoria)
references Categoria(Id_Categoria)
go

--Creaci�n tabla intermedia Kit-Herramienta--
use ALQUIFACIL
GO

CREATE TABLE KitHerramienta
(
id_KitHerramienta INT NOT NULL,
codigo_Kit INT NOT NULL,
Id_Herramienta INT NOT NULL,
cantidad_Herramientas INT NOT NULL
)
ON HERRAMIENTAS
GO

--Agrego llave primaria a KitHerramienta--

use ALQUIFACIL
GO
alter table KitHerramienta
add constraint PK_KitHerramienta_id_KitHerramienta
primary key (id_KitHerramienta)
GO



-- Agrego llaves foráneas a la tabla KitHerramienta
use ALQUIFACIL
GO
alter table KitHerramienta
add constraint FK_KitHerramienta_codigo_Kit
Foreign key (codigo_Kit)
REFERENCES Kit(codigo_Kit)
GO

use ALQUIFACIL
GO
alter table KitHerramienta
add constraint FK_KitHerramienta_Id_Herramienta
Foreign key (Id_Herramienta)
REFERENCES Herramienta(Id_Herramienta)
GO

exec sp_help KitHerramienta
go