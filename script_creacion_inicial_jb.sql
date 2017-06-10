USE GD1C2017
GO

--DROP SCHEMA
IF NOT EXISTS (
	SELECT schema_name
	FROM information_schema.schemata
	WHERE schema_name = 'SAPNU_PUAS'
	)
--CREATE SCHEMA
BEGIN
	EXEC sp_executesql N'CREATE SCHEMA SAPNU_PUAS;';
END
--DROP DE TODAS LAS TABLAS SI EXISTEN
IF OBJECT_ID('SAPNU_PUAS.Funcionalidad_x_Rol') IS NOT NULL
BEGIN
    DROP TABLE SAPNU_PUAS.Funcionalidad_x_Rol;
END;

IF OBJECT_ID('SAPNU_PUAS.Funcionalidad') IS NOT NULL
BEGIN
    DROP TABLE SAPNU_PUAS.Funcionalidad;
END;

IF OBJECT_ID('SAPNU_PUAS.Rol_x_Usuario') IS NOT NULL
BEGIN
    DROP TABLE SAPNU_PUAS.Rol_x_Usuario;
END;

IF OBJECT_ID('SAPNU_PUAS.Viaje_x_Factura') IS NOT NULL
BEGIN
    DROP TABLE SAPNU_PUAS.Viaje_x_Factura;
END;

IF OBJECT_ID('SAPNU_PUAS.Viaje_x_Rendicion') IS NOT NULL
BEGIN
    DROP TABLE SAPNU_PUAS.Viaje_x_Rendicion;
END;

IF OBJECT_ID('SAPNU_PUAS.Rol') IS NOT NULL
BEGIN
    DROP TABLE SAPNU_PUAS.Rol;
END;

IF OBJECT_ID('SAPNU_PUAS.Rendicion') IS NOT NULL
BEGIN
    DROP TABLE SAPNU_PUAS.Rendicion;
END;

IF OBJECT_ID('SAPNU_PUAS.Factura') IS NOT NULL
BEGIN
    DROP TABLE SAPNU_PUAS.Factura;
END;

IF OBJECT_ID('SAPNU_PUAS.Viaje') IS NOT NULL
BEGIN
    DROP TABLE SAPNU_PUAS.Viaje;
END;

IF OBJECT_ID('SAPNU_PUAS.Auto') IS NOT NULL
BEGIN
    DROP TABLE SAPNU_PUAS.Auto;
END;

IF OBJECT_ID('SAPNU_PUAS.Turno') IS NOT NULL
BEGIN
    DROP TABLE SAPNU_PUAS.Turno;
END;


IF OBJECT_ID('SAPNU_PUAS.Chofer') IS NOT NULL
BEGIN
    DROP TABLE SAPNU_PUAS.Chofer;
END;


IF OBJECT_ID('SAPNU_PUAS.Marca') IS NOT NULL
BEGIN
    DROP TABLE SAPNU_PUAS.Marca;
END;

IF OBJECT_ID('SAPNU_PUAS.Cliente') IS NOT NULL
BEGIN
    DROP TABLE SAPNU_PUAS.Cliente;
END;

IF OBJECT_ID('SAPNU_PUAS.Persona') IS NOT NULL
BEGIN
    DROP TABLE SAPNU_PUAS.Persona;
END;

IF OBJECT_ID('SAPNU_PUAS.Usuario') IS NOT NULL
BEGIN
    DROP TABLE SAPNU_PUAS.Usuario;
END;

-- CREATE DE TODAS LAS TABLAS
-- Tabla: Auto
CREATE TABLE SAPNU_PUAS.Auto (
    Auto_Marca int  NOT NULL,
    Auto_Modelo varchar(255)  NOT NULL,
    Auto_Patente varchar(10)  NOT NULL,
    Auto_Licencia varchar(26)  NULL,
    Auto_Rodado varchar(10)  NULL,
    Auto_Activo tinyint  NOT NULL,
    Auto_Chofer numeric(18,0)  NOT NULL,
    Auto_Turno int  NOT NULL,
    CONSTRAINT Auto_pk PRIMARY KEY  (Auto_Patente)
);

-- Tabla: Chofer
CREATE TABLE SAPNU_PUAS.Chofer (
    Chofer_Nombre varchar(255)  NOT NULL,
    Chofer_Apellido varchar(255)  NOT NULL,
    Chofer_Dni numeric(18,0)  NOT NULL,
    Chofer_Direccion varchar(255)  NOT NULL,
    Chofer_Telefono numeric(18,0)  NOT NULL,
    Chofer_Mail varchar(50)  NOT NULL,
    Chofer_Fecha_Nac datetime  NOT NULL,
    Chofer_Activo tinyint  NOT NULL,
    Chofer_Persona int  NOT NULL,
    CONSTRAINT Chofer_pk PRIMARY KEY  (Chofer_Telefono)
);

-- Tabla: Cliente
CREATE TABLE SAPNU_PUAS.Cliente (
    Cliente_Nombre varchar(255)  NOT NULL,
    Cliente_Apellido varchar(255)  NOT NULL,
    Cliente_Dni numeric(18,0)  NOT NULL,
    Cliente_Telefono numeric(18,0)  NOT NULL,
    Cliente_Direccion varchar(255)  NOT NULL,
    Cliente_Mail varchar(255)  NULL,
    Cliente_Fecha_Nac datetime  NOT NULL,
    Cliente_Codigo_Postal numeric(4,0)  NOT NULL,
    Cliente_Activo tinyint  NOT NULL,
    Cliente_Persona int  NOT NULL,
    CONSTRAINT Cliente_pk PRIMARY KEY  (Cliente_Telefono)
);

-- Tabla: Factura
CREATE TABLE SAPNU_PUAS.Factura (
    Factura_Nro int  NOT NULL IDENTITY(1, 1),
    Factura_Fecha_Inicio datetime  NOT NULL,
    Factura_Fecha_Fin datetime  NOT NULL,
    Factura_Importe numeric(18,2)  NOT NULL,
    Factura_Fecha datetime  NOT NULL,
    Factura_Cliente numeric(18,0)  NOT NULL,
    CONSTRAINT Factura_pk PRIMARY KEY  (Factura_Nro)
);

-- Tabla: Funcionalidad
CREATE TABLE SAPNU_PUAS.Funcionalidad (
    Funcionalidad_Codigo int  NOT NULL IDENTITY(1, 1),
    Funcionalidad_Nombre varchar(255)  NOT NULL,
    CONSTRAINT Funcionalidad_pk PRIMARY KEY  (Funcionalidad_Codigo)
);

-- Tabla: Funcionalidad_x_Rol
CREATE TABLE SAPNU_PUAS.Funcionalidad_x_Rol (
    Rol_Codigo int  NOT NULL,
    Funcionalidad_Codigo int  NOT NULL,
    CONSTRAINT Funcionalidad_x_Rol_pk PRIMARY KEY  (Rol_Codigo,Funcionalidad_Codigo)
);

-- Tabla: Marca
CREATE TABLE SAPNU_PUAS.Marca (
    Marca_Codigo int  NOT NULL IDENTITY,
    Marca_Nombre varchar(255)  NOT NULL,
    CONSTRAINT Marca_pk PRIMARY KEY  (Marca_Codigo)
);

-- Tabla: Persona
CREATE TABLE SAPNU_PUAS.Persona (
    Persona_Id int  NOT NULL IDENTITY(1, 1),
    Persona_Telefono numeric(18,0)  NOT NULL,
    Persona_Username varchar(50)  NOT NULL,
    CONSTRAINT Telefono_Unico UNIQUE (Persona_Telefono),
    CONSTRAINT Persona_pk PRIMARY KEY  (Persona_Id)
);

-- Tabla: Rendicion
CREATE TABLE SAPNU_PUAS.Rendicion (
    Rendicion_Nro numeric(18,0)  NOT NULL IDENTITY(1, 1),
    Rendicion_Fecha datetime  NOT NULL,
    Rendicion_Importe numeric(18,2)  NOT NULL,
    Rendicion_Chofer numeric(18,0)  NOT NULL,
    Rendicion_Turno int  NOT NULL,
    Rendicion_Porcentaje numeric(5,2)  NOT NULL,
    --CONSTRAINT Rendicion_Unica UNIQUE (Rendicion_Fecha, Rendicion_Chofer),
    CONSTRAINT Rendicion_pk PRIMARY KEY  (Rendicion_Nro)
);

-- Tabla: Rol
CREATE TABLE SAPNU_PUAS.Rol (
    Rol_Codigo int  NOT NULL IDENTITY(1, 1),
    Rol_Nombre varchar(255)  NOT NULL,
    Rol_Activo tinyint  NOT NULL,
    CONSTRAINT Rol_pk PRIMARY KEY  (Rol_Codigo)
);

-- Tabla: Rol_x_Usuario
CREATE TABLE SAPNU_PUAS.Rol_x_Usuario (
    Rol_Codigo int  NOT NULL,
    Usuario_Username varchar(50)  NOT NULL,
    CONSTRAINT Rol_x_Usuario_pk PRIMARY KEY  (Rol_Codigo,Usuario_Username)
);

