USE ISOYEX
go
/*Procedures para obtener roles*/
CREATE PROCEDURE spObtenerRolPorNombre(
	@Nombre nvarchar(128)
)as
BEGIN
	SELECT Id_Rol FROM Rol
	WHERE Nombre LIKE @Nombre
END
go
/*Procedures para publicaciones*/
CREATE PROCEDURE spCrearPublicacion
(
	@Titulo nvarchar(150),
	@Id_TipoSangre int,
	@Contenido text,
	@Fecha datetime,
	@Id_Usuario int
)as
BEGIN
	INSERT INTO Publicacion 
		(Titulo, Contenido, Fecha, Id_TipoSangre, Id_Usuario) 
	VALUES
		(@Titulo, @Contenido, @Fecha, @Id_TipoSangre, @Id_Usuario)
END
/*Prueba de crearPublicaciones
EXEC spCrearPublicacion 'Busqueda de sangre tipo A+', 1, '<b>El hospital necesita sangre urgente</b>', '2018-04-05 23:39:21', 1
SELECT * FROM Publicacion
*/
go
CREATE PROCEDURE spModificarPublicacion
(
	@Id_Publicacion int,
	@Titulo nvarchar(150),
	@Id_TipoSangre int,
	@Contenido text,
	@Fecha datetime
)as
BEGIN
	UPDATE [dbo].[Publicacion]
	SET Titulo = @Titulo, Id_TipoSangre = @Id_TipoSangre, Contenido = @Contenido, Fecha = @Fecha
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
	SELECT  p.Id_Publicacion,p.Titulo, p.Contenido,
	p.Fecha, u.Id_Usuario, u.Nombre, 
	ts.TipoSangre
	FROM Publicacion as p
	inner join TipoSangre as ts on ts.Id_TipoSangre = p.Id_TipoSangre
	inner join Usuario as u on u.Id_Usuario = p.Id_Usuario
	ORDER BY Id_Publicacion DESC
END
go
/* Prueba de retornarPublicaciones - newer to old
EXEC spRetornarPublicaciones
SELECT * FROM Publicacion
*/
go
ALTER PROCEDURE spRetornarPublicacionPorId(
	@Id_Publicacion int
)as
BEGIN
	SELECT p.Id_Publicacion,p.Titulo, p.Contenido, 
		   p.Fecha, p.Id_Usuario, u.Nombre, u.Imagen, au.Email,
		   pr.Provincia, mu.Municipio, ts.TipoSangre
	FROM Publicacion as p
	inner join TipoSangre as ts on ts.Id_TipoSangre = p.Id_TipoSangre
	inner join Usuario as u on u.Id_Usuario = p.Id_Usuario
	inner join AutenticacionUsuario as au on au.Id_AutenticacionUsuario = u.Id_AutenticacionUsuario
	inner join Direccion as d on d.Id_Direccion = u.Id_Direccion
	inner join Provincia as pr on pr.Id_Provincia = d.Id_Provincia
	inner join Municipio as mu on mu.Id_Municipio = d.Id_Municipio
	WHERE p.Id_Publicacion = @Id_Publicacion
END
go
/*Prueba de retornarPublicacionPorId
EXEC spRetornarPublicacionPorId 2
SELECT * FROM Publicacion
*/
CREATE PROCEDURE spEliminarPublicacion
(
	@Id_Publicacion int
)as
BEGIN
	DELETE FROM Comentario WHERE Id_Publicacion = @Id_Publicacion
	DELETE FROM Publicacion WHERE Id_Publicacion = @Id_Publicacion
END
go
/*Prueba eliminar publicacion
EXEC spEliminarPublicacion 1
SELECT * FROM Publicacion
*/
/*Comentarios de publicaciones*/
go
CREATE PROCEDURE spCrearComentario
(
	@Contenido text,
	@Fecha datetime,
	@Id_Usuario int,
	@Id_Publicacion int
)as
BEGIN
	INSERT INTO Comentario 
		(Contenido, Fecha, Id_Usuario, Id_Publicacion)
	VALUES
		(@Contenido, @Fecha, @Id_Usuario, @Id_Publicacion)
