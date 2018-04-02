USE ISOYEX
go
ALTER PROCEDURE spFiltradoPorSangre
(
	@Id_TipoSangre int
)
AS
BEGIN
	SELECT 
		u.Id_Usuario, u.Nombre, u.Apellido, 
		u.Imagen, au.Email, u.FechaNacimiento, c.Numero, 
		tc.Tipo, p.Provincia, m.Municipio, ts.TipoSangre
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
		inner join AutenticacionUsuario as au on au.Id_AutenticacionUsuario = u.Id_AutenticacionUsuario
		WHERE u.Id_TipoSangre = @Id_TipoSangre
END
go
/*PROCEDURE FiltradoPorDireccion - MAIKEL*/
ALTER PROCEDURE spFiltradoPorDireccion
(
	@Id_Provincia int,
	@Id_Municipio int
)AS
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

	SELECT 
	u.Id_Usuario, u.Nombre, u.Apellido, 
	u.Imagen, au.Email, u.FechaNacimiento, c.Numero, 
	tc.Tipo, p.Provincia, m.Municipio, ts.TipoSangre
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
	inner join AutenticacionUsuario as au on au.Id_AutenticacionUsuario = u.Id_AutenticacionUsuario
	WHERE u.Id_Direccion = @Id_Direccion
End
go
/*PROCEDURE FiltradoPorDireccionYSangre - CARLOS*/
ALTER PROCEDURE spFiltradoPorDireccionYSangre (
	@Id_Provincia int,
	@Id_Municipio int,
	@Id_TipoSangre int
)as
BEGIN 
	DECLARE @Id_Direccion int, @CurrentDireccionId int, @CurrentProvinciaId int, @CurrentMunicipioId int

	DECLARE c_direccion CURSOR FOR
		SELECT Id_Direccion, Id_Provincia, Id_Municipio FROM Direccion

	OPEN c_direccion
		WHILE 1=1
		BEGIN
			FETCH NEXT FROM c_direccion INTO @CurrentDireccionId, @CurrentProvinciaId, @CurrentMunicipioId
			IF(@@FETCH_STATUS <> 0)
			BEGIN
				BREAK;
			END
			ELSE IF(@CurrentProvinciaId = @Id_Provincia AND @CurrentMunicipioId = @CurrentMunicipioId)
			BEGIN
				SET @Id_Direccion = @CurrentDireccionId;
				BREAK;
			END
		END
	CLOSE c_direccion
	DEALLOCATE c_direccion

	SELECT 
		u.Id_Usuario, u.Nombre, u.Apellido, 
		u.Imagen, au.Email, u.FechaNacimiento, c.Numero, 
		tc.Tipo, p.Provincia, m.Municipio, ts.TipoSangre
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
		inner join AutenticacionUsuario as au on au.Id_AutenticacionUsuario = u.Id_AutenticacionUsuario
		WHERE u.Id_TipoSangre = @Id_TipoSangre AND u.Id_Direccion = @Id_Direccion

END