-- Tabla: Turno
CREATE TABLE SAPNU_PUAS.Turno (
    Turno_Codigo int  NOT NULL IDENTITY(1, 1),
    Turno_Hora_Inicio numeric(18,0)  NOT NULL,
    Turno_Hora_Fin numeric(18,0)  NOT NULL,
    Turno_Descripcion varchar(255)  NOT NULL,
    Turno_Valor_Kilometro numeric(18,2)  NOT NULL,
    Turno_Precio_Base numeric(18,2)  NOT NULL,
    Turno_Activo tinyint  NOT NULL,
    CONSTRAINT Turno_Franja_Horaria UNIQUE (Turno_Hora_Inicio, Turno_Hora_Fin),
    CONSTRAINT Turno_pk PRIMARY KEY  (Turno_Codigo)
);

-- Tabla: Usuario
CREATE TABLE SAPNU_PUAS.Usuario (
    Usuario_Username varchar(50)  NOT NULL,
    Usuario_Password varbinary(255)  NOT NULL,
    Usuario_Reintentos smallint  NOT NULL,
    Usuario_Activo tinyint  NOT NULL,
    CONSTRAINT Usuario_pk PRIMARY KEY  (Usuario_Username)
);

-- Tabla: Viaje
CREATE TABLE SAPNU_PUAS.Viaje (
    Viaje_Codigo int  NOT NULL IDENTITY(1, 1),
    Viaje_Cant_Kilometros numeric(18,0)  NOT NULL,
    Viaje_Fecha_Hora_Inicio datetime  NOT NULL,
    Viaje_Fecha_Hora_Fin datetime  NOT NULL,
    Viaje_Chofer numeric(18,0)  NOT NULL,
    Viaje_Auto varchar(10)  NOT NULL,
    Viaje_Turno int  NOT NULL,
    Viaje_Cliente numeric(18,0)  NOT NULL,
    CONSTRAINT Viaje_pk PRIMARY KEY  (Viaje_Codigo)
);

-- Tabla: Viaje_x_Factura
CREATE TABLE SAPNU_PUAS.Viaje_x_Factura (
    Factura_Nro int  NOT NULL,
    Viaje_Codigo int  NOT NULL,
    CONSTRAINT Viaje_x_Factura_pk PRIMARY KEY  (Factura_Nro,Viaje_Codigo)
);

-- Tabla: Viaje_x_Rendicion
CREATE TABLE SAPNU_PUAS.Viaje_x_Rendicion (
    Viaje_Codigo int  NOT NULL,
    Rendicion_Nro numeric(18,0)  NOT NULL,
    CONSTRAINT Viaje_x_Rendicion_pk PRIMARY KEY  (Viaje_Codigo,Rendicion_Nro)
);

-- AGREGADO DE FOREIGN KEYS
-- Reference: Auto_Chofer (tabla: Auto)
ALTER TABLE SAPNU_PUAS.Auto ADD CONSTRAINT Auto_Chofer
    FOREIGN KEY (Auto_Chofer)
    REFERENCES SAPNU_PUAS.Chofer (Chofer_Telefono);

-- Reference: Auto_Marca (tabla: Auto)
ALTER TABLE SAPNU_PUAS.Auto ADD CONSTRAINT Auto_Marca
    FOREIGN KEY (Auto_Marca)
    REFERENCES SAPNU_PUAS.Marca (Marca_Codigo);

-- Reference: Auto_Turno (tabla: Auto)
ALTER TABLE SAPNU_PUAS.Auto ADD CONSTRAINT Auto_Turno
    FOREIGN KEY (Auto_Turno)
    REFERENCES SAPNU_PUAS.Turno (Turno_Codigo);

-- Reference: Chofer_Persona (tabla: Chofer)
ALTER TABLE SAPNU_PUAS.Chofer ADD CONSTRAINT Chofer_Persona
    FOREIGN KEY (Chofer_Persona)
    REFERENCES SAPNU_PUAS.Persona (Persona_Id);

-- Reference: Cliente_Persona (tabla: Cliente)
ALTER TABLE SAPNU_PUAS.Cliente ADD CONSTRAINT Cliente_Persona
    FOREIGN KEY (Cliente_Persona)
    REFERENCES SAPNU_PUAS.Persona (Persona_Id);

-- Reference: Factura_Cliente (tabla: Factura)
ALTER TABLE SAPNU_PUAS.Factura ADD CONSTRAINT Factura_Cliente
    FOREIGN KEY (Factura_Cliente)
    REFERENCES SAPNU_PUAS.Cliente (Cliente_Telefono);

-- Reference: Funcionalidad_x_Rol_Funcionalidad (tabla: Funcionalidad_x_Rol)
ALTER TABLE SAPNU_PUAS.Funcionalidad_x_Rol ADD CONSTRAINT Funcionalidad_x_Rol_Funcionalidad
    FOREIGN KEY (Funcionalidad_Codigo)
    REFERENCES SAPNU_PUAS.Funcionalidad (Funcionalidad_Codigo);

-- Reference: Funcionalidad_x_Rol_Rol (tabla: Funcionalidad_x_Rol)
ALTER TABLE SAPNU_PUAS.Funcionalidad_x_Rol ADD CONSTRAINT Funcionalidad_x_Rol_Rol
    FOREIGN KEY (Rol_Codigo)
    REFERENCES SAPNU_PUAS.Rol (Rol_Codigo);

-- Reference: Persona_Usuario (tabla: Persona)
ALTER TABLE SAPNU_PUAS.Persona ADD CONSTRAINT Persona_Usuario
    FOREIGN KEY (Persona_Username)
    REFERENCES SAPNU_PUAS.Usuario (Usuario_Username);

-- Reference: Rendicion_Chofer (tabla: Rendicion)
ALTER TABLE SAPNU_PUAS.Rendicion ADD CONSTRAINT Rendicion_Chofer
    FOREIGN KEY (Rendicion_Chofer)
    REFERENCES SAPNU_PUAS.Chofer (Chofer_Telefono);

-- Reference: Rendicion_Turno (tabla: Rendicion)
ALTER TABLE SAPNU_PUAS.Rendicion ADD CONSTRAINT Rendicion_Turno
    FOREIGN KEY (Rendicion_Turno)
    REFERENCES SAPNU_PUAS.Turno (Turno_Codigo);

-- Reference: Rol_x_Usuario_Rol (tabla: Rol_x_Usuario)
ALTER TABLE SAPNU_PUAS.Rol_x_Usuario ADD CONSTRAINT Rol_x_Usuario_Rol
    FOREIGN KEY (Rol_Codigo)
    REFERENCES SAPNU_PUAS.Rol (Rol_Codigo);

-- Reference: Rol_x_Usuario_Usuario (tabla: Rol_x_Usuario)
ALTER TABLE SAPNU_PUAS.Rol_x_Usuario ADD CONSTRAINT Rol_x_Usuario_Usuario
    FOREIGN KEY (Usuario_Username)
    REFERENCES SAPNU_PUAS.Usuario (Usuario_Username);

-- Reference: Viaje_Auto (tabla: Viaje)
ALTER TABLE SAPNU_PUAS.Viaje ADD CONSTRAINT Viaje_Auto
    FOREIGN KEY (Viaje_Auto)
    REFERENCES SAPNU_PUAS.Auto (Auto_Patente);

-- Reference: Viaje_Chofer (tabla: Viaje)
ALTER TABLE SAPNU_PUAS.Viaje ADD CONSTRAINT Viaje_Chofer
    FOREIGN KEY (Viaje_Chofer)
    REFERENCES SAPNU_PUAS.Chofer (Chofer_Telefono);

-- Reference: Viaje_Cliente (tabla: Viaje)
ALTER TABLE SAPNU_PUAS.Viaje ADD CONSTRAINT Viaje_Cliente
    FOREIGN KEY (Viaje_Cliente)
    REFERENCES SAPNU_PUAS.Cliente (Cliente_Telefono);

-- Reference: Viaje_Turno (tabla: Viaje)
ALTER TABLE SAPNU_PUAS.Viaje ADD CONSTRAINT Viaje_Turno
    FOREIGN KEY (Viaje_Turno)
    REFERENCES SAPNU_PUAS.Turno (Turno_Codigo);

-- Reference: Viaje_x_Factura_Factura (tabla: Viaje_x_Factura)
ALTER TABLE SAPNU_PUAS.Viaje_x_Factura ADD CONSTRAINT Viaje_x_Factura_Factura
    FOREIGN KEY (Factura_Nro)
    REFERENCES SAPNU_PUAS.Factura (Factura_Nro);

-- Reference: Viaje_x_Factura_Viaje (tabla: Viaje_x_Factura)
ALTER TABLE SAPNU_PUAS.Viaje_x_Factura ADD CONSTRAINT Viaje_x_Factura_Viaje
    FOREIGN KEY (Viaje_Codigo)
    REFERENCES SAPNU_PUAS.Viaje (Viaje_Codigo);

-- Reference: Viaje_x_Rendicion_Rendicion (tabla: Viaje_x_Rendicion)
ALTER TABLE SAPNU_PUAS.Viaje_x_Rendicion ADD CONSTRAINT Viaje_x_Rendicion_Rendicion
    FOREIGN KEY (Rendicion_Nro)
    REFERENCES SAPNU_PUAS.Rendicion (Rendicion_Nro);

-- Reference: Viaje_x_Rendicion_Viaje (tabla: Viaje_x_Rendicion)
ALTER TABLE SAPNU_PUAS.Viaje_x_Rendicion ADD CONSTRAINT Viaje_x_Rendicion_Viaje
    FOREIGN KEY (Viaje_Codigo)
    REFERENCES SAPNU_PUAS.Viaje (Viaje_Codigo);

GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/*Funcion que verifica que los horarios ingresados por parametro esten incluidos dentro del turno ingresado*/
IF OBJECT_ID('SAPNU_PUAS.match_turn_hour') IS NOT NULL
BEGIN
	DROP FUNCTION SAPNU_PUAS.match_turn_hour;
