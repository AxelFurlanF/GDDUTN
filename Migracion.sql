CREATE FUNCTION dbo.calcular_importe (@cliente_telefono numeric(18,0), @periodo_inicio datetime, @periodo_fin datetime)
RETURNS TABLE
AS
	RETURN (SELECT (Turno_Precio_Base+ Turno_Valor_Kilometro* Viaje_Cant_Kilometros) as importe, Viaje_Codigo as viaje FROM dbo.Viaje JOIN dbo.Turno ON Viaje_Turno=Turno_Codigo WHERE Viaje_Cliente=@cliente_telefono AND Viaje_Fecha_Hora_Inicio BETWEEN @periodo_inicio AND @periodo_fin)
GO
CREATE VIEW r1 AS SELECT DISTINCT Rendicion_Nro, Rendicion_Fecha, Rendicion_Importe, Chofer_Telefono, Turno_Codigo FROM gd_esquema.Maestra t1 JOIN dbo.Turno t ON t1.Turno_Descripcion=t.Turno_Descripcion  WHERE Rendicion_Nro IS NOT NULL
GO


/*
Vista para revisar facturación de un chofer y dia especificos para constrastarla con su rendición del mismo día: datos distintos
go
CREATE VIEW c1 as 
SELECT Viaje_Cant_Kilometros*(SELECT t.Turno_Valor_Kilometro FROM dbo.Turno t WHERE t.Turno_Codigo=v.Viaje_Turno) 
+ (SELECT t.Turno_Precio_Base FROM dbo.Turno t WHERE t.Turno_Codigo=v.Viaje_Turno) importe 
FROM dbo.Viaje v WHERE Viaje_Chofer=80191273 AND CONVERT(date,Viaje_Fecha_Hora_Inicio)='2015-01-01'
go
SELECT importe from c1
*/
DELETE FROM dbo.Funcionalidad_x_Rol
DELETE FROM dbo.Funcionalidad
DELETE FROM dbo.Rol_x_Usuario
DELETE FROM dbo.Viaje_x_Factura
DELETE FROM dbo.Viaje_x_Rendicion
DELETE FROM dbo.Rol
DELETE FROM dbo.Usuario
DELETE FROM dbo.Persona
DELETE FROM dbo.Rendicion
DELETE FROM dbo.Factura
DELETE FROM dbo.Viaje
DELETE FROM dbo.Auto
DELETE FROM dbo.Turno
DELETE FROM dbo.Chofer
DELETE FROM dbo.Marca
DELETE FROM dbo.Cliente


--Rol
-- dbo.Rol
INSERT INTO dbo.Rol(Rol_Nombre, Rol_Activo)
VALUES ('Administrador',1),('Cliente',1),('Chofer',1)
--Funcionalidad
-- dbo.Funcionalidad
INSERT INTO dbo.Funcionalidad(Funcionalidad_Nombre)
VALUES ('ABM_Rol'),('Registro_Usuario'),('ABM_Cliente'),('ABM_Auto'),('ABM_Chofer'),('Registro_Viajes'),('Generar_rendicion'),('Facturacion_Cliente'),('Listado_Estadistico')
--FuncionalidadxRol
--Consideraciones: el administrador puede realizar todas las operaciones, el chofer sólo puede registrar un viaje, el cliente solo podrá revisar su factura
-- dbo.Funcionalidad_x_Rol
INSERT INTO dbo.Funcionalidad_x_Rol(Rol_Codigo,Funcionalidad_Codigo)
SELECT (SELECT Rol_Codigo FROM dbo.Rol WHERE Rol_Nombre='Administrador'),Funcionalidad_Codigo FROM Funcionalidad
UNION
SELECT (SELECT Rol_Codigo FROM dbo.Rol WHERE Rol_Nombre='Cliente'),Funcionalidad_Codigo FROM Funcionalidad WHERE Funcionalidad_Nombre='Facturacion_Cliente'
UNION
SELECT (SELECT Rol_Codigo FROM dbo.Rol WHERE Rol_Nombre='Chofer'),Funcionalidad_Codigo FROM Funcionalidad WHERE Funcionalidad_Nombre='Registro_Viajes'

--Usuarios Clientes
--Consideraciones: ya que usamos el teléfono del cliente como clave principal, la misma será su usuario y clave.
-- dbo.Usuario
INSERT INTO dbo.Usuario(Usuario_Username, Usuario_Password, Usuario_Activo, Usuario_Reintentos)
SELECT DISTINCT Cliente_Telefono, HashBytes('SHA2_256',convert(varchar(255), Cliente_Telefono)), 1, 0 FROM gd_esquema.Maestra
--Insertar Rol
INSERT INTO dbo.Rol_x_Usuario(Rol_Codigo, Usuario_Username)
SELECT DISTINCT (SELECT Rol_Codigo FROM dbo.Rol WHERE Rol_Nombre='Cliente'), Cliente_Telefono FROM dbo.Cliente

