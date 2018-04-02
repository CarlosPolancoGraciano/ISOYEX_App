using ISOYEX_App.Class_Library;
using ISOYEX_App.Models;
using ISOYEX_App.Web_Api;
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
                helper.LLenaDrop(TipoSangreDropDown, table, "Tipo", "Id_TipoSangre");
            }
        }

        protected void ddlProvincia_SelectedIndexChanged(object sender, EventArgs e)
        {
            DropDownList provinciaDrop = (DropDownList)sender;
            string[] parametros = { "@idProvincia", provinciaDrop.SelectedValue.ToString() };
            DataTable table = ManejadorData.Exec_Stp("spCargarMunicipio", 's', parametros);
            if(provinciaDrop.SelectedValue.ToString() != "")
            {
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
                    Response.Write("<script>alert('Funcionando')</script>");
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
                    Response.Write("<script>alert('Funcionando')</script>");
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
                    Response.Write("<script>alert('Funcionando')</script>");
                }
                catch(Exception ex)
                {
                    throw ex;
                }
            }
        }
    }
}