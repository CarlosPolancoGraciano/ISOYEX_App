using ISOYEX_App.Models;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Net;
using System.Net.Http;
using System.Web.Http;

namespace ISOYEX_App
{
    public class FilteredUsersController : ApiController
    {
        private static List<Users> users = new List<Users>();
        
        public void formatUsers(DataTable filteredUsers)
        {
            foreach (DataRow row in filteredUsers.Rows)
            {
                Users currentUser = new Users();
                currentUser.UserId = Convert.ToInt32(row["Id_Usuario"].ToString());
                currentUser.Nombre = row["Nombre"].ToString();
                currentUser.Apellido = row["Apellido"].ToString();
                currentUser.ImagenURL = row["Imagen"].ToString();
                currentUser.Email = row["Email"].ToString();
                currentUser.FechaNacimiento = row.Field<DateTime>("FechaNacimiento");
                currentUser.NumeroTelefonico = row["Numero"].ToString();
                currentUser.TipoContacto = row["Tipo"].ToString();
                currentUser.Provincia = row["Provincia"].ToString();
                currentUser.Municipio = row["Municipio"].ToString();
                currentUser.TipoSangre = row["TipoSangre"].ToString();

                users.Add(currentUser);
            }
        }
        // GET: api/FilteredUsers
        //Class used with ListView Of Filtered User
        [HttpGet]
        public List<Users> Get()
        {
            return users;
        }
        /*
        // GET: api/FilteredUsers/5
        public string Get(int id)
        {
            return "value";
        }

        // POST: api/FilteredUsers
        public void Post([FromBody]string value)
        {
        }

        // PUT: api/FilteredUsers/5
        public void Put(int id, [FromBody]string value)
        {
        }

        // DELETE: api/FilteredUsers/5
        public void Delete(int id)
        {
        }
        */
    }
}
