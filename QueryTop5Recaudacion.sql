CREATE FUNCTION SAPNU_PUAS.top5recaudacion (@anio int, @mes1 int, @mes2 int)
RETURNS TABLE
AS
RETURN
	SELECT TOP 5 SUM(Rendicion_Importe) as RecaudacionTotal, Chofer_Apellido, Chofer_Telefono, Chofer_Mail
	FROM SAPNU_PUAS.Chofer JOIN SAPNU_PUAS.Rendicion ON Rendicion_Chofer=Chofer_Telefono
	WHERE YEAR(Rendicion_Fecha)=@anio AND MONTH(Rendicion_Fecha) BETWEEN @mes1 and @mes2
	GROUP BY Chofer_Apellido, Chofer_Telefono, Chofer_Mail
	ORDER BY SUM (Rendicion_Importe) DESC;