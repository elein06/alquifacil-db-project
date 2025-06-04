use ALQUIFACIL
go

create table Devolucion(
	Id_Devolucion int not null,
	estado varchar(50) null,
	costo_Reparacion money null,
	cargos_Por_Dia_Atraso money null,
	id_Cliente int null
)
on HERRAMIENTAS
go

alter table Devolucion
add constraint PK_Devolucion_Id
primary key (Id_Devolucion)
go

alter table Devolucion
add constraint FK_Devolucion_Cliente
foreign key (id_Cliente) references Cliente(Id_Cliente)
go

exec sp_help Devolucion
go
