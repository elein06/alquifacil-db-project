
-- Tabla devolucion
use ALQUIFACIL
go
create table Devolucion(
	Id_Devolucion int IDENTITY (1,1) not null,
	estado varchar(50) null,
	costo_Reparacion money null,
	cargos_Por_Dia_Atraso money null,
	id_Cliente int null
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



-- Devolucion Kit

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


ALTER TABLE DevolucionKit
ADD CONSTRAINT PK_Id_Devolucion_Kit
PRIMARY KEY (Id_Devolucion_Kit)
GO


ALTER TABLE DevolucionKit
ADD CONSTRAINT FK_Kit_Devolucion_Kit
FOREIGN KEY (codigo_Kit)
REFERENCES Kit(codigo_Kit)
GO


ALTER TABLE DevolucionKit
ADD CONSTRAINT FK_Kit_Devolucion_Devolucion
FOREIGN KEY (Id_Devolucion)
REFERENCES Devolucion(Id_Devolucion)
GO


EXEC sp_help DevolucionKit
GO
