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