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
        DataTable tabla = new DataTable();
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
            try
            {
                tabla = ManejadorData.Exec_Stp("spUsuarioData", 's', userParametros);
            }
            catch (Exception)
            {
                throw;
            }

            DateTime BirthDate = DateTime.Parse(tabla.Rows[0]["FechaNacimiento"].ToString());
            var age = (DateTime.Now.Year - BirthDate.Year);

            userProfilePicture.ImageUrl = tabla.Rows[0]["Imagen"].ToString();
            txtNombreLabel.Text = tabla.Rows[0]["Nombre"].ToString() + " " + tabla.Rows[0]["Apellido"].ToString();
            txtEdadLabel.Text = age.ToString();
            ddlTipoSangreLabel.Text = tabla.Rows[0]["TipoSangre"].ToString();
            txtEmailLabel.Text = tabla.Rows[0]["Email"].ToString();
            labelcontacto.Text = tabla.Rows[0]["Tipo"].ToString();
            labeltelefono.Text = tabla.Rows[0]["Numero"].ToString();
            ddlProvinciaLabel.Text = tabla.Rows[0]["Provincia"].ToString();
            ddlMunicipioLabel.Text = tabla.Rows[0]["Municipio"].ToString();
        }
    }
}