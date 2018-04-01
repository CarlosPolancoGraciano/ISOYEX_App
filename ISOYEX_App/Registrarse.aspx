<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Registrarse.aspx.cs" Inherits="ISOYEX_App.Registrarse" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentHeader" runat="server">
    <script>
        $(document).ready(function () {

            $(".AllControl").hide();

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
    <form>
            <div class="p-4 m-4">
                <div>
                    <label>Tipo de Registro</label>
                </div>
                <div class="btn-group btn-group-toggle" data-toggle="buttons">
                    <label class="btn btn-light">
                        <input type="radio" name="options" value="ind">
                        Individuo
                    </label>
                    <label class="btn btn-light">
                        <input type="radio" name="options" value="ins">
                        Institución
                    </label>
                </div>
            </div>
            <div class="card p-5">
                <div class="card-body">
                    <div class="container AllControl">
                        <div class="row">
                            <div class="form-group col-md-6">
                                <label for="txtNombre">Nombre</label>
                                <asp:TextBox ID="txtNombre" class="form-control txt" runat="server"></asp:TextBox>
                            </div>
                            <div class="form-group col-md-6 VisiIndi">
                                <label for="txtApellido">Apellido</label>
                                <asp:TextBox ID="txtApellido" class="form-control txt" runat="server"></asp:TextBox>
                            </div>
                        </div>
                        <div class="row">
                            <div class="form-group col-md-4 VisiInst">
                                <label for="txtRNC">RNC</label>
                                <asp:TextBox ID="txtRNC" onKeyPress="return soloNumeros(event)" class="form-control txt" runat="server"></asp:TextBox>
                            </div>
                            <div class="form-group col-md-6">
                                    <label for="ImageUpload">Imagen de perfil</label>
                                    <asp:FileUpload ID="ImageUpload" CssClass="form-control" runat="server" />
                                 </div>
                            <div class="form-group col-md-6 VisiIndi">
                                <label for="txtFechaNacimiento">Fecha Nacimiento</label>
                                <asp:TextBox ID="txtFechaNacimiento" TextMode="Date" class="form-control txt" runat="server"></asp:TextBox>
                            </div>
                        </div>
                        <div class="row">
                            <div class="form-group col-md-6 VisiIndi">
                                <label for="ddlTipoSangre">Tipo de Sangre</label>
                                <asp:DropDownList ID="ddlTipoSangre" class="form-control ddl" runat="server"></asp:DropDownList>
                            </div>
                            <div class="form-group col-md-6">
                                <label for="txtEmail">Email</label>
                                <asp:TextBox ID="txtEmail" TextMode="Email" class="form-control txt" runat="server"></asp:TextBox>
                            </div>
                        </div>
                        <div class="row">
                            <div class="form-group col-md-6">
                                <label for="ddlTipoContacto">Tipo de Contacto</label>
                                <asp:DropDownList ID="ddlTipoContacto" class="form-control ddl" runat="server"></asp:DropDownList>
                            </div>
                            <div class="form-group col-md-6">
                                <label for="txtTelefono">No. Telefono</label>
                                <asp:TextBox ID="txtTelefono" onKeyPress="return soloNumeros(event)" class="form-control txt" runat="server"></asp:TextBox>
                            </div>
                        </div>
                        <div class="row">
                            <div class="form-group col-md-6">
                                <label for="ddlProvincia">Provincia</label>
                                <asp:DropDownList ID="ddlProvincia" ClientIDMode="Static" class="form-control ddl" runat="server" AutoPostBack="True" OnSelectedIndexChanged="ddlProvincia_SelectedIndexChanged"></asp:DropDownList>
                            </div>
                            <div class="form-group col-md-6">
                                <label for="ddlMunicipio">Municipio</label>
                                <asp:DropDownList ID="ddlMunicipio" class="form-control" runat="server"></asp:DropDownList>
                            </div>
                        </div>
                        <div class="row">
                            <div class="form-group col-md-6">
                                <label for="txtContrasena">Contraseña</label>
                                <asp:TextBox ID="txtContrasena" class="form-control txt" runat="server"></asp:TextBox>
                            </div>
                            <div class="form-group col-md-6">
                                <label for="txtConfContrasena">Confirmar Contraseña</label>
                                <asp:TextBox ID="txtConfContrasena" class="form-control txt" runat="server"></asp:TextBox>
                            </div>
                        </div>
                        <div class="row text-center col-md-6">
                            <asp:Button ID="btnRegistrarse" class="btn btn-success AllControl" runat="server" Text="Button" OnClick="btnRegistrarse_Click" />
                            <asp:HiddenField ID="hdnOpcion" ClientIDMode="Static" Value="" runat="server" />
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </form>
</asp:Content>
