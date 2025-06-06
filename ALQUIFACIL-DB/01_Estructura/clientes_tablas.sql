-- TABLAS DEL FILEGROUP CLIENTES

--tabla padre cliente
USE ALQUIFACIL
GO
CREATE TABLE CLIENTE
(
	id_Cliente	int IDENTITY (1,1) not null
	CONSTRAINT PK_ID_CLIENTE PRIMARY KEY CLUSTERED (id_Cliente)
)
ON CLIENTES
GO


--tablas hijas 

-- Tabla Cliente Fisico
USE ALQUIFACIL
GO
CREATE TABLE ClienteFisico
(
    id_Cliente int NOT NULL,
	ced_fisica varchar(20) not null,
    nombre varchar(50) NOT NULL,
    apellido1 varchar(50) NOT NULL,
	apellido2 varchar(50) NOT NULL,
    telefono varchar(15) null,
	correo varchar(50) null,
	tipo_cliente int not null
)
ON CLIENTES
GO

--creacion de PK
USE ALQUIFACIL
GO
ALTER TABLE ClienteFisico
ADD CONSTRAINT PK_ClienteFisico 
PRIMARY KEY (id_Cliente)
GO

USE ALQUIFACIL
GO
ALTER TABLE ClienteFisico
ADD CONSTRAINT FK_ClienteFisico_Cliente 
FOREIGN KEY (id_Cliente) REFERENCES CLIENTE(id_Cliente)
GO

-- Tabla Cliente Juridico
USE ALQUIFACIL
GO
CREATE TABLE ClienteJuridico
(
    id_Cliente int NOT NULL,
	ced_juridica varchar(20) not null,
    razon_social varchar(100) NOT NULL,
    telefono varchar(15) null,
	correo varchar(50) null,
	tipo_cliente int NOT NULL
)
ON CLIENTES
GO

--CREACION DE PK

USE ALQUIFACIL
GO
ALTER TABLE ClienteJuridico
ADD CONSTRAINT PK_ClienteJuridico 
PRIMARY KEY (id_Cliente)
GO

USE ALQUIFACIL
GO
ALTER TABLE ClienteJuridico
ADD CONSTRAINT FK_ClienteJuridico_Cliente 
FOREIGN KEY (id_Cliente) REFERENCES CLIENTE(id_Cliente)
GO
