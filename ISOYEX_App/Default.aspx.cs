using ISOYEX_App.Class_Library;
using ISOYEX_App.Controllers;
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
        DataTable filteredPosts = new DataTable();
        PostController postController = new PostController();
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                if (Session["Id_Rol"] != null)
                {
                    showCreatePostButton(Session["Id_Rol"].ToString());
                }
                string[] parametros = { };
                DataTable table = ManejadorData.Exec_Stp("spCargarProvincias", 's', parametros);
                helper.LLenaDrop(ProvinciaDropDown, table, "Provincia", "Id_Provincia");
                helper.LLenaDrop(PostProvinciaDropDown, table, "Provincia", "Id_Provincia");

                table = ManejadorData.Exec_Stp("spCargarTipoSangre", 's', parametros);
                helper.LLenaDrop(TipoSangreDropDown, table, "TipoSangre", "Id_TipoSangre");
                helper.LLenaDrop(PostTipoSangreDropDown, table, "TipoSangre", "Id_TipoSangre");

                /*Send post to web api*/
                table = ManejadorData.Exec_Stp("spRetornarPublicaciones", 's', parametros);
                postController.formatPosts(table);
            }
        }

        protected void showCreatePostButton(string currentUserRolId)
        {
            string[] parametros = { "@Nombre", "Institucion" };
            DataTable tabla = ManejadorData.Exec_Stp("spRetonarRolId", 's', parametros);
            Int32 donanteId = Convert.ToInt32(tabla.Rows[0]["Id_Rol"].ToString());
            if (Convert.ToInt32(currentUserRolId) == donanteId)
            {
                btnCrearPost.Style.Remove("display");
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

        protected void SearchPostButton_Click(object sender, EventArgs e)
        {
            String indexProvincia = PostProvinciaDropDown.SelectedValue;
            String indexMunicipio = PostMunicipioDropDown.SelectedValue;
            String indexTipoSangre = PostTipoSangreDropDown.SelectedValue;

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
                    filteredPosts = ManejadorData.Exec_Stp("spFiltrarPostPorDireccionUsuario", 's', parametros);
                    postController.formatPosts(filteredUsers);
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
                    filteredPosts = ManejadorData.Exec_Stp("spFiltradoPostPorTipoSangre", 's', parametros);
                    postController.formatPosts(filteredUsers);
                }
                catch (Exception ex)
                {
                    throw ex;
                }
            }
            else if (indexProvincia != string.Empty &&
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
                    filteredPosts = ManejadorData.Exec_Stp("spFiltradoPostDireccionTipoSangre", 's', parametros);
                    postController.formatPosts(filteredUsers);
                }
                catch (Exception ex)
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

        protected void PostProvinciaDropDown_SelectedIndexChanged(object sender, EventArgs e)
        {
            DropDownList provinciaDrop = (DropDownList)sender;
            string[] parametros = { "@idProvincia", provinciaDrop.SelectedValue.ToString() };
            if (provinciaDrop.SelectedValue.ToString() != "")
            {
                DataTable table = ManejadorData.Exec_Stp("spCargarMunicipio", 's', parametros);
                helper.LLenaDrop(PostMunicipioDropDown, table, "Municipio", "Id_Municipio");
            }
            else
            {
                PostMunicipioDropDown.Items.Clear();
            }
        }
    }
}