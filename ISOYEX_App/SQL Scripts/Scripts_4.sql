USE ISOYEX
go
CREATE PROCEDURE spFiltradoPorSangre
(
	@TipoSangre nvarchar(50)
)
AS
BEGIN
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
		WHERE Usuario.Id_TipoSangre = @TipoSangre
END
go
/*PROCEDURE FiltradoPorDireccion - MAIKEL*/
go
/*PROCEDURE FiltradoPorDireccionYSangre - CARLOS*/
CREATE PROCEDURE spFiltradoPorDireccionYSangre (
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
		WHERE Usuario.Id_TipoSangre = @Id_TipoSangre AND Usuario.Id_Direccion = @Id_Direccion

END