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
    public partial class _Default : Page
    {
        Helper helper = new Helper();
        DataTable filteredUsers = new DataTable();
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                string[] parametros = { };
                DataTable table = ManejadorData.Exec_Stp("spCargarProvincias", 's', parametros);
                helper.LLenaDrop(ProvinciaDropDown, table, "Provincia", "Id_Provincia");
                table = ManejadorData.Exec_Stp("spCargarTipoSangre", 's', parametros);
                helper.LLenaDrop(TipoSangreDropDown, table, "TipoSangre", "Id_TipoSangre");
            }
        }

        protected void ddlProvincia_SelectedIndexChanged(object sender, EventArgs e)
        {
            DropDownList provinciaDrop = (DropDownList)sender;
            string[] parametros = { "@idProvincia", provinciaDrop.SelectedValue.ToString() };
            if(provinciaDrop.SelectedValue.ToString() != "")
            {
                DataTable table = ManejadorData.Exec_Stp("spCargarMunicipio", 's', parametros);
                helper.LLenaDrop(MunicipioDropDown, table, "Municipio", "Id_Municipio");
            }
            else
            {
                MunicipioDropDown.Items.Clear();
            }
            
        }

        protected void ddlMunicipio_SelectedIndexChanged(object sender, EventArgs e)
        {

        }

        protected void SearchButton_Click(object sender, EventArgs e)
        {
            FilteredUsersController ajaxFilteredUseres = new FilteredUsersController();
            String indexProvincia = ProvinciaDropDown.SelectedValue;
            String indexMunicipio = MunicipioDropDown.SelectedValue;
            String indexTipoSangre = TipoSangreDropDown.SelectedValue;

            if (indexProvincia != string.Empty &&
                indexMunicipio != string.Empty &&
                indexTipoSangre == string.Empty)
            {
                //Filtrado por direccion
                string[] parametros = {
                    "@Id_Provincia", indexProvincia,
                    "@Id_Municipio", indexMunicipio
                };
                try
                {
                    filteredUsers = ManejadorData.Exec_Stp("spFiltradoPorDireccion", 's', parametros);
                    ajaxFilteredUseres.formatUsers(filteredUsers);
                }
                catch (Exception ex)
                {
                    throw ex;
                }

            }
            else if (indexProvincia == string.Empty &&
                      indexMunicipio == string.Empty &&
                      indexTipoSangre != string.Empty)
            {
                //Filtrado por tipo de sangre
                string[] parametros = { "@Id_TipoSangre", indexTipoSangre };
                try
                {
                    filteredUsers = ManejadorData.Exec_Stp("spFiltradoPorSangre", 's', parametros);
                    ajaxFilteredUseres.formatUsers(filteredUsers);
                }
                catch (Exception ex)
                {
                    throw ex;
                }
            }
            else if(indexProvincia != string.Empty &&
                    indexMunicipio != string.Empty &&
                    indexTipoSangre != string.Empty)
            {
                //Filtrado por direccion y tipo de sangre
                string[] parametros = {
                    "@Id_Provincia", indexProvincia,
                    "@Id_Municipio", indexMunicipio,
                    "@Id_TipoSangre", indexTipoSangre
                };
                try
                {
                    filteredUsers = ManejadorData.Exec_Stp("spFiltradoPorDireccionYSangre", 's', parametros);
                    ajaxFilteredUseres.formatUsers(filteredUsers);
                }
                catch(Exception ex)
                {
                    throw ex;
                }
            }
            else if (indexProvincia == string.Empty &&
                    indexMunicipio == string.Empty &&
                    indexTipoSangre == string.Empty)
            {
                ScriptManager.RegisterStartupScript(this, this.GetType(), "unvalidFilteredAction", "swal('Busqueda invalida', 'Debes seleccionar un tipo de sangre o dirección o ambos a la vez para poder filtrar', 'error')", true);
            }
        }
    }
}