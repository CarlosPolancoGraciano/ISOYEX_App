CREATE DATABASE ISOYEX
go
USE ISOYEX
go
/*Systems tables*/
CREATE TABLE Provincia(
Id_Provincia int identity(1,1) PRIMARY KEY,
Provincia varchar(100) not null
)
go
CREATE TABLE Municipio(
Id_Municipio int identity(1,1) PRIMARY KEY,
Municipio varchar(100) not null,
Id_Provincia int not null,
CONSTRAINT fk_MunicipioProvincia FOREIGN KEY(Id_Provincia)
REFERENCES Provincia(Id_Provincia)
)
go
CREATE TABLE Direccion(
Id_Direccion int identity(1,1) PRIMARY KEY,
Id_Provincia int not null,
Id_Municipio int not null,
CONSTRAINT fk_DireccionProvincia FOREIGN KEY(Id_Provincia)
REFERENCES Provincia(Id_Provincia),
CONSTRAINT fk_DireccionMunicipio FOREIGN KEY(Id_Municipio)
REFERENCES Municipio(Id_Municipio)
)
go
CREATE TABLE Contacto(
Id_Contacto int identity(1,1) PRIMARY KEY,
Numero varchar(15) not null,
)
go
CREATE TABLE TipoContacto(
Id_TipoContacto int identity(1,1) PRIMARY KEY,
Tipo varchar(50) not null
)
go
CREATE TABLE ContactoTipoContacto(
Id_ContactoTipoContacto int identity(1,1) PRIMARY KEY,
Id_Contacto int not null,
Id_TipoContacto int not null,
CONSTRAINT fk_ContactoTipoContactoContacto FOREIGN KEY (Id_Contacto)
REFERENCES Contacto(Id_Contacto),
CONSTRAINT fk_ContactoTipoContactoTipoContacto FOREIGN KEY (Id_TipoContacto)
REFERENCES TipoContacto(Id_TipoContacto)
)
go
CREATE TABLE TipoSangre
(
Id_TipoSangre int identity(1,1) PRIMARY KEY,
TipoSangre varchar(15) not null
)
go
CREATE TABLE Rol
(
	Id_Rol int identity(1,1) PRIMARY KEY,
	Nombre nvarchar(128) not null
)
go
CREATE TABLE AutenticacionUsuario(
Id_AutenticacionUsuario int identity(1,1) PRIMARY KEY,
Email nvarchar(128) not null,
Contrasena nvarchar(100) not null,
)
go
CREATE TABLE Usuario(
Id_Usuario int identity(1,1) PRIMARY KEY,
RNC nvarchar(20),
Nombre nvarchar(100) not null,
Apellido nvarchar(100),
Imagen nvarchar(100),
FechaNacimiento datetime,
Id_AutenticacionUsuario int,
Id_TipoSangre int,
Id_Contacto int,
Id_Direccion int,
CONSTRAINT fk_UsuarioAutenticacionUsuario FOREIGN KEY(Id_AutenticacionUsuario)
REFERENCES AutenticacionUsuario(Id_AutenticacionUsuario),
CONSTRAINT fk_UsuarioContacto FOREIGN KEY(Id_Contacto)
REFERENCES Contacto(Id_Contacto),
CONSTRAINT fk_UsuarioDireccion FOREIGN KEY(Id_Direccion)
REFERENCES Direccion(Id_Direccion),
CONSTRAINT fk_UsuarioTipoSangre FOREIGN KEY(Id_TipoSangre)
REFERENCES TipoSangre(Id_TipoSangre)
)
go
CREATE TABLE UsuarioRol
(
Id_UsuarioRol int identity(1,1) PRIMARY KEY,
Id_Rol int not null,
Id_AutenticacionUsuario int not null,
CONSTRAINT fk_RolUsuarioRol FOREIGN KEY (Id_Rol)
REFERENCES Rol(Id_Rol),
CONSTRAINT fk_UsuarioRolAutenticacionUsuario FOREIGN KEY (Id_AutenticacionUsuario)
REFERENCES AutenticacionUsuario(Id_AutenticacionUsuario)
)
go
CREATE TABLE Publicacion(
Id_Publicacion int identity(1,1) PRIMARY KEY,
Titulo nvarchar(150) not null,
Contenido text not null,
Fecha datetime not null,
Id_TipoSangre int,
Id_Usuario int,
CONSTRAINT fk_PublicacionTipoSangre FOREIGN KEY(Id_TipoSangre)
REFERENCES TipoSangre(Id_TipoSangre),
CONSTRAINT fk_PublicacionUsuario FOREIGN KEY(Id_Usuario)
REFERENCES Usuario(Id_Usuario)
)
go
CREATE TABLE Comentario(
Id_Comentario int identity(1,1) PRIMARY KEY,
Contenido text not null,
Fecha datetime not null,
Id_Usuario int not null,
Id_Publicacion int not null
CONSTRAINT fk_ComentarioUsuario FOREIGN KEY(Id_Usuario)
REFERENCES Usuario(Id_Usuario),
CONSTRAINT fk_ComentarioPublicacion FOREIGN KEY(Id_Publicacion)
REFERENCES Publicacion(Id_Publicacion)
)
go
CREATE TABLE Notificacion(
Id_Notificacion int identity(1,1) PRIMARY KEY,
Contenido text not null,
Id_Usuario int not null,
Id_Publicacion int not null,
CONSTRAINT fk_NotificacionUsuario FOREIGN KEY(Id_Usuario)
REFERENCES Usuario(Id_Usuario),
CONSTRAINT fk_NotificacionPublicacion FOREIGN KEY(Id_Publicacion)
REFERENCES Publicacion(Id_Publicacion)
)
go
INSERT INTO Rol VALUES ('Donante')
INSERT INTO Rol VALUES ('Institucion')
go
/*Inserting type of blood data*/
INSERT INTO TipoSangre VALUES ('A+')
INSERT INTO TipoSangre VALUES ('A-')
INSERT INTO TipoSangre VALUES ('B+')
INSERT INTO TipoSangre VALUES ('B-')
INSERT INTO TipoSangre VALUES ('AB+')
INSERT INTO TipoSangre VALUES ('AB-')
INSERT INTO TipoSangre VALUES ('O+')
INSERT INTO TipoSangre VALUES ('O-')
INSERT INTO TipoSangre VALUES ('Ninguna')
go
/*Inserting Contact Type*/
INSERT INTO TipoContacto VALUES ('Personal')
INSERT INTO TipoContacto VALUES ('Hogar')
INSERT INTO TipoContacto VALUES ('Oficina')
go
/*Inserting Provinces and Municipalities*/
INSERT INTO Provincia VALUES ('ALTAGRACIA'),('AZUA'),('Bahoruco'),
('Barahona'),('Dajabón'),('Distrito Nacional'),
('Duarte'),('El Seibo'),('Elías Piña'),
('Espaillat'),('Hato Mayor'),('Hermanas Mirabal'),
('Independencia'),('La Romana'),('La Vega'),('Maria Trinidad Sánchez'),
('Monseñor Nouel'),('Monte Plata'),('Montecristi'),
('Pedernales'),('Peravia'),('Puerto Plata'),
('Samaná'),('San Cristóbal'),('San Jose de Ocoa'),
('San Juan'),('San Pedro de macoris'),('Sánchez Ramirez'),
('Santiago de los Caballeros'),('Santiago Rodriguez'), ('Santo Domingo'),('Valverde')
go
INSERT INTO Municipio VALUES ('Bayahibe', 1), ('Boca de Yuma', 1), ('Higuey', 1),
('La Laguna de Nisibon', 1), ('La Otra Banda', 1), ('San Rafael del Yuma', 1),
('Turistico Veron Punta Cana', 1), ('Amiama Gomez', 2), ('Azua', 2), ('Barreras', 2),
('Barro Arriba', 2), ('Doña Emma Balaguer VDA. Vallejo', 2), ('El Rosario', 2),
('Estebania', 2),('Guayabal', 2),('Hato nuevo cortes', 2),
('La Siembra', 2),('Las Barias-La Estancia', 2),('Las Charcas', 2),
('Las Clavellinas', 2),('Las Lagunas', 2),('Las Lomas', 2),
('Las Yayas De Viajama', 2),('Los Frios', 2),('Los Jovillos', 2),
('Los Toros', 2),('Monte Bonito', 2),('Padre Las Casas', 2),
('Palmar de Ocoa', 2),('Peralta', 2),('Proyecto #4', 2),
('Proyecto 2-C', 2),('Proyecto D-1 Ganadero', 2),('Pueblo Viejo', 2),
('Puerto Viejo-Los Negros', 2),('Sabana Yegua', 2),('Tabara Abajo', 2),
('Tabara Arriba', 2),('Villarpando', 2),('Cabeza de Toro', 3),
('El Palmar', 3),('El Salado', 3),('Galvan', 3),
('Las Clavellinas', 3),('Los Rios', 3),('Mena', 3),
('Monserrat', 3),('Neyba', 3),('Santa Barbara El 6', 3),
('Santana', 3),('Tamayo', 3),('Uvilla', 3),
('Villa Jaragua', 3),('Arroyo Dulce', 4),('Bahoruco', 4),
('Cabral', 4),('Canoa', 4),('El Cachon', 4),
('El Peñon', 4),('Enriquillo', 4),('Fondo Negro', 4),
('Fundación', 4),('Jaquimeyes', 4),('La Cienaga', 4),
('La Guazara', 4),('Las Salinas', 4),('Los Patos', 4),
('Palo Alto', 4),('Paraiso', 4),('Pescaderia', 4),
('Polo', 4),('Quita Coraza', 4),('Vicente Noble', 4),
('Villa Central', 4),('Cañongo', 5),('Capotillo', 5),
('Dajabon', 5),('El Pino', 5),('Loma de Cabrera', 5),
('Manuel Bueno', 5),('Partido', 5),('Restauracion', 5),
('Santiago de la Cruz', 5),('Distrito Nacional', 6),('Agua Santa del Yuna', 7),
('Arenoso', 7),('Barraquito', 7),('Castillo', 7),
('Cenovi', 7),('Cristo Rey de Guaraguao', 7),('Don Antonio Guzman Fernandez', 7),
('El Aguacate', 7),('Eugenio Maria de Hostos', 7),('Jaya', 7),
('La Peña', 7),('Las Coles', 7),('Las Guaranas', 7),
('Las Taranas', 7),('Pimentel', 7),('Sabana Grande', 7),
('San Francisco de Macoris', 7),('Villa Riva', 7),('El Jovero (El Cedro)', 8),
('El Seibo', 8),('La Gina', 8),('Miches', 8),
('Pedro Sánchez', 8),('San Francisco-Vicentillo', 8),('Santa Lucia-La Higuera', 8),
('Banica', 9),('Comendador', 9),('El Llano', 9),
('Guanito', 9),('Guayabo', 9),('Hondo Valle', 9),
('Juan Santiago', 9),('Pedro Santana', 9),('Rancho de la Guardia', 9),
('Rio Limpio', 9),('Sabana Cruz', 9),('Sanaba Higuero', 9),
('Sabana Larga', 9),('Canca la Reyna', 10),('Cayetano Germosen', 10),
('Gaspar Hernandez', 10),('Higuerito', 10),('Jamao Al Norte', 10),
('Joba Arriba', 10),('Jose Contreras', 10),('Juan Lopez Abajo (El Mamey)', 10),
('Las Lagunas Abajo', 10),('Moca', 10),('Monte de la Jagua', 10),
('Ortega', 10),('San Victor', 10),('Veragua', 10),
('Villa Magante', 10),('El Valle', 11),('Elupina Cordero de las Cañitas', 11),
('Guayabo Dulce', 11),('Hato Mayor', 11),('Mata Palacio', 11),
('Sabana de la Mar', 11),('Yerba Buena', 11),('Blanco', 12),
('Monte Llano (Jamao Afuera)', 12),('Salcedo', 12),('Tenares', 12),
('Villa Tapia', 12),('Batey 8', 13),('Boca de Cachon', 13),
('Cristobal', 13),('Duverge', 13),('El Limon', 13),
('Guayabal', 13),('Jimani', 13),('La Colonia', 13),
('La Descubierta', 13),('Mella', 13),('Postrer Rio', 13),
('Vengan A Ver', 13),('Cumayasa', 14),('Guaymate', 14),
('La Caleta', 14),('La Romana', 14),('Villa Hermosa', 14),
('Buena Vista', 15),('Constanza', 15),('El Ranchito', 15),
('Jarabacoa', 15),('Jima Abajo', 15),('La Sabina', 15),
('La Vega', 15),('Manabao', 15),('Rincon', 15),
('Rio Verde Arriba', 15),('Tireo Arriba', 15),('Arroyo Al Medio', 16),
('Arroyo Salado', 16),('Cabrera', 16),('El Factor', 16),
('El Pozo', 16),('La Entrada', 16),('Las Gordas', 16),
('Nagua', 16),('Rio San Juan', 16),('San Jose De Matanzas', 16),
('Arroyo Toro-Masipedro', 17),('Bonao', 17),('Jayaco', 17),
('Juan Adrian', 17),('Juma Bejucal', 17),('La Salvia-Los Quedamos', 17),
('Maimon', 17),('Piedra Blanca', 17),('Sabana del Puerto', 17),
('Villa Sonador', 17),('Bayaguana', 18),('Boya-El Centro', 18),
('Chirino', 18),('Don Juan', 18),('Gonzalo', 18),
('Los Botados', 18),('Majagual', 18),('Monte Plata', 18),
('Peralvillo', 18),('Sabana Grande de Boya', 18),('Yamasa', 18),
('Cana Chapeton', 19),('Castañuelas', 19),('Guayubin', 19),
('Hatillo Palma', 19),('Las Matas de Santa Cruz', 19),('Montecristi', 19),
('Palo Verde (El Ahogado)', 19),('Pepillo Salcedo', 19),('Villa Elisa', 19),
('Villa Vasquez', 19),('Jose Francisco Peña Gomez', 20),('Juancho', 20),
('Oviedo', 20),('Pedernales', 20),('Bani', 21),
('El Carreton', 21),('El Limonal', 21),('La Catalina', 21),
('Las Barias', 21),('Matanzas', 21),('Nizao', 21),
('Paya', 21),('Pizarrete', 21),('Sabana Buey', 21),
('Santana', 21),('Villa Fundación', 21),('Villa Sombrero', 21),
('Altamira', 22),('Belloso', 22),('Cabarete', 22),
('Estero Hondo', 22),('Estrecho de Luperon Omar Bross', 22),('Gualepe', 22),
('Guananico', 22),('Imbert', 22),('La Isabela', 22),
('La Jaiba', 22),('Los Hidalgos', 22),('Luperon', 22),
('Maimon', 22),('Navas', 22),('Puerto Plata', 22),
('Rio Grande', 22),('Sabaneta de Yasica', 22),('Sosua', 22),
('Villa Isabela', 22),('Villa Montellano', 22),('Yasica Arriba', 22),
('Arroyo Barril', 23),('El Limón', 23),('Las Galeras', 23),
('Las Terrenas', 23),('Samaná', 23),('Sanchez', 23),
('Bajos de Haina', 24),('Cambita Garabitos', 24),('El Carril', 24),
('Hato Damas', 24),('La Cuchilla', 24),('Los Cacaos', 24),
('Medina', 24),('Sabana Grande de Palenque', 24),('San Cristobal', 24),
('San Gregorio De Nigua', 24),('San Jose-Pino Herrado-El Puerto', 24),('Villa Altragacia', 24),
('Yaguate', 24),('El Naranjal', 25),('El Pinar', 25),
('La Cienaga', 25),('Nizao-Las Auyamas', 25),('Rancho Arriba', 25),
('Sabana Larga', 25),('San Jose De Ocoa', 25),('Arroyo Cano', 26),
('Batista', 26),('Bohechio', 26),('Carrera de Yeguas', 26),
('Derrumbadero (El Nuevo Brazil)', 26),('El Cercado', 26),('El Rosario', 26),
('Guanito', 26),('Hato del Padre', 26),('Jinova', 26),
('Jorgillo', 26),('Juan de Herrera', 26),('La Jagua', 26),
('La Zanja', 26),('Las Charcas de Maria Novas', 26),('Las Maguanas-Hato Nuevo', 26),
('Las Matas de Farfan', 26),('Matayaya', 26),('Pedro Corto', 26),
('Sabana Alta', 26),('Sabaneta', 26),('San Juan de la Maguana', 26),
('Vallejuevo', 26),('Yaque (Buena Vista)', 26),('Consuelo', 27),
('El Puerto', 27),('Gautier', 27),('Guayacanes', 27),
('Los Llanos', 27),('Quisqueya', 27),('Ramon Santana', 27),
('San Pedro de Macoris', 27),('Angelina', 28),('Caballero', 28),
('Cevicos', 28),('Comedero Arriba', 28),('Cotui', 28),
('Fantino', 28),('Hernando Alonzo', 28),('La Bija', 28),
('La Cueva', 28),('Platanal', 28),('Quita Sueño', 28),
('Villa La Mata', 28),('Baitoa', 29),('Canabacoa Abajo', 29),
('Canca La Piedra', 29),('El Caimito', 29),('El Limón', 29),
('El Rubio', 29),('Guayabal', 29),('Hato del Yaque', 29),
('Janico', 29),('Juncalito', 29),('La Canela', 29),
('Las Cuesta', 29),('Las Palomas', 29),('Las Placetas', 29),
('Licey Al Medio', 29),('Palmar Arriba', 29),('Pedro Garcia', 29),
('Puñal', 29),('Sabana Iglesia', 29),('San Francisco de Jacagua', 29),
('San Jose de las Matas', 29),('Santiago de los Caballeros', 29),('Tamboril', 29),
('Villa Bisono -Navarrete-', 29),('Villa Gonzalez', 29),('Moncion', 30),
('San Ignacio de Sabaneta', 30),('Villa Los Almacigos', 30),('Boca Chica', 31),
('Hato Viejo', 31),('La Caleta', 31),('La Cuaba', 31),
('La Guayiga', 31),('La Victoria', 31),('Los Alcarrizos', 31),
('Palmarejo', 31),('Pantoja', 31),('Pedro Brand', 31),
('San Antonio de Guerra', 31),('San Luis', 31),('Santo Domingo Este', 31),
('Santo Domingo Norte', 31),('Santo Domingo Oeste', 31),('Amina', 32),
('Boca de Mao', 32),('Cruce de Guayacanes', 32),('Esperanza', 32),
('Guatapanal', 32),('Jaibon', 32),('Jaiñan', 32),
('Jicome', 32),('La Caya', 32),('Laguna Salada', 32),
('Maizal', 32),('Mao', 32),('Paradero', 32)

