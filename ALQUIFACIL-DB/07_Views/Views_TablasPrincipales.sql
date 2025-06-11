--  VIEWS TABLAS PRINCIPALES
-- Proyecto ALQUIFÁCIL

USE master
GO

USE ALQUIFACIL
GO

--VISTA  GENERAL DE HERRAMIENTAS
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
CREATE VIEW vw_ClienteJuridico
AS
SELECT 
    c.id_Cliente,
    c.telefono,
    c.correo,
    c.tipo_cliente,
    cj.ced_juridica AS cedula,
    CAST(NULL AS VARCHAR(150)) AS nombre_completo,
    cj.razon_social,
    'Juridico' AS tipo_cliente_nombre
FROM Cliente c
INNER JOIN ClienteJuridico cj ON c.id_Cliente = cj.id_Cliente;

SELECT * FROM vw_ClienteJuridico;
GO



--VISTA CON LOS CLIENTES FISICOS
CREATE VIEW vw_ClienteFisico 
AS
SELECT 
    c.id_Cliente,
    c.telefono,
    c.correo,
    c.tipo_cliente,
    cf.ced_fisica AS cedula,
    cf.nombre + ' ' + cf.apellido1 + ' ' + cf.apellido2 AS nombre_completo,
    CAST(NULL AS VARCHAR(100)) AS razon_social,
    'Fisico' AS tipo_cliente_nombre
FROM Cliente c
INNER JOIN ClienteFisico cf ON c.id_Cliente = cf.id_Cliente;

SELECT * FROM vw_ClienteFisico;
GO


--VISTA GENERAL DE LA INFO DE LOS CLIENTES
CREATE VIEW vw_ClienteGeneral
AS
SELECT * FROM vw_ClienteFisico
UNION
SELECT * FROM vw_ClienteJuridico;
GO


SELECT * FROM vw_ClienteGeneral
GO


--VISTA GENERAL DE MANTENIMIENTO
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