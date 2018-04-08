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
    public partial class Publicaciones : System.Web.UI.Page
    {
        Helper helper = new Helper();
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                if (Session["Id_Usuario"] != null)
                {
                    string[] parametros = { };
                    DataTable tabla = ManejadorData.Exec_Stp("spCargarTipoSangre", 's', parametros);
                    helper.LLenaDrop(ddlTipoSangre, tabla, "TipoSangre", "Id_TipoSangre");
                }
                else
                {
                    Response.Redirect("Login.aspx");
                }
                
            }
        }

        private bool ValidarControles()
        {
            if (helper.validarVacio(txtTitulo))
                return false;
            else if (helper.validarNoSeleccionado(ddlTipoSangre))
                return false;
            else if (postEditor.Value == null)
                return false;
            else
                return true;
        }

        private bool ValidarRolUsuario()
        {
            string[] parametros = { "@Nombre", "Institucion" };
            DataTable tabla = ManejadorData.Exec_Stp("spObtenerRolPorNombre", 's', parametros);
            if (Session["Id_Rol"].ToString() == tabla.Rows[0]["Id_Rol"].ToString())
            {
                return true;
            }
            return false;
        }

        protected void btnSavePost_Click(object sender, EventArgs e)
        {
            if (ValidarControles())
            {
                string[] parametros = {
                    "@Titulo", txtTitulo.Text,
                    "@Id_TipoSangre", ddlTipoSangre.SelectedValue,
                    "@Contenido", postEditor.Value,
                    "@Fecha", DateTime.Now.ToString(),
                    "@Id_Usuario", Session["Id_Usuario"].ToString()
                    };
                ManejadorData.Exec_Stp("spCrearPublicacion", 'm', parametros);
                ScriptManager.RegisterStartupScript(this, this.GetType(), "emptyFieldsSweetAlert", "swal('Publicación hecha!', 'El post fue publicado exitosamente, todos los donantes han sido notificados','success').then((value) => { window.location.href = '/Default.aspx'; })", true);
                /*if (ValidarRolUsuario())
                {
                    
                }
                else
                {
                    ScriptManager.RegisterStartupScript(this, this.GetType(), "emptyFieldsSweetAlert", "swal('Error!', 'Solo las instituciones pueden crear publicaciones','error')", true);
                }*/

            }
            else
            {
                ScriptManager.RegisterStartupScript(this, this.GetType(), "emptyFieldsSweetAlert", "swal('Campos faltantes', 'En el fomulario para publicar existen campos vacios','error')", true);
            }
        }
    }
}