END;
GO

CREATE FUNCTION [SAPNU_PUAS].[match_turn_hour]
(
	@turno int,
	@iniHour int,
	@endHour int
)
RETURNS int
AS
BEGIN
	
	DECLARE @Result  int,
			@horaini int,
			@horaFin int;

	SELECT @horaini = Turno_Hora_Inicio, @horaFin = Turno_Hora_Fin
				FROM SAPNU_PUAS.turno
		 WHERE Turno_Activo = 1
	   AND Turno_Codigo = @turno;
	
	IF(@horaini <> NULL AND @horaFin <> NULL)

	BEGIN

		IF(@iniHour >= @horaini AND @iniHour < @horaFin AND @endHour > @horaini AND @endHour <= @horaFin)
		BEGIN
			SET @Result = 1;
		END
		ELSE
		BEGIN
			SET @Result = 0;
		END;

	END

	ELSE
	BEGIN
		SET @Result = 0;
	END;

	RETURN @Result;

END;

GO

-- =======================================================================
-- Description:	Funcion que verifica que la patente recibida por parametro 
--				no exista en la tabla de Auto
-- =======================================================================
IF OBJECT_ID('SAPNU_PUAS.verificar_patente') IS NOT NULL
BEGIN
	DROP FUNCTION SAPNU_PUAS.verificar_patente;
END;
GO

CREATE FUNCTION [SAPNU_PUAS].[verificar_patente] 
(

	@patente VARCHAR(10) 
)
RETURNS INT
AS
BEGIN
	-- Declare the return variable here
	DECLARE @Result int

	SET @Result = (SELECT COUNT(*) 
					FROM SAPNU_PUAS.Auto
				   WHERE Auto_Patente = @patente); 


	RETURN @Result

END
;

GO
-- ==================================================================================
-- Description:	Funcion que verifica si un rango horario esta disponible en la tabla 
--              de turnos sin tener en cuenta el turno a modificar. 
--              Devuelve 0 si esta disponible, caso contrario devuelve distinto de 0.
-- ==================================================================================

IF OBJECT_ID('SAPNU_PUAS.is_available_hour_range') IS NOT NULL
BEGIN
	DROP FUNCTION SAPNU_PUAS.is_available_hour_range;
END;
GO

CREATE FUNCTION[SAPNU_PUAS].[is_available_hour_range]
(
	@iniHour int,
	@endHour int,
	@cod     int = -1 --Parametro que toma -1 como default
)
RETURNS int
AS
BEGIN
	-- Declare the return variable here
	DECLARE @Result int

	-- Verifica si hay algun turno que se superponga con los horarios ingesados por parametro
	set @Result = (SELECT COUNT(*)
	                 FROM SAPNU_PUAS.turno
				    WHERE Turno_Activo = 1
					  AND Turno_Codigo <> @cod
					  AND ((turno_hora_inicio <= @iniHour AND  @iniHour <  turno_hora_fin)
					       OR (turno_hora_inicio <  @endHour AND  @endHour <= turno_hora_fin)
					       OR (@iniHour <= turno_hora_inicio AND turno_hora_inicio < @endHour)
					       OR (@iniHour < turno_hora_fin AND turno_hora_fin <= @endHour)))

	-- Return the result of the function
	RETURN @Result

END;


GO
-- =============================================
-- Description:	SP que da de alta un turno
-- =============================================

IF OBJECT_ID('SAPNU_PUAS.sp_turno_alta') IS NOT NULL
BEGIN
	DROP PROCEDURE SAPNU_PUAS.sp_turno_alta;
END;
GO

CREATE PROCEDURE [SAPNU_PUAS].[sp_turno_alta]
	-- Add the parameters for the stored procedure here
	@horaInicio int,
	@horaFin int,
	@descripcion varchar(255),
	@valorkm numeric(18,2),
	@precioBase numeric(18,2),
	@activo  int,
	@codOp   int OUT,
	@resultado  varchar(255) OUT
AS
BEGIN
	DECLARE @validHora int

	SET NOCOUNT ON;
	
    SET @validHora = SAPNU_PUAS.is_available_hour_range(@horaInicio,@horaFin, default);

	--Se valida que no haya ningun turno con el que se superpongan los horarios
	IF(@validHora = 0)
	BEGIN
		BEGIN TRY
			SET @codOp = 0;
			INSERT INTO SAPNU_PUAS.turno
			VALUES(@horaInicio,@horaFin,@descripcion,@valorkm,@precioBase,@activo);
		END TRY
		BEGIN CATCH
			SET @codOp = @@ERROR;

			IF(@codOp <> 0)
				SET @resultado = 'Ocurrio un error al realizar INSERT en la tabla Turnos';
		END CATCH;
	END
	ELSE
	BEGIN
	--Se encuentran turnos con horarios superpuestos, entonces se envía un mensaje indicando dicho suceso
		SET @codOp = 1;
		SET @resultado = 'Se superponen los horarios con otro/s turno/s';
	END;
END;

GO
-- =============================================
-- Description:	SP que da de alta un turno
-- =============================================

IF OBJECT_ID('SAPNU_PUAS.sp_turno_modif') IS NOT NULL
BEGIN
	DROP PROCEDURE SAPNU_PUAS.sp_turno_modif;
END;
GO

CREATE PROCEDURE [SAPNU_PUAS].[sp_turno_modif]
	-- Add the parameters for the stored procedure here
	@codigo int,
	@horaInicio int,
	@horaFin int,
	@descripcion varchar(255),
	@valorkm numeric(18,2),
	@precioBase numeric(18,2),
	@activo  int,
	@codOp   int OUT,
	@resultado  varchar(255) OUT
AS
BEGIN
	DECLARE @validHora int

	SET NOCOUNT ON;
	
	/*Se valida la hora únicamente si se va a modificar un turno que va a estar activo*/
	IF(@activo = 1)
		SET @validHora = SAPNU_PUAS.is_available_hour_range(@horaInicio,@horaFin,@codigo);
	ELSE
		SET @validHora = 0;

	--Se valida que no haya ningun turno con el que se superpongan los horarios
	IF(@validHora = 0)
	BEGIN
		BEGIN TRY
			SET @codOp = 0;
			UPDATE SAPNU_PUAS.turno
			SET Turno_Hora_Inicio = @horaInicio,
				Turno_Hora_Fin = @horaFin,
				Turno_Descripcion = @descripcion,
				Turno_Valor_Kilometro =  @valorkm,
				Turno_Precio_Base = @precioBase,
				Turno_Activo =  @activo
			WHERE Turno_codigo =  @codigo;
		END TRY
		BEGIN CATCH
			SET @codOp = @@ERROR;

			IF(@codOp <> 0)
				SET @resultado = 'Ocurrio un error al actualizar los datos de la tabla Turnos';
		END CATCH;
	END
	ELSE
	BEGIN
	--Se encuentran turnos con horarios superpuestos, entonces se envía un mensaje indicando dicho suceso
		SET @codOp = 1;
		SET @resultado = 'Se superponen los horarios con otro/s turno/s';
	END;
END;

GO
-- ==============================================================================
-- Description:	SP que realiza alta de un automovil.
--              En caso de ser exitosa el alta retorna 0, en caso contrario
--              retornara un codigo de error y un mensaje descriptivo del error.
-- ==============================================================================

IF OBJECT_ID('SAPNU_PUAS.sp_auto_alta') IS NOT NULL
BEGIN
	DROP PROCEDURE SAPNU_PUAS.sp_auto_alta;
END;
GO

CREATE PROCEDURE [SAPNU_PUAS].[sp_auto_alta] 

	@marca int, 
	@modelo varchar(255), 
	@patente varchar(10), 
	@licencia varchar(26), 
	@rodado varchar(10), 
	@activo int, 
	@chofer numeric(18,0), 
	@turno int,
	@codOp int out,
	@resultado varchar(255) out
AS
BEGIN
	DECLARE @validDuplicado int

	SET @validDuplicado = SAPNU_PUAS.verificar_patente(@patente);

	IF(@validDuplicado = 0)
	BEGIN
		BEGIN TRY
			SET @codOp = 0;
			IF(EXISTS(SELECT Auto_Chofer FROM SAPNU_PUAS.AUTO WHERE Auto_Chofer = @chofer AND Auto_Activo = 1))
			BEGIN
				SET @codOp = 2;
				SET @resultado = 'Ya existe un auto activo registrado para el chofer ingresado';
			END
			ELSE
			BEGIN
				INSERT INTO [SAPNU_PUAS].Auto
				VALUES(@marca,@modelo,@patente,@licencia,@rodado,@activo,@chofer,@turno);
			END
		END TRY
		BEGIN CATCH
			SET @codOp = @@ERROR;

			IF(@codOp <> 0)
				SET @resultado = 'Ocurrio un error al realizar INSERT en la tabla Auto';
		END CATCH
	END
	ELSE
	BEGIN
	--Se encuentra otro auto con la misma patente en la base de datos
		SET @codOp = 1;
		SET @resultado = 'Ya existe un auto con la patente ingresada. Verifique que la patente ingresada sea correcta.';
	END;

END;

GO
-- ========================================================
-- Description:	SP que realiza la modificacion de los Autos
-- ========================================================

IF OBJECT_ID('SAPNU_PUAS.sp_auto_modif') IS NOT NULL
BEGIN
	DROP PROCEDURE SAPNU_PUAS.sp_auto_modif;
