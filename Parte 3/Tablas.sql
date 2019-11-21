--create database BancoXY
go
use BancoXY
go
create table Pais(
	Id_pais int primary key identity(1,1),
	Nombre varchar(20) not null
)
insert into Pais values('Republica Dominicana')
create table Cliente (
	Id_cliente int primary key identity(1,1),
	Nombre varchar(50) not null,
	Id_pais int not null foreign key references Pais(Id_pais)
)
insert into Cliente values('Dawin',1)
create table Cuenta(
	Id_cuenta int primary key identity(1,1),
	Id_cliente int not null foreign key references Cliente(Id_cliente),--Asumiendo que Nombre  hace referencia a la tabla cliente se 
	--reemplazo por el campo Id_cliente la cual hace referencia a dicha tabla
	Tipo int not null check (Tipo in(1,2))--Donde 1 es cuenta de Ahorro y 2 es cuenta de Prestamo
)
insert into Cuenta values(1,2)
Create table Ahorro(
	Id_cuenta int primary key foreign key references Cuenta(Id_cuenta),
	Monto_apertura  decimal(12,1) not null,
	Balance decimal (12,1) not null
)
select * from Cuenta
create table Prestamo(
	Id_prestamo int primary key identity(1,1),
	Id_cuenta int foreign key references Cuenta(Id_cuenta),
	CantidadCuotas int not null,
	Monto decimal(12,1) not null,
	Saldo decimal(12,1) not null
)
insert into Prestamo values(1,2,10000,5000)
insert into Prestamo values(3,2,10000,5000)
create table PagoPrestamo(
	Id_pago int primary key identity(1,1),
	Id_cuenta int foreign key references Prestamo(Id_prestamo),
	Monto decimal(12,1) not null,
	Fecha datetime default getdate() not null
)

insert into PagoPrestamo values(2,3000,getdate())