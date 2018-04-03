<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Perfil.aspx.cs" Inherits="ISOYEX_App.perfil" %>
<asp:Content ID="PerfilWebPage" ContentPlaceHolderID="MainContent" runat="server">
    <div class="container-fluid p-4 mt-4">
        <div class="row justify-content-center">
            <div class="col-8">
                <div class="card">
                    <div class="card-body">
                        <div class="text-center mb-3">
                            <span class="h3">Datos Personales</span>
                        </div>
                        <div class="row">
                            <div class="form-group col-md-6">
                                <asp:Label ID="txtNombreLabel" runat="server" Text="Nombre" AssociatedControlID="txtNombre"></asp:Label>
                                <asp:TextBox ID="txtNombre"  Enabled="false" placeholder="Ingresar Nombre" CssClass="form-control" runat="server"></asp:TextBox>
                            </div>
                            <div class="form-group col-md-6 ">
                                <asp:Label ID="txtApellidoLabel" runat="server" Text="Apellido" AssociatedControlID="txtApellido"></asp:Label>
                                <asp:TextBox ID="txtApellido"  Enabled="false" placeholder="Ingresar Apellido" CssClass="form-control" runat="server"></asp:TextBox>
                            </div>
                        </div>
                        <div class="row">
                            <div class="form-group col-md-6">
                                <asp:Label ID="txtFechaNacimientoLabel" runat="server" Text="Fecha de Nacimiento" AssociatedControlID="txtFechaNacimiento"></asp:Label>
                                <asp:TextBox ID="txtFechaNacimiento"  Enabled="false" placeholder="Ingresar fecha de nacimiento" CssClass="form-control" runat="server"></asp:TextBox>
                            </div>
                            <div class="form-group col-md-6">
                                <asp:Label ID="ddlTipoSangreLabel" runat="server" Text="Tipo de Sangre" AssociatedControlID="ddlTipoSangre"></asp:Label>
                                <asp:DropDownList ID="ddlTipoSangre"  Enabled="false" CssClass="form-control" runat="server"></asp:DropDownList>
                            </div>
                        </div>
                        <hr />
                        <div class="text-center mb-3">
                            <span class="h3">Datos de cuenta & dirección</span>
                        </div>
                        <div class="row">
                            <div class="form-group col-md-6">
                                <asp:Label ID="txtEmailLabel" runat="server" Text="Correo electrónico" AssociatedControlID="txtEmail"></asp:Label>
                                <asp:TextBox ID="txtEmail" runat="server" Enabled="false" CssClass="form-control" placeholder="Ingresar Correo Electrónico"></asp:TextBox>
                            </div>
                        </div>
                        <div class="row">
                            <div class="form-group col-md-6">
                                <asp:Label ID="txtPasswordLabel" runat="server" Text="Nueva Contraseña" AssociatedControlID="txtPassword"></asp:Label>
                                <asp:TextBox ID="txtPassword" runat="server" TextMode="Password" CssClass="form-control" placeholder="Ingresar nueva contraseña"></asp:TextBox>
                            </div>
                            <div class="form-group col-md-6">
                                <asp:Label ID="txtConfContrasenaLabel" runat="server" Text="Repite Nueva Contraseña" AssociatedControlID="txtConfContrasena"></asp:Label>
                                <asp:TextBox ID="txtConfContrasena" runat="server" CssClass="form-control" placeholder="Repite Nueva Contraseña"></asp:TextBox>
                            </div>
                        </div>
                        <div class="row">
                            <div class="form-group col-md-6">
                                <asp:Label ID="labelcontacto" runat="server" Text="Tipo de contacto" AssociatedControlID="ddlTipoContacto"></asp:Label>
                                <asp:DropDownList ID="ddlTipoContacto" runat="server" CssClass="form-control"></asp:DropDownList>
                            </div>
                            <div class="form-group col-md-6">
                                <asp:Label ID="labeltelefono" runat="server" Text="Numero Telefonico"></asp:Label>
                                <asp:TextBox ID="txtTelefono" runat="server" CssClass="form-control" placeholder="Ingresar Numero Telefonico"></asp:TextBox>
                            </div>
                        </div>
                        <div class="row">
                            <div class="form-group col-md-6">
                                <asp:Label ID="ddlProvinciaLabel" runat="server" Text="Provincia"></asp:Label>
                                <asp:DropDownList ID="ddlProvincia" runat="server" CssClass="form-control" OnSelectedIndexChanged="ddlProvincia_SelectedIndexChanged" AutoPostBack="True"></asp:DropDownList>
                            </div>
                            <div class="form-group col-md-6">
                                <asp:Label ID="ddlMunicipioLabel" runat="server" Text="Municipio"></asp:Label>
                                <asp:DropDownList ID="ddlMunicipio" runat="server" CssClass="form-control"></asp:DropDownList>
                            </div>
                        </div>
                        <div class="text-center mt-2">
                            <div class="" role="group">
                                <asp:Button ID="btnModificar" Text="Modificar" CssClass="btn btn-warning" runat="server" OnClick="btnModificar_Click" />
                                <asp:Button ID="btnSaveChanges"  Text="Guardar" Visible="false" CssClass="btn btn-success" runat="server"  OnClick="btnSaveChanges_Click" />
                                <asp:Button ID="btnCancelar" Text="Cancelar" Visible="false" CssClass="btn btn-wine-color" runat="server" OnClick="btnCancelar_Click"/>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</asp:Content>