--Usuarios Choferes
--Consideraciones: ya que usamos el teléfono del chofer como clave principal, la misma será su usuario y clave.
-- dbo.Usuario
INSERT INTO dbo.Usuario(Usuario_Username, Usuario_Password, Usuario_Activo, Usuario_Reintentos)
SELECT DISTINCT Chofer_Telefono, HashBytes('SHA2_256',convert(varchar(255), Chofer_Dni)), 1, 0 FROM gd_esquema.Maestra
--Insertar Rol
INSERT INTO dbo.Rol_x_Usuario(Rol_Codigo, Usuario_Username)
SELECT DISTINCT (SELECT Rol_Codigo FROM dbo.Rol WHERE Rol_Nombre='Chofer'), Chofer_Dni FROM dbo.Chofer

--Usuario Admin
-- dbo.Usuario
INSERT INTO dbo.Usuario(Usuario_Username, Usuario_Password, Usuario_Activo, Usuario_Reintentos)
VALUES ('admin',HashBytes('SHA2_256','w23e'),1,0)
--Insertar Rol
INSERT INTO dbo.Rol_x_Usuario(Rol_Codigo, Usuario_Username)
SELECT Rol_Codigo, 'admin' FROM dbo.Rol WHERE Rol_Nombre='Administrador'

--Persona
--dbo.Persona
INSERT INTO dbo.Persona(Persona_Telefono, Persona_Username)
SELECT DISTINCT Cliente_Telefono, Cliente_Telefono FROM gd_esquema.Maestra
UNION
SELECT DISTINCT Chofer_Telefono, Chofer_Telefono FROM gd_esquema.Maestra

--Cliente
-- dbo.Cliente
INSERT INTO dbo.Cliente (Cliente_Dni, Cliente_Nombre, Cliente_Apellido, Cliente_Direccion, Cliente_Telefono, Cliente_Mail, Cliente_Fecha_Nac, Cliente_Codigo_Postal, Cliente_Activo, Cliente_Persona)
SELECT DISTINCT Cliente_Dni, Cliente_Nombre, Cliente_Apellido, Cliente_Direccion, Cliente_Telefono, Cliente_Mail, Cliente_Fecha_Nac, 1, 1, 
Persona_Id
FROM gd_esquema.Maestra JOIN dbo.Persona ON Persona_Telefono=Cliente_Telefono
--Chofer
-- dbo.Chofer
INSERT INTO dbo.Chofer (Chofer_Dni, Chofer_Nombre, Chofer_Apellido, Chofer_Direccion, Chofer_Telefono, Chofer_Mail, Chofer_Fecha_Nac, Chofer_Activo, Chofer_Persona)
SELECT DISTINCT Chofer_Dni, Chofer_Nombre, Chofer_Apellido, Chofer_Direccion, Chofer_Telefono, Chofer_Mail, Chofer_Fecha_Nac, 1,
Persona_Id
FROM gd_esquema.Maestra JOIN dbo.Persona ON Persona_Telefono=Chofer_Telefono
--Marca
-- dbo.Marca
INSERT INTO dbo.Marca (Marca_Nombre)
SELECT DISTINCT Auto_Marca FROM gd_esquema.Maestra
--Turno
-- dbo.Turno
INSERT INTO dbo.Turno (Turno_Descripcion, Turno_Hora_Inicio, Turno_Hora_Fin, Turno_Precio_Base, Turno_Valor_Kilometro, Turno_Activo)
SELECT DISTINCT Turno_Descripcion, Turno_Hora_Inicio, Turno_Hora_Fin, Turno_Precio_Base, Turno_Valor_Kilometro, 1 FROM gd_esquema.Maestra
--Auto
--Consideraciones: el turno del chofer es el correspondiente al último viaje que realizó, ya que se asume que ese es el último valor que tiene asignado
-- dbo.Auto
INSERT INTO dbo.Auto (Auto_Patente, Auto_Marca, Auto_Licencia, Auto_Rodado, Auto_Modelo, Auto_Chofer, Auto_Activo, Auto_Turno)
SELECT DISTINCT Auto_Patente, m1.Marca_Codigo, Auto_Licencia, Auto_Rodado, Auto_Modelo, Chofer_Telefono, 1, (SELECT TOP 1 t.Turno_Codigo FROM dbo.Turno t, gd_esquema.Maestra m WHERE t.Turno_Descripcion=m.Turno_Descripcion AND m.Auto_Patente=t1.Auto_Patente ORDER BY m.Viaje_Fecha DESC) FROM gd_esquema.Maestra AS t1 JOIN dbo.Marca m1 ON t1.Auto_Marca=m1.Marca_Nombre

