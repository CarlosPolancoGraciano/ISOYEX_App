USE ISOYEX
go
Alter PROCEDURE spCargarDatosDireccion
AS
BEGIN
	DECLARE @Id_Provincia int
	DECLARE @ProvinciaId int
	DECLARE @Id_Municipio int

	DECLARE c_provincia CURSOR FOR
		SELECT Id_Provincia FROM Provincia

	OPEN c_provincia

		WHILE 1=1
		BEGIN
			FETCH NEXT FROM c_provincia INTO @Id_Provincia
			IF(@@FETCH_STATUS<>0)
			BEGIN
				BREAK;
			END

			DECLARE c_municipio CURSOR FOR
				SELECT Id_Municipio, Id_Provincia FROM Municipio

			OPEN c_municipio

				WHILE 1=1
				BEGIN
					FETCH NEXT FROM c_municipio INTO @Id_Municipio, @ProvinciaId
					IF(@@FETCH_STATUS <> 0)
					BEGIN
						BREAK;
					END
					ELSE IF(@ProvinciaId = @Id_Provincia)
					BEGIN
						INSERT INTO Direccion VALUES (@Id_Provincia, @Id_Municipio)
					END
				END

			CLOSE c_municipio
			DEALLOCATE c_municipio
		END

	CLOSE c_provincia
	DEALLOCATE c_provincia
END
go
EXEC [dbo].[spCargarDatosDireccion]
go
/* Carga de Provincia y Municipio (Con sus Ids y nombres) */
Create PROCEDURE spCargarDirecciones
AS
BEGIN
	SELECT p.Id_Provincia, p.Provincia, m.Id_Municipio, m.Municipio FROM Municipio as m
	inner join Provincia as p on p.Id_Provincia = m.Id_Provincia
END
go
/* Carga de tipos de sangre */
ALTER PROCEDURE spCargarTipoSangre
AS
BEGIN
	SELECT Id_TipoSangre, Tipo FROM TipoSangre
END
go
/* Carga de tipos de contacto */
ALTER PROCEDURE spCargarTipoContacto
AS
BEGIN
	SELECT Id_TipoContacto, Tipo FROM TipoContacto
END
go
CREATE PROCEDURE spCargarProvincias
AS
BEGIN
SELECT * FROM Provincia
END
go
CREATE PROCEDURE spCargarMunicipio
(
	@idProvincia int
)
AS
BEGIN
	SELECT Id_Municipio, Municipio FROM Municipio
	WHERE
	(@idProvincia = '' or (@idProvincia <> '' and Id_Provincia = @idProvincia))
END
