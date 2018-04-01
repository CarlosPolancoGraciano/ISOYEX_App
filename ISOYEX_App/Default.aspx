<%@ Page Title="Home Page" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Default.aspx.cs" Inherits="ISOYEX_App._Default" %>

<asp:Content ID="ContentHeader" runat="server" ContentPlaceHolderID="ContentHeader">
    <!--
    <script src="Scripts/knockout-3.4.2.js" type="text/javascript"></script>
    <script src="Scripts/jquery-3.0.0.min.js" type="text/javascript"></script>
    <script type="text/javascript">
        var viewModel = {
                        employees: ko.observableArray([]),
                        }
        $(document).ready(function () {
            debugger;
            $.ajax({
                url: "api/Get",
                contentType: "application/json",
                type: "GET",
                success: function (data) {
                    $.each(data, function (index) {
                        console.log(data[index]);
                        /*viewModel.employees.push(ToKnockOutObservable(data[index]));*/
                     });
                    ko.applyBindings(viewModel);
                },
                error: function (data) {
                    alert("error occured");
                }
             });
        });
    </script>
    -->
</asp:Content>
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
                    <form>
                        <div class="form-inline">
                            <div class="form-group">
                                <asp:Label ID="ProvinciaLabel" runat="server" Text="Provincia: " AssociatedControlID="ddlProvincia"></asp:Label>
                                <div class="ml-2">
                                    <asp:DropDownList ID="ddlProvincia" CssClass="form-control" runat="server" ClientIDMode="Static" OnSelectedIndexChanged="ddlProvincia_SelectedIndexChanged" AutoPostBack="True"></asp:DropDownList>
                                </div>
                            </div>
                            <div class="form-group ml-2">
                                <asp:Label ID="MunicipioLabel" runat="server" Text="Municipio: " AssociatedControlID="ddlMunicipio"></asp:Label>
                                <div class="ml-2">
                                    <asp:DropDownList ID="ddlMunicipio" CssClass="form-control" runat="server" OnSelectedIndexChanged="ddlMunicipio_SelectedIndexChanged"></asp:DropDownList>
                                </div>
                            </div>
                            <div class="form-group ml-2">
                                <asp:Label ID="TipoSangreLabel" runat="server" Text="Tipo de sangre: " AssociatedControlID="ddlTipoSangre"></asp:Label>
                                <div class="ml-2">
                                    <asp:DropDownList ID="ddlTipoSangre" CssClass="form-control" runat="server"></asp:DropDownList>
                                </div>
                            </div>
                            <div class="ml-2">
                                <asp:Button ID="SearchButton" runat="server" Text="Buscar" CssClass="btn btn-wine-color" OnClick="SearchButton_Click" />
                            </div>
                        </div>
                    </form>
                </div>
            </div>
            <div class="container">
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
                                    <span></span>
                                    <p class="h4">Direccion</p>
                                    <ul class="list-unstyled">
                                        <li><span class="text-muted h6">Provincia</span>: Altagracia</li>
                                        <li><span class="text-muted h6">Municipio</span>: XXXXXXXXX</li>
                                    </ul>
                                </p>
                            </div>
                            <div class="card-footer text-center">
                                <a href="#" class="btn btn-wine-color">Más información</a>
                            </div>
                        </div>
                    </div>
            </div>
            <!-- Content Row -->
        <!-- /.row -->
    </div>
    <!-- /.container -->
</asp:Content>
