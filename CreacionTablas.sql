-- Created by Vertabelo (http://vertabelo.com)
-- Last modification date: 2017-05-25 04:44:30.109

-- tables
-- Table: Auto
CREATE TABLE Auto (
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

-- Table: Chofer
CREATE TABLE Chofer (
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

-- Table: Cliente
CREATE TABLE Cliente (
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

-- Table: Factura
CREATE TABLE Factura (
    Factura_Nro int  NOT NULL IDENTITY(1, 1),
    Factura_Fecha_Inicio datetime  NOT NULL,
    Factura_Fecha_Fin datetime  NOT NULL,
    Factura_Importe numeric(18,2)  NOT NULL,
    Factura_Fecha datetime  NOT NULL,
    Factura_Cliente numeric(18,0)  NOT NULL,
    CONSTRAINT Factura_pk PRIMARY KEY  (Factura_Nro)
);

-- Table: Funcionalidad
CREATE TABLE Funcionalidad (
    Funcionalidad_Codigo int  NOT NULL IDENTITY(1, 1),
    Funcionalidad_Nombre varchar(255)  NOT NULL,
    CONSTRAINT Funcionalidad_pk PRIMARY KEY  (Funcionalidad_Codigo)
);

-- Table: Funcionalidad_x_Rol
CREATE TABLE Funcionalidad_x_Rol (
    Rol_Codigo int  NOT NULL,
    Funcionalidad_Codigo int  NOT NULL,
    CONSTRAINT Funcionalidad_x_Rol_pk PRIMARY KEY  (Rol_Codigo,Funcionalidad_Codigo)
);

-- Table: Marca
CREATE TABLE Marca (
    Marca_Codigo int  NOT NULL IDENTITY,
    Marca_Nombre varchar(255)  NOT NULL,
    CONSTRAINT Marca_pk PRIMARY KEY  (Marca_Codigo)
);

-- Table: Persona
CREATE TABLE Persona (
    Persona_Id int  NOT NULL IDENTITY(1, 1),
    Persona_Telefono numeric(18,0)  NOT NULL,
    Persona_Username varchar(50)  NOT NULL,
    CONSTRAINT Telefono_Unico UNIQUE (Persona_Telefono),
    CONSTRAINT Persona_pk PRIMARY KEY  (Persona_Id)
);

-- Table: Rendicion
CREATE TABLE Rendicion (
    Rendicion_Nro numeric(18,0)  NOT NULL IDENTITY(1, 1),
    Rendicion_Fecha datetime  NOT NULL,
    Rendicion_Importe numeric(18,2)  NOT NULL,
    Rendicion_Chofer numeric(18,0)  NOT NULL,
    Rendicion_Turno int  NOT NULL,
    Rendicion_Porcentaje numeric(5,2)  NOT NULL,
    --CONSTRAINT Rendicion_Unica UNIQUE (Rendicion_Fecha, Rendicion_Chofer),
    CONSTRAINT Rendicion_pk PRIMARY KEY  (Rendicion_Nro)
);

-- Table: Rol
CREATE TABLE Rol (
    Rol_Codigo int  NOT NULL IDENTITY(1, 1),
    Rol_Nombre varchar(255)  NOT NULL,
    Rol_Activo tinyint  NOT NULL,
    CONSTRAINT Rol_pk PRIMARY KEY  (Rol_Codigo)
);

-- Table: Rol_x_Usuario
CREATE TABLE Rol_x_Usuario (
    Rol_Codigo int  NOT NULL,
    Usuario_Username varchar(50)  NOT NULL,
    CONSTRAINT Rol_x_Usuario_pk PRIMARY KEY  (Rol_Codigo,Usuario_Username)
);

-- Table: Turno
CREATE TABLE Turno (
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

-- Table: Usuario
CREATE TABLE Usuario (
    Usuario_Username varchar(50)  NOT NULL,
    Usuario_Password varchar(255)  NOT NULL,
    Usuario_Reintentos smallint  NOT NULL,
    Usuario_Activo tinyint  NOT NULL,
    CONSTRAINT Usuario_pk PRIMARY KEY  (Usuario_Username)
);

-- Table: Viaje
CREATE TABLE Viaje (
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

-- Table: Viaje_x_Factura
CREATE TABLE Viaje_x_Factura (
    Factura_Nro int  NOT NULL,
    Viaje_Codigo int  NOT NULL,
    CONSTRAINT Viaje_x_Factura_pk PRIMARY KEY  (Factura_Nro,Viaje_Codigo)
);

-- Table: Viaje_x_Rendicion
CREATE TABLE Viaje_x_Rendicion (
    Viaje_Codigo int  NOT NULL,
    Rendicion_Nro numeric(18,0)  NOT NULL,
    CONSTRAINT Viaje_x_Rendicion_pk PRIMARY KEY  (Viaje_Codigo,Rendicion_Nro)
);

-- foreign keys
-- Reference: Auto_Chofer (table: Auto)
ALTER TABLE Auto ADD CONSTRAINT Auto_Chofer
    FOREIGN KEY (Auto_Chofer)
    REFERENCES Chofer (Chofer_Telefono);

-- Reference: Auto_Marca (table: Auto)
ALTER TABLE Auto ADD CONSTRAINT Auto_Marca
    FOREIGN KEY (Auto_Marca)
    REFERENCES Marca (Marca_Codigo);

-- Reference: Auto_Turno (table: Auto)
ALTER TABLE Auto ADD CONSTRAINT Auto_Turno
    FOREIGN KEY (Auto_Turno)
    REFERENCES Turno (Turno_Codigo);

-- Reference: Chofer_Persona (table: Chofer)
ALTER TABLE Chofer ADD CONSTRAINT Chofer_Persona
    FOREIGN KEY (Chofer_Persona)
    REFERENCES Persona (Persona_Id);

-- Reference: Cliente_Persona (table: Cliente)
ALTER TABLE Cliente ADD CONSTRAINT Cliente_Persona
    FOREIGN KEY (Cliente_Persona)
    REFERENCES Persona (Persona_Id);

-- Reference: Factura_Cliente (table: Factura)
ALTER TABLE Factura ADD CONSTRAINT Factura_Cliente
    FOREIGN KEY (Factura_Cliente)
    REFERENCES Cliente (Cliente_Telefono);

-- Reference: Funcionalidad_x_Rol_Funcionalidad (table: Funcionalidad_x_Rol)
ALTER TABLE Funcionalidad_x_Rol ADD CONSTRAINT Funcionalidad_x_Rol_Funcionalidad
    FOREIGN KEY (Funcionalidad_Codigo)
    REFERENCES Funcionalidad (Funcionalidad_Codigo);

-- Reference: Funcionalidad_x_Rol_Rol (table: Funcionalidad_x_Rol)
ALTER TABLE Funcionalidad_x_Rol ADD CONSTRAINT Funcionalidad_x_Rol_Rol
    FOREIGN KEY (Rol_Codigo)
    REFERENCES Rol (Rol_Codigo);

-- Reference: Persona_Usuario (table: Persona)
ALTER TABLE Persona ADD CONSTRAINT Persona_Usuario
    FOREIGN KEY (Persona_Username)
    REFERENCES Usuario (Usuario_Username);

-- Reference: Rendicion_Chofer (table: Rendicion)
ALTER TABLE Rendicion ADD CONSTRAINT Rendicion_Chofer
    FOREIGN KEY (Rendicion_Chofer)
    REFERENCES Chofer (Chofer_Telefono);

-- Reference: Rendicion_Turno (table: Rendicion)
ALTER TABLE Rendicion ADD CONSTRAINT Rendicion_Turno
    FOREIGN KEY (Rendicion_Turno)
    REFERENCES Turno (Turno_Codigo);

-- Reference: Rol_x_Usuario_Rol (table: Rol_x_Usuario)
ALTER TABLE Rol_x_Usuario ADD CONSTRAINT Rol_x_Usuario_Rol
    FOREIGN KEY (Rol_Codigo)
    REFERENCES Rol (Rol_Codigo);

-- Reference: Rol_x_Usuario_Usuario (table: Rol_x_Usuario)
ALTER TABLE Rol_x_Usuario ADD CONSTRAINT Rol_x_Usuario_Usuario
    FOREIGN KEY (Usuario_Username)
    REFERENCES Usuario (Usuario_Username);

-- Reference: Viaje_Auto (table: Viaje)
ALTER TABLE Viaje ADD CONSTRAINT Viaje_Auto
    FOREIGN KEY (Viaje_Auto)
    REFERENCES Auto (Auto_Patente);

-- Reference: Viaje_Chofer (table: Viaje)
ALTER TABLE Viaje ADD CONSTRAINT Viaje_Chofer
    FOREIGN KEY (Viaje_Chofer)
    REFERENCES Chofer (Chofer_Telefono);

-- Reference: Viaje_Cliente (table: Viaje)
ALTER TABLE Viaje ADD CONSTRAINT Viaje_Cliente
    FOREIGN KEY (Viaje_Cliente)
    REFERENCES Cliente (Cliente_Telefono);

-- Reference: Viaje_Turno (table: Viaje)
ALTER TABLE Viaje ADD CONSTRAINT Viaje_Turno
    FOREIGN KEY (Viaje_Turno)
    REFERENCES Turno (Turno_Codigo);

-- Reference: Viaje_x_Factura_Factura (table: Viaje_x_Factura)
ALTER TABLE Viaje_x_Factura ADD CONSTRAINT Viaje_x_Factura_Factura
    FOREIGN KEY (Factura_Nro)
    REFERENCES Factura (Factura_Nro);

-- Reference: Viaje_x_Factura_Viaje (table: Viaje_x_Factura)
ALTER TABLE Viaje_x_Factura ADD CONSTRAINT Viaje_x_Factura_Viaje
    FOREIGN KEY (Viaje_Codigo)
    REFERENCES Viaje (Viaje_Codigo);

-- Reference: Viaje_x_Rendicion_Rendicion (table: Viaje_x_Rendicion)
ALTER TABLE Viaje_x_Rendicion ADD CONSTRAINT Viaje_x_Rendicion_Rendicion
    FOREIGN KEY (Rendicion_Nro)
    REFERENCES Rendicion (Rendicion_Nro);

-- Reference: Viaje_x_Rendicion_Viaje (table: Viaje_x_Rendicion)
ALTER TABLE Viaje_x_Rendicion ADD CONSTRAINT Viaje_x_Rendicion_Viaje
    FOREIGN KEY (Viaje_Codigo)
    REFERENCES Viaje (Viaje_Codigo);

-- End of file.
