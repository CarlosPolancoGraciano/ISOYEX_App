using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI.WebControls;
using System.Data;

namespace ISOYEX_App.Class_Library
{
    public class Helper
    {
        public void LLenaDrop(DropDownList Drop, DataTable tabla, string CampoText, string CampoValue)
        {
            Drop.DataSource = tabla;
            Drop.DataValueField = CampoValue;
            Drop.DataTextField = CampoText;
            Drop.DataBind();
            Drop.Items.Insert(0, (new ListItem("-- Seleccionar --", "")));
        }
    }
}