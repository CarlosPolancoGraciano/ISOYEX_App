<%@ Page Title="Home Page" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Default.aspx.cs" Inherits="ISOYEX_App._Default" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentHeader" runat="server">
    <script src="Scripts/knockout-3.4.2.js"></script>
    <script src="Scripts/jquery-3.0.0.min.js"></script>
    <script>
        /*jQuery*/
       $(window).scroll(function () {
           if ($(window).scrollTop() >= 450) {
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
        </div>
        <!-- /.row -->
        <!-- Filter form -->
        <!-- Nav tabs -->
        <ul class="nav nav-tabs nav-justified justify-content-center" id="myTab" role="tablist">
            <li class="nav-item">
                <a class="nav-link text-danger active p-3" id="home-tab" data-toggle="tab" href="#home" role="tab" aria-controls="home" aria-selected="true">Filtrado de usuarios</a>
            </li>
            <li class="nav-item">
                <a class="nav-link text-danger p-3" id="profile-tab" data-toggle="tab" href="#profile" role="tab" aria-controls="profile" aria-selected="false">Publicaciones de instituciones</a>
            </li>
        </ul>
        <!-- Tab panes -->
        <div class="tab-content">
            <div class="tab-pane fade show active" id="home" role="tabpanel" aria-labelledby="home-tab">
                <div id="startchange">
                    <div class="p-3">
                        <div class="row">
                            <div class="col-2"></div>
                            <div class="col-8 text-justify p-2">
                                <div class="text-center">
                                    <h1 class="display-6">Uso filtro de donantes</h1>
                                </div>
                                <p class="lead">Puede realizar el filtrado seleccionando todos los campos (provincia, direccion y tipo de sangre) o seleccionando la direccion (provincia y municipio) o seleccionando el tipo de sangre.</p>
                            </div>
                            <div class="col-2"></div>
                        </div>
                    </div>
                </div>
                <div class="container">
                    <div class="row">
                        <div class="card mb-2 col-12 bg-light">
                            <div class="card-body text-center">
                                <div class="form-inline">
                                    <div class="form-group ml-2">
                                        <asp:Label ID="ProvinciaLabel" runat="server" CssClass="h6" Text="Provincia: " AssociatedControlID="ProvinciaDropDown"></asp:Label>
                                        <div class="ml-2">
                                            <asp:DropDownList ID="ProvinciaDropDown" CssClass="form-control" runat="server" AutoPostBack="True" OnSelectedIndexChanged="ddlProvincia_SelectedIndexChanged"></asp:DropDownList>
                                        </div>
                                    </div>
                                    <div class="form-group ml-2">
                                        <asp:Label ID="MunicipioLabel" runat="server" CssClass="h6" Text="Municipio: " AssociatedControlID="MunicipioDropDown"></asp:Label>
                                        <div class="ml-2">
                                            <asp:DropDownList ID="MunicipioDropDown" CssClass="form-control" runat="server"></asp:DropDownList>
                                        </div>
                                    </div>
                                    <div class="form-group ml-2">
                                        <asp:Label ID="TipoSangreLabel" runat="server" CssClass="h6" Text="Tipo de sangre: " AssociatedControlID="TipoSangreDropDown"></asp:Label>
                                        <div class="ml-2">
                                            <asp:DropDownList ID="TipoSangreDropDown" CssClass="form-control" runat="server"></asp:DropDownList>
                                        </div>
                                    </div>
                                    <div class="ml-4">
                                        <asp:Button ID="SearchButton" runat="server" Text="Buscar" CssClass="btn btn-wine-color btn-lg" OnClick="SearchButton_Click" />
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                    <!-- Content Row -->
                    <div id="UserListHasData">
                        <div class="text-center">
                            <span class="text-muted h4">Resultado de busqueda de filtrado</span>
                        </div>
                        <div class="row p-4">
                            <!-- ko foreach: paginated -->
                            <div class="col-md-4 mt-2">
                                <div class="card">
                                    <img class="img-fluid card-img-top" data-bind="attr: { src: $data.ImagenURL, alt: $data.Nombre }">
                                    <div class="card-body">
                                        <h2 class="card-title h2" data-bind="text: $data.Nombre"></h2>
                                        <h6 class="card-subtitle mb-2 text-muted">Tipo de sangre: <span class="text-muted" data-bind="text: $data.TipoSangre"></span></h6>
                                        <div class="card-text">
                                            <p class="h4">Dirección</p>
                                            <ul class="list-unstyled">
                                                <li><span class="text-muted h6">Provincia</span>: <span class="font-weight-bold" data-bind="text: $data.Provincia"></span></li>
                                                <li><span class="text-muted h6">Municipio</span>: <span class="font-weight-bold" data-bind="text: $data.Municipio"></span></li>
                                            </ul>
                                        </div>
                                    </div>
                                    <div class="card-footer text-center">
                                        <a class="btn btn-wine-color text-white" data-bind="click: function (data) { $root.checkProfileInformation($data.UserId(), data) }">Más información</a>
                                    </div>
                                </div>
                            </div>
                            <!-- /ko -->
                        </div>
                        <div class="mt-4">
                            <nav aria-label="Page navigation example">
                                <ul class="pagination pagination-lg justify-content-center">
                                    <li id="previousButton" class="page-item"><a class="page-link text-danger" data-bind="click: previous">&laquo;</a></li>
                                    <li class="page-item"><a class="page-link text-danger" data-bind="text: $root.pageNumber"></a></li>
                                    <li id="nextButton" class="page-item"><a class="page-link text-danger" data-bind="click: next">&raquo;</a></li>
                                </ul>
                            </nav>
                        </div>
                    </div>
                    <div class="container">
                        <div id="UserListHasNoData" class="bg-light mt-4 mb-4">
                            <div class="row">
                                <div class="col-12">
                                    <div class="p-4 m-4">
                                        <div class="text-center">
                                            <span class="h3 text-muted">No hay resultados encontrados</span>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <!-- /.row -->
                    </div>
                </div>
            </div>
            <div class="tab-pane fade" id="profile" role="tabpanel" aria-labelledby="profile-tab">
                <div class="container">
                    <div class="row">
                        <!-- Blog Entries Column -->
                        <div class="col-md-12">
                            <h2 class="my-4">Publicaciones
                               
                                <small class="text-muted">Hechas por instituciones</small>
                            </h2>
                            <!--
                            <div class="row">
                                <div class="card mb-2 col-12 bg-light">
                                    <div class="card-body text-center">
                                        <div class="form-inline">
                                            <div class="form-group ml-2">
                                                <asp:Label ID="PostProvinciaDropDownLabel" runat="server" CssClass="h6" Text="Provincia: " AssociatedControlID="ProvinciaDropDown"></asp:Label>
                                                <div class="ml-2">
                                                    <asp:DropDownList ID="PostProvinciaDropDown" CssClass="form-control" runat="server" AutoPostBack="True" OnSelectedIndexChanged="PostProvinciaDropDown_SelectedIndexChanged"></asp:DropDownList>
                                                </div>
                                            </div>
                                            <div class="form-group ml-2">
                                                <asp:Label ID="PostMunicipioDropDownLabel" runat="server" CssClass="h6" Text="Municipio: " AssociatedControlID="MunicipioDropDown"></asp:Label>
                                                <div class="ml-2">
                                                    <asp:DropDownList ID="PostMunicipioDropDown" CssClass="form-control" runat="server"></asp:DropDownList>
                                                </div>
                                            </div>
                                            <div class="form-group ml-2">
                                                <asp:Label ID="PostTipoSangreDropDownLabel" runat="server" CssClass="h6" Text="Tipo de sangre: " AssociatedControlID="TipoSangreDropDown"></asp:Label>
                                                <div class="ml-2">
                                                    <asp:DropDownList ID="PostTipoSangreDropDown" CssClass="form-control" runat="server"></asp:DropDownList>
                                                </div>
                                            </div>
                                            <div class="ml-4">
                                                <asp:Button ID="SearchPostButton" runat="server" Text="Buscar" CssClass="btn btn-wine-color btn-lg" OnClick="SearchPostButton_Click" />
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            -->
                            <!-- Blog Post -->
                            <div class="row">
                                <!-- ko foreach: paginatedPost -->
                                <div class="col-lg-12">
                                    <div class="card mb-4">
                                        <div class="card-body">
                                            <h2 class="card-title" data-bind="text: $data.PostTitulo"></h2>
                                            <p class="card-text">Se busca donante de tipo de sangre: <span data-bind="text: $data.PostBloodTypeSearched"></span></p>
                                            <a class="btn btn-wine-color text-white" data-bind="click: function (data) { $root.sendToPostPage($data.PostId(), data) }">Ver más &rarr;</a>
                                        </div>
                                        <div class="card-footer text-muted">
                                            Publicado <span data-bind="text: $data.PostFecha"></span> por

                                            <span data-bind="text: $data.PostOwnerName"></span>
                                        </div>
                                    </div>
                                </div>
                                <!-- /ko -->
                            </div>
                            <!-- Pagination -->
                            <div class="mt-4">
                                <nav aria-label="Page navigation example">
                                    <ul class="pagination pagination-lg justify-content-center">
                                        <li class="page-item"><a class="page-link text-danger" data-bind="click: postPrevious">&laquo;</a></li>
                                        <li class="page-item"><a class="page-link text-danger" data-bind="text: $root.pageNumber"></a></li>
                                        <li class="page-item"><a class="page-link text-danger" data-bind="click: postNext">&raquo;</a></li>
                                    </ul>
                                </nav>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <!-- /.container -->
    <script>
        /*Knockout.js*/
        function HomeAppViewModel() {
            var self = this;
            let PersistUsersList = [];

            /* BEGIN PAGINATOR */
            self.UsersList = ko.observableArray([]);
            self.PostsList = ko.observableArray([]);
            self.pageNumber = ko.observable(0);
            self.postPageNumber = ko.observable(0);
            self.nbPerPage = 6;

            /* UsersList paginator */
	        self.totalPages = ko.computed(function() {
		        let div = Math.floor(self.UsersList().length / self.nbPerPage);
		        div += self.UsersList().length % self.nbPerPage > 0 ? 1 : 0;
		        return div - 1;
	        });
    
            self.paginated = ko.computed(function() {
                let first = self.pageNumber() * self.nbPerPage;
                return self.UsersList.slice(first, first + self.nbPerPage);
            });
	        self.hasPrevious = ko.computed(function() {
		        return self.pageNumber() !== 0;
	        });
	        self.hasNext = ko.computed(function() {
		        return self.pageNumber() !== self.totalPages();
	        });
	        self.next = function() {
		        if(self.pageNumber() < self.totalPages()) {
			        self.pageNumber(self.pageNumber() + 1);
		        }
	        }
	
	        self.previous = function() {
		        if(self.pageNumber() != 0) {
			        self.pageNumber(self.pageNumber() - 1);
		        }
            }
            /* END PAGINATOR */

            self.checkProfileInformation = function(userId){
                window.location.href = `/PerfilFiltrado.aspx?q=${userId}`;
            }

            self.GetUsers = function (){
              $.ajax({
                dataType: "json",
                url: 'api/FilteredUsers',
                  success: function (data) {
                    if (data.length == 0) {
                        $("#UserListHasData").hide();
                        $("#UserListHasNoData").show();
                    } else {
                        $("#UserListHasNoData").hide();
                        $("#UserListHasData").show();
                    }
                    if (data.length != self.UsersList().length) {
                        //Here you map and create a new instance of userDetailVM
                        self.UsersList($.map(data, function (user) {
                            return new FilteredUsersViewModel(user);
                        }));
                    }
                }
              });
            }

            /* Post List */
            self.totalPostPages = ko.computed(function() {
		        let div = Math.floor(self.PostsList().length / self.nbPerPage);
		        div += self.PostsList().length % self.nbPerPage > 0 ? 1 : 0;
		        return div - 1;
	        });
            self.paginatedPost = ko.computed(function() {
                let first = self.postPageNumber() * self.nbPerPage;
                return self.PostsList.slice(first, first + self.nbPerPage);
            });
	        self.postHasPrevious = ko.computed(function() {
		        return self.postPageNumber() !== 0;
	        });
	        self.postHasNext = ko.computed(function() {
		        return self.postPageNumber() !== self.totalPostPages();
	        });
	        self.postNext = function() {
		        if(self.postPageNumber() < self.totalPostPages()) {
			        self.postPageNumber(self.postPageNumber() + 1);
		        }
	        }
	        self.postPrevious = function() {
		        if(self.postPageNumber() != 0) {
			        self.postPageNumber(self.postPageNumber() - 1);
		        }
            }

            self.sendToPostPage = function (postId) {
                debugger;
                window.location.href = `/Publicacion.aspx?q=${postId}`;
            }

            self.GetPosts = function (){
              $.ajax({
                dataType: "json",
                url: 'api/Post',
                  success: function (data) {
                    if (data.length != self.PostsList().length) {
                        //Here you map and create a new instance of userDetailVM
                        self.PostsList($.map(data, function (post) {
                            return new FilteredPostsViewModel(post);
                        }));
                    }
                }
              });
            }
           //call to get users list when the VM is loading or you can call it on any event on your model
            self.GetUsers();
            
            $("#profile-tab").click(function () {
                self.GetPosts();
            });
            
        }

        function FilteredUsersViewModel(data){
            var self = this;
            debugger;
            self.UserId = ko.observable(data.UserId);
            self.Nombre= ko.observable(data.Nombre);
            self.Apellido = ko.observable(data.Apellido);
            self.ImagenURL = ko.observable(data.ImagenURL);
            self.TipoSangre = ko.observable(data.TipoSangre);
            self.Provincia = ko.observable(data.Provincia);
            self.Municipio = ko.observable(data.Municipio);
        }

        function FilteredPostsViewModel(data){
            var self = this;
            debugger;
            /* Set moment.js locale zone (es-do) Republica Dominicana */
            moment.locale('es-do');

            self.PostId = ko.observable(data.PostId);
            self.PostTitulo = ko.observable(data.PostTitulo);
            self.PostContenido = ko.observable(data.PostContenido);
            self.PostFecha = ko.observable(moment(data.PostFecha, "YYYYMMDD").fromNow());
            self.PostOwnerName = ko.observable(data.PostOwnerName);
            self.PostBloodTypeSearched = ko.observable(data.PostBloodTypeSearched);
        }
        
        ko.applyBindings(new HomeAppViewModel());
    </script>
</asp:Content>
