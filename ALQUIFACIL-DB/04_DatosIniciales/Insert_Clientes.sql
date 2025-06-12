-- Insert Clientes
-- Proyecto ALQUIFÁCIL


--						procedimiento almacenado para agregar cliente físico

USE ALQUIFACIL
GO
CREATE PROCEDURE sp_InsertarClienteFisico (
    @_ced_fisica VARCHAR(20),
    @_nombre VARCHAR(50),
    @_apellido1 VARCHAR(50),
    @_apellido2 VARCHAR(50),
    @_telefono VARCHAR(15),
    @_correo VARCHAR(50),
    @_tipo_cliente INT)
AS
BEGIN TRY
        BEGIN TRANSACTION;
			-- Insertar en la tabla CLIENTE
			INSERT INTO CLIENTE (telefono, correo, tipo_cliente)
			VALUES (@_telefono, @_correo, @_tipo_cliente)

			DECLARE @nuevoId INT = SCOPE_IDENTITY() -- esta línea guarda el id generado en CLIENTE en la variable @nuevoId

			-- Insertar en ClienteFisico
			INSERT INTO ClienteFisico (id_Cliente, ced_fisica, nombre, apellido1, apellido2)
			VALUES (@nuevoId, @_ced_fisica, @_nombre, @_apellido1, @_apellido2)

			COMMIT TRANSACTION;
        PRINT 'EL CLIENTE FÍSICO SE HA REGISTRADO CORRECTAMENTE.';
    END TRY

    BEGIN CATCH
        ROLLBACK TRANSACTION;
        PRINT 'Error: ' + ERROR_MESSAGE();
    END CATCH
GO

--										agregar 10 clientes físicos a la tabla clienteFisico

exec sp_InsertarClienteFisico '604790218', 'Elein', 'Rodríguez', 'Chavarría', '60360695', 'rodriguezrayeli06@gmail.com', 1
GO

exec sp_InsertarClienteFisico '504520784', 'Karina', 'Moreno', 'Diaz', '60694160', 'karina.moreno.diaz@gmail.com', 2
GO

exec sp_InsertarClienteFisico '801350281', 'Elizabeth', 'Chavarría', 'Chavarría', '60434580', 'elichavarria@gmail.com', 1
GO

exec sp_InsertarClienteFisico '504420400', 'Jehnua Javier', 'Ramírez', 'Gomez', '83554901', 'jehnuaramirezgomez@gmail.com', 1
GO

exec sp_InsertarClienteFisico '108460561', 'Ewell', 'Marchena', 'Aguilar', '89452763', 'ewellmarchena@gmail.com', 2
GO

exec sp_InsertarClienteFisico '604590485', 'Jair José', 'Ugalde', 'Chavarría', '70825541', 'jairugalde@gmail.com', 1
GO

exec sp_InsertarClienteFisico '604910996', 'Joshua Roberto', 'Solis', 'Chavarría', '60529873', 'joshuasolis@gmail.com', 1
GO

exec sp_InsertarClienteFisico '505670235', 'Eliott', 'Ramirez', 'Rodriguez', '88888888', 'eliott.rr@gmail.com', 2
GO

exec sp_InsertarClienteFisico '504420344', 'Delis Johanna', 'Cascante', 'Cruz', '60773117', 'deliscantantec@gmail.com', 2
GO

exec sp_InsertarClienteFisico '504360829', 'Ambar Fiorelly', 'Barrantes', 'Ruiz', '85639142', 'wolfchild@gmail.com', 2
GO





--											procedimiento almacenado para agregar cliente jurídico

USE ALQUIFACIL
GO
CREATE PROCEDURE sp_InsertarClienteJuridico (
    @_ced_juridica VARCHAR(20),
    @_razon_social VARCHAR(100),
    @_telefono VARCHAR(15),
    @_correo VARCHAR(50),
    @_tipo_cliente INT)
AS
BEGIN TRY
        BEGIN TRANSACTION;
			-- Insertar en la tabla CLIENTE
			INSERT INTO CLIENTE (telefono, correo, tipo_cliente)
			VALUES (@_telefono, @_correo, @_tipo_cliente)

			DECLARE @nuevoId INT = SCOPE_IDENTITY()-- obtener el id generado

			-- Insertar en ClienteJuridico
			INSERT INTO ClienteJuridico (id_Cliente, ced_juridica, razon_social)
			VALUES (@nuevoId, @_ced_juridica, @_razon_social);

		COMMIT TRANSACTION;
     PRINT 'EL CLIENTE JURÍDICO SE HA REGISTRADO CORRECTAMENTE';
END TRY

 BEGIN CATCH
     ROLLBACK TRANSACTION;
     PRINT 'Error: ' + ERROR_MESSAGE();
END CATCH
GO


--											agregar 10 clientes Jurídicos a la tabla ClienteJuridico

EXEC sp_InsertarClienteJuridico '111111111', 'Fundación Monkey Park', '26660000', 'monkeypark@gmail.com', 2
GO

EXEC sp_InsertarClienteJuridico '222222222', 'Constructora del Sur S.A.', '22558844', 'contacto@constructsursa.com', 1
GO

EXEC sp_InsertarClienteJuridico '333333333', 'Distribuidora Eléctrica CR', '24002211', 'ventas@electrica-cr.com', 1
GO

EXEC sp_InsertarClienteJuridico '444444444', 'Clinica Dental Sonrisas S.A.', '22770011', 'info@sonrisas.com', 2
GO

EXEC sp_InsertarClienteJuridico '555555555', 'Agencia de Viajes Pura Vida', '22998877', 'reservas@puravidaviajes.com', 1
GO

EXEC sp_InsertarClienteJuridico '666666666', 'Tecnologías Innovadoras S.A.', '25252525', 'soporte@innovatech.com', 2
GO

EXEC sp_InsertarClienteJuridico '777777777', 'Consultores Ambientales Verde', '26440088', 'contacto@verdeconsultores.com', 2
GO

EXEC sp_InsertarClienteJuridico '888888888', 'Transportes del Norte', '24332211', 'info@transnorte.com', 1
GO

EXEC sp_InsertarClienteJuridico '999999999', 'Hotel Playa Azul S.A.', '26778899', 'reservas@playazulhotel.com', 1
GO

EXEC sp_InsertarClienteJuridico '101010101', 'Editorial Costa Rica', '22224444', 'contacto@editorialcr.com', 2
GO