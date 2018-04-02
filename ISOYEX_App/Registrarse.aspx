<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Registrarse.aspx.cs" Inherits="ISOYEX_App.Registrarse" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentHeader" runat="server">
    <script>
        $(document).ready(function () {

            $(".AllControl").hide();

            /*jQuery for input file*/
            $("input[type=file]").change(function () {
                //debugger;
                let filename = $('input[type=file]').val().split('\\').pop();
                //console.log(filename);
                $("#MainContent_ImageUploadLabel").text(filename);
            });

            $('input[type=radio][name=options]').change(function () {
                $("#hdnOpcion").val(this.value);
                $(".AllControl").show();
                if (this.value == 'ind') {

                    ResetControls();
                    $("#txtPrueba").text('HOla');
                    $(".form-group").show();
                    $(".VisiInst").hide();
                }
                else if (this.value == 'ins') {
                    ResetControls();
                    $(".form-group").show();
                    $(".VisiIndi").hide();
                }
            });
            

            if ($("#hdnOpcion").val() == 'ind') {
                $(".AllControl").show();
                $(".form-group").show();
                $(".VisiInst").hide();
            }
            else if ($("#hdnOpcion").val() == 'ins') {
                $(".AllControl").show();
                $(".form-group").show();
                $(".VisiIndi").hide();
            }
            
            function ResetControls() {
                $(".txt").val("");
                $(".ddl").val('');
            }
            
        });

        function soloNumeros(e) {
            var key = window.Event ? e.which : e.keyCode
            return (key >= 48 && key <= 57)
        }
        
    </script>

