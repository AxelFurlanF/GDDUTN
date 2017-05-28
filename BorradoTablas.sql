-- Created by Vertabelo (http://vertabelo.com)
-- Last modification date: 2017-05-25 04:44:30.109

-- foreign keys
ALTER TABLE Auto DROP CONSTRAINT Auto_Chofer;

ALTER TABLE Auto DROP CONSTRAINT Auto_Marca;

ALTER TABLE Auto DROP CONSTRAINT Auto_Turno;

ALTER TABLE Chofer DROP CONSTRAINT Chofer_Persona;

ALTER TABLE Cliente DROP CONSTRAINT Cliente_Persona;

ALTER TABLE Factura DROP CONSTRAINT Factura_Cliente;

ALTER TABLE Funcionalidad_x_Rol DROP CONSTRAINT Funcionalidad_x_Rol_Funcionalidad;

ALTER TABLE Funcionalidad_x_Rol DROP CONSTRAINT Funcionalidad_x_Rol_Rol;

ALTER TABLE Persona DROP CONSTRAINT Persona_Usuario;

ALTER TABLE Rendicion DROP CONSTRAINT Rendicion_Chofer;

ALTER TABLE Rendicion DROP CONSTRAINT Rendicion_Turno;

ALTER TABLE Rol_x_Usuario DROP CONSTRAINT Rol_x_Usuario_Rol;

ALTER TABLE Rol_x_Usuario DROP CONSTRAINT Rol_x_Usuario_Usuario;

ALTER TABLE Viaje DROP CONSTRAINT Viaje_Auto;

ALTER TABLE Viaje DROP CONSTRAINT Viaje_Chofer;

ALTER TABLE Viaje DROP CONSTRAINT Viaje_Cliente;

ALTER TABLE Viaje DROP CONSTRAINT Viaje_Turno;

ALTER TABLE Viaje_x_Factura DROP CONSTRAINT Viaje_x_Factura_Factura;

ALTER TABLE Viaje_x_Factura DROP CONSTRAINT Viaje_x_Factura_Viaje;

ALTER TABLE Viaje_x_Rendicion DROP CONSTRAINT Viaje_x_Rendicion_Rendicion;

ALTER TABLE Viaje_x_Rendicion DROP CONSTRAINT Viaje_x_Rendicion_Viaje;

-- tables
DROP TABLE Auto;

DROP TABLE Chofer;

DROP TABLE Cliente;

DROP TABLE Factura;

DROP TABLE Funcionalidad;

DROP TABLE Funcionalidad_x_Rol;

DROP TABLE Marca;

DROP TABLE Persona;

DROP TABLE Rendicion;

DROP TABLE Rol;

DROP TABLE Rol_x_Usuario;

DROP TABLE Turno;

DROP TABLE Usuario;

DROP TABLE Viaje;

DROP TABLE Viaje_x_Factura;

DROP TABLE Viaje_x_Rendicion;

-- End of file.

