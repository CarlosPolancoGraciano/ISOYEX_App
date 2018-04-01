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

        public bool ValidarControles()
        {
            if (hdnOpcion.Value == "ins" && helper.validarVacio(txtRNC))
                return false;
            else if (helper.validarVacio(txtNombre))
                return false;
            else if (hdnOpcion.Value == "ind" && helper.validarVacio(txtApellido))
                return false;
            else if (hdnOpcion.Value == "ind" && helper.validarVacio(txtFechaNacimiento))
                return false;
            else if (hdnOpcion.Value == "ind" && helper.validarNoSeleccionado(ddlTipoSangre))
                return false;
            else if (helper.validarVacio(txtEmail))
                return false;
            else if (helper.validarNoSeleccionado(ddlTipoContacto))
                return false;
            else if (helper.validarVacio(txtTelefono))
                return false;
            else if (helper.validarNoSeleccionado(ddlProvincia))
                return false;
            else if (helper.validarNoSeleccionado(ddlMunicipio))
                return false;
            else if (helper.validarVacio(txtContrasena))
                return false;
            else
                return true;
        }

        protected void btnRegistrarse_Click(object sender, EventArgs e)
        {
            if (ValidarControles())
            {
                if (hdnOpcion.Value == "ind")
                {
                    

                    string[] parametros =
                        {
                    "@Nombre",txtNombre.Text,
                    "@Apellido",txtApellido.Text,
                    "@Imagen","0x",
                    "@Email",txtEmail.Text,
                    "@Contrasena",txtContrasena.Text,
                    "@FechaNacimiento",helper.dateFormat(txtFechaNacimiento.Text,"yyyy-dd-MM"),
                    "@Id_TipoSangre",ddlTipoSangre.SelectedValue,
                    "@NumeroTelefonico",txtTelefono.Text,
                    "@Id_TipoContacto",ddlTipoContacto.SelectedValue,
                    "@Id_Provincia",ddlProvincia.SelectedValue,
                    "@Id_Municipio",ddlMunicipio.SelectedValue
                };
                    try
                    {
                        ManejadorData.Exec_Stp("spRegistrarDonanteReceptor", 'm', parametros);
                        Response.Write("<script>alert('Registrado con exito');</script>");
                        Response.Redirect("Default.aspx");
                    }
                    catch (Exception)
                    {

                        throw;
                    }

                }
                else if (hdnOpcion.Value == "ins")
                {
                    string[] parametros =
                        {
                    "@RNC",txtRNC.Text,
                    "@Nombre",txtNombre.Text,
                    "@Imagen","0x",
                    "@Email",txtEmail.Text,
                    "@Contrasena",txtContrasena.Text,
                    "@NumeroTelefonico",txtTelefono.Text,
                    "@Id_TipoContacto",ddlTipoContacto.SelectedValue,
                    "@Id_Provincia",ddlProvincia.SelectedValue,
                    "@Id_Municipio",ddlMunicipio.SelectedValue
                };
                    try
                    {
                        ManejadorData.Exec_Stp("spRegistrarInstitucion", 'm', parametros);
                        Response.Write("<script>alert('Registrado con exito');</script>");
                        Response.Redirect("Default.aspx");
                    }
                    catch (Exception)
                    {
                        throw;
                        
                    }

                }

            }
        }
    }
}