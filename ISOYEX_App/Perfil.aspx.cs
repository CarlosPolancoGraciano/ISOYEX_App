using ISOYEX_App.Class_Library;
using ISOYEX_App.Models;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace ISOYEX_App
{
    public partial class perfil : System.Web.UI.Page
    {
        Helper helper = new Helper();
        DataTable tabla = new DataTable();
        Users user = null;
        protected void Page_Load(object sender, EventArgs e)
       {
            if (!IsPostBack)
            {
                if (Session["Id_Usuario"] == null)
                {
                    Response.Redirect("Login.aspx");
                }
                if(user == null)
                {
                    /*Obtaining User Id*/
                    string idUsuario = Session["Id_Usuario"].ToString();
                    /*Obtaining User Data*/
                    string[] userParametros = { "@Id_Usuario", idUsuario };
                    tabla = ManejadorData.Exec_Stp("spUsuarioData", 's', userParametros);
                    user = UsuarioData(tabla);
                    InsertPersistUserData(user);
                }

                /*Loading Blood Type*/
                string[] parametros = { };
                tabla = ManejadorData.Exec_Stp("spCargarTipoSangre", 's', parametros);
                helper.LLenaDrop(ddlTipoSangre, tabla, "TipoSangre", "Id_TipoSangre");

                /*Loading Contact Type*/
                tabla = ManejadorData.Exec_Stp("spCargarTipoContacto", 'S', parametros);
                helper.LLenaDrop(ddlTipoContacto, tabla, "Tipo", "Id_TipoContacto");

                /*Loading Provincia Data*/
                tabla = ManejadorData.Exec_Stp("spCargarProvincias", 'S', parametros);
                helper.LLenaDrop(ddlProvincia, tabla, "Provincia", "Id_Provincia");

                //Custom method
                FillInputWithUserData(user);
            }
            PersistUserData();
        }
        /*Update user data*/
        protected void ddlProvincia_SelectedIndexChanged(object sender, EventArgs e)
        {
            DropDownList drop = (DropDownList)sender;
            ddlMunicipio.ClearSelection();
            if (drop.SelectedValue.ToString() != "")
            {
                string[] parametros = { "@idProvincia", drop.SelectedValue.ToString() };
                tabla = ManejadorData.Exec_Stp("spCargarMunicipio", 'S', parametros);
                helper.LLenaDrop(ddlMunicipio, tabla, "Municipio", "Id_Municipio");
            }
        }

        protected void btnSaveChanges_Click(object sender, EventArgs e)
        {

        }

        /*Load user data*/
        private Users UsuarioData(DataTable userData)
        { 
            Users user = new Users();
            foreach (DataRow row in userData.Rows)
            {
                user.UserId = Convert.ToInt32(row["Id_Usuario"].ToString());
                user.Nombre = row["Nombre"].ToString();
                user.Apellido = row["Apellido"].ToString();
                user.ImagenURL = row["Imagen"].ToString();
                user.Email = row["Email"].ToString();
                user.FechaNacimiento = row.Field<DateTime>("FechaNacimiento");
                user.NumeroTelefonico = row["Numero"].ToString();
                user.TipoContactoId = Convert.ToInt32(row["Id_TipoContacto"].ToString());
                user.TipoContacto = row["Tipo"].ToString();
                user.ProvinciaId = Convert.ToInt32(row["Id_Provincia"].ToString());
                user.Provincia = row["Provincia"].ToString();
                user.MunicipioId = Convert.ToInt32(row["Id_Municipio"].ToString());
                user.Municipio = row["Municipio"].ToString();
                user.TipoSangreId = Convert.ToInt32(row["Id_TipoSangre"].ToString());
                user.TipoSangre = row["TipoSangre"].ToString();
            }
            return user;
        }

        private void PersistUserData()
        {
            /*Retrieve and Save Current User Data to Session*/
            /*If postback was made, persist the currentUser*/
            if (Session["currentUser"] != null && (user == null))
            {
                user = (Users)Session["currentUser"];

            }
        }

        private void InsertPersistUserData(Users user)
        {
            /*Insert Current User Data to Session*/
            /*The first time the user data get's retrieve from DB*/
            if (Session["currentUser"] == null && user != null)
            {
                Session["currentUser"] = user;

            }
        }

        private void FillInputWithUserData(Users user)
        {
            txtNombre.Text = user.Nombre;
            txtApellido.Text = user.Apellido;
            txtFechaNacimiento.Text = user.FechaNacimiento.ToString("dd-MM-yyyy");
            ddlTipoSangre.Text = user.TipoSangre;
            txtEmail.Text = user.Email;
            ddlTipoContacto.Text = user.TipoContacto;
            txtTelefono.Text = user.NumeroTelefonico;
            ddlProvincia.Text = user.Provincia;
            if (user.ProvinciaId.ToString() != "")
            {
                string[] parametros = { "@idProvincia", user.ProvinciaId.ToString() };
                tabla = ManejadorData.Exec_Stp("spCargarMunicipio", 'S', parametros);
                helper.LLenaDrop(ddlMunicipio, tabla, "Municipio", "Id_Municipio");
                ddlMunicipio.Text = user.Municipio;
            }
            else
            {
                ddlMunicipio.Items.Clear();
            }
        }
    }
}