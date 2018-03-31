<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Login.aspx.cs" Inherits="ISOYEX_App.login" %>
<asp:Content ID="LoginWebPage" ContentPlaceHolderID="MainContent" runat="server">
    <form>
        <div class="container p-4 m-4">
            <div class="row justify-content-center">
                <div class="col-8">
                    <div class="card">
                      <div class="card-body">
                        <div class="avatar">
                            <img src="Content/Imagenes/Avatar2_Login.png" class="rounded mx-auto d-block img-fluid" alt="Login de usuario" height="90" width="90" />
                        </div>
                        <h2 class="card-title text-center mt-3">Login</h2>
                        <div class="row"> 
                            <div class="form-group col-12 offset-3"> 
                                <asp:Label ID="labelEmail" runat="server" Text="Correo electrónico" AssociatedControlID="txtemail"></asp:Label>
                                <asp:TextBox ID="txtemail" runat="server" CssClass="form-control" placeholder="Ingresar Correo Electrónico"></asp:TextBox>
                            </div>
                         </div>
                         <div class="row">
                            <div class="form-group col-12 offset-3">
                                <asp:Label ID="labelPassword" runat="server" Text="Contraseña" AssociatedControlID="txtemail"></asp:Label>
                                <asp:TextBox ID="txtpassword" runat="server" TextMode="Password" CssClass="form-control" placeholder="Ingresar contraseña"></asp:TextBox>
                            </div>
                         </div>
                         <div class="text-center">
                            <asp:Button ID="btningresar" runat="server" Text="Iniciar Sesión" CssClass="btn btn-login-color btn-lg"/>
                         </div>
                      </div>
                    </div>
                </div>
            </div>
        </div>
    </form>
</asp:Content>