/*Modificación para tabla de Usuario
ALTER TABLE Usuario
DROP COLUMN Imagen
ALTER TABLE Usuario
ADD Imagen nvarchar(100)
*/

/* Modificación para datetime a date en campo de FechaNacimiento
ALTER TABLE Usuario
DROP COLUMN FechaNacimiento
go
ALTER TABLE Usuario
ADD FechaNacimiento date
*/

/*Delete all info related to users in website
TRUNCATE TABLE Publicacion
ALTER TABLE Publicacion
DROP CONSTRAINT fk_PublicacionUsuario
TRUNCATE TABLE Usuario
ALTER TABLE Publicacion
ADD CONSTRAINT fk_PublicacionUsuario
FOREIGN KEY (Id_Usuario) REFERENCES Usuario(Id_Usuario)
ALTER TABLE Usuario
DROP CONSTRAINT fk_UsuarioAutenticacionUsuario
ALTER TABLE UsuarioRol
DROP CONSTRAINT fk_UsuarioRolAutenticacionUsuario
TRUNCATE TABLE AutenticacionUsuario
ALTER TABLE Usuario
ADD CONSTRAINT fk_UsuarioAutenticacionUsuario
FOREIGN KEY (Id_AutenticacionUsuario) REFERENCES AutenticacionUsuario(Id_AutenticacionUsuario);
TRUNCATE TABLE UsuarioRol
ALTER TABLE UsuarioRol
ADD CONSTRAINT fk_UsuarioRolAutenticacionUsuario
FOREIGN KEY (Id_AutenticacionUsuario) REFERENCES AutenticacionUsuario(Id_AutenticacionUsuario);
ALTER TABLE Usuario
DROP CONSTRAINT fk_UsuarioContacto
ALTER TABLE ContactoTipoContacto
DROP CONSTRAINT fk_ContactoTipoContactoContacto
TRUNCATE TABLE Contacto
ALTER TABLE Usuario
ADD CONSTRAINT fk_UsuarioContacto
FOREIGN KEY (Id_Contacto) REFERENCES Contacto(Id_Contacto);
TRUNCATE TABLE ContactoTipoContacto
ALTER TABLE ContactoTipoContacto
ADD CONSTRAINT fk_ContactoTipoContactoContacto
FOREIGN KEY (Id_Contacto) REFERENCES Contacto(Id_Contacto);
*/

/*Delete all information related to "Publicaciones" y "Comentarios"
TRUNCATE TABLE Comentario
ALTER TABLE Comentario
DROP CONSTRAINT fk_ComentarioPublicacion
TRUNCATE TABLE Publicacion
ALTER TABLE Comentario
ADD CONSTRAINT fk_ComentarioPublicacion FOREIGN KEY(Id_Publicacion)
REFERENCES Publicacion(Id_Publicacion)
*/

/*Change user field
ALTER TABLE Usuario
DROP CONSTRAINT fk_UsuarioTipoSangre
TRUNCATE TABLE TipoSangre
ALTER TABLE TipoSangre
DROP COLUMN Tipo
ALTER TABLE TipoSangre
ADD TipoSangre varchar(15) not null
ALTER TABLE Usuario
ADD CONSTRAINT fk_UsuarioTipoSangre 
FOREIGN KEY (Id_TipoSangre) REFERENCES TipoSangre(Id_TipoSangre)
*/
