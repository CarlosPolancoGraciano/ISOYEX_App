using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;

namespace ISOYEX_App
{
    public partial class login : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void btningresar_Click(object sender, EventArgs e)
        {
            if (!string.IsNullOrWhiteSpace(txtemail.Text) && !string.IsNullOrWhiteSpace(txtpassword.Text))
            {
                string[] parametros = { "@Email", txtemail.Text, "@contrasena", txtpassword.Text };
                DataTable tabla = ManejadorData.Exec_Stp("spLoginEmail", 's', parametros);

                if (tabla.Rows.Count > 0)
                {
                    //Session["NombreUsuario"] = (tabla.Rows[0]["Nombre"] + " "+ tabla.Rows[0]["Apellido"]);
                    Session["NombreUsuario"] = (tabla.Rows[0]["Nombre"]);
                    Session["Id_Usuario"] = tabla.Rows[0]["Id_Usuario"].ToString();
                    Response.Redirect("Default.aspx");
                }
                else
                    pnlError.Visible = true;
            }
        }
    }
}