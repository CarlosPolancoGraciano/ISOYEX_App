using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace ISOYEX_App.Models
{
    public class Comments
    {
        public int ComentarioId { get; set; }
        public string Contenido { get; set; }
        public DateTime Fecha { get; set; }
        public int UsuarioId { get; set; }
        public string UsuarioNombre { get; set; }
        public string UsuarioApellido { get; set; }
        public string UsuarioImagen { get; set; }
    }
}