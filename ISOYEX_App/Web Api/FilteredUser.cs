using ISOYEX_App.Models;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Net;
using System.Net.Http;
using System.Web.Http;

namespace ISOYEX_App.Web_Api
{
    public class FilteredUser : ApiController
    {
        DataTable filteredUsers = new DataTable();

        public FilteredUser(DataTable filteredUser)
        {
            filteredUsers = filteredUser;
        }

        // GET api/<controller>
        [HttpGet, Route("api/Get")]
        public IEnumerable<string> Get()
        {
            return new string[] { "value1", "value2" };
        }

        //Class used with ListView Of Filtered User
        [HttpGet, Route("api/getFilteredUsers")]
        public List<Users> getFilteredUsers()
        {
            if (filteredUsers == null) { return null; };

            List<Users> users = new List<Users>();
            users.Add(new Users { Nombre = "Carlos Abel", Apellido="Polanco Graciano", Email="Carlosfollows@gmail.com" });
            /*
            foreach (DataRow row in filteredUsers.Rows)
            {
                Users currentUser = new Users();
                currentUser.UserId = Convert.ToInt32(row["Id_Usuario"].ToString());
                currentUser.Nombre = row["Nombre"].ToString();
                currentUser.Apellido = row["Apellido"].ToString();
                currentUser.ImagenURL = "http://placehold.it/900x400";
                currentUser.Email = row["Email"].ToString();
                currentUser.FechaNacimiento = Convert.ToDateTime(row["FechaNacimiento"].ToString());
                currentUser.NumeroTelefonico = row["Numero"].ToString();
                currentUser.TipoContacto = row["Tipo"].ToString();
                currentUser.Provincia = row["Provincia"].ToString();
                currentUser.Municipio = row["Municipio"].ToString();

                users.Add(currentUser);
            }
            */
            return users;
        }
    }
}