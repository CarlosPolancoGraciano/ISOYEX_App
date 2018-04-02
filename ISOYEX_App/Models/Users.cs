using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace ISOYEX_App.Models
{
    public class Users
    {
        public int UserId { get; set; }
        public string Nombre { get; set; }
        public string Apellido { get; set; }
        public string ImagenURL { get; set; }
        public int? AutenticacionUsuarioId { get; set; }
        public string Email { get; set; }
        public string Contrasena { get; set; }
        public DateTime FechaNacimiento { get; set; }
        public int? ContactoId { get; set; }
        public string NumeroTelefonico { get; set; }
        public string TipoContacto { get; set; }
        public int? DireccionId { get; set; }
        public string Provincia { get; set; }
        public string Municipio { get; set; }
        public int? TipoSangreId { get; set; }
        public string TipoSangre { get; set; }

    }
}