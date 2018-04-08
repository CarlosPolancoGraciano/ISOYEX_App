using ISOYEX_App.Models;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Net;
using System.Net.Http;
using System.Web.Http;

namespace ISOYEX_App.Controllers
{
    public class PostCommentsController : ApiController
    {
        private static bool executeUsersHttpGet = false;
        private static List<Comments> comments = new List<Comments>();

        public void formatComments(DataTable postComments)
        {
            /*Clear user list*/
            comments.Clear();
            executeUsersHttpGet = true;
            foreach (DataRow row in postComments.Rows)
            {
                Comments currentComment = new Comments();

                if (postComments.Rows.Count > 0)
                {
                    currentComment.ComentarioId = Convert.ToInt32(row["Id_Comentario"].ToString());
                    currentComment.Contenido = row["Contenido"].ToString();
                    currentComment.UsuarioId = Convert.ToInt32(row["Id_Usuario"].ToString());
                    currentComment.UsuarioNombre = row["Nombre"].ToString();
                    currentComment.UsuarioApellido = row["Apellido"].ToString();
                    currentComment.UsuarioImagen = row["Imagen"].ToString();
                }
                if (!comments.Exists(x => x.ComentarioId == currentComment.ComentarioId))
                {
                    comments.Add(currentComment);
                }
            }
        }
        // GET: api/PostComentarios
        public List<Comments> Get()
        {
            if (executeUsersHttpGet)
            {
                executeUsersHttpGet = false;
                return comments;
            }
            else
            {
                comments.Clear();
                return new List<Comments>();
            }
        }
        /*
        // GET: api/PostComentarios/5
        public string Get(int id)
        {
            return "value";
        }

        // POST: api/PostComentarios
        public void Post([FromBody]string value)
        {
        }

        // PUT: api/PostComentarios/5
        public void Put(int id, [FromBody]string value)
        {
        }

        // DELETE: api/PostComentarios/5
        public void Delete(int id)
        {
        }
        */
    }
}
