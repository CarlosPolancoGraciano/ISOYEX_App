using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using ISOYEX_App.Class_Library;

namespace ISOYEX_App
{
    public partial class Registrarse : System.Web.UI.Page
    {
        Helper helper = new Helper();
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                string[] parametros = { };
                DataTable tabla = ManejadorData.Exec_Stp("spCargarTipoSangre", 's', parametros);
                helper.LLenaDrop(ddlTipoSangre, tabla, "Tipo", "Id_TipoSangre");

                tabla = ManejadorData.Exec_Stp("spCargarTipoContacto", 'S', parametros);
                helper.LLenaDrop(ddlTipoContacto, tabla, "Tipo", "Id_TipoContacto");

                tabla = ManejadorData.Exec_Stp("spCargarProvincias", 'S', parametros);
                helper.LLenaDrop(ddlProvincia, tabla, "Provincia", "Id_Provincia");
            }
        }

        protected void ddlProvincia_SelectedIndexChanged(object sender, EventArgs e)
        {
            DropDownList drop = (DropDownList)sender;
            string[] parametros = { "@idProvincia", drop.SelectedValue.ToString() };
            DataTable tabla = ManejadorData.Exec_Stp("spCargarMunicipio", 's', parametros);
            if (drop.SelectedValue.ToString() != "")
                helper.LLenaDrop(ddlMunicipio, tabla, "Municipio", "Id_Municipio");
            else
                ddlMunicipio.Items.Clear();
        }

        protected void btnRegistrarse_Click(object sender, EventArgs e)
        {

            if (hdnOpcion.Value == "ind")
            {
                string[] parametros =
                    {
                    "@Nombre",txtNombre.Text,
                    "@Apellido",txtApellido.Text,
                    "@Imagen","",
                    "@Email",txtEmail.Text,
                    "@Contrasena",txtContrasena.Text,
                    "@FechaNacimiento",txtFechaNacimiento.Text,
                    "@Id_TipoSangre",ddlTipoSangre.SelectedValue,
                    "@NumeroTelefonico",txtTelefono.Text,
                    "@Id_TipoContacto",ddlTipoContacto.SelectedValue,
                    "@Id_Provincia",ddlProvincia.SelectedValue,
                    "@Id_Municipio",ddlMunicipio.SelectedValue
                };
                try
                {
                    ManejadorData.Exec_Stp("spRegistrarDonanteReceptor", 'm', parametros);
                    Response.Write("<script>alert('Bien!');</script>");
                }
                catch (Exception)
                {

                    throw;
                }
                
            }
        }
    }
}