END;
GO

CREATE PROCEDURE [SAPNU_PUAS].[sp_auto_modif]
	@marca int, 
	@modelo varchar(255), 
	@patente varchar(10), 
	@patente_nueva varchar(10),
	@licencia varchar(26), 
	@rodado varchar(10), 
	@activo int, 
	@chofer numeric(18,0), 
	@turno int,
	@codOp int out,
	@resultado varchar(255) out
AS
BEGIN
	DECLARE @validDuplicado int,
			@choferAutos int
	SET NOCOUNT ON;
	SET @validDuplicado = 0;

	IF(@patente <> @patente_nueva)
		SET @validDuplicado = SAPNU_PUAS.verificar_patente(@patente_nueva);

	IF(@validDuplicado = 0)
	BEGIN
		--Se verifica que un auto no tenga asignado un chofer que ya tenga un coche activo. Esta verificacion sirve en caso de que se cambie el chofer del auto.
		--Se agrega la validación contra la patente(vieja en caso de que se haya modificado por una nueva), para que se excluya de la busqueda el registro que se esta alterando. 
		IF(EXISTS(SELECT Auto_Chofer FROM SAPNU_PUAS.AUTO WHERE Auto_Chofer = @chofer AND Auto_Activo = 1 AND Auto_Patente <> @patente))
		BEGIN
			SET @codOp = 2;
			SET @resultado = 'Ya existe un auto activo registrado para el chofer ingresado';
		END
		ELSE
		BEGIN
			BEGIN TRY
				SET @codOp = 0;
				UPDATE SAPNU_PUAS.Auto
				SET Auto_Marca = @marca,
					Auto_Modelo = @modelo,
					Auto_Licencia = @licencia,
					Auto_Rodado = @rodado,
					Auto_Activo = @activo,
					Auto_Chofer = @chofer,
					Auto_turno = @turno,
					Auto_patente = @patente_nueva
				WHERE Auto_Patente =  @patente;
			END TRY
			BEGIN CATCH
				SET @codOp = @@ERROR;
		
				IF(@codOp <> 0)
					SET @resultado = 'Ocurrio un error al actualizar los datos de la tabla Auto';
			END CATCH;
		END;
	END
	ELSE
	BEGIN
	--Se encuentra otro auto con la misma patente en la base de datos
		SET @codOp = 1;
		SET @resultado = 'Ya existe un auto con la patente ingresada. Verifique que la patente ingresada sea correcta.';
	END;
END;

GO

-- =======================================================================
-- Description:	Función que verifica la existencia de un auto mediante su
--              patente.
-- =======================================================================

IF OBJECT_ID('SAPNU_PUAS.exist_car') IS NOT NULL
BEGIN
	DROP FUNCTION SAPNU_PUAS.exist_car;
END;
GO

CREATE FUNCTION [SAPNU_PUAS].[exist_car]
(
	@PATENTE varchar(10)
)
RETURNS int
AS
BEGIN
	
	RETURN (SELECT COUNT(*) 
			 FROM SAPNU_PUAS.Auto
		   WHERE Auto_Patente = @PATENTE);

END;

GO
-- ==============================================================================
-- Description:	SP que revisa si un usuario tiene asignado un rol. En caso de no
--				tenerlo, se lo asigna
-- ==============================================================================
IF OBJECT_ID('SAPNU_PUAS.sp_asignar_rol') IS NOT NULL
BEGIN
	DROP PROCEDURE SAPNU_PUAS.sp_asignar_rol;
END;
GO

CREATE PROCEDURE [SAPNU_PUAS].[sp_asignar_rol] 

	@username varchar(50), 
	@codigoRol int,
	@codOp int out,
	@resultado varchar(255) out
AS
BEGIN
	
	IF (EXISTS(SELECT * FROM SAPNU_PUAS.Rol_x_Usuario WHERE Rol_Codigo = @codigoRol AND Usuario_Username =@username ))
		BEGIN
			SET @codOp = 1;
			SET @resultado = 'Ya se encuentra asignado';
		END;
	ELSE
		BEGIN TRY
			INSERT INTO SAPNU_PUAS.Rol_x_Usuario VALUES (@codigoRol,@username);
		END TRY
		BEGIN CATCH
			SET @codOp = 1;
			SET @resultado = ERROR_MESSAGE();
		END CATCH

	SET @codOp = 0;
	SET @resultado = 'ok';

END; 

GO

-- ========================================================================
-- Description:	Función que verifica la existencia de un chofer mediante su
--              teléfono.
-- ========================================================================

IF OBJECT_ID('SAPNU_PUAS.exist_chofer') IS NOT NULL
BEGIN
	DROP FUNCTION SAPNU_PUAS.exist_chofer;
END;
GO

CREATE FUNCTION [SAPNU_PUAS].[exist_chofer]
(
	@Telefono numeric(18)
)
RETURNS int
AS
BEGIN
	
	RETURN (SELECT COUNT(*) 
			 FROM SAPNU_PUAS.Chofer
		   WHERE Chofer_Activo = 1
		     AND Chofer_Telefono = @Telefono);

END;

GO
-- =======================================================================
-- Description:	Función que verifica la existencia de un turno.
-- =======================================================================

IF OBJECT_ID('SAPNU_PUAS.exist_turn') IS NOT NULL
BEGIN
	DROP FUNCTION SAPNU_PUAS.exist_turn;
END;
GO

CREATE FUNCTION [SAPNU_PUAS].[exist_turn]
(
	@TURNO int
)
RETURNS int
AS
BEGIN
	
	RETURN (SELECT COUNT(*) 
			 FROM SAPNU_PUAS.Turno
		   WHERE Turno_Activo = 1 
			 AND Turno_Codigo = @TURNO);

END;

GO

-- =======================================================================
-- Description:	Función que verifica la existencia de un cliente mediante 
--				su teléfono.
-- =======================================================================

IF OBJECT_ID('SAPNU_PUAS.exist_client') IS NOT NULL
BEGIN
	DROP FUNCTION SAPNU_PUAS.exist_client;
END;
GO

CREATE FUNCTION [SAPNU_PUAS].[exist_client]
(
	@CLIENT_TEL numeric(18)
)
RETURNS int
AS
BEGIN
	
	RETURN (SELECT COUNT(*) 
			 FROM SAPNU_PUAS.Cliente
		   WHERE Cliente_Telefono = @CLIENT_TEL);

END;

GO

-- =======================================================================
-- Description:	Procedure da de alta un viaje controlando que el inicio
--				y el fin del mismo se de durante el mismo día.
-- =======================================================================


IF OBJECT_ID('SAPNU_PUAS.sp_viaje_alta') IS NOT NULL
BEGIN
	DROP PROCEDURE SAPNU_PUAS.sp_viaje_alta;
END;
GO

CREATE PROCEDURE [SAPNU_PUAS].[sp_viaje_alta] 
	-- Add the parameters for the stored procedure here
	 @viaje_cant_km numeric(18), 
	 @viaje_hora_ini datetime,
	 @viaje_hora_fin datetime,
	 @viaje_chofer numeric(18),
	 @viaje_auto varchar(10),
	 @viaje_turno int,
	 @viaje_cliente numeric(18),
	 @codOp   int OUT,
	 @resultado  varchar(255) OUT
AS
BEGIN
	SET NOCOUNT ON;
	SET @codOp = 0;
	--Verifica que el viaje se realice dentro del mismo día
	IF((DATEPART(DAY, @viaje_hora_ini)) <> (DATEPART(DAY, @viaje_hora_fin)) OR (DATEPART(MONTH, @viaje_hora_ini)) <> (DATEPART(MONTH, @viaje_hora_fin)) OR (DATEPART(YEAR, @viaje_hora_ini)) <> (DATEPART(YEAR, @viaje_hora_fin)))
	BEGIN
		SET @codOp = 1;
		SET @resultado = 'La hora de inicio y fin del viaje deben corresponder al mismo día.';
	END
	ELSE IF(SAPNU_PUAS.exist_car(@viaje_auto) = 0)
	BEGIN
		SET @codOp = 2;
		SET @resultado = 'No existe un auto activo con la patente ingresada';
	END
	ELSE IF(SAPNU_PUAS.exist_chofer(@viaje_chofer) = 0)
	BEGIN
		SET @codOp = 3;
		SET @resultado = 'El chofer ingresado no se encuentra activo en el sistema';
	END
	ELSE IF(SAPNU_PUAS.exist_turn(@viaje_turno) = 0)
	BEGIN
		SET @codOp = 4;
		SET @resultado = 'No existe el turno ingresado';
	END
	ELSE IF(SAPNU_PUAS.exist_client(@viaje_cliente) = 0)
	BEGIN
		SET @codOp = 5;
		SET @resultado = 'El cliente ingresado no se encuentra registrado';
	END
	/*EN REVISION
	ELSE IF(SAPNU_PUAS.match_turn_hour(DATEPART(HOUR, @viaje_hora_ini),DATEPART(HOUR, @viaje_hora_fin),@viaje_turno) = 0)
	BEGIN
		SET @codOp = 6;
		SET @resultado = 'Los horarios ingresados no corresponden al turno elegido';
	END*/
	/*Se verifica que no exista registrado un viaje en la misma fecha y hora*/
	ELSE IF(EXISTS(SELECT * 
			 FROM SAPNU_PUAS.VIAJE A
			WHERE A.Viaje_Cliente = @viaje_cliente
		      AND (     (A.Viaje_Fecha_Hora_Inicio <= @viaje_hora_ini AND @viaje_hora_ini < A.Viaje_Fecha_Hora_Fin)
					 OR (A.Viaje_Fecha_Hora_Inicio < @viaje_hora_fin AND @viaje_hora_fin <= A.Viaje_Fecha_Hora_Fin)
				  )
				  )
		   )

	BEGIN
		SET @codOp = 7;
		SET @resultado = 'Ya se registro un viaje realizado dentro del rango horario ingresado';
	END;

	IF (@codOp = 0)
	BEGIN

		BEGIN TRY
			INSERT INTO SAPNU_PUAS.Viaje 
			VALUES (@viaje_cant_km,@viaje_hora_ini,@viaje_hora_fin,@viaje_chofer,@viaje_auto,@viaje_turno,@viaje_cliente);
		END TRY
		BEGIN CATCH

			SET @codOp = @@ERROR;

			IF(@codOp <> 0)
				SET @resultado = 'Ocurrio un error al realizar INSERT en la tabla Viaje';

		END CATCH
	END;
