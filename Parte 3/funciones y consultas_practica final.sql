--2
create function descripcion_cuenta(@tipo varchar(15))
returns varchar(50)
begin
	if lower(@tipo)='ahorro'
	begin
		return 'Descripcion de cuenta de ahorro'
	end
	else if lower(@tipo)='prestamo'
	begin
		return 'Descripcion de cuenta de prestamo'
	end
	return 'El tipo de cuenta especificado no se ha encontrado en la base de datos'
end

--3
create procedure PA_retorna_balance_saldo 
@tipo varchar(15)
as
begin
	if LOWER(@tipo)='ahorro'
	begin
		select * from Ahorro
	end
	else if LOWER(@tipo)='prestamo' 
	begin
		Select * from Prestamo
	end
	else 
	begin
		Print 'No se encontro el tipo de cuenta'
	end
end

--4
Select Cliente.Nombre,COUNT(Prestamo.Id_cuenta) as Prestamos,SUM(PagoPrestamo.Monto) as 'Total pagado' from Cliente inner join Cuenta on Cuenta.Id_cliente=Cliente.Id_cliente
inner join Prestamo on Cuenta.Id_cuenta=Prestamo.Id_cuenta inner join PagoPrestamo on Prestamo.Id_prestamo=PagoPrestamo.Id_cuenta group by Cliente.Nombre
