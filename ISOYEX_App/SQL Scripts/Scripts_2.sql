/*External procedures*/
USE ISOYEX
go
/*REGISTER USERS PROCEDURES*/
ALTER PROCEDURE spRegistrarDonanteReceptor
(		
		 @Nombre nvarchar(100),
		 @Apellido nvarchar(100), 
		 @Imagen nvarchar(100), 
		 @Email nvarchar(100), 
		 @Contrasena nvarchar(100),
		 @FechaNacimiento nvarchar(100),
		 @Id_TipoSangre int,
		 @NumeroTelefonico varchar(15),
		 @Id_TipoContacto int,
		 @Id_Provincia int,
		 @Id_Municipio int
) as
BEGIN 
	DECLARE @Id_AutenticacionUsuario int, @Id_Direccion int, @DireccionId int, @MyProvinciaId int, @MyMunicipioId int, @Id_Contacto int, @Id_Usuario int

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

	INSERT INTO 
	AutenticacionUsuario (Email, Contrasena) 
	VALUES 
	(@Email, @Contrasena)

	SELECT @Id_AutenticacionUsuario=SCOPE_IDENTITY()

	INSERT INTO UsuarioRol (Id_Rol, Id_AutenticacionUsuario)
	VALUES
	(1, @Id_AutenticacionUsuario)

	INSERT INTO 
	Usuario (Nombre, Apellido, Imagen, FechaNacimiento, Id_AutenticacionUsuario, Id_Direccion, Id_TipoSangre) 
	VALUES 
	(@Nombre, @Apellido, @Imagen, CONVERT(datetime, @FechaNacimiento, 103), @Id_AutenticacionUsuario, @Id_Direccion, @Id_TipoSangre)

	SELECT @Id_Usuario=SCOPE_IDENTITY()
	
	INSERT INTO 
	Contacto (Numero)
	VALUES
	(@NumeroTelefonico)
	
	SELECT @Id_Contacto=SCOPE_IDENTITY()

	UPDATE [dbo].[Usuario]
	SET Id_Contacto=@Id_Contacto
	WHERE [dbo].[Usuario].Id_Usuario = @Id_Usuario
	INSERT INTO
	ContactoTipoContacto(Id_TipoContacto,Id_Contacto)
	VALUES
	(@Id_TipoContacto,@Id_Contacto)

END
go
ALTER PROCEDURE spRegistrarInstitucion
(
	@RNC nvarchar(20),
	@Nombre nvarchar(100),
	@Imagen nvarchar(100),
	@Email nvarchar(100),
	@Contrasena nvarchar(100),
	@NumeroTelefonico varchar(15),
	@Id_TipoContacto int,
    @Id_Provincia int,
	@Id_Municipio int
)as
BEGIN
	DECLARE @Id_AutenticacionUsuario int, @Id_Direccion int, @DireccionId int, @MyProvinciaId int, @MyMunicipioId int, @Id_Contacto int, @Id_Usuario int

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

	INSERT INTO 
	AutenticacionUsuario (Email, Contrasena) 
	VALUES 
	(@Email, @Contrasena)

	SELECT @Id_AutenticacionUsuario=SCOPE_IDENTITY()

	INSERT INTO UsuarioRol (Id_Rol, Id_AutenticacionUsuario)
	VALUES
	(2, @Id_AutenticacionUsuario)
	
	INSERT INTO 
	Usuario (RNC, Nombre, Imagen, Id_AutenticacionUsuario, Id_Direccion)
	VALUES
	(@RNC, @Nombre,  @Imagen, @Id_AutenticacionUsuario, @Id_Direccion)
	
	SELECT @Id_Usuario=SCOPE_IDENTITY()
	
	INSERT INTO Contacto(Numero) VALUES (@NumeroTelefonico)

	SELECT @Id_Contacto=SCOPE_IDENTITY()

	UPDATE [dbo].[Usuario]
	SET Id_Contacto=@Id_Contacto
	WHERE [dbo].[Usuario].Id_Usuario = @Id_Usuario

	INSERT INTO ContactoTipoContacto(Id_TipoContacto, Id_Contacto) VALUES (@Id_TipoContacto, @Id_Contacto)

