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

                if (Session["Id_Usuario"] == null)
                {

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
            txtFechaNacimiento.Text = helper.dateFormat(tabla.Rows[0]["FechaNacimiento"].ToString(), "dd-MM-yyyy");
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

            Session["FechaNacimiento"] = tabla.Rows[0]["FechaNacimiento"].ToString();
        }

        public void EnableControls(bool Activos)
        {
            //txtNombre.Enabled = Activos;
            //txtApellido.Enabled = Activos;
            //txtFechaNacimiento.Enabled = Activos;
            //ddlTipoSangre.Enabled = Activos;
            ddlTipoContacto.Enabled = Activos;
            txtTelefono.Enabled = Activos;
            ddlProvincia.Enabled = Activos;
            ddlMunicipio.Enabled = Activos;
            //ddlTipoSangre.Enabled = Activos;
            txtConfContrasena.Enabled = Activos;
            txtPassword.Enabled = Activos;
        }
        protected void btnSaveChanges_Click(object sender, EventArgs e)
        {
            if (!validarControls())
            {
                string[] parametros = {
                "@Id_Usuario",Session["Id_Usuario"].ToString(),
                "@Nombre",txtNombre.Text,
                "@Apellido",txtApellido.Text,
                "@Imagen","",
                "@Email",txtEmail.Text,
                "@Contrasena",txtPassword.Text,
                "@FechaNacimiento",Session["FechaNacimiento"].ToString(),
                "@NumeroTelefonico",txtTelefono.Text,
                "@Id_TipoContacto",ddlTipoContacto.SelectedValue,
                "@Id_TipoSangre",ddlTipoSangre.SelectedValue,
                "@Id_Provincia",ddlProvincia.SelectedValue,
                "@Id_Municipio",ddlMunicipio.SelectedValue
                 };
                try
                {
                    ManejadorData.Exec_Stp("spUpdateDonanteReceptorData", 'm', parametros);
                    ScriptManager.RegisterClientScriptBlock(this, this.GetType(), "saveFiledsSweetAlert", "sweetAlert('Perfil actualizado', 'Cambios guardados exitosamente', 'success')", true);
                }
                catch (Exception)
                {
                    throw;
                }
            }
            else
            {
                ScriptManager.RegisterClientScriptBlock(this, this.GetType(), "emptyFieldsSweetAlert", "sweetAlert('Campos faltantes', 'En el fomulario existen campos vacios', 'error')", true);
            }
        }

        public bool validarControls()
        {
            if (helper.validarVacio(txtNombre))
                return true;
            else if (helper.validarVacio(txtApellido))
                return true;
            else if (helper.validarVacio(txtFechaNacimiento))
                return true;
            else if (helper.validarNoSeleccionado(ddlTipoSangre))
                return true;
            else if (helper.validarVacio(txtEmail))
                return true;
            else if (helper.validarVacio(txtPassword))
                return true;
            else if (helper.validarVacio(txtConfContrasena) || txtConfContrasena.Text != txtPassword.Text)
                return true;
            else if (helper.validarNoSeleccionado(ddlTipoContacto))
                return true;
            else if (helper.validarVacio(txtTelefono))
                return true;
            else if (helper.validarNoSeleccionado(ddlProvincia))
                return true;
            else if (helper.validarNoSeleccionado(ddlMunicipio))
                return true;

            return false;
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