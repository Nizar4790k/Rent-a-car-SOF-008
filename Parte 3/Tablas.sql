create database BancoXY
go
use BancoXY
go
create table Pais(
	Id_pais int primary key identity(1,1),
	Nombre varchar(20) not null
)
go
create table Cliente (
	Id_cliente int primary key identity(1,1),
	Nombre varchar(50) not null,
	IdPais int not null foreign key references Pais(Id_pais)
)
go
create table Cuenta(
	Id_cuenta int primary key identity(1,1),
	Id_cliente int not null foreign key references Cliente(Id_cliente),--Asumiendo que Nombre  hace referencia a la tabla cliente se 
	--reemplazo por el campo Id_cliente la cual hace referencia a dicha tabla
	Tipo int not null check (Tipo in(1,2))--Donde 1 es cuenta de Ahorro y 2 es cuenta de Prestamo
)
go
Create table Ahorro(
	Id_cuenta int primary key foreign key references Cuenta(Id_cuenta),
	Monto_apertura  decimal(12,1) not null,
	Balance decimal (12,1) not null

go
create table Prestamo(
	Id_cuenta int primary key foreign key references Cuenta(Id_cuenta),
	CantidadCuotas int not null,
	Monto decimal(12,1) not null,
	Saldo decimal(12,1) not null
)
drop table Prestamo
--Se agrego el campo Id_prestamo para que sea la primary key ya que el Id_cuenta no puede serlo esto debido a que en esta 
--tabla esta contemplado que una cuenta pueda tener mas de un prestamo
go
create table PagoPrestamo(
	Id_pago int primary key identity(1,1),
	Id_cuenta int foreign key references Prestamo(Id_cuenta),
	Monto decimal(12,1) not null,
	Fecha datetime default getdate() not null
)