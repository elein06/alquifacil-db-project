-- Checks para filegroup herramientas 

--TABLA HERRAMIENTA

-- Año de adquisición no puede ser en el futuro
use ALQUIFACIL
go
ALTER TABLE Herramienta
ADD CONSTRAINT CHK_Anio_Adquisicion
CHECK (Anio_Adquisicion <= YEAR(GETDATE()))
go

-- Stock debe ser mayor o igual a 0
use ALQUIFACIL
go
ALTER TABLE Herramienta
ADD CONSTRAINT CHK_Stock_Herramientas_Positive
CHECK (Stock_Herramientas >= 0)
go

-- Valor de reposición debe ser positivo o cero
use ALQUIFACIL
go
ALTER TABLE Herramienta
ADD CONSTRAINT CHK_Valor_Reposicion_Positive
CHECK (Valor_Reposicion >= 0)
go

-- Stock por defecto en 0
use ALQUIFACIL
go
ALTER TABLE Herramienta
ADD CONSTRAINT DF_Stock_Herramientas
DEFAULT 1 FOR Stock_Herramientas
go
-- Tabla TIPO
-- Validar que el tipo sea uno de los permitidos
use ALQUIFACIL
go
ALTER TABLE Tipo
ADD CONSTRAINT CK_Tipo_Validar_Nombre
CHECK (nombreTipo IN ('Eléctrica', 'Manual', 'Motorizada'))
go

-- Tabla Estado
-- Validar que el estado sea uno de los permitidos
use ALQUIFACIL
go
ALTER TABLE Estado
ADD CONSTRAINT CK_EstadoActual_Validar_Nombre
CHECK (nombreEstado IN ('Disponible', 'Alquilada', 'En mantenimiento', 'Dada de baja', 'No disponible'))
go

-- Estado por defecto en Disponible
use ALQUIFACIL
go
ALTER TABLE Estado
ADD CONSTRAINT DF_EstadoActual_Nombre
DEFAULT 'Disponible' FOR nombreEstado
go

-- Tabla CondicionFisica
-- Validar que la condición física sea una de las opciones válidas
use ALQUIFACIL
go
ALTER TABLE CondicionFisica
ADD CONSTRAINT CK_CondicionFisica_Validar_Nombre
CHECK (Nombre_Condicion IN ('Excelente', 'Buena', 'Regular', 'Defectuosa'))
go

-- Condición física por defecto 'Excelente'
use ALQUIFACIL
go
ALTER TABLE CondicionFisica
ADD CONSTRAINT DF_CondicionFisica_Nombre
DEFAULT 'Excelente' FOR Nombre_Condicion
go




-- Tabla Kit

--Checks

-- Validar que codigo_Kit sea positivo
use ALQUIFACIL
go
ALTER TABLE Kit
ADD CONSTRAINT CK_Kit_Codigo_Positivo
CHECK (codigo_Kit > 0)
go


-- Validar que nombre no sea una cadena vacía
use ALQUIFACIL
go
ALTER TABLE Kit
ADD CONSTRAINT CK_Kit_Validar_Nombre
CHECK (LTRIM(RTRIM(nombre)) <> '')
go


-- Validar que tarifa_Diaria_Especial sea mayor o igual a 0
use ALQUIFACIL
go
ALTER TABLE Kit
ADD CONSTRAINT CK_Kit_Validar_Tarifa
CHECK (tarifa_Diaria_Especial >= 0)
go


-- Validar que id_Categoria sea válido
use ALQUIFACIL
go
ALTER TABLE Kit
ADD CONSTRAINT CK_Kit_Validar_id_Categoria
CHECK (id_Categoria > 0)
go

--Fin Checks


--Defaults 

-- Valor por defecto para nombre
use ALQUIFACIL
go
ALTER TABLE Kit
ADD CONSTRAINT DF_Kit_Nombre
DEFAULT 'Kit Sin Nombre' FOR nombre
go

-- Valor por defecto para tarifa diaria especial
use ALQUIFACIL
go
ALTER TABLE Kit
ADD CONSTRAINT DF_Kit_Tarifa
DEFAULT 0.00 FOR tarifa_Diaria_Especial

--Fin Defaults 



--Tabla KitHerramienta

--Checks

-- Validar que el id de KitHerramienta es positivo
use ALQUIFACIL
go
ALTER TABLE KitHerramienta
ADD CONSTRAINT CK_KitHerramienta_Id_Positivo
CHECK (id_KitHerramienta > 0)
go


-- Validar que el código de Kit sea positivo
use ALQUIFACIL
go
ALTER TABLE KitHerramienta
ADD CONSTRAINT CK_KitHerramienta_codigo_Kit_Positivo
CHECK (codigo_Kit > 0)
go


-- Validar que el id de Herramienta sea positivo
use ALQUIFACIL
go
ALTER TABLE KitHerramienta
ADD CONSTRAINT CK_KitHerramienta_Id_Herramienta_Positivo
CHECK (Id_Herramienta > 0)
go

-- Validar que la cantidad de herramientas sea positiva 
use ALQUIFACIL
go
ALTER TABLE KitHerramienta
ADD CONSTRAINT CK_KitHerramienta_Validar_Cantidad
CHECK (cantidad_Herramientas > 0)
go
--Fin Checks

--Defaults

-- Valor por defecto para la cantidad de herramientas
use ALQUIFACIL
go
ALTER TABLE KitHerramienta
ADD CONSTRAINT DF_KitHerramienta_Cantidad
DEFAULT 1 FOR cantidad_Herramientas
go

--Fin Defaults


----CHECKS TABLA CATEGORIA

--verificar que el nombre de la categoria sea uno de las opciones validas
USE ALQUIFACIL
go
ALTER TABLE Categoria
ADD CONSTRAINT CK_Categoria_ValidarNombre
CHECK (nombre_categoria IN ('Construccion', 'Jardineria', 'Hogar'))
go

-- Validar que el nombre de la categoria no sean nulo
use ALQUIFACIL
go
ALTER TABLE Categoria
ADD CONSTRAINT CK_Categoria_ValidarNombreVacio
CHECK (LTRIM(RTRIM(nombre_categoria)) <> '')
go