END;

GO


--=================================================================================
-- =======================================================================
-- Description:	Procedimiento que realiza la rendición de todos los viajes
-- 				realizados por un chofer dada una fecha y un turno.
-- =======================================================================


IF OBJECT_ID('SAPNU_PUAS.sp_rendicion_viajes') IS NOT NULL
BEGIN
	DROP PROCEDURE SAPNU_PUAS.sp_rendicion_viajes;
END;
GO

CREATE PROCEDURE SAPNU_PUAS.sp_rendicion_viajes 

-----Declaracion de Parametros-----
	 @chofer_telefono numeric(18), 
	 @fecha datetime,
	 @turno_codigo int,
	 @porcentaje numeric(5,2),
	 @codOp   int OUT,
	 @resultado  varchar(255) OUT

AS

BEGIN

-----Declaracion de Variables-----
	DECLARE 
	@turno_precio numeric(18,2),
	@resultado_final numeric(18,2),
	@cant_kilometros numeric(18),
	@precio_base numeric(18,2),
	@rendicion_nro numeric(18);
    
	SET NOCOUNT ON;

--SE VERIFICA QUE NO EXISTA UNA RENDICIÓN PARA EL MISMO CHOFER EL MISMO DIA Y TURNO--
		IF(SELECT 
		count(1) 
		from SAPNU_PUAS.Rendicion
		where 
		Rendicion_Chofer = @chofer_telefono
		and CONVERT(date,Rendicion_Fecha) = CONVERT(date,@fecha)
		and Rendicion_Turno = @turno_codigo) > 0 or 
		(SELECT Turno_Activo from SAPNU_PUAS.Turno where Turno_Codigo = @turno_codigo) = 0 or
		(SELECT Chofer_Activo from SAPNU_PUAS.Chofer where Chofer_Telefono = @chofer_telefono) = 0

	BEGIN
			SET @codOp = 1;
			SET @resultado = 
			'Ocurrió un error en validaciones previas. Chequear que la rendicion no haya sido hecha previamente y
			que el chofer y el turno estén activos.';
	
	END
	
	ELSE

		BEGIN

			--OBTENGO EL VALOR POR KILOMETRO Y EL PRECIO BASE DEL TURNO INGRESADO
			SELECT 
			@turno_precio = turno_valor_kilometro, 
			@precio_base = turno_precio_base
			FROM SAPNU_PUAS.Turno 
			WHERE 
			turno_codigo = @turno_codigo;

			--CALCULO EL VALOR FINAL DE LA RENDICION PARA ESE CHOFER EN ESE TURNO PARA ESE DIA
			SELECT 
			@resultado_final = (sum(Viaje_Cant_Kilometros * @turno_precio + @precio_base) * @porcentaje) 
			FROM SAPNU_PUAS.Viaje 
			WHERE 
			Viaje_Chofer = @chofer_telefono and 
			CONVERT(date,@fecha) = CONVERT(date,Viaje_Fecha_Hora_Inicio) and
			Viaje_Turno = @turno_codigo;

			
			BEGIN TRY
					
					SET @codOp = 0;

					BEGIN TRANSACTION T1
						
						--INSERTO LA RENDICION DE ESE CHOFER PARA ESE TURNO PARA ESE DIA
						INSERT INTO SAPNU_PUAS.Rendicion 
						(Rendicion_Fecha, Rendicion_Importe, Rendicion_Chofer, Rendicion_Turno, Rendicion_Porcentaje)
						VALUES (@fecha, @resultado_final, @chofer_telefono, @turno_codigo, @porcentaje);

						--OBTENGO EL CODIGO DE LA RENDICION RECIEN INSERTADA PARA USARLA EN EL PROXIMO INSERT
						set @rendicion_nro = @@IDENTITY;

						--INSERTO TODOS LOS VIAJES EN VIAJE X RENDICION DESDE LA TABLA DE VIAJES PARA EL CHOFER ESE DIA Y EN ESE TURNO
						INSERT INTO SAPNU_PUAS.Viaje_x_Rendicion
						SELECT Viaje_Codigo, @rendicion_nro from SAPNU_PUAS.Viaje 
						WHERE 
						Viaje_Chofer = @chofer_telefono and 
						CONVERT(date,@fecha) = CONVERT(date,Viaje_Fecha_Hora_Inicio) and
						Viaje_Turno = @turno_codigo;

					--CONFIRMO TRANSACCIONES
					COMMIT TRANSACTION T1

			END TRY
	
			BEGIN CATCH

				SET @codOp = @@ERROR;

				IF(@codOp <> 0)
				SET @resultado = 'Ocurrio un error al realizar INSERT en Rendicion/Viaje_x_Rendicion';
					--ROLLBACK DE TODAS LAS TRANSACCIONES REALIZADAS PORQUE ALGUNA FALLO
					ROLLBACK TRANSACTION T1

			END CATCH
	
		END
END;
GO

-- =======================================================================
-- Description:	Procedure de facturacion de clientes
-- =======================================================================
--

IF OBJECT_ID('SAPNU_PUAS.sp_fact_cliente') IS NOT NULL
BEGIN
	DROP PROCEDURE SAPNU_PUAS.sp_fact_cliente;
END;
GO

CREATE PROCEDURE [SAPNU_PUAS].[sp_fact_cliente] 

	 @fecha_ini datetime, 
	 @fecha_fin datetime,
	 @cliente numeric(18,0),
	 @codOp   int OUT,
	 @resultado  varchar(255) OUT

AS

BEGIN


	DECLARE 
	@importe numeric(18,2),
	@precio_base numeric(18,2),
	@cant_km numeric(18,0),
	@valor_km numeric(18,2),
	@nroFact int
    
	SET NOCOUNT ON;

		--Se verifica que exista el cliente recibido por parametro
		IF(SAPNU_PUAS.exist_client(@cliente) = 0)
		BEGIN
			SET @codOp = 1;
			SET @resultado = 'No se encuentra registrado en la base de datos el cliente ingresado.';
		END
		ELSE
		
		--SI CONTROLA QUE NO EXISTA UNA FACTURACION REALIZADA EN EL MISMO MES PARA EL CLIENTE, EN CASO DE HABERLO, SE CANCELA LA FACTURACION.
		IF(EXISTS(SELECT * FROM SAPNU_PUAS.FACTURA
				   WHERE Factura_Cliente = @cliente
				     AND (Factura_Fecha_Inicio BETWEEN @fecha_ini AND @fecha_fin OR
					      Factura_Fecha_Fin    BETWEEN @fecha_ini AND @fecha_fin )))

		BEGIN
			SET @codOp = 2;
			SET @resultado = 'Ya existe una facturacion realizada para el mes ingresado. Verifique las fechas ingresadas.';
		END
	
		ELSE

		BEGIN

			--SE DECLARA CURSOR QUE RECUPERA EL IMPORTE TOTAL POR CADA TURNO
			DECLARE IMPORTES_TURNO_CURSOR CURSOR FOR
			SELECT SUM(B.Turno_Precio_Base),SUM(A.Viaje_Cant_Kilometros),b.Turno_Valor_Kilometro
			  FROM SAPNU_PUAS.Viaje A, SAPNU_PUAS.Turno B
             WHERE A.Viaje_Cliente = @cliente
               AND A.Viaje_Fecha_Hora_Inicio BETWEEN @fecha_ini AND @fecha_fin
               AND A.Viaje_Fecha_Hora_Fin    BETWEEN @fecha_ini AND @fecha_fin
               AND B.Turno_Codigo = A.Viaje_Turno
             GROUP BY A.Viaje_Turno, b.Turno_Valor_Kilometro;

			OPEN IMPORTES_TURNO_CURSOR;

			SET @importe = 0;
			FETCH NEXT FROM IMPORTES_TURNO_CURSOR INTO @precio_base, @cant_km, @valor_km
			
			--SUMA LOS IMPORTES DE CADA TURNO EN LA VARIABLE @IMPORTE
			WHILE @@FETCH_STATUS = 0  
			BEGIN  
				SET @importe = (@importe  + (@precio_base + (@cant_km * @valor_km)));
				FETCH NEXT FROM IMPORTES_TURNO_CURSOR INTO @precio_base, @cant_km, @valor_km
			END;

			CLOSE IMPORTES_TURNO_CURSOR  ;
			DEALLOCATE IMPORTES_TURNO_CURSOR  ;

			BEGIN TRY
				
				BEGIN TRANSACTION T1

				    SET @nroFact = 0;
				    	
			        SET @codOp = 0;
			        /*Se inserta la factura del mes para el cliente ingresado por parametros*/
			        INSERT INTO SAPNU_PUAS.Factura
			        VALUES (@fecha_ini,@fecha_fin,@importe,SYSDATETIME(),@cliente);
			        
			        SET @nroFact = @@IDENTITY;
				    
				    /*Si se inserto existosamente la factura, se va a insertar en la tabla VIAJE_X_FACTURA
			          la relacion entre la factura y los viajes que facturados en la misma.*/
			        INSERT INTO SAPNU_PUAS.Viaje_x_Factura
			        SELECT Factura_Nro, Viaje_Codigo FROM SAPNU_PUAS.Factura, SAPNU_PUAS.Viaje
			        WHERE Factura_nro = @nroFact
			          AND Factura_Cliente = Viaje_Cliente
                                  AND Viaje_Fecha_Hora_Inicio BETWEEN Factura_Fecha_Inicio AND Factura_Fecha_Fin
				  AND Viaje_Fecha_Hora_Fin BETWEEN Factura_Fecha_Inicio AND Factura_Fecha_Fin
			
				COMMIT TRANSACTION T1

			END TRY
			
			BEGIN CATCH
				/*Si hubo algun error se deshacen todos los cambios en las tablas*/
				ROLLBACK TRANSACTION T1;

				SET @codOp = @@ERROR;
				
				IF(@nroFact = 0)
					SET @resultado = 'Ocurrio un error al registrar la facturacion en la tabla de facturas.';
				ELSE
					SET @resultado = 'Ocurrio un error al registrar los viajes de la factura en la tabla FACTURA_X_VIAJE.';
				
			END CATCH
			    
		END;