--Viajes
--Consideraciones: la fecha y hora de finalización del viaje es la misma que de finalización del turno correspondiente
-- dbo.Viaje
INSERT INTO dbo.Viaje (Viaje_Cant_Kilometros, Viaje_Fecha_Hora_Inicio, Viaje_Fecha_Hora_Fin, Viaje_Chofer, Viaje_Auto, Viaje_Turno, Viaje_Cliente)
SELECT DISTINCT Viaje_Cant_Kilometros, Viaje_Fecha,
--Devuelve hora a la hora final de turno
dateadd(HOUR,
t2.Turno_Hora_Fin,
--Devuelve fecha con hora del viaje a 0
dateadd(HOUR, 
	-DATEPART(hour,Viaje_Fecha),
Viaje_Fecha)
),
 Chofer_Telefono, Auto_Patente, 
 t2.Turno_Codigo,
 Cliente_Telefono 
 FROM gd_esquema.Maestra t1 JOIN dbo.Turno t2 ON t1.Turno_Descripcion=t2.Turno_Descripcion ORDER BY Viaje_Fecha DESC

--Factura
--Consideraciones: la app mostrará los viajes correspodientes a la factura a través de un SP a través de las fechas de inicio y fin de factura. No se registrá de forma explícita que viajes corresponden a qué factura, pero si estarán vinculados por lo anterior.
SET IDENTITY_INSERT dbo.Factura ON
-- dbo.Factura
INSERT INTO dbo.Factura (Factura_Nro, Factura_Fecha, Factura_Fecha_Inicio, Factura_Fecha_Fin, Factura_Importe, Factura_Cliente)
SELECT DISTINCT Factura_Nro, Factura_Fecha, Factura_Fecha_Inicio, Factura_Fecha_Fin,
--Devuelve importe total de factura
(
SELECT SUM(importe) FROM dbo.calcular_importe(t1.Cliente_Telefono, t1.Factura_Fecha_Inicio, t1.Factura_Fecha_Fin)
) as importe_total, Cliente_Telefono FROM gd_esquema.Maestra AS t1 WHERE Factura_Nro IS NOT NULL ORDER BY importe_total ASC

SET IDENTITY_INSERT dbo.Factura OFF
 --Viaje_x_Factura
INSERT INTO dbo.Viaje_x_Factura(Factura_Nro, Viaje_Codigo)
SELECT   Factura_Nro, Viaje_Codigo
FROM dbo.Viaje JOIN dbo.Factura ON Factura_Cliente=Viaje_Cliente
WHERE Viaje_Fecha_Hora_Inicio BETWEEN Factura_Fecha_Inicio AND Factura_Fecha_Fin

--Rendicion
/*Consideraciones: las rendiciones correspondientes a números,fechas y turnos iguales serán agrupadas
en una igual con la suma total de sus importes.
Aunque el enunciado declare que un chofer rendirá 1 sola rendición en el día,
notamos que en la base de datos, varios choferes tenían más de 1 rendición en un mismo día,
por lo que se tomó la decisión de migrarlas de igual forma;
ya que incluso correspondian a turnos distintos.
*/
SET IDENTITY_INSERT dbo.Rendicion ON
-- dbo.Rendicion
INSERT INTO dbo.Rendicion(Rendicion_Nro, Rendicion_Fecha, Rendicion_Importe, Rendicion_Chofer, Rendicion_Turno, Rendicion_Porcentaje)
SELECT Rendicion_Nro, Rendicion_Fecha, SUM(Rendicion_Importe) as importe_total, Chofer_Telefono, Turno_codigo, 0.3 FROM r1 GROUP BY Rendicion_Nro, Rendicion_Fecha, Chofer_Telefono, Turno_codigo ORDER BY Chofer_Telefono,Rendicion_Fecha ASC
SET IDENTITY_INSERT dbo.Rendicion OFF
 --Viaje_x_Rendicion
INSERT INTO dbo.Viaje_x_Rendicion(Rendicion_Nro, Viaje_Codigo)
SELECT DISTINCT Rendicion_Nro,Viaje_Codigo
FROM dbo.Viaje JOIN dbo.Rendicion ON Rendicion_Chofer=Viaje_Chofer AND Rendicion_Turno=Viaje_Turno
WHERE Rendicion_Nro IS NOT NULL AND CAST(Viaje_Fecha_Hora_Inicio AS DATE) = CAST(Rendicion_Fecha AS DATE)
ORDER BY Viaje_Codigo
