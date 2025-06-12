--Reporte de Clientes que alquilan kits específicos con mayor frecuencia
-- Proyecto ALQUIFÁCIL 

USE ALQUIFACIL
GO
CREATE PROCEDURE sp_verClientesAlquilerKitsEspecificos
AS
    SELECT TOP 10
        CLIENTE.id_Cliente,
        CASE 
            WHEN ClienteFisico.id_Cliente IS NOT NULL THEN 'Físico'
            WHEN ClienteJuridico.id_Cliente IS NOT NULL THEN 'Jurídico'
            ELSE 'Desconocido'
        END AS 'Tipo de Cliente',

        ISNULL(RTRIM(ClienteFisico.nombre) + ' ' + RTRIM(ClienteFisico.apellido1) + ' ' + RTRIM(ClienteFisico.apellido2), ClienteJuridico.razon_social) AS 'Nombre del cliente',
        Kit.nombre AS 'Nombre del kit',

        COUNT(*) AS 'Cantidad de veces que lo ha alquilado'

    FROM CLIENTE
    LEFT JOIN ClienteFisico ON CLIENTE.id_Cliente = ClienteFisico.id_Cliente
    LEFT JOIN ClienteJuridico ON CLIENTE.id_Cliente = ClienteJuridico.id_Cliente
    INNER JOIN Alquiler ON CLIENTE.id_Cliente = Alquiler.Id_cliente
    INNER JOIN AlquilerKit ON Alquiler.num_Contrato = AlquilerKit.num_contrato
    INNER JOIN Kit ON AlquilerKit.codigo_kit = Kit.codigo_kit

    GROUP BY 
        CLIENTE.id_Cliente,
        ClienteFisico.nombre, ClienteFisico.apellido1, ClienteFisico.apellido2,
        ClienteJuridico.razon_social,
        ClienteFisico.id_Cliente, ClienteJuridico.id_Cliente,
        Kit.nombre

    ORDER BY 'Cantidad de veces que lo ha alquilado' DESC;
GO

EXEC sp_verClientesAlquilerKitsEspecificos
GO