END;
GO

-- =======================================================================
-- Description:	Función que dado un año y un trimestre devuelve los 5 choferes 
--				con los viajes más largos del período.
-- =======================================================================

IF OBJECT_ID('SAPNU_PUAS.viajes_mas_largos') IS NOT NULL
BEGIN
	DROP FUNCTION SAPNU_PUAS.viajes_mas_largos;
END;
GO

CREATE FUNCTION [SAPNU_PUAS].[viajes_mas_largos](@anio int, @mes_inicio int, @mes_fin int)
RETURNS TABLE 
AS
RETURN
SELECT top 5
C.Chofer_Nombre,
C.Chofer_Apellido,
C.Chofer_Telefono,
C.Chofer_Mail,
max(V.Viaje_Cant_Kilometros) AS Viaje_Cant_Kms    
FROM SAPNU_PUAS.Viaje V
JOIN SAPNU_PUAS.Chofer C
ON V.Viaje_Chofer = C.Chofer_Telefono
WHERE 
YEAR(V.Viaje_Fecha_Hora_Inicio) = @anio and
MONTH(V.Viaje_Fecha_Hora_Inicio) BETWEEN @mes_inicio and @mes_fin
group by C.Chofer_Nombre, C.Chofer_Apellido, C.Chofer_Mail,C.Chofer_Telefono
order by max(V.Viaje_Cant_Kilometros) desc

GO

-- =======================================================================
-- Description:	Función devuelve los 5 clientes con mayor consumo dado
--				un año y un trimestre.
-- =======================================================================

IF OBJECT_ID('SAPNU_PUAS.clientes_mayor_consumo') IS NOT NULL
BEGIN
	DROP FUNCTION SAPNU_PUAS.clientes_mayor_consumo;
END;
GO

CREATE FUNCTION [SAPNU_PUAS].[clientes_mayor_consumo](@anio int, @mes_inicio int, @mes_fin int)
RETURNS TABLE 
AS
RETURN

select
top 5
C.Cliente_Apellido,
C.Cliente_Nombre,
C.Cliente_Mail,
C.Cliente_Telefono,
sum(F.Factura_Importe) as Importe


FROM SAPNU_PUAS.Factura F

INNER JOIN SAPNU_PUAS.Cliente C
ON F.Factura_Cliente = C.Cliente_Telefono

 WHERE
 YEAR(F.Factura_Fecha) = @anio and
 MONTH(F.Factura_Fecha) BETWEEN @mes_inicio and @mes_fin
 group by C.Cliente_Apellido,C.Cliente_Nombre,C.Cliente_Mail,C.Cliente_Telefono
 order by sum(F.Factura_Importe) desc

 GO

-- ======================================================================
-- Description:	SP que realiza el alta de un chofer. Si no tiene usuario,
--              se le crea uno. Caso contrario, se le asigna a su usuario
--              el rol de chofer.
-- ======================================================================

IF OBJECT_ID('SAPNU_PUAS.sp_chofer_alta') IS NOT NULL
BEGIN
	DROP PROCEDURE SAPNU_PUAS.sp_chofer_alta;
END;
GO

CREATE PROCEDURE [SAPNU_PUAS].[sp_chofer_alta] 
	@nombre varchar(255), 
	@apellido varchar(255), 
	@dni numeric(18,0), 
	@mail varchar(50), 
	@telefono numeric(18,0), 
	@direccion varchar(255), 
	@fechaNacimiento datetime, 
	@activo tinyint,
	@codOp int out,
	@resultado varchar(255) out
AS
BEGIN

	SET @codOp = 0;
	declare @idPersona int
	
	--Chequeo si el chofer a dar de alta ya fue dado de alta como persona
	SELECT @idPersona = Persona_Id
	FROM SAPNU_PUAS.Persona P
	WHERE P.Persona_Telefono = @telefono;

	--Si no tiene persona, creo el usuario y la persona con su usuario asociado. Luego, creo el chofer con su persona
	--Caso contrario, creo el chofer y le asigno su persona
	IF (isnull(@idPersona,0) = 0)
		BEGIN
			BEGIN TRY
				INSERT INTO SAPNU_PUAS.Usuario (Usuario_Username,Usuario_Password,Usuario_Reintentos,Usuario_Activo) values (@telefono,HashBytes('SHA2_256',convert(varchar(255), @telefono)),0,1);
				INSERT INTO SAPNU_PUAS.Persona (Persona_Telefono,Persona_Username) values (@telefono,@telefono);
				INSERT INTO SAPNU_PUAS.Chofer (Chofer_Activo,Chofer_Apellido,Chofer_Direccion,Chofer_Dni,Chofer_Fecha_Nac,Chofer_Mail,Chofer_Nombre,Chofer_Persona,Chofer_Telefono) values (@activo,@apellido,@direccion,@dni,@fechaNacimiento,@mail,@nombre,@@IDENTITY,@telefono);
			END TRY
			BEGIN CATCH
				SET @codOp = 1;

				IF(@codOp <> 0)
					SET @resultado = 'Ocurrio un error al tratar de crear el usuario asociado al chofer';
			END CATCH
		END
	ELSE
		BEGIN TRY
			INSERT INTO SAPNU_PUAS.Chofer (Chofer_Activo,Chofer_Apellido,Chofer_Direccion,Chofer_Dni,Chofer_Fecha_Nac,Chofer_Mail,Chofer_Nombre,Chofer_Persona,Chofer_Telefono) values (@activo,@apellido,@direccion,@dni,@fechaNacimiento,@mail,@nombre,@idPersona,@telefono);
		END TRY
		BEGIN CATCH
			SET @codOp = 1;

			IF(@codOp <> 0)
				SET @resultado = 'Ocurrio un error al tratar dar de alta el chofer';
		END CATCH

	--Busco el usuario del chofer y le asigno el rol de chofer
	declare @usernameChofer varchar(50)

	BEGIN TRY
		SELECT @usernameChofer = Persona_Username
		FROM SAPNU_PUAS.Persona P
		WHERE P.Persona_Telefono = @telefono;

		INSERT INTO SAPNU_PUAS.Rol_x_Usuario (Usuario_Username,Rol_Codigo) values (@usernameChofer,(SELECT Rol_Codigo FROM Rol where Rol_Nombre = 'Chofer'));
	END TRY
	BEGIN CATCH
		SET @codOp = 1;

		IF(@codOp <> 0)
			SET @resultado = 'Ocurrio un error al tratar de asignar los permisos de chofer a su usuario';
	END CATCH

	IF (@codOp = 0)
		SET @resultado = 'Chofer creado correctamente';

END

GO
-- =======================================================================
-- Description:	SP que realiza el alta de un cliente. Si no tiene usuario,
--              se le crea uno. Caso contrario, se le asigna a su usuario
--              el rol de Cliente.
-- =======================================================================

IF OBJECT_ID('SAPNU_PUAS.sp_cliente_alta') IS NOT NULL
BEGIN
	DROP PROCEDURE SAPNU_PUAS.sp_cliente_alta;
END;
GO

CREATE PROCEDURE [SAPNU_PUAS].[sp_cliente_alta] 
	@nombre varchar(255), 
	@apellido varchar(255), 
	@dni numeric(18,0), 
	@mail varchar(50), 
	@telefono numeric(18,0), 
	@direccion varchar(255), 
	@fechaNacimiento datetime, 
	@codPostal numeric(4,0), 
	@activo tinyint,
	@codOp int out,
	@resultado varchar(255) out
