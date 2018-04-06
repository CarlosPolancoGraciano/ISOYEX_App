/*Procedures para publicaciones*/
USE ISOYEX
go
CREATE PROCEDURE spCrearPublicacion
(
	@Titulo nvarchar(150),
	@Imagen nvarchar(100),
	@Contenido text,
	@Fecha datetime,
	@Id_Usuario int
)as
BEGIN
	INSERT INTO Publicacion 
		(Titulo, Imagen, Contenido, Fecha, Id_Usuario) 
	VALUES
		(@Titulo, @Imagen, @Contenido, @Fecha, @Id_Usuario)
END
/* Prueba de crearPublicaciones
EXEC spCrearPublicacion 'Busqueda de sangre tipo A+', '../Somewhere', '<b>El hospital necesita sangre urgente</b>', '2018-04-05 23:39:21', 1
SELECT * FROM Publicacion
*/
go
CREATE PROCEDURE spModificarPublicacion
(
	@Id_Publicacion int,
	@Titulo nvarchar(150),
	@Imagen nvarchar(100),
	@Contenido text,
	@Fecha datetime
)as
BEGIN
	UPDATE [dbo].[Publicacion]
	SET Titulo = @Titulo, Imagen = @Imagen, Contenido = @Contenido, Fecha = @Fecha
	FROM Publicacion
	WHERE Id_Publicacion = @Id_Publicacion
END
go
/*Pruebas de modificar publicaciones
EXEC spModificarPublicacion 1, 'Busqueda de sangre tipo A-', '../Something', '<span>El hospital necesita sangre no urgente</span>', '2018-04-05 23:44:25'
SELECT * FROM Publicacion
go
*/
CREATE PROCEDURE spRetornarPublicaciones
as
BEGIN
	/*Retuns newer to old publication*/
	SELECT * FROM Publicacion
	ORDER BY Id_Publicacion DESC
END
go
/* Prueba de retornarPublicaciones - newer to old
EXEC spRetornarPublicaciones
SELECT * FROM Publicacion
*/
go
CREATE PROCEDURE spEliminarPublicacion
(
	@Id_Publicacion int
)as
BEGIN
	DELETE FROM Publicacion WHERE Id_Publicacion = @Id_Publicacion
END
go
/* Prueba eliminar publicacion
EXEC spEliminarPublicacion 4
SELECT * FROM Publicacion
*/
/*Comentarios de publicaciones*/
go
CREATE PROCEDURE spCrearComentario
(
	@Contenido text,
	@Id_Usuario int,
	@Id_Publicacion int
)as
BEGIN
	INSERT INTO Comentario 
		(Contenido, Id_Usuario, Id_Publicacion)
	VALUES
		(@Contenido, @Id_Usuario, @Id_Publicacion)
END
go
 /*Prueba de crearComentario
EXEC spCrearComentario 'Yo deseo ayudar, contacteme', 2, 3
SELECT * FROM Comentario
*/
go
CREATE PROCEDURE spModificarComentario
(
	@Id_Comentario int,
	@Contenido text
)as
BEGIN 
	UPDATE [dbo].[Comentario]
	SET Contenido = @Contenido
	FROM Comentario WHERE Id_Comentario = @Id_Comentario
END
go
/* Prueba de modificarComentario
EXEC spModificarComentario 1, 'Se desea ayudar, contacteme'
SELECT * FROM Comentario
*/
go
CREATE PROCEDURE spEliminarComentario
(
	@Id_Comentario int
)as
BEGIN
	DELETE FROM Comentario WHERE Id_Comentario = @Id_Comentario
END
go
/* Prueba de eliminarComentario
EXEC spEliminarComentario 1
SELECT * FROM Comentario
*/
go
/*Procedure de comentarios de publicaciones*/
CREATE PROCEDURE spRetornarComentariosPublicacion
(
	@Id_Publicacion int
)as
BEGIN
	SELECT  c.Contenido, u.Id_Usuario, u.Nombre, 
			u.Apellido, u.Imagen 
	FROM Comentario as c
	inner join Usuario as u on u.Id_Usuario = c.Id_Usuario
	WHERE c.Id_Publicacion = @Id_Publicacion
END
/*
go
Prueba de retornarComentariosPublicacion
EXEC spRetornarComentariosPublicacion 3
SELECT * FROM Comentario
SELECT * FROM Publicacion
*/
go
/*Procedure para eliminar comentarios cuando se elimine su respectiva publicacion*/
CREATE PROCEDURE spEliminarComentariosPublicacion
(
	@Id_Publicacion int
)as
BEGIN
	DELETE FROM Comentario WHERE Id_Publicacion = @Id_Publicacion
END
/* go
Prueba de spEliminarComentariosPublicacion
EXEC spEliminarComentariosPublicacion 3
SELECT * FROM Comentario
*/