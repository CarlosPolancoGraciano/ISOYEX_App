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
		WHERE Usuario.Id_Usuario = @UsuarioId
END