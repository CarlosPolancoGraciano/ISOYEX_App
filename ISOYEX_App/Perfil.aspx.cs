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
        protected void Page_Load(object sender, EventArgs e)
       {
            if (!IsPostBack)
            {

                if(Session["Id_Usuario"] == null){

                    Response.Redirect("Login.aspx");
                }
                
                string[] parametros = { };
                tabla = ManejadorData.Exec_Stp("spCargarTipoSangre", 's', parametros);
                helper.LLenaDrop(ddlTipoSangre, tabla, "TipoSangre", "Id_TipoSangre");

                /*Loading Contact Type*/
                tabla = ManejadorData.Exec_Stp("spCargarTipoContacto", 'S', parametros);
                helper.LLenaDrop(ddlTipoContacto, tabla, "Tipo", "Id_TipoContacto");

                /*Loading Provincia Data*/
                tabla = ManejadorData.Exec_Stp("spCargarProvincias", 'S', parametros);
                helper.LLenaDrop(ddlProvincia, tabla, "Provincia", "Id_Provincia");
                
                cargarDatos();
                EnableControls(false);
            }
        }

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

        public void cargarDatos()
        {
            string idUsuario = Session["Id_Usuario"].ToString();
            string[] userParametros = { "@Id_Usuario", idUsuario };
            tabla = ManejadorData.Exec_Stp("spUsuarioData", 's', userParametros);

            txtNombre.Text = tabla.Rows[0]["Nombre"].ToString();
            txtApellido.Text = tabla.Rows[0]["Apellido"].ToString();
            txtFechaNacimiento.Text = tabla.Rows[0]["FechaNacimiento"].ToString();
            ddlTipoSangre.SelectedValue = tabla.Rows[0]["FechaNacimiento"].ToString();
            txtEmail.Text = tabla.Rows[0]["Email"].ToString();
            ddlTipoContacto.SelectedValue = tabla.Rows[0]["Id_TipoContacto"].ToString();
            txtTelefono.Text = tabla.Rows[0]["Numero"].ToString();
            ddlProvincia.SelectedValue = tabla.Rows[0]["Id_Provincia"].ToString();

            string[] parametros = { "@idProvincia", tabla.Rows[0]["Id_Provincia"].ToString() };
            DataTable tablita = ManejadorData.Exec_Stp("spCargarMunicipio", 'S', parametros);
            helper.LLenaDrop(ddlMunicipio, tablita, "Municipio", "Id_Municipio");

            ddlMunicipio.SelectedValue = tabla.Rows[0]["Id_Municipio"].ToString();

            ddlTipoSangre.SelectedValue = tabla.Rows[0]["Id_TipoSangre"].ToString();
        }

        public void EnableControls(bool Activos)
        {
            txtNombre.Enabled = Activos;
            txtApellido.Enabled = Activos;
            txtFechaNacimiento.Enabled = Activos;
            ddlTipoSangre.Enabled = Activos;
            ddlTipoContacto.Enabled = Activos;
            txtTelefono.Enabled = Activos;
            ddlProvincia.Enabled = Activos;
            ddlMunicipio.Enabled = Activos;
            ddlTipoSangre.Enabled = Activos;
            txtConfContrasena.Enabled = Activos;
            txtPassword.Enabled = Activos;
        }
        protected void btnSaveChanges_Click(object sender, EventArgs e)
        {
            string[] parametros = {
                "@Id_Usuario",Session["Id_Usuario"].ToString(),
                "@Nombre",txtNombre.Text,
                "@Apellido",txtApellido.Text,
                "@Imagen","",
                "@Email",txtEmail.Text,
                "@Contrasena",txtPassword.Text,
                "@FechaNacimiento",helper.dateFormat(txtFechaNacimiento.Text,"yyyy-dd-MM"),
                "@NumeroTelefonico",txtTelefono.Text,
                "@Id_TipoContacto",ddlTipoContacto.SelectedValue,
                "@Id_TipoSangre",ddlTipoSangre.SelectedValue,
                "@Id_Provincia",ddlProvincia.SelectedValue,
                "@Id_Municipio",ddlMunicipio.SelectedValue
            };

            ManejadorData.Exec_Stp("spUpdateDonanteReceptorData",'M', parametros);
        }

        protected void btnModificar_Click(object sender, EventArgs e)
        {

            EnableControls(true);
            btnCancelar.Visible = true;
            btnSaveChanges.Visible = true;
            btnModificar.Visible = false;

        }

        protected void btnCancelar_Click(object sender, EventArgs e)
        {
            Response.Redirect("Perfil.aspx");
        }
    }
}