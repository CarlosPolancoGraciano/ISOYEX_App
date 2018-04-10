<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Publicacion.aspx.cs" Inherits="ISOYEX_App.Publicacion" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentHeader" runat="server">
    <script src="Scripts/knockout-3.4.2.js"></script>
    <script src="Scripts/jquery-3.0.0.min.js"></script>
    <link href="Content/Website CSS/LoginView.css" rel="stylesheet" type="text/css" />
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <!-- Page Content -->
    <div id="backgroundImage">
        <div class="container mt-5">
            <div class="card">
                <div class="card-body">
                    <div class="row p-4">

                        <!-- Post Content Column -->
                        <div class="col-lg-8">

                            <!-- Title -->
                            <h1 class="mt-4" id="postTitle" runat="server"></h1>

                            <!-- Author -->
                            <p class="lead">
                                por
                            <label id="publishOwner" runat="server"></label>
                            </p>

                            <hr>

                            <!-- Date/Time -->
                            <p>Publicado el <span id="postDate" runat="server"></span> a las <span id="postHour" runat="server"></span></p>

                            <hr>
                            <!-- Post Content -->
                            <div class="fr-view" id="contentFroalaView" runat="server">
                            </div>

                            <hr>

                            <!-- Comments Form -->
                            <div class="card my-4" id="ableToCommentDiv" runat="server">
                                <h5 class="card-header">Responde la publicación</h5>
                                <div class="card-body">
                                    <div class="row">
                                        <div class="col-lg-6 border-right border-danger text-center">
                                            <div class="form-group">
                                                <textarea id="txtComentario" class="form-control" rows="3" runat="server"></textarea>
                                            </div>
                                            <div class="text-right">
                                                <asp:Button ID="btnGuardarComentario" CssClass="btn btn-wine-color" runat="server" Text="Comentar" OnClick="btnGuardarComentario_Click" />
                                            </div>
                                        </div>
                                        <div class="col-lg-6 text-center">
                                            <label>Respuestas rapidas</label>
                                            <div class="row mb-2">
                                                <div class="col-12">
                                                    <asp:Button ID="btnMensajeRapido1" CssClass="btn btn-outline-danger" runat="server" Text="Me ofrezco a donar" OnClick="btnMensajeRapido1_Click" />
                                                </div>
                                            </div>
                                            <div class="row">
                                                <div class="col-12">
                                                    <asp:Button ID="btnMensajeRapido2" CssClass="btn btn-outline-danger" runat="server" Text="Contactemé, puedo donar" OnClick="btnMensajeRapido2_Click" />
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <div id="noAbleToCommentDiv" runat="server">
                                <div class="card my-4">
                                    <h5 class="card-header">Responde la publicación</h5>
                                    <div class="card-body">
                                        <div class="row">
                                            <div class="col-lg-6 border-right border-danger text-center">
                                                <div class="form-group">
                                                    <textarea id="Textarea1" class="form-control" rows="3" runat="server"></textarea>
                                                </div>
                                                <div class="text-right">
                                                    <asp:Button ID="Button1" CssClass="btn btn-wine-color" runat="server" Text="Comentar" OnClick="btnGuardarComentario_Click" />
                                                </div>
                                            </div>
                                            <div class="col-lg-6 text-center">
                                                <label>Respuestas rapidas</label>
                                                <div class="row mb-2">
                                                    <div class="col-12">
                                                        <asp:Button ID="Button2" CssClass="btn btn-outline-danger" runat="server" Text="Me ofrezco a donar" OnClick="btnMensajeRapido1_Click" />
                                                    </div>
                                                </div>
                                                <div class="row">
                                                    <div class="col-12">
                                                        <asp:Button ID="Button3" CssClass="btn btn-outline-danger" runat="server" Text="Contactemé, puedo donar" OnClick="btnMensajeRapido2_Click" />
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <!-- Single Comment -->
                            <div id="UserListHasData">
                                <div class="row">
                                    <!-- ko foreach: paginated -->
                                    <div class="col-lg-12">
                                        <div class="card">
                                            <div class="card-body">
                                                <div class="media mb-4">
                                                    <a class="pointer" data-bind="click: function (data) { $root.sendToUserProfile($data.UsuarioId(), data) }">
                                                        <img class="d-flex mr-3 rounded-circle" width="50" height="50" data-bind="attr: { src: $data.UsuarioImagen, alt: $data.UsuarioNombre }">
                                                    </a>
                                                    <div class="media-body">
                                                        <div class="row">
                                                            <div class="col-md-4">
                                                                <h5 class="mt-0" data-bind="text: $data.UsuarioNombre"></h5>
                                                            </div>
                                                            <div class="col-md-4 offset-md-4" data-bind="if: $data.Deletable">
                                                                <button type="button" class="close" aria-label="Close" data-bind="click: function (data) { $root.deleteCommentById($data.ComentarioId(), data) }">
                                                                    <span aria-hidden="true" class="text-danger">&times;</span>
                                                                </button>
                                                            </div>
                                                        </div>
                                                        <span data-bind="text: $data.Contenido"></span>
                                                        <div class="text-left mt-2">
                                                            <span class="text-muted" data-bind="text: $data.Fecha"></span>
                                                        </div>
                                                    </div>
                                                </div>
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
                                                    <span class="h3 text-muted">No hay comentarios</span>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                <!-- /.row -->
                            </div>
                        </div>

                        <div class="mt-3"></div>
                        <!-- Sidebar Widgets Column -->
                        <div class="col-md-4 mt-5">
                            <!-- Search Widget -->
                            <div class="card my-4">
                                <div class="card-body">
                                    <div class="avatar">
                                        <asp:Image ID="postOwnerImage" CssClass="rounded-circle mx-auto d-block img-fluid" alt="Foto del publicador" Height="90" Width="90" runat="server" />
                                    </div>
                                    <div class="text-center">
                                        <span class="h3" id="nombreSpan" runat="server">Papito Plata</span>
                                    </div>
                                    <hr />
                                    <div class="mt-2">
                                        <h5 class="text-muted mb-3">Datos de publicador</h5>
                                        <span style="display: none;" class="postOwnerId" id="postOwnerId" runat="server"></span>
                                        <p><strong>Email: </strong><span id="emailSpan" runat="server"></span></p>
                                        <p><strong>Provincia: </strong><span id="provinciaSpan" runat="server"></span></p>
                                        <p><strong>Municipio: </strong><span id="MunicipioSpan" runat="server"></span></p>
                                        <div class="text-center">
                                            <asp:Button ID="btnEliminarPublicacion" CssClass="btn btn-wine-color" runat="server" Text="Eliminar publicación" OnClick="btnEliminarPublicacion_Click" />
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <span style="display: none;" class="currentUserIdSpan" id="currentUserIdSpan" runat="server"></span>
                    </div>
                </div>
            </div>
            <!-- /.row -->
        </div>
    </div>
    <!-- /.container -->
    <script>
        /*Knockout.js*/
        function HomeAppViewModel() {
            var self = this;
            /* BEGIN PAGINATOR */
            self.CommentsList = ko.observableArray([]);
            self.pageNumber = ko.observable(0);
            self.nbPerPage = 3;

	        self.totalPages = ko.computed(function() {
		        let div = Math.floor(self.CommentsList().length / self.nbPerPage);
		        div += self.CommentsList().length % self.nbPerPage > 0 ? 1 : 0;
		        return div - 1;
	        });
    
            self.paginated = ko.computed(function() {
                let first = self.pageNumber() * self.nbPerPage;
                return self.CommentsList.slice(first, first + self.nbPerPage);
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

            self.sendToUserProfile = function (usuarioId) {
                window.location.href = `/PerfilFiltrado.aspx?q=${usuarioId}`;
            }

            self.deleteCommentById = function (usuarioId) {
                $.ajax({
                    type: 'DELETE',
                    url: `api/PostComments/${usuarioId}`,
                    success: function (data) {
                        swal('Comentario eliminado!', '', 'success').then((value) => { window.location.reload() });
                    }
                });
            }

            self.GetComments = function (){
              $.ajax({
                dataType: "json",
                url: 'api/PostComments',
                  success: function (data) {
                      debugger;
                    if (data.length == 0) {
                        $("#UserListHasData").hide();
                        $("#UserListHasNoData").show();
                    } else {
                        $("#UserListHasNoData").hide();
                        $("#UserListHasData").show();
                    }
                    if (data.length != self.CommentsList().length) {
                        //Here you map and create a new instance of userDetailVM
                        self.CommentsList($.map(data, function (comment) {
                            return new FilteredUsersViewModel(comment);
                        }));
                    }
                }
              });
            }
           //call to get users list when the VM is loading or you can call it on any event on your model
           self.GetComments();
        }

        function FilteredUsersViewModel(data){
            var self = this;
            /* Set moment.js locale zone (es-do) Republica Dominicana */
            moment.locale('es-do');
            debugger;
            /* User Data */
            self.ComentarioId = ko.observable(data.ComentarioId);
            self.Contenido = ko.observable(data.Contenido);
            self.Fecha = ko.observable(moment(data.Fecha, "YYYYMMDD").fromNow());
            self.UsuarioId = ko.observable(data.UsuarioId)
            self.UsuarioNombre = ko.observable(data.UsuarioNombre);
            self.UsuarioApellido = ko.observable(data.UsuarioApellido);
            self.UsuarioImagen = ko.observable(data.UsuarioImagen);

            /* Display comment remove button */
            let currentUserId = parseInt($(".currentUserIdSpan").text());
            let postOwnerId = parseInt($(".postOwnerId").text());
            if (postOwnerId === currentUserId) {
                self.Deletable = ko.observable(true);
            } else if (currentUserId === data.UsuarioId) {
                self.Deletable = ko.observable(true);
            } else {
                self.Deletable = ko.observable(false);
            }
            
        }
        
        ko.applyBindings(new HomeAppViewModel());
    </script>
</asp:Content>
