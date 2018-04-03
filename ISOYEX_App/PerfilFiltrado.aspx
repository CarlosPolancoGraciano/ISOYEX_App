<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="PerfilFiltrado.aspx.cs" Inherits="ISOYEX_App.PerfilFiltrado" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentHeader" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <div class="container-fluid">
        <div class="row mt-5"></div>
        <div class="row mt-5"></div>
        <div class="row mt-5"></div>
        <div class="container-fluid">
            <div class="row justify-content-center">
                <div class="col-md-8">
                    <div class="card">
                        <div class="card-body">
                            <div class="text-center">
                                <asp:Image ID="userProfilePicture" CssClass="img-fluid rounded-circle" Width="200" Height="200" runat="server" />
                            </div>
                            <div class="text-center mb-3">
                                <div class="mt-3">
                                    <span class="h3">Datos Personales</span>
                                </div>
                            </div>
                            <div class="row">
                                <div class="col-md-8">
                                    <asp:Label ID="txtNombreLabel" runat="server" Text=""></asp:Label>
                                </div>
                                <div class="col-md-2">
                                    <asp:Label ID="txtEdadLabel" runat="server" Text=""></asp:Label>
                                </div>
                                <div class="col-md-2">
                                    <asp:Label ID="ddlTipoSangreLabel" runat="server" Text=""></asp:Label>
                                </div>
                            </div>
                            <hr />
                            <div class="text-center mb-3">
                                <span class="h3">Datos de cuenta & dirección</span>
                            </div>
                            <div class="row">
                                <div class="col-md-6">
                                    <asp:Label ID="txtEmailLabel" runat="server" Text=""></asp:Label>
                                </div>
                            </div>
                            <div class="row">
                                <div class="col-md-6">
                                    <asp:Label ID="labelcontacto" runat="server" Text=""></asp:Label>
                                </div>
                                <div class="col-md-6">
                                    <asp:Label ID="labeltelefono" runat="server" Text=""></asp:Label>
                                </div>
                            </div>
                            <div class="row">
                                <div class="col-md-6">
                                    <asp:Label ID="ddlProvinciaLabel" runat="server" Text=""></asp:Label>
                                </div>
                                <div class="col-md-6">
                                    <asp:Label ID="ddlMunicipioLabel" runat="server" Text=""></asp:Label>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <div class="row mt-5"></div>
        <div class="row mt-5"></div>
        <div class="row mt-5"></div>
        <div class="row mt-5"></div>
        <div class="row mt-5"></div>
        <div class="row mt-5"></div>
        <div class="row mt-5"></div>
        <div class="row mt-4"></div>
    </div>
</asp:Content>
