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
    public partial class _Default : Page
    {
        Helper helper = new Helper();
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                string[] parametros = { };
                DataTable table = ManejadorData.Exec_Stp("spCargarProvincias", 's', parametros);
                helper.LLenaDrop(ddlProvincia, table, "Provincia", "Id_Provincia");
                table = ManejadorData.Exec_Stp("spCargarTipoSangre", 's', parametros);
                helper.LLenaDrop(ddlTipoSangre, table, "Tipo", "Id_TipoSangre");
            }
        }

        protected void ddlProvincia_SelectedIndexChanged(object sender, EventArgs e)
        {
            DropDownList provinciaDrop = (DropDownList)sender;
            string[] parametros = { "@idProvincia", provinciaDrop.SelectedValue.ToString() };
            DataTable table = ManejadorData.Exec_Stp("spCargarMunicipio", 's', parametros);
            if(provinciaDrop.SelectedValue.ToString() != "")
            {
                helper.LLenaDrop(ddlMunicipio, table, "Municipio", "Id_Municipio");
            }
            else
            {
                ddlMunicipio.Items.Clear();
            }
            
        }

        protected void ddlMunicipio_SelectedIndexChanged(object sender, EventArgs e)
        {

        }
    }
}