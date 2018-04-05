using ISOYEX_App.Class_Library;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace ISOYEX_App
{
    public partial class PerfilFiltrado : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                if (Request.QueryString["q"] == null)
                {
                    Response.Redirect("Default.aspx");
                }
                if (Session["Id_Usuario"] == null)
                {
                    Response.Redirect("Login.aspx");
                }
                cargarDatos();
            }
        }

        public void cargarDatos()
        {
            String sFilteredUserId = Request.QueryString["q"];
            string[] userParametros = { "@Id_Usuario", sFilteredUserId };
            DataTable tabla = new DataTable();
            tabla = ManejadorData.Exec_Stp("spUsuarioData", 's', userParametros);

            DateTime BirthDate = DateTime.Parse(tabla.Rows[0]["FechaNacimiento"].ToString());
            var age = (DateTime.Now.Year - BirthDate.Year);

            userProfilePicture.ImageUrl = tabla.Rows[0]["Imagen"].ToString();
            txtNombreLabel.Text = "Nombre: " + tabla.Rows[0]["Nombre"].ToString() + " " + tabla.Rows[0]["Apellido"].ToString();
            txtEdadLabel.Text = "Edad: " + age.ToString();
            ddlTipoSangreLabel.Text = "Tipo de sangre: " + tabla.Rows[0]["TipoSangre"].ToString();
            txtEmailLabel.Text = "Email: " + tabla.Rows[0]["Email"].ToString();
            labelcontacto.Text = "Tipo de contacto: " + tabla.Rows[0]["Tipo"].ToString();
            labeltelefono.Text = "Número telefónico: " + tabla.Rows[0]["Numero"].ToString();
            ddlProvinciaLabel.Text = "Provincia: " + tabla.Rows[0]["Provincia"].ToString();
            ddlMunicipioLabel.Text = "Municipio: " + tabla.Rows[0]["Municipio"].ToString();
        }
    }
}