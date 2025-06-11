-- BACKUPS PARA ALQUIFACIL

backup database ALQUIFACIL
-- Cambien la ruta
to disk = 'C:\Users\User\Desktop\Cursos UNA\Ciclo I 2025\Bases de Datos\Proyecto BD\ALQUIFACIL_backup.bak'
-- Para sobreescribir si ya existe el archivo
with format, Init,
name = 'BackupDeALQUIFACIL',
-- Para mostrar el progreso
skip, Norewind, Nounload, stats = 10;



-- Para restaurar la DB
restore database ALQUIFACIL
-- Cambie la ruta
from disk = 'C:\Users\User\Desktop\Cursos UNA\Ciclo I 2025\Bases de Datos\Proyecto BD\ALQUIFACIL_backup.bak'
-- Para sobreescribir la DB actual (CUIDADO!!!!!!!!!)
with replace;



-- Como proceso almacenado
create or alter procedure sp_BackupCompleto
	-- RutaDestino = la ruta del disco donde se hara
    @RutaDestino Nvarchar(255)
as
begin
    declare @AlquifacilBackup Nvarchar(255);
    set @AlquifacilBackup = @RutaDestino + 'Alquifacil_Backup' + format(getdate(), 'yyyyMMdd_HHmmss') + '.bak';

    backup database ALQUIFACIL
    to disk = @AlquifacilBackup
    with format , Init, name = 'Backup Completo de ALQUIFACIL',
         STATS = 10;
end



												-- Cambien la ruta
exec sp_BackupCompleto 'C:\Users\User\Desktop\Cursos UNA\Ciclo I 2025\Bases de Datos\Proyecto BD\'
go