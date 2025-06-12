-- ControlPermisos
-- Proyecto ALQUIFÁCIL

USE MASTER
GO
-- RolAdministrativo: Tiene permisos para todo

GRANT CONTROL ON DATABASE::ALQUIFACIL TO RolAdministrativo
GO



USE ALQUIFACIL
GO
-- RolConsulta: Solo puede realizar operaciones de lectura y ejecución de reportes

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



USE ALQUIFACIL
GO
-- RolInsercion: Solo puede realizar inserción, pero no actualizar ni borrar

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