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
    public class PostController : ApiController
    {
        //private static bool executeUsersHttpGet = false;
        private static List<Posts> posts = new List<Posts>();
        public void formatPosts(DataTable sentPosts)
        {
            /*Clear user list*/
            posts.Clear();
            //executeUsersHttpGet = true;
            foreach (DataRow row in sentPosts.Rows)
            {
                Posts currentPost = new Posts();

                if (sentPosts.Rows.Count > 0)
                {
                    currentPost.PostId = Convert.ToInt32(row["Id_Publicacion"].ToString());
                    currentPost.PostTitulo = row["Titulo"].ToString();
                    currentPost.PostContenido = row["Contenido"].ToString();
                    currentPost.PostFecha = Convert.ToDateTime(row["Fecha"].ToString());
                    currentPost.PostOwnerId = Convert.ToInt32(row["Id_Usuario"].ToString());
                    currentPost.PostOwnerName = row["Nombre"].ToString();
                    currentPost.PostBloodTypeSearched = row["TipoSangre"].ToString();
                }
                if (!posts.Exists(x => x.PostId == currentPost.PostId))
                {
                    posts.Add(currentPost);
                }
            }
        }
        // GET: api/Post
        public List<Posts> Get()
        {
            return posts;
        }

        /*
        // GET: api/Post/5
        public string Get(int id)
        {
            return "value";
        }

        // POST: api/Post
        public void Post([FromBody]string value)
        {
        }

        // PUT: api/Post/5
        public void Put(int id, [FromBody]string value)
        {
        }

        // DELETE: api/Post/5
        public void Delete(int id)
        {
        }
        */
    }
}
