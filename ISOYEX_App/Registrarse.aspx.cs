using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using ISOYEX_App.Class_Library;
using System.IO;

namespace ISOYEX_App
{
    public partial class Registrarse : System.Web.UI.Page
    {
        Helper helper = new Helper();
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                string[] parametros = { };
                DataTable tabla = ManejadorData.Exec_Stp("spCargarTipoSangre", 's', parametros);
                helper.LLenaDrop(ddlTipoSangre, tabla, "TipoSangre", "Id_TipoSangre");

                tabla = ManejadorData.Exec_Stp("spCargarTipoContacto", 'S', parametros);
                helper.LLenaDrop(ddlTipoContacto, tabla, "Tipo", "Id_TipoContacto");

                tabla = ManejadorData.Exec_Stp("spCargarProvincias", 'S', parametros);
                helper.LLenaDrop(ddlProvincia, tabla, "Provincia", "Id_Provincia");
            }
            /*Manage File Upload*/
            /*The first time the image get's upload*/
            if (Session["ImageUpload"] == null && ImageUpload.HasFile)
            {
                Session["ImageUpload"] = ImageUpload;
                ImageUploadLabel.Text = ImageUpload.FileName;

            }/*If postback was made, persist the image*/
            else if (Session["ImageUpload"] != null && (!ImageUpload.HasFile))
            {
                ImageUpload = (FileUpload) Session["ImageUpload"];
                ImageUploadLabel.Text = ImageUpload.FileName;
            }/*If user changes image*/
            else if (ImageUpload.HasFile)
            {
                Session["ImageUpload"] = ImageUpload;
                ImageUploadLabel.Text = ImageUpload.FileName;
            }
        }

        protected void ddlProvincia_SelectedIndexChanged(object sender, EventArgs e)
        {
            DropDownList drop = (DropDownList)sender;
            string[] parametros = { "@idProvincia", drop.SelectedValue.ToString() };
            if (drop.SelectedValue.ToString() != "")
            {
                DataTable tabla = ManejadorData.Exec_Stp("spCargarMunicipio", 's', parametros);
                helper.LLenaDrop(ddlMunicipio, tabla, "Municipio", "Id_Municipio");
            }
            else
            {
                ddlMunicipio.Items.Clear();
            }
        }

        public bool ValidarControles()
        {
            if (hdnOpcion.Value == "ins" && helper.validarVacio(txtRNC))
                return false;
            else if (helper.validarVacio(txtNombre))
                return false;
            else if (hdnOpcion.Value == "ind" && helper.validarVacio(txtApellido))
                return false;
            else if (hdnOpcion.Value == "ind" && helper.validarVacio(txtFechaNacimiento))
                return false;
            else if (hdnOpcion.Value == "ind" && helper.validarNoSeleccionado(ddlTipoSangre))
                return false;
            else if (helper.validarVacio(txtEmail))
                return false;
            else if (helper.validarNoSeleccionado(ddlTipoContacto))
                return false;
            else if (helper.validarVacio(txtTelefono))
                return false;
            else if (helper.validarNoSeleccionado(ddlProvincia))
                return false;
            else if (helper.validarNoSeleccionado(ddlMunicipio))
                return false;
            else if (helper.validarVacio(txtContrasena))
                return false;
            else if (!ImageUpload.HasFile)
                return false;
            else
                return true;
        }

        public string ValidarVacio()
        {
            if (hdnOpcion.Value == "ins" && helper.validarVacio(txtRNC))
                return txtRNCError.Text = "Favor agregar RNC";
            else if (helper.validarVacio(txtNombre))
                return txtNombreError.Text = "Favor agregar Nombre";
            else if (hdnOpcion.Value == "ind" && helper.validarVacio(txtApellido))
                return txtApellidoError.Text = "Favor agregar Apellido";
            else if (hdnOpcion.Value == "ind" && helper.validarNoSeleccionado(ddlTipoSangre))
                return TipoSangreError.Text = "Favor seleccionar Tipo de Sangre";
            else if (helper.validarVacio(txtEmail))
                return txtEmailError.Text = "Favor agregar Email";
            else if (helper.validarNoSeleccionado(ddlTipoContacto))
                return ddlTipoContactError.Text = "Favor seleccionar tipo de contacto";
            else if (helper.validarVacio(txtTelefono))
                return txtTelefonoError.Text = "Favor agregar numero de telefono";
            else if (helper.validarNoSeleccionado(ddlProvincia))
                return ddlProvinciaError.Text = "Favor seleccionar Provincia";
            else if (helper.validarNoSeleccionado(ddlMunicipio))
                return ddlMunicipioError.Text = "Favor seleccionar Municipio";
            else if (helper.validarVacio(txtContrasena))
                return txtContrasenaError.Text = "Favor escribir Contraseña";
            else
                return null;
        }


        protected void btnRegistrarse_Click(object sender, EventArgs e)
        {
            if (ValidarControles())
            {
                if (hdnOpcion.Value == "ind")
                {
                    if (validateEmailExistence())
                    {
                        String url = SaveImage(this.ImageUpload);
                        if (url != "Imagen grande")
                        {
                            string[] parametros =
                            {
                            "@Nombre",txtNombre.Text,
                            "@Apellido",txtApellido.Text,
                            "@Imagen", url,
                            "@Email",txtEmail.Text,
                            "@Contrasena",txtContrasena.Text,
                            "@FechaNacimiento",helper.dateFormat(txtFechaNacimiento.Text,"yyyy-dd-MM"),
                            "@Id_TipoSangre",ddlTipoSangre.SelectedValue,
                            "@NumeroTelefonico",txtTelefono.Text,
                            "@Id_TipoContacto",ddlTipoContacto.SelectedValue,
                            "@Id_Provincia",ddlProvincia.SelectedValue,
                            "@Id_Municipio",ddlMunicipio.SelectedValue
                            };
                            try
                            {
                                ManejadorData.Exec_Stp("spRegistrarDonanteReceptor", 'm', parametros);
                                // Validacion que eliminar imagen de session luego de registrar
                                Session["ImageUpload"] = null;
                                ScriptManager.RegisterStartupScript(this, this.GetType(), "saveFiledsSweetAlert", "swal('Registro hecho', 'Bienvenido, tu registro fue hecho exitosamente', 'success').then((value) => { window.location.href = '/Login.aspx'; })", true);
                            }
                            catch (Exception)
                            {
                                throw;
                            }
                        }
                        else
                        {
                            ScriptManager.RegisterStartupScript(this, this.GetType(), "imageTooBig", "swal('Error con imagen', 'La imagen es muy grande (debe ser igual o menor de 6 MB)', 'error')", true);
                        }
                    }
                    else
                    {
                        ScriptManager.RegisterStartupScript(this, this.GetType(), "emailAlreadyInUse", "swal('Error: Email ya existe', 'El correo electronico o email que fue ingresado está siendo utilizado por otro usuario', 'error')", true);
                    }
                }
                else if (hdnOpcion.Value == "ins")
                {
                    if (validateRNCExistence())
                    {
                        String url = SaveImage(this.ImageUpload);
                        if (url != "Imagen grande")
                        {
                            string[] parametros =
                            {
                            "@RNC",txtRNC.Text,
                            "@Nombre",txtNombre.Text,
                            "@Imagen", url,
                            "@Email",txtEmail.Text,
                            "@Contrasena",txtContrasena.Text,
                            "@NumeroTelefonico",txtTelefono.Text,
                            "@Id_TipoContacto",ddlTipoContacto.SelectedValue,
                            "@Id_Provincia",ddlProvincia.SelectedValue,
                            "@Id_Municipio",ddlMunicipio.SelectedValue
                            };
                            try
                            {
                                ManejadorData.Exec_Stp("spRegistrarInstitucion", 'm', parametros);
                                // Validacion que eliminar imagen de session luego de registrar
                                Session["ImageUpload"] = null;
                                ScriptManager.RegisterStartupScript(this, this.GetType(), "saveFiledsSweetAlert", "swal('Registro exitoso', 'Bienvenido, tu registro fue hecho exitosamente', 'success').then((value) => { window.location.href = '/Login.aspx'; })", true);
                            }
                            catch (Exception)
                            {
                                throw;
                            }
                        }
                        else
                        {
                            ScriptManager.RegisterStartupScript(this, this.GetType(), "imageTooBig", "swal('Error con imagen','La imagen es muy grande (debe ser igual o menor de 6 MB)', 'error')", true);
                        }
                    }
                    else
                    {
                        ScriptManager.RegisterStartupScript(this, this.GetType(), "rncAlreadyInUse", "swal('Error: RNC ya existe', 'El RNC que fue ingresado está siendo utilizado por otro usuario', 'error')", true);
                    }
                }
            }
            else
            {
                ScriptManager.RegisterStartupScript(this, this.GetType(), "emptyFieldsSweetAlert", "swal('Campos faltantes', 'En el fomulario existen campos vacios','error')", true);
            }
        }

        private string SaveImage(FileUpload imageUpload)
        {
            String FolderSaveurl = string.Empty;
            String DBUrl = string.Empty;
            if (imageUpload.HasFile)
            {
                // Byte limit size: 6 MB
                if (BitConverter.ToInt32(imageUpload.FileBytes, 0) <= 6291456)
                {
                    try
                    {
                        if (imageUpload.PostedFile.ContentType == "image/jpeg" || imageUpload.PostedFile.ContentType == "image/png"
                           || imageUpload.PostedFile.ContentType == "image/webp" || imageUpload.PostedFile.ContentType == "image/bmp"
                           || imageUpload.PostedFile.ContentType == "image/gif" || imageUpload.PostedFile.ContentType == "image/jpg")
                        {
                            string fileName = Path.GetFileName(imageUpload.FileName);
                            FolderSaveurl = Server.MapPath("Images/") + txtEmail.Text + "-" + fileName;
                            DBUrl = "../Images/" + txtEmail.Text + "-" + fileName;
                            imageUpload.SaveAs(FolderSaveurl);
                        }
                        else
                        {
                            return DBUrl;
                        }
                    }
                    catch (Exception ex)
                    {
                        throw ex;
                    }
                }
                else
                {
                    return "Imagen grande";
                }
            }
            return DBUrl;
        }

        private bool validateEmailExistence()
        {
            string[] emailValidation = { "@Email", txtEmail.Text };
            DataTable respuestaValidacion = ManejadorData.Exec_Stp("spValidateEmail", 's', emailValidation);
            if (Convert.ToInt32(respuestaValidacion.Rows[0].ItemArray[0]) != 0)
            {
                return false;
            }
            return true;
        }

        private bool validateRNCExistence()
        {
            string[] rncValidation = { "@Rnc", txtRNC.Text };
            DataTable respuestaValidacion = ManejadorData.Exec_Stp("spValidateRNC", 's', rncValidation);
            if (Convert.ToInt32(respuestaValidacion.Rows[0].ItemArray[0]) != 0)
            {
                return false;
            }
            return true;
        }
    }
}