AS
BEGIN
	
	SET @codOp = 0;

	declare @idPersona int
	
	--Chequeo si el cliente a dar de alta ya fue dado de alta como persona
	SELECT @idPersona = Persona_Id
	FROM SAPNU_PUAS.Persona P
	WHERE P.Persona_Telefono = @telefono;

	--Si no tiene persona, creo el usuario y la persona con su usuario asociado. Luego, creo el cliente con su persona
	--Caso contrario, creo el cliente y le asigno su persona
	IF (isnull(@idPersona,0) = 0)
		BEGIN
			BEGIN TRY
				INSERT INTO SAPNU_PUAS.Usuario (Usuario_Username,Usuario_Password,Usuario_Reintentos,Usuario_Activo) values (@telefono,HashBytes('SHA2_256',convert(varchar(255), @telefono)),0,1);
				INSERT INTO SAPNU_PUAS.Persona (Persona_Telefono,Persona_Username) values (@telefono,@telefono);
				INSERT INTO SAPNU_PUAS.Cliente (Cliente_Activo,Cliente_Apellido,Cliente_Direccion,Cliente_Dni,Cliente_Fecha_Nac,Cliente_Mail,Cliente_Nombre,Cliente_Persona,Cliente_Telefono,Cliente_Codigo_Postal) values (@activo,@apellido,@direccion,@dni,@fechaNacimiento,@mail,@nombre,@@IDENTITY,@telefono,@codPostal);
			END TRY
			BEGIN CATCH
				SET @codOp = 1;

				IF(@codOp <> 0)
					SET @resultado = 'Ocurrio un error al tratar de crear el usuario asociado al Cliente';
			END CATCH
		END
	ELSE
		BEGIN TRY
			INSERT INTO SAPNU_PUAS.Cliente (Cliente_Activo,Cliente_Apellido,Cliente_Direccion,Cliente_Dni,Cliente_Fecha_Nac,Cliente_Mail,Cliente_Nombre,Cliente_Persona,Cliente_Telefono,Cliente_Codigo_Postal) values (@activo,@apellido,@direccion,@dni,@fechaNacimiento,@mail,@nombre,@idPersona,@telefono,@codPostal);
		END TRY
		BEGIN CATCH
			SET @codOp = 1;

			IF(@codOp <> 0)
				SET @resultado = 'Ocurrio un error al tratar dar de alta el Cliente';
		END CATCH

	--Busco el usuario del Cliente y le asigno el rol de Cliente
	declare @usernameCliente varchar(50)

	BEGIN TRY
		SELECT @usernameCliente = Persona_Username
		FROM SAPNU_PUAS.Persona P
		WHERE P.Persona_Telefono = @telefono;

		INSERT INTO SAPNU_PUAS.Rol_x_Usuario (Usuario_Username,Rol_Codigo) values (@usernameCliente,(SELECT Rol_Codigo FROM Rol where Rol_Nombre = 'Cliente'));
	END TRY
	BEGIN CATCH
		SET @codOp = 1;

		IF(@codOp <> 0)
			SET @resultado = 'Ocurrio un error al tratar de asignar los permisos de Cliente a su usuario';
	END CATCH

	IF (@codOp = 0)
		SET @resultado = 'Cliente creado correctamente';

END
GO

-- =======================================================================
-- Description:	Función que obtiene los 5 choferes con mayor recaudación
--              dado un año y un trimestre.
-- =======================================================================

IF OBJECT_ID('SAPNU_PUAS.top5recaudacion') IS NOT NULL
BEGIN
	DROP FUNCTION SAPNU_PUAS.top5recaudacion;
END;
GO

CREATE FUNCTION SAPNU_PUAS.top5recaudacion (@anio int, @mes1 int, @mes2 int)
RETURNS TABLE
AS
RETURN
	SELECT TOP 5 SUM(Rendicion_Importe) as RecaudacionTotal, Chofer_Apellido, Chofer_Telefono, Chofer_Mail
	FROM SAPNU_PUAS.Chofer JOIN SAPNU_PUAS.Rendicion ON Rendicion_Chofer=Chofer_Telefono
	WHERE YEAR(Rendicion_Fecha)=@anio AND MONTH(Rendicion_Fecha) BETWEEN @mes1 and @mes2
	GROUP BY Chofer_Apellido, Chofer_Telefono, Chofer_Mail
	ORDER BY SUM (Rendicion_Importe) DESC;
GO

-- =======================================================================
-- Description:	Función que obtiene los 5 autos/choferes con mayores 
--				coincidencias con el mismo cliente.
-- =======================================================================

IF OBJECT_ID('SAPNU_PUAS.top5ClienteAuto') IS NOT NULL
BEGIN
	DROP FUNCTION SAPNU_PUAS.top5ClienteAuto;
END;
GO

CREATE FUNCTION SAPNU_PUAS.top5ClienteAuto (@anio int, @mes1 int, @mes2 int)
RETURNS TABLE
AS
RETURN
	SELECT TOP 5 Auto_Patente, Chofer_Nombre, Chofer_Apellido, Chofer_Telefono, Cliente_Nombre, Cliente_Apellido, Cliente_Telefono, COUNT(*) as CantidadDeVeces
	FROM SAPNU_PUAS.Viaje JOIN SAPNU_PUAS.Cliente ON Viaje_Cliente=Cliente_Telefono JOIN SAPNU_PUAS.Auto ON Viaje_Auto=Auto_Patente JOIN SAPNU_PUAS.Chofer ON Auto_Chofer=Chofer_Telefono
	WHERE YEAR(Viaje_Fecha_Hora_Inicio)=@anio AND MONTH(Viaje_Fecha_Hora_Inicio) BETWEEN @mes1 and @mes2
	GROUP BY Auto_Patente, Chofer_Nombre, Chofer_Apellido, Chofer_Telefono, Cliente_Nombre, Cliente_Apellido, Cliente_Telefono
	ORDER BY CantidadDeVeces desc
GO

-- =======================================================================
-- Description:	Función que calcula el importe para un cliente comprendido
--				dentro de un período.
-- =======================================================================

IF OBJECT_ID('SAPNU_PUAS.calcular_importe') IS NOT NULL
BEGIN
	DROP FUNCTION SAPNU_PUAS.calcular_importe;
END;
GO

CREATE FUNCTION SAPNU_PUAS.calcular_importe (@cliente_telefono numeric(18,0), @periodo_inicio datetime, @periodo_fin datetime)
RETURNS TABLE
AS
	RETURN (SELECT (Turno_Precio_Base+ Turno_Valor_Kilometro* Viaje_Cant_Kilometros) as importe, Viaje_Codigo as viaje FROM SAPNU_PUAS.Viaje JOIN SAPNU_PUAS.Turno ON Viaje_Turno=Turno_Codigo WHERE Viaje_Cliente=@cliente_telefono AND Viaje_Fecha_Hora_Inicio BETWEEN @periodo_inicio AND @periodo_fin)
GO

IF OBJECT_ID('SAPNU_PUAS.r1') IS NOT NULL
BEGIN
	DROP VIEW SAPNU_PUAS.r1;
END;
GO

CREATE VIEW SAPNU_PUAS.r1 AS SELECT DISTINCT Rendicion_Nro, Rendicion_Fecha, Rendicion_Importe, Chofer_Telefono, Turno_Codigo FROM gd_esquema.Maestra t1 JOIN SAPNU_PUAS.Turno t ON t1.Turno_Descripcion=t.Turno_Descripcion  WHERE Rendicion_Nro IS NOT NULL
GO


--INSERCION DE DATOS

--Rol
-- SAPNU_PUAS.Rol
INSERT INTO SAPNU_PUAS.Rol(Rol_Nombre, Rol_Activo)
VALUES ('Administrador',1),('Cliente',1),('Chofer',1)
--Funcionalidad
-- SAPNU_PUAS.Funcionalidad
INSERT INTO SAPNU_PUAS.Funcionalidad(Funcionalidad_Nombre)
VALUES ('ABMrol'),('ABMcliente'),('ABMturno'),
('ABMauto'),('ABMchofer'),('RegistroViaje'),
('RendicionViaje'),('Facturacion'),('ListadoEstadistico')
--FuncionalidadxRol
--Consideraciones: el administrador puede realizar todas las operaciones, el chofer sólo puede registrar un viaje, el cliente solo podrá revisar su factura
-- SAPNU_PUAS.Funcionalidad_x_Rol
INSERT INTO SAPNU_PUAS.Funcionalidad_x_Rol(Rol_Codigo,Funcionalidad_Codigo)
SELECT (SELECT Rol_Codigo FROM SAPNU_PUAS.Rol WHERE Rol_Nombre='Administrador'),Funcionalidad_Codigo FROM SAPNU_PUAS.Funcionalidad
UNION
SELECT (SELECT Rol_Codigo FROM SAPNU_PUAS.Rol WHERE Rol_Nombre='Cliente'),Funcionalidad_Codigo FROM SAPNU_PUAS.Funcionalidad WHERE Funcionalidad_Nombre='Facturacion'
UNION
SELECT (SELECT Rol_Codigo FROM SAPNU_PUAS.Rol WHERE Rol_Nombre='Chofer'),Funcionalidad_Codigo FROM SAPNU_PUAS.Funcionalidad WHERE Funcionalidad_Nombre='RegistroViaje'



--Usuarios Clientes
--Consideraciones: ya que usamos el teléfono del cliente como clave principal, la misma será su usuario y clave.
-- SAPNU_PUAS.Usuario
INSERT INTO SAPNU_PUAS.Usuario(Usuario_Username, Usuario_Password, Usuario_Activo, Usuario_Reintentos)
SELECT DISTINCT Cliente_Telefono, HashBytes('SHA2_256',convert(varchar(255), Cliente_Telefono)), 1, 0 FROM gd_esquema.Maestra
--Insertar Rol
INSERT INTO SAPNU_PUAS.Rol_x_Usuario(Rol_Codigo, Usuario_Username)
SELECT DISTINCT (SELECT Rol_Codigo FROM SAPNU_PUAS.Rol WHERE Rol_Nombre='Cliente'), Cliente_Telefono FROM gd_esquema.Maestra

