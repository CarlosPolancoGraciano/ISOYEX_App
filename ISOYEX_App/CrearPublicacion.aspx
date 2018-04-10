<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="CrearPublicacion.aspx.cs" Inherits="ISOYEX_App.Publicaciones" ValidateRequest="false" %>

<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">
    <link href="Content/Website CSS/LoginView.css" rel="stylesheet" type="text/css"/>
    <!-- Page Content -->
    <div id="backgroundImage">
        <div class="container p-5 mr">
            <div class="card my-5">
                <div class="card-body">
                    <div class="text-center">
                        <span class="display-4">Publicación para donantes</span>
                        <div class="text-center">
                            <p class="lead">Aquí puede publicar qué tipo de sangre busca para que los donantes puedan cooperar con la institución.</p>
                        </div>
                    </div>
                    <hr />
                    <div class="row mt-2">
                        <!-- Post Content Column -->
                        <div class="col-lg-12">
                            <div class="form-row ml-4">
                                <!-- Title -->
                                <div class="col-6 form-group">
                                    <asp:Label ID="txtTituloLabel" runat="server" CssClass="" Text="Titulo*" AssociatedControlID="txtTitulo"></asp:Label>
                                    <asp:TextBox ID="txtTitulo" placeholder="Ingresar Titulo de Publicación" CssClass="form-control" runat="server"></asp:TextBox>
                                </div>
                                <div class="col-6 form-group">
                                    <asp:Label ID="txtTipoSangreLabel" runat="server" Text="Tipo de Sangre*" AssociatedControlID="ddlTipoSangre"></asp:Label>
                                    <asp:DropDownList ID="ddlTipoSangre" CssClass="form-control ddl" runat="server"></asp:DropDownList>
                                </div>
                            </div>
                            <!-- WYSIWYG Form -->
                            <div class="my-4">
                                <label class="h5 text-muted">Contenido de la publicación*</label>
                                <textarea id="postEditor" name="postEditor" class="postEditor" runat="server"></textarea>
                            </div>
                            <!-- WYSIWYG Form -->
                            <div class="text-right">
                                <span class="text-muted">Todos los campos con <b>*</b> son requeridos</span>
                            </div>
                            <div class="text-center">
                                <asp:Button ID="btnSavePost" CssClass="btn btn-wine-color" runat="server" Text="Crear publicación" OnClick="btnSavePost_Click" />
                            </div>
                        </div>
                        <!-- /.row -->
                    </div>
                </div>
            </div>
            <!-- /.container -->
        </div>
    </div>
    <!-- Scripts -->
    <!-- Froala editor needed scripts -->
    <script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/codemirror/5.25.0/codemirror.min.js"></script>
    <script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/codemirror/5.25.0/mode/xml/xml.min.js"></script>
    <script type="text/javascript" src="Scripts/FroalaEditor/froala_editor.pkgd.min.js"></script>
    <!-- Froala editor needed scripts -->
    <script type="text/javascript">
        $(function () {
            $('.postEditor')
                .froalaEditor({
                    toolbarInline: false,
                    theme: 'gray',
                    zIndex: 2002
                });
        });
    </script>
</asp:Content>
