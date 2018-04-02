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

        public bool validarVacio(TextBox textBox)
        {
            if (String.IsNullOrWhiteSpace(textBox.Text))
                return true;
            else
            return false;
        }

        public bool validarNoSeleccionado(DropDownList dropDown)
        {
            if (dropDown.SelectedIndex == 0)
                return true;
            else
            return false;
        }

        public string dateFormat(string facha, string formato)
        {
            DateTime dt = DateTime.Parse(facha);
            string formateada = dt.ToString(formato);
            return formateada;
        }

    }
}