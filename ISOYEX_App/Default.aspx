<%@ Page Title="Home Page" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Default.aspx.cs" Inherits="ISOYEX_App._Default" %>

<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">

    <!-- Page Content -->
    <div class="container">

        <!-- Heading Row -->
        <div class="row my-4">
            <div class="col-lg-8">
                <img class="img-fluid rounded" src="http://placehold.it/900x400" alt="">
            </div>
            <!-- /.col-lg-8 -->
            <div class="col-lg-4">
                <h1>Business Name or Tagline</h1>
                <p>This is a template that is great for small businesses. It doesn't have too much fancy flare to it, but it makes a great use of the standard Bootstrap core components. Feel free to use this template for any project you want!</p>
                <a class="btn btn-wine-color btn-lg" href="#">Call to Action!</a>
            </div>
            <!-- /.col-md-4 -->
        </div>
        <!-- /.row -->
        <!-- Filter form -->
        <div class="card my-4 text-center">
            <div class="card-body">
                <div class="form-inline">
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
        <div class="row">
            <div class="col-md-4 mb-4">
                <div class="card h-100">
                    <div class="card-img-top">
                        <img class="img-fluid" src="http://placehold.it/900x400" alt="">
                    </div>
                    <div class="card-body">
                        <h2 class="card-title h2">Carlos Polanco</h2>
                        <h6 class="card-subtitle mb-2 text-muted">Tipo de sangre: A+</h6>
                        <p class="card-text">
                            <p class="h4">Contacto</p>
                            <ul class="list-unstyled">
                                <li><span class="text-muted h6">Personal</span>: 829-555-xxxx</li>
                                <li><span class="text-muted h6">Oficina</span>: 809-555-yxyx</li>
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
                            <p class="h4">Contacto</p>
                            <ul class="list-unstyled">
                                <li><span class="text-muted h6">Personal</span>: 829-555-xxxx</li>
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
                            <p class="h4">Contacto</p>
                            <ul class="list-unstyled">
                                <li><span class="text-muted h6">Personal</span>: 829-555-xxxx</li>
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
        <!-- /.row -->
    </div>
    <!-- /.container -->
</asp:Content>
