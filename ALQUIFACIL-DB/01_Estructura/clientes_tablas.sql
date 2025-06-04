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
	tipo_cliente int not null,

    CONSTRAINT PK_ClienteFisico PRIMARY KEY (id_Cliente),
    CONSTRAINT FK_ClienteFisico_Cliente FOREIGN KEY (id_Cliente) REFERENCES CLIENTE(id_Cliente),
	CONSTRAINT  CK_ClienteFisico_Tipo CHECK (tipo_cliente IN (1,2)) -- 1= recurrente, 2= ocasional
)
ON CLIENTES
GO


USE ALQUIFACIL
GO
CREATE TABLE ClienteJuridico
(
    id_Cliente int NOT NULL,
	ced_juridica varchar(20) not null,
    razon_social varchar(100) NOT NULL,
    telefono varchar(15) null,
	correo varchar(50) null,
	tipo_cliente int NOT NULL,

    CONSTRAINT PK_ClienteJuridico PRIMARY KEY (id_Cliente),
    CONSTRAINT FK_ClienteJuridico_Cliente FOREIGN KEY (id_Cliente) REFERENCES CLIENTE(id_Cliente),
	CONSTRAINT CK_ClienteJuridico_Tipo CHECK (tipo_cliente IN (1,2)) -- 1= recurrente, 2= ocasional
)
ON CLIENTES
GO