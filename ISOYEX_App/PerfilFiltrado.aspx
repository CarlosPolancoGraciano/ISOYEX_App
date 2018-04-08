<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="PerfilFiltrado.aspx.cs" Inherits="ISOYEX_App.PerfilFiltrado" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentHeader" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <div class="container-fluid">
        <!-- User Details - START -->
        <div class="container" style="padding-top: 10%;">
            <div class="row">
                <div class="col-md-offset-2 col-md-8 col-lg-offset-3 col-lg-6">
                    <div class="well details">
                        <div class="col-sm-12">
                            <div class="col-xs-12 col-sm-8">
                                <asp:Label ID="txtNombreLabel" CssClass="h2" tyle="text-decoration: underline;" runat="server" Text=""></asp:Label>
                                <p><strong>Edad: </strong><asp:Label ID="txtEdadLabel" runat="server" Text=""></asp:Label> </p>
                                <p><strong>Tipo de sangre: </strong><asp:Label ID="ddlTipoSangreLabel" runat="server" Text=""></asp:Label> </p>
                                <p><strong>Email: </strong><asp:Label ID="txtEmailLabel" runat="server" Text=""></asp:Label> </p>
                                <p><strong>Tipo de contacto: </strong><asp:Label ID="labelcontacto" runat="server" Text=""></asp:Label></p>
                                <p><strong>Telefono: </strong><asp:Label ID="labeltelefono" runat="server" Text=""></asp:Label> </p>
                                <p><strong>Provincia: </strong><asp:Label ID="ddlProvinciaLabel" runat="server" Text=""></asp:Label> </p>
                                <p><strong>Municipio: </strong><asp:Label ID="ddlMunicipioLabel" runat="server" Text=""></asp:Label></p>
                            </div>
                            <div class="col-xs-12 col-sm-4 col-lg-1 text-center">
                                <figure>
                                    <asp:Image ID="userProfilePicture" CssClass="img-fluid rounded-circle"  style="width: 127px; padding-top: 20px;" runat="server" />
                                </figure>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <div class="row mt-5"></div>
        <div class="row mt-5"></div>
        <div class="row mt-5"></div>
        <link rel="stylesheet" type="text/css" href="http://www.shieldui.com/shared/components/latest/css/light/all.min.css" />
        <script type="text/javascript" src="http://www.shieldui.com/shared/components/latest/js/shieldui-all.min.js"></script>
    </div>
</asp:Content>
