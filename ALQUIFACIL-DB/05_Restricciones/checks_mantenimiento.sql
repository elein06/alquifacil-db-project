-- Checks de filegroup mantenimietno 


--			TABLA MANTENIMIENTO
-- Costo no puede ser negativo
use ALQUIFACIL
go
ALTER TABLE Mantenimiento
ADD CONSTRAINT CK_Mantenimiento_Costo_Positive
CHECK (Costo >= 0);
go

-- Fecha no puede ser futura
use ALQUIFACIL
go
ALTER TABLE Mantenimiento
ADD CONSTRAINT CK_Mantenimiento_Validar_Fecha
CHECK (Fecha_Mantenimiento <= GETDATE());
go

-- Modalidad servicio: interno o externo
use ALQUIFACIL
go
ALTER TABLE Mantenimiento
ADD CONSTRAINT CK_Mantenimiento_Validar_Modalidad
CHECK (Modalidad_Servicio IN ('Interno', 'Externo'));
go



--			TABLA PERSONA RESPONSABLE}

-- Validar que nombre y apellidos no sean nulos
use ALQUIFACIL
go
ALTER TABLE Persona_Responsable
ADD CONSTRAINT CK_PersonaResponsable_Validar_Nombre
CHECK (LTRIM(RTRIM(nombre)) <> '');
go

use ALQUIFACIL
go
ALTER TABLE Persona_Responsable
ADD CONSTRAINT CK_PersonaResponsable_Validar_Apellido1
CHECK (LTRIM(RTRIM(apellido1)) <> '');
go

use ALQUIFACIL
go
ALTER TABLE Persona_Responsable
ADD CONSTRAINT CK_PersonaResponsable_Validar_Apellido2
CHECK (LTRIM(RTRIM(apellido2)) <> '');
go

--			TABLA TIPO DE MANTENIMIENTO

-- validar que el nombre del mantenimiento sea preventivo o correctivo
use ALQUIFACIL
go
ALTER TABLE tipo_mantenimiento
ADD CONSTRAINT CK_TipoMantenimiento_ValidarNombre
CHECK (nombre_tipo_mantenimiento IN ('Preventivo', 'Correctivo'))
go