</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <div class="container">
        <div class="card p-3 m-3">
            <div class="card-body ml-2">
                <div class="p-1 m-1 text-center">
                    <h1 class="display-4">Registro de usuarios</h1>
                    <div class="btn-group btn-group-toggle" data-toggle="buttons">
                        <label class="btn btn-outline-danger active">
                            <input type="radio" name="options" class="radio" value="ind">
                            Donante
                        </label>
                        <label class="btn btn-outline-danger">
                            <input type="radio" name="options" class="radio" value="ins">
                            Institución
                        </label>
                    </div>
                </div>
                <hr />
                <div class="container-fluid AllControl">
                    <div class="text-center">
                        <span class="h4 text-muted">Completa el siguiente formulario</span>
                    </div>
                    <div class="row">
                        <div class="form-group col-md-6">
                            <asp:Label ID="txtNombreLabel" runat="server" Text="Nombre" AssociatedControlID="txtNombre"></asp:Label>
                            <asp:TextBox ID="txtNombre" CssClass="form-control txt" runat="server"></asp:TextBox>
                        </div>
                        <div class="form-group col-md-6">
                            <div class="VisiInst">
                                <asp:Label ID="txtRNCLabel" runat="server" Text="RNC" AssociatedControlID="txtRNC"></asp:Label>
                                <asp:TextBox ID="txtRNC" onKeyPress="return soloNumeros(event)" class="form-control txt" runat="server"></asp:TextBox>
                            </div>
                            <div class="VisiIndi">
                                <asp:Label ID="txtApellidoLabel" runat="server" Text="Apellido" AssociatedControlID="txtApellido"></asp:Label>
                                <asp:TextBox ID="txtApellido" CssClass="form-control txt" runat="server"></asp:TextBox>
                            </div>
                        </div>
                    </div>
                    <div class="row">
                        <div class="form-group col-md-4">
                            <label>Foto de perfil</label>
                            <div class="custom-file">
                                <asp:Label ID="ImageUploadLabel" runat="server" CssClass="custom-file-label" AssociatedControlID="ImageUpload"></asp:Label>
                                <asp:FileUpload ID="ImageUpload" CssClass="custom-file-input" runat="server" />
                            </div>
                        </div>
                        <div class="col-2"></div>
                        <div class="form-group col-md-6 VisiIndi">
                            <asp:Label ID="txtFechaNacimientoLabel" runat="server" Text="Fecha Nacimiento" AssociatedControlID="txtFechaNacimiento"></asp:Label>
                            <asp:TextBox ID="txtFechaNacimiento" TextMode="Date" CssClass="form-control txt" runat="server"></asp:TextBox>
                        </div>
                    </div>
                    <div class="row">
                        <div class="form-group col-md-6 VisiIndi">
                            <asp:Label ID="TipoSangreLabel" runat="server" Text="Tipo de Sangre" AssociatedControlID="ddlTipoSangre"></asp:Label>
                            <asp:DropDownList ID="ddlTipoSangre" CssClass="form-control ddl" runat="server"></asp:DropDownList>
                        </div>
                        <div class="form-group col-md-6">
                            <asp:Label ID="txtEmailLabel" runat="server" Text="Email" AssociatedControlID="txtEmail"></asp:Label>
                            <asp:TextBox ID="txtEmail" TextMode="Email" CssClass="form-control txt" runat="server"></asp:TextBox>
                        </div>
                    </div>
                    <div class="row">
                        <div class="form-group col-md-6">
                            <asp:Label ID="ddlTipoContactoLabel" runat="server" Text="Tipo de Contacto" AssociatedControlID="ddlTipoContacto"></asp:Label>
                            <asp:DropDownList ID="ddlTipoContacto" CssClass="form-control ddl" runat="server"></asp:DropDownList>
                        </div>
                        <div class="form-group col-md-6">
                            <asp:Label ID="txtTelefonoLabel" runat="server" Text="No. Telefono" AssociatedControlID="txtTelefono"></asp:Label>
                            <asp:TextBox ID="txtTelefono" TextMode="Phone" onKeyPress="return soloNumeros(event)" CssClass="form-control txt" runat="server"></asp:TextBox>
                        </div>
                    </div>
                    <div class="row">
                        <div class="form-group col-md-6">
                            <asp:Label ID="ddlProvinciaLabel" runat="server" Text="Provincia" AssociatedControlID="ddlProvincia"></asp:Label>
                            <asp:DropDownList ID="ddlProvincia" ClientIDMode="Static" CssClass="form-control ddl" runat="server" AutoPostBack="True" OnSelectedIndexChanged="ddlProvincia_SelectedIndexChanged"></asp:DropDownList>
                        </div>
                        <div class="form-group col-md-6">
                            <asp:Label ID="ddlMunicipioLabel" runat="server" Text="Municipio" AssociatedControlID="ddlMunicipio"></asp:Label>
                            <asp:DropDownList ID="ddlMunicipio" CssClass="form-control" runat="server"></asp:DropDownList>
                        </div>
                    </div>
                    <div class="row">
                        <div class="form-group col-md-6">
                            <asp:Label ID="txtContrasenaLabel" runat="server" Text="Contraseña" AssociatedControlID="txtContrasena"></asp:Label>
                            <asp:TextBox ID="txtContrasena" TextMode="Password" CssClass="form-control txt" runat="server"></asp:TextBox>
                        </div>
                        <div class="form-group col-md-6">
                            <asp:Label ID="txtConfContrasenaLabel" runat="server" Text="Confirmar Contraseña" AssociatedControlID="txtConfContrasena"></asp:Label>
                            <asp:TextBox ID="txtConfContrasena" TextMode="Password" CssClass="form-control txt" runat="server"></asp:TextBox>
                        </div>
                    </div>
                    <div class="text-center mx-auto">
                        <asp:Button ID="btnRegistrarse" CssClass="btn btn-success AllControl" runat="server" Text="Registrarme" OnClick="btnRegistrarse_Click" />
                        <asp:HiddenField ID="hdnOpcion" ClientIDMode="Static" Value="ind" runat="server" />
                    </div>
                </div>
            </div>
        </div>
    </div>
</asp:Content>
