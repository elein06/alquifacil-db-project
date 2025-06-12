--  VIEWS TABLAS PRINCIPALES
-- Proyecto ALQUIFÁCIL

USE master
GO
--VISTA  GENERAL DE HERRAMIENTAS
USE ALQUIFACIL
GO
CREATE VIEW vw_Herramienta 
AS
SELECT 
    Id_Herramienta,
    Numero_Serie,
    Anio_Adquisicion,
    Valor_Reposicion,
    Stock_Herramientas,
    Marca,
    Modelo,
    Id_Estado,
    Id_Tipo,
    Id_Condicion_Fisica,
    Id_Categoria
FROM Herramienta;
GO

SELECT * FROM vw_Herramienta;
GO


--VISTA GENERAL DE KITS
USE ALQUIFACIL
GO
CREATE VIEW vw_Kits
AS
SELECT 
    codigo_Kit,
    nombre,
    tarifa_Diaria_Especial,
    id_Categoria,
    Id_Estado
FROM Kit;
GO

SELECT * FROM vw_Kits;
GO



--VISTA CON LOS CLIENTES JURIDICOS
USE ALQUIFACIL
GO
CREATE VIEW vw_ClienteJuridico
AS
SELECT 
    c.id_Cliente,
    c.telefono,
    c.correo,
    c.tipo_cliente,
    cj.ced_juridica AS 'Cédula Jurídica',
    cj.razon_social
FROM Cliente c
INNER JOIN ClienteJuridico cj ON c.id_Cliente = cj.id_Cliente;
GO

SELECT * FROM vw_ClienteJuridico;
GO



--VISTA CON LOS CLIENTES FISICOS
USE ALQUIFACIL
GO
CREATE VIEW vw_ClienteFisico 
AS
SELECT 
    c.id_Cliente,
	cf.ced_fisica AS 'Cédula Física',
    cf.nombre + ' ' + cf.apellido1 + ' ' + cf.apellido2 AS 'Nombre Completo',
	c.tipo_cliente,
    c.telefono,
	c.correo
FROM Cliente c
INNER JOIN ClienteFisico cf ON c.id_Cliente = cf.id_Cliente;
GO

SELECT * FROM vw_ClienteFisico;
GO


--VISTA GENERAL DE LA INFO DE LOS CLIENTES
USE ALQUIFACIL;
GO
CREATE VIEW vw_TodosClientes
AS
SELECT 
    c.id_Cliente,
    c.telefono,
    c.correo,
    c.tipo_cliente,
    'Físico' AS tipo_persona,
    cf.ced_fisica AS cedula,
    cf.nombre + ' ' + cf.apellido1 + ' ' + cf.apellido2 AS nombre_completo,
    NULL AS razon_social
FROM 
    Cliente c
    INNER JOIN ClienteFisico cf ON c.id_Cliente = cf.id_Cliente

UNION ALL

SELECT 
    c.id_Cliente,
    c.telefono,
    c.correo,
    c.tipo_cliente,
    'Jurídico' AS tipo_persona,
    cj.ced_juridica AS cedula,
    NULL AS nombre_completo,
    cj.razon_social
FROM 
    Cliente c
    INNER JOIN ClienteJuridico cj ON c.id_Cliente = cj.id_Cliente;
GO

SELECT * FROM vw_TodosClientes
GO


--VISTA GENERAL DE MANTENIMIENTO
USE ALQUIFACIL
GO
CREATE VIEW vw_Mantenimiento
AS
SELECT 
    Id_Mantenimiento,
    Costo,
    Fecha_Mantenimiento,
    Modalidad_Servicio,
    Observaciones,
    Id_Tipo_Mantenimiento,
    Id_Persona_Responsable,
    Id_Herramienta
FROM Mantenimiento;
GO


SELECT * FROM vw_Mantenimiento;
GO


--VISTA GENERAL DE ALQUILER
USE ALQUIFACIL
GO
CREATE VIEW vw_Alquiler 
AS
SELECT 
    num_Contrato,
    fecha_Inicio,
    fecha_Dev,
    tarifa_Total_Diaria,
    deposito_Garantia,
    costo_alquiler,
    estado_Contrato,
    Id_cliente
FROM Alquiler;
GO

SELECT * FROM vw_Alquiler;
GO