END
go
/*LOGIN PROCEDURES*/
ALTER PROCEDURE spLoginEmail(
@Email nvarchar(100),
@contrasena nvarchar(128)
)as
BEGIN
	SELECT 
		u.Id_Usuario, u.Nombre, u.Apellido, 
		u.Imagen, u.FechaNacimiento, c.Numero, 
		tc.Tipo, p.Provincia, m.Municipio, ts.Tipo,
		au.Email, au.Contrasena, r.Nombre
		FROM Usuario as u
		/*Address*/
		inner join Direccion as d on d.Id_Direccion = u.Id_Direccion
		inner join Municipio as m on m.Id_Municipio = d.Id_Municipio
		inner join Provincia as p on p.Id_Provincia = d.Id_Provincia
		/*Phone number & Type*/
		inner join Contacto as c on c.Id_Contacto = u.Id_Contacto
		inner join ContactoTipoContacto as ctc on ctc.Id_Contacto = c.Id_Contacto
		inner join TipoContacto as tc on tc.Id_TipoContacto = ctc.Id_TipoContacto
		/*Blood Type*/
		inner join TipoSangre as ts on ts.Id_TipoSangre = u.Id_TipoSangre
		/*Link to password */
		inner join AutenticacionUsuario as au on au.Id_AutenticacionUsuario = u.Id_AutenticacionUsuario
		inner join UsuarioRol as ur on ur.Id_AutenticacionUsuario = au.Id_AutenticacionUsuario
		inner join Rol as r on r.Id_Rol = ur.Id_Rol
		WHERE au.Email = @Email AND au.Contrasena = @contrasena
END
go
/*USER DATA PROCEDURES*/
ALTER PROCEDURE spUsuarioData
(
	@Id_Usuario nvarchar(128),
	@UsuarioId int
)as
BEGIN
	DECLARE @RolId int, @RolCurrentUsuarioId int, @CurrentRolId int

	DECLARE c_rol CURSOR FOR
			SELECT Id_Rol, Id_Usuario FROM UsuarioRol

			SELECT Id_Rol, u.Id_UsuarioRol FROM UsuarioRol as u

			SELECT ur.Id_Rol, u.Id_Usuario FROM UsuarioRol as ur
			inner join AutenticacionUsuario as au on au.Id_AutenticacionUsuario = ur.Id_AutenticacionUsuario
			inner join Usuario as u on u.Id_AutenticacionUsuario = au.Id_AutenticacionUsuario


		OPEN c_rol
			WHILE 1=1
			BEGIN
				FETCH NEXT FROM c_rol INTO @CurrentRolId, @RolCurrentUsuarioId
				IF(@@FETCH_STATUS <> 0)
				BEGIN
					BREAK;
				END
				ELSE IF(@RolCurrentUsuarioId = @Id_Usuario)
				BEGIN
					SET @RolId = @CurrentRolId;
					BREAK;
				END
			END;
		CLOSE c_rol
		DEALLOCATE c_rol
	
	IF(@RolId = 1)
	(

			SELECT  u.Id_Usuario, u.Nombre, u.Apellido, 
			u.Imagen, au.Email, au.Contrasena, u.FechaNacimiento, c.Numero,
			tc.Id_TipoContacto, tc.Tipo, d.Id_Provincia, p.Provincia,
			d.Id_Municipio, m.Municipio, ts.Id_TipoSangre, ts.Tipo
			FROM Usuario as u
			/*Address*/
			inner join Direccion as d on d.Id_Direccion = u.Id_Direccion
			inner join Municipio as m on m.Id_Municipio = d.Id_Municipio
			inner join Provincia as p on p.Id_Provincia = d.Id_Provincia
			/*Phone number & Type*/
			inner join Contacto as c on c.Id_Contacto = u.Id_Contacto
			inner join ContactoTipoContacto as ctc on ctc.Id_Contacto = c.Id_Contacto
			inner join TipoContacto as tc on tc.Id_TipoContacto = ctc.Id_TipoContacto
			/*Blood Type*/
			inner join TipoSangre as ts on ts.Id_TipoSangre = u.Id_TipoSangre
			/*User email, Role and Contrasena*/
			inner join AutenticacionUsuario as au on au.Id_AutenticacionUsuario = u.Id_AutenticacionUsuario
			inner join UsuarioRol as ur on ur.Id_AutenticacionUsuario = au.Id_AutenticacionUsuario
			WHERE u.Id_Usuario = @UsuarioId		
	)
	ELSE
	(
			SELECT u.Id_Usuario, u.RNC, 
			u.Nombre, u.Imagen, au.Email, au.Contrasena, 
			c.Numero, tc.Tipo, tc.Id_TipoContacto,d.Id_Provincia, 
			p.Provincia, d.Id_Municipio, m.Municipio
			FROM Usuario as u
			inner join Contacto as c on c.Id_Contacto = u.Id_Contacto
			/*Phone Number and Type*/
			inner join ContactoTipoContacto as ctc on ctc.Id_Contacto = c.Id_Contacto
			inner join TipoContacto as tc on tc.Id_TipoContacto = ctc.Id_TipoContacto
			/*Address and Type*/
			inner join Direccion as d on d.Id_Direccion = u.Id_Direccion
			inner join Municipio as m on m.Id_Municipio = d.Id_Municipio
			inner join Provincia as p on p.Id_Provincia = d.Id_Provincia
			/*User email, Role and Contrasena*/
			inner join AutenticacionUsuario as au on au.Id_AutenticacionUsuario = u.Id_AutenticacionUsuario
			inner join UsuarioRol as ur on ur.Id_AutenticacionUsuario = au.Id_AutenticacionUsuario
			WHERE	u.Id_Usuario = @UsuarioId
	)
