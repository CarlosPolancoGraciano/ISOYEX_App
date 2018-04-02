<%@ Page Title="Home Page" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Default.aspx.cs" Inherits="ISOYEX_App._Default" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentHeader" runat="server">
    <script src="Scripts/jquery-3.0.0.min.js"></script>
    <script>
       $(window).scroll(function () {
           if ($(window).scrollTop() >= 500) {
               $('.navbar').removeClass('navbar-color');
               $('.navbar').addClass('red-custom');
           } else {
               $('.navbar').removeClass('red-custom');
               $('.navbar').addClass('navbar-color');
            }
        });
    </script>
</asp:Content>
<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">
    <link href="Content/Website CSS/DefaultView.css" rel="stylesheet" type="text/css"/>

    <!-- Page Content -->
    <div class="container-fluid no-padding">
        <div class="hero-section text-white">
            <div class="hero-section-text">
                <h1 class="display-4">Hello, world!</h1>
                <p class="lead">This is a simple hero unit, a simple Hero-style component for calling extra attention to featured content or information.</p>
            </div>
        </div>
       <!-- /.row -->
       <!-- Filter form -->
        <div id="startchange">
            <div class="p-5">
                <div class="card my-4 text-center p-4">
                    <div class="card-body">
                        <div class="form-inline">
                            <div class="hero-section-text">
                            <h2 class="display-4">Uso filtro de donantes.</h2>
                            <p class="lead"> Puede realizar el filtrado seleccionando todos los campos (provincia, direccion y tipo de sangre) o seleccionando la direccion (provincia y municipio) o seleccionando el tipo de sangre.</p>
                           </div>
                            <div class="form-group">
                                <asp:Label ID="ProvinciaLabel" runat="server" Text="Provincia: " AssociatedControlID="ProvinciaDropDown"></asp:Label>
                                <div class="ml-4">
                                    <asp:DropDownList ID="ProvinciaDropDown" CssClass="form-control form-control-lg" runat="server"></asp:DropDownList>
                                </div>
                            </div>
                            <div class="form-group ml-4">
                                <asp:Label ID="MunicipioLabel" runat="server" Text="Municipio: " AssociatedControlID="MunicipioDropDown"></asp:Label>
                                <div class="ml-4">
                                    <asp:DropDownList ID="MunicipioDropDown" CssClass="form-control form-control-lg" runat="server"></asp:DropDownList>
                                </div>
                            </div>
                            <div class="form-group ml-4">
                                <asp:Label ID="TipoSangreLabel" runat="server" Text="Tipo de sangre: " AssociatedControlID="TipoSangreDropDown"></asp:Label>
                                <div class="ml-4">
                                    <asp:DropDownList ID="TipoSangreDropDown" CssClass="form-control form-control-lg" runat="server"></asp:DropDownList>
                                </div>
                            </div>
                            <div class="ml-4">
                                <asp:Button ID="SearchButton" runat="server" Text="Buscar" CssClass="btn btn-wine-color btn-lg" />
                            </div>
                        </div>
                    </div>
                </div>

                <!-- Content Row -->
                <div class="row p-4">
                    <div class="col-md-4 mb-4">
                        <div class="card h-100">
                            <div class="card-img-top">
                                <img class="img-fluid" src="http://placehold.it/900x400" alt="">
                            </div>
                            <div class="card-body">
                                <h2 class="card-title h2">Carlos Polanco</h2>
                                <h6 class="card-subtitle mb-2 text-muted">Tipo de sangre: A+</h6>
                                <p class="card-text">
                                    <p class="h4">Dirección</p>
                                    <ul class="list-unstyled">
                                        <li><span class="text-muted h6">Provincia</span>: XXXXXXXXXXXX</li>
                                        <li><span class="text-muted h6">Municipio</span>: XXXXXXXXXXXX</li>
                                    </ul>
                                </p>
                            </div>
                            <div class="card-footer text-center">
                                <a href="#" class="btn btn-wine-color">Más información</a>
                            </div>
                        </div>
                    </div>
                    <!-- /.col-md-4 -->
                    <div class="col-md-4 mb-4">
                        <div class="card h-100">
                            <div class="card-img-top">
                                <img class="img-fluid" src="http://placehold.it/900x400" alt="">
                            </div>
                            <div class="card-body">
                                <h2 class="card-title">Fidel Acosta</h2>
                                <h6 class="card-subtitle mb-2 text-muted">Tipo de sangre: O+</h6>
                                <p class="card-text">
                                    <p class="h4">Dirección</p>
                                    <ul class="list-unstyled">
                                        <li><span class="text-muted h6">Provincia</span>: XXXXXXXXXXXX</li>
                                        <li><span class="text-muted h6">Municipio</span>: XXXXXXXXXXXX</li>
                                    </ul>
                                </p>
                            </div>
                            <div class="card-footer text-center">
                                <a href="#" class="btn btn-wine-color">Más información</a>
                            </div>
                        </div>
                    </div>
                    <!-- /.col-md-4 -->
                    <div class="col-md-4 mb-4">
                        <div class="card h-100">
                            <div class="card-img-top">
                                <img class="img-fluid" src="http://placehold.it/900x400" alt="">
                            </div>
                            <div class="card-body">
                                <h2 class="card-title">Maikel Cuevas</h2>
                                <h6 class="card-subtitle mb-2 text-muted">Tipo de sangre: AB+</h6>
                                <p class="card-text">
                                    <p class="h4">Dirección</p>
                                    <ul class="list-unstyled">
                                        <li><span class="text-muted h6">Provincia</span>: XXXXXXXXXXXX</li>
                                        <li><span class="text-muted h6">Municipio</span>: XXXXXXXXXXXX</li>
                                    </ul>
                                </p>
                            </div>
                            <div class="card-footer text-center">
                                <a href="#" class="btn btn-wine-color">Más información</a>
                            </div>
                        </div>
                    </div>
                    <!-- /.col-md-4 -->
                </div>
            </div>
        </div>
       <!-- /.row -->
    </div>
    <!-- /.container -->
</asp:Content>