--Usuarios Choferes
--Consideraciones: ya que usamos el teléfono del chofer como clave principal, la misma será su usuario y clave.
-- SAPNU_PUAS.Usuario
INSERT INTO SAPNU_PUAS.Usuario(Usuario_Username, Usuario_Password, Usuario_Activo, Usuario_Reintentos)
SELECT DISTINCT Chofer_Telefono, HashBytes('SHA2_256',convert(varchar(255), Chofer_Telefono)), 1, 0 FROM gd_esquema.Maestra
--Insertar Rol
INSERT INTO SAPNU_PUAS.Rol_x_Usuario(Rol_Codigo, Usuario_Username)
SELECT DISTINCT (SELECT Rol_Codigo FROM SAPNU_PUAS.Rol WHERE Rol_Nombre='Chofer'), Chofer_Telefono FROM gd_esquema.Maestra

--Usuario Admin
-- SAPNU_PUAS.Usuario
INSERT INTO SAPNU_PUAS.Usuario(Usuario_Username, Usuario_Password, Usuario_Activo, Usuario_Reintentos)
VALUES ('admin',HashBytes('SHA2_256','w23e'),1,0)
--Insertar Rol
INSERT INTO SAPNU_PUAS.Rol_x_Usuario(Rol_Codigo, Usuario_Username)
SELECT Rol_Codigo, 'admin' FROM SAPNU_PUAS.Rol WHERE Rol_Nombre='Administrador'

--Persona
--SAPNU_PUAS.Persona
INSERT INTO SAPNU_PUAS.Persona(Persona_Telefono, Persona_Username)
SELECT DISTINCT Cliente_Telefono, Cliente_Telefono FROM gd_esquema.Maestra
UNION
SELECT DISTINCT Chofer_Telefono, Chofer_Telefono FROM gd_esquema.Maestra

--Cliente
-- SAPNU_PUAS.Cliente
INSERT INTO SAPNU_PUAS.Cliente (Cliente_Dni, Cliente_Nombre, Cliente_Apellido, Cliente_Direccion, Cliente_Telefono, Cliente_Mail, Cliente_Fecha_Nac, Cliente_Codigo_Postal, Cliente_Activo, Cliente_Persona)
SELECT DISTINCT Cliente_Dni, Cliente_Nombre, Cliente_Apellido, Cliente_Direccion, Cliente_Telefono, Cliente_Mail, Cliente_Fecha_Nac, 1, 1, 
Persona_Id
FROM gd_esquema.Maestra JOIN SAPNU_PUAS.Persona ON Persona_Telefono=Cliente_Telefono
--Chofer
-- SAPNU_PUAS.Chofer
INSERT INTO SAPNU_PUAS.Chofer (Chofer_Dni, Chofer_Nombre, Chofer_Apellido, Chofer_Direccion, Chofer_Telefono, Chofer_Mail, Chofer_Fecha_Nac, Chofer_Activo, Chofer_Persona)
SELECT DISTINCT Chofer_Dni, Chofer_Nombre, Chofer_Apellido, Chofer_Direccion, Chofer_Telefono, Chofer_Mail, Chofer_Fecha_Nac, 1,
Persona_Id
FROM gd_esquema.Maestra JOIN SAPNU_PUAS.Persona ON Persona_Telefono=Chofer_Telefono
--Marca
-- SAPNU_PUAS.Marca
INSERT INTO SAPNU_PUAS.Marca (Marca_Nombre)
SELECT DISTINCT Auto_Marca FROM gd_esquema.Maestra
--Turno
-- SAPNU_PUAS.Turno
INSERT INTO SAPNU_PUAS.Turno (Turno_Descripcion, Turno_Hora_Inicio, Turno_Hora_Fin, Turno_Precio_Base, Turno_Valor_Kilometro, Turno_Activo)
SELECT DISTINCT Turno_Descripcion, Turno_Hora_Inicio, Turno_Hora_Fin, Turno_Precio_Base, Turno_Valor_Kilometro, 1 FROM gd_esquema.Maestra
--Auto
--Consideraciones: el turno del chofer es el correspondiente al último viaje que realizó, ya que se asume que ese es el último valor que tiene asignado
-- SAPNU_PUAS.Auto
INSERT INTO SAPNU_PUAS.Auto (Auto_Patente, Auto_Marca, Auto_Licencia, Auto_Rodado, Auto_Modelo, Auto_Chofer, Auto_Activo, Auto_Turno)
SELECT DISTINCT Auto_Patente, m1.Marca_Codigo, Auto_Licencia, Auto_Rodado, Auto_Modelo, Chofer_Telefono, 1, (SELECT TOP 1 t.Turno_Codigo FROM SAPNU_PUAS.Turno t, gd_esquema.Maestra m WHERE t.Turno_Descripcion=m.Turno_Descripcion AND m.Auto_Patente=t1.Auto_Patente ORDER BY m.Viaje_Fecha DESC) FROM gd_esquema.Maestra AS t1 JOIN SAPNU_PUAS.Marca m1 ON t1.Auto_Marca=m1.Marca_Nombre

--Viajes
--Consideraciones: la fecha y hora de finalización del viaje es la misma que de finalización del turno correspondiente
-- SAPNU_PUAS.Viaje
INSERT INTO SAPNU_PUAS.Viaje (Viaje_Cant_Kilometros, Viaje_Fecha_Hora_Inicio, Viaje_Fecha_Hora_Fin, Viaje_Chofer, Viaje_Auto, Viaje_Turno, Viaje_Cliente)
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
 FROM gd_esquema.Maestra t1 JOIN SAPNU_PUAS.Turno t2 ON t1.Turno_Descripcion=t2.Turno_Descripcion ORDER BY Viaje_Fecha DESC

--Factura
--Consideraciones: la app mostrará los viajes correspodientes a la factura a través de un SP a través de las fechas de inicio y fin de factura. No se registrá de forma explícita que viajes corresponden a qué factura, pero si estarán vinculados por lo anterior.
SET IDENTITY_INSERT SAPNU_PUAS.Factura ON
-- SAPNU_PUAS.Factura
INSERT INTO SAPNU_PUAS.Factura (Factura_Nro, Factura_Fecha, Factura_Fecha_Inicio, Factura_Fecha_Fin, Factura_Importe, Factura_Cliente)
SELECT DISTINCT Factura_Nro, Factura_Fecha, Factura_Fecha_Inicio, Factura_Fecha_Fin,
--Devuelve importe total de factura
(
SELECT SUM(importe) FROM SAPNU_PUAS.calcular_importe(t1.Cliente_Telefono, t1.Factura_Fecha_Inicio, t1.Factura_Fecha_Fin)
) as importe_total, Cliente_Telefono FROM gd_esquema.Maestra AS t1 WHERE Factura_Nro IS NOT NULL ORDER BY importe_total ASC

SET IDENTITY_INSERT SAPNU_PUAS.Factura OFF
 --Viaje_x_Factura
INSERT INTO SAPNU_PUAS.Viaje_x_Factura(Factura_Nro, Viaje_Codigo)
SELECT   Factura_Nro, Viaje_Codigo
FROM SAPNU_PUAS.Viaje JOIN SAPNU_PUAS.Factura ON Factura_Cliente=Viaje_Cliente
WHERE Viaje_Fecha_Hora_Inicio BETWEEN Factura_Fecha_Inicio AND Factura_Fecha_Fin

--Rendicion
/*Consideraciones: las rendiciones correspondientes a números,fechas y turnos iguales serán agrupadas
en una igual con la suma total de sus importes.
Aunque el enunciado declare que un chofer rendirá 1 sola rendición en el día,
notamos que en la base de datos, varios choferes tenían más de 1 rendición en un mismo día,
por lo que se tomó la decisión de migrarlas de igual forma;
ya que incluso correspondian a turnos distintos.
*/
SET IDENTITY_INSERT SAPNU_PUAS.Rendicion ON
-- SAPNU_PUAS.Rendicion
INSERT INTO SAPNU_PUAS.Rendicion(Rendicion_Nro, Rendicion_Fecha, Rendicion_Importe, Rendicion_Chofer, Rendicion_Turno, Rendicion_Porcentaje)
SELECT Rendicion_Nro, Rendicion_Fecha, SUM(Rendicion_Importe) as importe_total, Chofer_Telefono, Turno_codigo, 0.3 FROM SAPNU_PUAS.r1 GROUP BY Rendicion_Nro, Rendicion_Fecha, Chofer_Telefono, Turno_codigo ORDER BY Chofer_Telefono,Rendicion_Fecha ASC
SET IDENTITY_INSERT SAPNU_PUAS.Rendicion OFF
 --Viaje_x_Rendicion
INSERT INTO SAPNU_PUAS.Viaje_x_Rendicion(Rendicion_Nro, Viaje_Codigo)
SELECT DISTINCT Rendicion_Nro,Viaje_Codigo
FROM SAPNU_PUAS.Viaje JOIN SAPNU_PUAS.Rendicion ON Rendicion_Chofer=Viaje_Chofer AND Rendicion_Turno=Viaje_Turno
WHERE Rendicion_Nro IS NOT NULL AND CAST(Viaje_Fecha_Hora_Inicio AS DATE) = CAST(Rendicion_Fecha AS DATE)
ORDER BY Viaje_Codigo