END
go
/*MODIFY USER DATA PROCEDURES*/
ALTER PROCEDURE spUpdateDonanteReceptorData

(
	@Id_Usuario int,
	@Nombre nvarchar(100),
	@Apellido nvarchar(100), 
	@Imagen varbinary(100), 
	@Email nvarchar(100),
	@Contrasena nvarchar(100),
	@FechaNacimiento datetime,
	@NumeroTelefonico nvarchar(15),
	@Id_TipoContacto int,
	@Id_TipoSangre int,
	@Id_Provincia int,
	@Id_Municipio int


)as
BEGIN
	DECLARE @Id_Direccion int, 
			@DireccionId int, 
			@MyProvinciaId int, 
			@MyMunicipioId int

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

	/*Update of user number*/

	UPDATE [dbo].[Contacto]
	SET Numero = @NumeroTelefonico
	FROM [dbo].[Contacto] as c
	inner join [dbo].[Usuario] as u on u.Id_Contacto = c.Id_Contacto
	WHERE u.Id_Usuario = @Id_Usuario

	/*Update of user contact type*/
	UPDATE [dbo].[ContactoTipoContacto]
	SET Id_TipoContacto = @Id_TipoContacto
	FROM [dbo].[ContactoTipoContacto] as ctc
	inner join [dbo].[Usuario] as u on u.Id_Contacto = ctc.Id_Contacto
	WHERE u.Id_Usuario = @Id_Usuario

	/*Update of user email and password*/
	UPDATE [dbo].[AutenticacionUsuario]
	SET Email = @Email, Contrasena = @Contrasena
	FROM [dbo].[AutenticacionUsuario] as au
	inner join Usuario as u on u.Id_AutenticacionUsuario = au.Id_AutenticacionUsuario
	WHERE u.Id_Usuario = @Id_Usuario

	 /*Update of user data*/
	UPDATE [dbo].[Usuario]
	SET Nombre = @Nombre, Apellido = @Apellido, Imagen = @Imagen, 
    FechaNacimiento = @FechaNacimiento, Id_TipoSangre = @Id_TipoSangre,
	Id_Direccion = @Id_Direccion 
	WHERE Usuario.Id_Usuario = @Id_Usuario

END
go
ALTER PROCEDURE spUpdateInstitucionData
(
	@Id_Usuario int,
	@RNC nvarchar(20),
	@Nombre nvarchar(100),
	@Imagen varbinary(100),
	@Email nvarchar(100),
	@Contrasena nvarchar(100),
	@NumeroTelefonico nvarchar(15),
	@Id_TipoContacto int,
	@Id_Provincia int,
	@Id_Municipio int
)as
BEGIN
	DECLARE @Id_Direccion int, @DireccionId int, @MyProvinciaId int, @MyMunicipioId int, @Id_Contacto int

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

	/*Update of user number*/
	UPDATE [dbo].[Contacto]
	SET Numero = @NumeroTelefonico
	FROM [dbo].[Contacto] as c
	inner join [dbo].[Usuario] as u on u.Id_Contacto = c.Id_Contacto
	WHERE u.Id_Usuario = @Id_Usuario

	/*Update of user contact type*/
	UPDATE [dbo].[ContactoTipoContacto]
	SET Id_TipoContacto = @Id_TipoContacto
	FROM [dbo].[ContactoTipoContacto] as ctc
	inner join [dbo].[Usuario] as u on u.Id_Contacto = ctc.Id_Contacto
	WHERE u.Id_Usuario = @Id_Usuario

	/*Update of user email and password*/
	UPDATE [dbo].[AutenticacionUsuario]
	SET Email = @Email, Contrasena = @Contrasena
	FROM [dbo].[AutenticacionUsuario] as au
	inner join Usuario as u on u.Id_AutenticacionUsuario = au.Id_AutenticacionUsuario
	WHERE u.Id_Usuario = @Id_Usuario

	/*Update of user data*/
	UPDATE [dbo].[Usuario]
	SET RNC = @RNC, Nombre = @Nombre, Imagen = @Imagen
	WHERE Usuario.Id_Usuario = @Id_Usuario

END