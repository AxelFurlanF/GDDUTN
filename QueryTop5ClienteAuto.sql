CREATE FUNCTION SAPNU_PUAS.top5ClienteAuto (@anio int, @mes1 int, @mes2 int)
RETURNS TABLE
AS
RETURN
	SELECT TOP 5 Auto_Patente, Chofer_Nombre, Chofer_Apellido, Chofer_Telefono, Cliente_Nombre, Cliente_Apellido, Cliente_Telefono, COUNT(*) as CantidadDeVeces
	FROM SAPNU_PUAS.Viaje JOIN SAPNU_PUAS.Cliente ON Viaje_Cliente=Cliente_Telefono JOIN SAPNU_PUAS.Auto ON Viaje_Auto=Auto_Patente JOIN SAPNU_PUAS.Chofer ON Auto_Chofer=Chofer_Telefono
	GROUP BY Auto_Patente, Chofer_Nombre, Chofer_Apellido, Chofer_Telefono, Cliente_Nombre, Cliente_Apellido, Cliente_Telefono
	ORDER BY CantidadDeVeces desc