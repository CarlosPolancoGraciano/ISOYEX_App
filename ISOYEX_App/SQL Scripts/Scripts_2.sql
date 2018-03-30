/*External procedures*/
USE ISOYEX
go
/*REGISTER USERS PROCEDURES*/
CREATE PROCEDURE spRegistrarDonanteReceptor
(		
		 @UserName nvarchar(128),
		 @Nombre nvarchar(100),
		 @Apellido nvarchar(100), 
		 @Imagen varbinary(max), 
		 @Email nvarchar(100), 
		 @Contrasena nvarchar(100),
		 @FechaNacimiento datetime,
		 @Id_TipoSangre int,
		 @NumeroTelefonico varchar(15),
		 @Id_TipoContacto int,
		 @Id_Provincia int,
		 @Id_Municipio int,
		 @Id_Usuario int
) as
BEGIN 
	DECLARE @Id_AutenticacionUsuario int, @Id_Direccion int, @DireccionId int, @MyProvinciaId int, @MyMunicipioId int, @Id_Contacto int

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
	AutenticacionUsuario (UserName, Contrasena) 
	VALUES 
	(@UserName, @Contrasena)

	SELECT @Id_AutenticacionUsuario=SCOPE_IDENTITY()

	INSERT INTO 
	Usuario (Nombre, Apellido, Imagen, Email, FechaNacimiento, Id_AutenticacionUsuario, Id_Direccion, Id_TipoSangre) 
	VALUES 
	(@Nombre, @Apellido, @Imagen, @Email, @FechaNacimiento, @Id_AutenticacionUsuario, @Id_Direccion, @Id_TipoSangre)
	
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
CREATE PROCEDURE spRegistrarInstitucion
(
	@UserName nvarchar(128),
	@RNC nvarchar(20),
	@Nombre nvarchar(100),
	@Imagen varbinary(max),
	@Email nvarchar(100),
	@Contrasena nvarchar(100),
	@NumeroTelefonico varchar(15),
	@Id_TipoContacto int,
    @Id_Provincia int,
	@Id_Municipio int,
	@Id_Usuario int
)as
BEGIN
	DECLARE @Id_AutenticacionUsuario int, @Id_Direccion int, @DireccionId int, @MyProvinciaId int, @MyMunicipioId int, @Id_Contacto int

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
	AutenticacionUsuario (UserName, Contrasena) 
	VALUES 
	(@UserName, @Contrasena)

	SELECT @Id_AutenticacionUsuario=SCOPE_IDENTITY()
	
	INSERT INTO 
	Usuario (RNC, Nombre, Imagen, Email, Id_AutenticacionUsuario, Id_Direccion)
	VALUES
	(@RNC, @Nombre, @Imagen, @Email, @Id_AutenticacionUsuario, @Id_Direccion)	
	
	INSERT INTO Contacto(Numero) VALUES (@NumeroTelefonico)

	SELECT @Id_Contacto=SCOPE_IDENTITY()

	UPDATE [dbo].[Usuario]
	SET Id_Contacto=@Id_Contacto
	WHERE [dbo].[Usuario].Id_Usuario = @Id_Usuario

	INSERT INTO ContactoTipoContacto(Id_TipoContacto, Id_Contacto) VALUES (@Id_TipoContacto, @Id_Contacto)

END
go
/*LOGIN PROCEDURES*/
CREATE PROCEDURE spLoginEmail(
@Email nvarchar(100),
@contrasena nvarchar(128)
)as
BEGIN
	DECLARE @CurrentEmail nVarchar(128),@currentContrasena nVarchar(128)

	DECLARE c_usuario CURSOR FOR
		SELECT Email FROM Usuario

	OPEN c_usuario
		WHILE 1=1
		BEGIN
			FETCH NEXT FROM c_usuario INTO @CurrentEmail
			IF(@@FETCH_STATUS <> 0)
			BEGIN
				BREAK;
			END
			ELSE IF (@currentEmail = @Email)
			BEGIN
				
				DECLARE c_contrasena CURSOR FOR
					SELECT Contrasena FROM AutenticacionUsuario

				OPEN c_contrasena
					WHILE 1=1
					BEGIN
						FETCH NEXT FROM c_login INTO @currentContrasena
						IF(@@FETCH_STATUS <> 0)
						BEGIN
							BREAK;
						END
						ELSE IF(@currentContrasena = @contrasena)
						BEGIN
							BREAK;
						END
					END;
				CLOSE c_contrasena;
				DEALLOCATE c_contrasena;
			END
		END
	CLOSE c_usuario
	DEALLOCATE c_usuario

END
go
CREATE PROCEDURE spLoginUsername(
@UserName nVarchar(128),
@contrasena nVarchar(128)
)as
BEGIN 
	DECLARE @MyUserName nVarchar(128),@MyContrasena nVarchar(128)
	DECLARE c_login CURSOR FOR
			SELECT UserName, Contrasena FROM AutenticacionUsuario

	OPEN c_login
		WHILE 1=1
		BEGIN
			FETCH NEXT FROM c_login INTO @MyUserName,@MyContrasena
			IF(@@FETCH_STATUS <> 0)
			BEGIN
				BREAK;
			END
			ELSE IF(@UserName = @MyUserName AND @contrasena = @MyContrasena)
			BEGIN
				BREAK;
			END
		END;
	CLOSE c_login;
	DEALLOCATE c_login;
