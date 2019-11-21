--Crea una función que partiendo del tipo de la cuenta me retorne la descripción.
alter function descripcion_cuenta(@tipo int)
returns varchar(50)
begin
	if @tipo=1
	begin
		return 'Descripcion de cuenta de ahorro'
	end
	else if @tipo=2
	begin
		return 'Descripcion de cuenta de prestamo'
	end
	return 'El tipo de cuenta especificado no se ha encontrado en la base de datos'
end
select dbo.descripcion_cuenta(1)
--Crea un procedimiento almacenado que dependiendo del tipo de cuenta retorne el balance o saldo.
create procedure PA_retorna_balance_saldo 
@id_cuenta int
as
begin
	declare @tipo int
	select @tipo=tipo from Cuenta where Cuenta.Id_cuenta=@id_cuenta
	if @tipo=1
	begin
		Select * from Ahorro where Id_cuenta=@id_cuenta
	end
	else 
	begin
		Select * from Prestamo where Id_cuenta=@id_cuenta
	end
end
exec PA_retorna_balance_saldo 1






--Crea una consulta que genere un listado de los clientes con cada préstamo que ha tomado y el total pagado. 
Select Cliente.Nombre,COUNT(Prestamo.Id_cuenta) as Prestamos,SUM(PagoPrestamo.Monto) as 'Total pagado' from Cliente 
inner join Cuenta on Cuenta.Id_cliente=Cliente.Id_cliente inner join Prestamo on Cuenta.Id_cuenta=Prestamo.Id_cuenta
inner join PagoPrestamo on Prestamo.Id_cuenta=PagoPrestamo.Id_cuenta group by Cliente.Nombre where PagoPrestamo.


select * from Prestamo
Select * from Cliente
select * from Cuenta

insert into Cuenta values(2,2)
insert into Prestamo values(4,3,15000,5000)
select * from PagoPrestamo
insert into PagoPrestamo values(4,3000,GETDATE())