END
go
 /*Prueba de crearComentario
EXEC spCrearComentario 'Yo deseo ayudar, contacteme', 2, 1
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
	SELECT  c.Id_Comentario, c.Contenido, c.Fecha, 
			u.Id_Usuario, u.Nombre, u.Apellido, 
			u.Imagen 
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
go
/*Filtro de publicaciones*/
CREATE PROCEDURE spFiltrarPostPorDireccionUsuario(
	@Id_Provincia int,
	@Id_Municipio int
)as
BEGIN
	DECLARE @Id_Direccion int, @DireccionId int, @MyProvinciaId int, @MyMunicipioId int

	DECLARE c_direccion CURSOR FOR
		SELECT Id_Direccion, Id_Provincia, Id_Municipio FROM Direccion 

	OPEN c_direccion
		WHILE 1=1
		BEGIN
			FETCH NEXT FROM c_direccion INTO @DireccionId, @MyProvinciaId, @MyMunicipioId
			IF(@@FETCH_STATUS <> 0)
			BEGIN
				BREAK;
			END
			ELSE IF(@Id_Provincia = @MyProvinciaId AND @Id_Municipio = @MyMunicipioId)
			BEGIN
				SET @Id_Direccion = @DireccionId;
				BREAK;
			END
		END;
	CLOSE c_direccion;
	DEALLOCATE c_direccion;

	SELECT p.Id_Publicacion,p.Titulo, p.Contenido,
	p.Fecha, u.Id_Usuario, u.Nombre, 
	ts.TipoSangre
	FROM Publicacion as p
	inner join Usuario as u on u.Id_Usuario = p.Id_Usuario
	inner join TipoSangre as ts on ts.Id_TipoSangre = p.Id_TipoSangre
	WHERE u.Id_Direccion = @Id_Direccion 
	ORDER BY Id_Publicacion DESC

END
go
CREATE PROCEDURE spFiltradoPostPorTipoSangre(
	@Id_TipoSangre int
)as
BEGIN
	SELECT p.Id_Publicacion,p.Titulo, p.Contenido,
	p.Fecha, u.Id_Usuario, u.Nombre, 
	ts.TipoSangre
	FROM Publicacion as p
	inner join Usuario as u on u.Id_Usuario = p.Id_Usuario
	inner join TipoSangre as ts on ts.Id_TipoSangre = p.Id_TipoSangre
	WHERE p.Id_TipoSangre = @Id_TipoSangre
	ORDER BY Id_Publicacion DESC
END
go
CREATE PROCEDURE spFiltradoPostDireccionTipoSangre(
	@Id_Provincia int,
	@Id_Municipio int,
	@Id_TipoSangre int
)as
BEGIN
	DECLARE @Id_Direccion int, @DireccionId int, @MyProvinciaId int, @MyMunicipioId int

	DECLARE c_direccion CURSOR FOR
		SELECT Id_Direccion, Id_Provincia, Id_Municipio FROM Direccion 

	OPEN c_direccion
		WHILE 1=1
		BEGIN
			FETCH NEXT FROM c_direccion INTO @DireccionId, @MyProvinciaId, @MyMunicipioId
			IF(@@FETCH_STATUS <> 0)
			BEGIN
				BREAK;
			END
			ELSE IF(@Id_Provincia = @MyProvinciaId AND @Id_Municipio = @MyMunicipioId)
			BEGIN
				SET @Id_Direccion = @DireccionId;
				BREAK;
			END
		END;
	CLOSE c_direccion;
	DEALLOCATE c_direccion;

	SELECT p.Id_Publicacion,p.Titulo, p.Contenido,
	p.Fecha, u.Id_Usuario, u.Nombre, 
	ts.TipoSangre
	FROM Publicacion as p
	inner join Usuario as u on u.Id_Usuario = p.Id_Usuario
	inner join TipoSangre as ts on ts.Id_TipoSangre = p.Id_TipoSangre
	WHERE u.Id_Direccion = @Id_Direccion AND p.Id_TipoSangre = @Id_TipoSangre
	ORDER BY Id_Publicacion DESC

END
go
/*Create trigger to add notification - IS = INSERT*/
CREATE TRIGGER [dbo].[TR_Notificacion_IS]
	ON [dbo].[Comentario]
	FOR INSERT
AS
BEGIN
	DECLARE @Contenido text, @Id_Usuario int, @Id_Publicacion int

	SET @Contenido = 'Notificacion de comentario'
	SET @Id_Usuario = (SELECT Id_Usuario FROM inserted)
	SET @Id_Publicacion = (SELECT Id_Publicacion FROM inserted)

	INSERT INTO 
		Notificacion (Contenido, Id_Publicacion, Id_Usuario)
	VALUES
		(@Contenido, @Id_Publicacion, @Id_Usuario)
END