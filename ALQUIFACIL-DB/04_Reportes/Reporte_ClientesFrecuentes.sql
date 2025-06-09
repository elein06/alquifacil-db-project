-- Reporte de Clientes Frecuentes
-- Proyecto ALQUIFÁCIL

USE ALQUIFACIL
GO
CREATE PROCEDURE sp_verClientesFrecuentes
AS
    SELECT TOP 10
        CLIENTE.id_Cliente as 'ID del cliente',
        CASE 
            WHEN ClienteFisico.id_Cliente IS NOT NULL THEN 'Físico'
            WHEN ClienteJuridico.id_Cliente IS NOT NULL THEN 'Jurídico'
            ELSE 'Desconocido'
        END AS 'Tipo de Cliente',
        ISNULL(RTRIM(ClienteFisico.nombre) + ' ' + RTRIM(ClienteFisico.apellido1) + ' ' + RTRIM(ClienteFisico.apellido2), ClienteJuridico.razon_social) AS 'Nombre del cliente',
        COUNT(Alquiler.num_Contrato) AS 'Cantidad de alquileres'
    FROM CLIENTE
    LEFT JOIN ClienteFisico ON CLIENTE.id_Cliente = ClienteFisico.id_Cliente
    LEFT JOIN ClienteJuridico ON CLIENTE.id_Cliente = ClienteJuridico.id_Cliente
    INNER JOIN Alquiler ON CLIENTE.id_Cliente = Alquiler.Id_cliente
    GROUP BY 
        CLIENTE.id_Cliente, 
        ClienteFisico.nombre, ClienteFisico.apellido1, ClienteFisico.apellido2, 
        ClienteJuridico.razon_social, 
        ClienteFisico.id_Cliente, ClienteJuridico.id_Cliente
    ORDER BY 'Cantidad de alquileres' DESC
GO

EXEC sp_verClientesFrecuentes;
go