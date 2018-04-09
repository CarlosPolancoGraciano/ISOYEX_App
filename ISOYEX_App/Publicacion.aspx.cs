using ISOYEX_App.Controllers;
using System;
using System.Collections.Generic;
using System.Data;
using System.Globalization;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace ISOYEX_App
{
    public partial class Publicacion : System.Web.UI.Page
    {
        DataTable tabla = new DataTable();
        PostCommentsController postComments = new PostCommentsController();
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                if (Request.QueryString["q"] == null)
                {
                    Response.Redirect("Default.aspx");
                }
                else if (Session["Id_Usuario"] == null)
                {
                    Response.Redirect("Login.aspx");
                }

                ComentarPorRol(Session["Id_Usuario"].ToString());

                /*Request for the post content to DB*/
                string[] parametros = { "@Id_Publicacion", Request.QueryString["q"].ToString() };
                tabla = ManejadorData.Exec_Stp("spRetornarPublicacionPorId", 's', parametros);
                MaquetarInformacion(tabla);

                /*Request for the post comments to DB*/
                string[] parametros2 = { "@Id_Publicacion", Request.QueryString["q"].ToString() };
                tabla = ManejadorData.Exec_Stp("spRetornarComentariosPublicacion", 's', parametros2);
                postComments.formatComments(tabla);
            }
        }

        private void ComentarPorRol(string currentUserId)
        {
            string[] parametros = { "@Nombre", "Donante" };
            tabla = ManejadorData.Exec_Stp("spRetonarRolId", 's', parametros);
            Int32 donanteId = Convert.ToInt32(tabla.Rows[0]["Id_Rol"].ToString());
            if (Convert.ToInt32(currentUserId) == donanteId)
            {
                noAbleToCommentDiv.Style.Add("display", "none");
            }
            else
            {
                ableToCommentDiv.Style.Add("display", "none");
            }
        }

        private void MaquetarInformacion(DataTable table)
        {
            /*Add current user id to span*/
            currentUserIdSpan.InnerText = Session["Id_Usuario"].ToString();

            /*Post content*/
            postTitle.InnerText = table.Rows[0]["Titulo"].ToString();
            publishOwner.InnerText = table.Rows[0]["Nombre"].ToString();
            MapDate(table);
            contentFroalaView.InnerHtml = table.Rows[0]["Contenido"].ToString();

            /*Post owner content*/
            postOwnerImage.ImageUrl = table.Rows[0]["Imagen"].ToString();
            nombreSpan.InnerText = table.Rows[0]["Nombre"].ToString();
            emailSpan.InnerText = table.Rows[0]["Email"].ToString();
            provinciaSpan.InnerText = table.Rows[0]["Provincia"].ToString();
            MunicipioSpan.InnerText = table.Rows[0]["Municipio"].ToString();

            /*Add post owner id to span*/
            postOwnerId.InnerText = table.Rows[0]["Id_Usuario"].ToString();
        }

        private void MapDate(DataTable table)
        {
            string[] result = { };
            String[] cultureNames = { "es-DO" };
            var culture = new CultureInfo(cultureNames[0]);
            CultureInfo.CurrentCulture = culture;
            DateTime date = DateTime.Parse(table.Rows[0]["Fecha"].ToString());

            postDate.InnerText = date.ToString("d MMM yyyy");
            postHour.InnerText = date.ToString("t");
        }

        protected void btnGuardarComentario_Click(object sender, EventArgs e)
        {
            if (txtComentario.Value != null)
            {
                string[] parametros = {
                    "@Contenido", txtComentario.Value,
                    "@Fecha", DateTime.Now.ToString(),
                    "@Id_Usuario", Session["Id_Usuario"].ToString(),
                    "@Id_Publicacion", Request.QueryString["q"].ToString()
                };
                try
                {
                    ManejadorData.Exec_Stp("spCrearComentario", 'm', parametros);
                    ScriptManager.RegisterStartupScript(this, this.GetType(), "emptyFieldsSweetAlert", "swal('Comentario agregado!', '','success').then((value) => { window.location.reload() })", true);
                }
                catch (Exception)
                {
                    throw;
                }
            }
            else
            {
                ScriptManager.RegisterStartupScript(this, this.GetType(), "emptyFieldsSweetAlert", "swal('Campo faltante', 'Debes ponerle un texto al comentario o elegir una respuesta rápida','error')", true);
            }
        }

        protected void btnMensajeRapido1_Click(object sender, EventArgs e)
        {
            string[] parametros = {
                "@Contenido", btnMensajeRapido1.Text,
                "@Fecha", DateTime.Now.ToString(),
                "@Id_Usuario", Session["Id_Usuario"].ToString(),
                "@Id_Publicacion", Request.QueryString["q"].ToString()
            };
            try
            {
                ManejadorData.Exec_Stp("spCrearComentario", 'm', parametros);
                ScriptManager.RegisterStartupScript(this, this.GetType(), "emptyFieldsSweetAlert", "swal('Comentario agregado!', '','success').then((value) => { location.reload() })", true);
            }
            catch (Exception)
            {
                throw;
            }
        }

        protected void btnMensajeRapido2_Click(object sender, EventArgs e)
        {
            string[] parametros = {
                "@Contenido", btnMensajeRapido2.Text,
                "@Fecha", DateTime.Now.ToString(),
                "@Id_Usuario", Session["Id_Usuario"].ToString(),
                "@Id_Publicacion", Request.QueryString["q"].ToString()
            };
            try
            {
                ManejadorData.Exec_Stp("spCrearComentario", 'm', parametros);
                ScriptManager.RegisterStartupScript(this, this.GetType(), "emptyFieldsSweetAlert", "swal('Comentario agregado!', '','success').then((value) => { location.reload() })", true);
            }
            catch (Exception)
            {
                throw;
            }
        }

    }
}