End
go
/*USER DATA PROCEDURES*/
CREATE PROCEDURE spUsuarioData
(
	@Id_Usuario nvarchar(128),
	@UsuarioId int
)as
BEGIN
	DECLARE @RolId int, @RolCurrentUsuarioId int, @CurrentRolId int

	DECLARE c_rol CURSOR FOR
			SELECT Id_Rol, Id_Usuario FROM UsuarioRol

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
		SELECT 
		u.Id_Usuario, u.Nombre, u.Apellido, 
		u.Imagen, u.Email, u.FechaNacimiento, c.Numero, 
		tc.Tipo, p.Provincia, m.Municipio, ts.Tipo
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
		WHERE u.Id_Usuario = @UsuarioId
	)
	ELSE
	(
		SELECT u.Id_Usuario, u.RNC, 
		u.Nombre, u.Imagen, u.Email, c.Numero, 
		tc.Tipo, p.Provincia, m.Municipio
		FROM Usuario as u
		inner join Contacto as c on c.Id_Contacto = u.Id_Contacto
		/*Phone Number and Type*/
		inner join ContactoTipoContacto as ctc on ctc.Id_Contacto = c.Id_Contacto
		inner join TipoContacto as tc on tc.Id_TipoContacto = ctc.Id_TipoContacto
		/*Address and Type*/
		inner join Direccion as d on d.Id_Direccion = u.Id_Direccion
		inner join Municipio as m on m.Id_Municipio = d.Id_Municipio
		inner join Provincia as p on p.Id_Provincia = d.Id_Provincia
		WHERE	u.Id_Usuario = @UsuarioId
	)
END
go
/*MODIFY USER DATA PROCEDURES*/
CREATE PROCEDURE spUpdateDonanteReceptorData
(
	@Id_Usuario int,
	@UserName nvarchar(128),
	@Nombre nvarchar(100),
	@Apellido nvarchar(100), 
	@Imagen varbinary(max), 
	@Email nvarchar(100),
	@Contrasena nvarchar(100),
	@FechaNacimiento datetime,
	@NumeroTelefonico nvarchar(15),
	@Id_TipoContacto int,
	@Id_TipoSangre int,
	@Id_Provincia int,
	@Id_Municipio int,
	@CurrentRolId int,
	@RolCurrentUsuarioId int,
	@RolId int

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

	DECLARE c_rol CURSOR FOR
			SELECT Id_Rol, Id_Usuario FROM UsuarioRol

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

	UPDATE [dbo].[Contacto]
	SET Numero = @NumeroTelefonico
	FROM [dbo].[Contacto] as c
	inner join [dbo].[Usuario] as u on u.Id_Contacto = c.Id_Contacto
	WHERE u.Id_Usuario = @Id_Usuario

	UPDATE [dbo].[ContactoTipoContacto]
	SET Id_TipoContacto = @Id_TipoContacto
	FROM [dbo].[ContactoTipoContacto] as ctc
	inner join [dbo].[Usuario] as u on u.Id_Contacto = ctc.Id_Contacto
	WHERE u.Id_Usuario = @Id_Usuario

	 /*Update of user data*/
	UPDATE [dbo].[Usuario]
	SET Nombre = @Nombre, Apellido = @Apellido, Imagen = @Imagen, 
	Email = @Email, FechaNacimiento = @FechaNacimiento, Id_TipoSangre = @Id_TipoSangre,
	Id_Direccion = @Id_Direccion 
	WHERE Usuario.Id_Usuario = @Id_Usuario

END
go
CREATE PROCEDURE spUpdateInstitucionData
(
	@Id_Usuario int,
	@UserName nvarchar(256),
	@RNC nvarchar(20),
	@Nombre nvarchar(100),
	@Imagen varbinary(max),
	@Email nvarchar(100),
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

	UPDATE [dbo].[Contacto]
	SET Numero = @NumeroTelefonico
	FROM [dbo].[Contacto] as c
	inner join [dbo].[Usuario] as u on u.Id_Contacto = c.Id_Contacto
	WHERE u.Id_Usuario = @Id_Usuario

	UPDATE [dbo].[ContactoTipoContacto]
	SET Id_TipoContacto = @Id_TipoContacto
	FROM [dbo].[ContactoTipoContacto] as ctc
	inner join [dbo].[Usuario] as u on u.Id_Contacto = ctc.Id_Contacto
	WHERE u.Id_Usuario = @Id_Usuario

	/*Update of user data*/
	UPDATE [dbo].[Usuario]
	SET RNC = @RNC, Nombre = @Nombre, Imagen = @Imagen, Email = @Email
	WHERE Usuario.Id_Usuario = @Id_Usuario

END