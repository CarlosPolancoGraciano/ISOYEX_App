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
                $('input[type=radio][name=options]').val("ind");
                $('input[type=radio][name=options]').addClass('active');
            }
            else if ($("#hdnOpcion").val() == 'ins') {
                $(".AllControl").show();
                $('input[type=radio][name=options]').val("ins");
                $('input[type=radio][name=options]').addClass('active');
            }

            
            function ResetControls() {
                $(".txt").val("");
                $(".ddl").val('');
            }
        });

        
    </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <form>
        <div class="form-group">
            
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
        <div class="AllControl">
            <div class="form-group VisiInst">
                <label>RNC</label>
                <asp:TextBox ID="txtRNC" class="form-control txt" runat="server"></asp:TextBox>
            </div>
            <div class="form-group">
                <label>Nombre</label>
                <asp:TextBox ID="txtNombre" class="form-control txt" runat="server"></asp:TextBox>
            </div>
            <div class="form-group VisiIndi">
                <label>Apellido</label>
                <asp:TextBox ID="txtApellido" class="form-control txt" runat="server"></asp:TextBox>
            </div>
            <div class="form-group VisiIndi">
                <label>Fecha Nacimiento</label>
                <asp:TextBox ID="txtFechaNacimiento" class="form-control txt" runat="server"></asp:TextBox>
            </div>
            <div class="form-group VisiIndi">
                <label>Tipo de Sangre</label>
                <asp:DropDownList ID="ddlTipoSangre" class="form-control ddl" runat="server"></asp:DropDownList>
            </div>
            <div class="form-group ">
                <label>Email</label>
                <asp:TextBox ID="txtEmail" class="form-control txt" runat="server"></asp:TextBox>
            </div>
            <div class="form-group ">
                <label>Tipo de Contacto</label>
                <asp:DropDownList ID="ddlTipoContacto" class="form-control ddl" runat="server"></asp:DropDownList>
            </div>
            <div class="form-group">
                <label>No. Telefono</label>
                <asp:TextBox ID="txtTelefono" class="form-control txt" runat="server"></asp:TextBox>
            </div>
            <div class="form-group ">
                <label>Provincia</label>
                <asp:DropDownList ID="ddlProvincia" ClientIDMode="Static" class="form-control ddl" runat="server" AutoPostBack="True" OnSelectedIndexChanged="ddlProvincia_SelectedIndexChanged"></asp:DropDownList>
            </div>
            <div class="form-group">
                <label>Municipio</label>
                <asp:DropDownList ID="ddlMunicipio" class="form-control" runat="server"></asp:DropDownList>
            </div>
            <div class="form-group">
                <label>Contraseña</label>
                <asp:TextBox ID="txtContrasena" class="form-control txt" runat="server"></asp:TextBox>
            </div>
            <div class="form-group">
                <label>Confirmar Contraseña</label>
                <asp:TextBox ID="txtConfContrasena" class="form-control txt" runat="server"></asp:TextBox>
            </div>
        </div>

        <asp:Button ID="btnRegistrarse" class="btn btn-success AllControl" runat="server" Text="Button" OnClick="btnRegistrarse_Click" />
        <asp:HiddenField ID="hdnOpcion" ClientIDMode="Static" Value="" runat="server" />
    </form>
</asp:Content>
