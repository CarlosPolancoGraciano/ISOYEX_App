using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;

namespace ISOYEX_App
{
    public partial class SiteMaster : MasterPage
    {
        protected void Page_Load(object sender, EventArgs e)
        {
                if (Session["NombreUsuario"] == null || Session["Id_Usuario"] == null)
                {
                    itemLogin.Visible = false;
                }
                else
                {
                    string nombreUsuario = Session["NombreUsuario"].ToString();
                    navbarDropdown.Text = "Hola " + nombreUsuario+ " !";
                    itemNologin.Visible = false;
                    itemNologin2.Visible = false;
                }
        }

        protected void lkbsalir_Click(object sender, EventArgs e)
        {
            Session["NombreUsuario"] = null;
            Session["Id_Usuario"] = null;
            Response.Redirect("Default.aspx");
        }
    }
}