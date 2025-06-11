-- ControlPermisos
-- Proyecto ALQUIFÁCIL


USE master
GO

use ALQUIFACIL
GO

-- RolAdministrativo: Tiene permisos para todo
/*
GRANT SELECT, INSERT, UPDATE, DELETE ON Cliente TO RolAdministrativo;
go

GRANT SELECT, INSERT, UPDATE, DELETE ON Herramienta TO RolAdministrativo;
go

GRANT SELECT, INSERT, UPDATE, DELETE ON Alquiler TO RolAdministrativo;
go
*/

GRANT CONTROL ON DATABASE::ALQUIFACIL TO RolAdministrativo
GO



-- RolConsulta: Solo puede realizar operaciones de lectura y ejecución de reportes
/*
GRANT SELECT ON Cliente TO RolConsulta;
go

GRANT SELECT ON Herramienta TO RolConsulta;
go

GRANT SELECT ON Alquiler TO RolConsulta;
go

GRANT EXECUTE ON sp_verHerramientasRetiradas TO RolConsulta;
go
*/

GRANT SELECT ON SCHEMA::dbo TO RolConsulta
GO

GRANT EXECUTE ON dbo.sp_verClientesAlquilerKitsEspecificos TO RolConsulta;
GO


GRANT EXECUTE ON dbo.sp_verClientesFrecuentes TO RolConsulta;
GO

GRANT EXECUTE ON dbo.sp_VerReporteDevolucionesMalEstado TO RolConsulta;
GO

GRANT EXECUTE ON dbo.sp_VerCantidadAlquiladas TO RolConsulta;
GO

GRANT EXECUTE ON dbo.sp_verHerramientasRetiradas TO RolConsulta;
GO

GRANT EXECUTE ON dbo.sp_VerCantidadDevoluciones TO RolConsulta;
GO

GRANT EXECUTE ON dbo.sp_VerCantidadMantenimientos TO RolConsulta;
GO

GRANT EXECUTE ON dbo.sp_VerMantenimientosPorTipo TO RolConsulta;
GO

GRANT EXECUTE ON dbo.sp_VerHistorialDiasDeRetraso TO RolConsulta;
GO

GRANT EXECUTE ON dbo.sp_ReporteKitsPorTemporada TO RolConsulta;
GO

GRANT EXECUTE ON dbo.sp_VerReporteRentabilidadHerramientas TO RolConsulta;
GO


-- RolInsercion:Solo puede realizar inserción, pero no actualizar ni borrar
/*GRANT INSERT ON Cliente TO RolInsercion;
go

GRANT INSERT ON Herramienta TO RolInsercion;
go

GRANT INSERT ON Alquiler TO RolInsercion;
go


GRANT EXECUTE TO RolInsercion;
go
*/

GRANT SELECT, INSERT ON SCHEMA::dbo TO RolInsercion
GO


GRANT EXECUTE ON dbo.sp_RegistrarAlquileresConHerramientas TO RolInsercion;
GO

GRANT EXECUTE ON dbo.sp_RegistrarAlquileresConKits TO RolInsercion;
GO

GRANT EXECUTE ON dbo.sp_InsertarClienteFisico TO RolInsercion;
GO

GRANT EXECUTE ON dbo.sp_InsertarClienteJuridico TO RolInsercion;
GO

GRANT EXECUTE ON dbo.sp_RegistrarDevolucionConHerramienta TO RolInsercion;
GO

GRANT EXECUTE ON dbo.sp_RegistrarKitDevolucion TO RolInsercion;
GO

GRANT EXECUTE ON dbo.sp_InsertarCategoria TO RolInsercion;
GO

GRANT EXECUTE ON dbo.sp_ingresoEstado TO RolInsercion;
GO

GRANT EXECUTE ON dbo.sp_ingresoTipo TO RolInsercion;
GO


GRANT EXECUTE ON dbo.sp_ingresoCondicionFisica TO RolInsercion;
GO


GRANT EXECUTE ON dbo.sp_ingresoHerramienta TO RolInsercion;
GO


GRANT EXECUTE ON dbo.sp_IngresarKitConHerramientas TO RolInsercion;
GO


GRANT EXECUTE ON dbo.sp_ingresoPersonaResponsable TO RolInsercion;
GO


GRANT EXECUTE ON dbo.sp_InsertarTipoMantenimiento TO RolInsercion;
GO


GRANT EXECUTE ON dbo.sp_ingresoMantenimiento TO RolInsercion;
GO
