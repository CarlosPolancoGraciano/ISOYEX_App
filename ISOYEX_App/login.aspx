<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Login.aspx.cs" Inherits="ISOYEX_App.login" %>
<asp:Content ID="LoginWebPage" ContentPlaceHolderID="MainContent" runat="server">
    <link href="Content/Website CSS/LoginView.css" rel="stylesheet" type="text/css"/>
    <div id="backgroundImage">
        <div class="row mt-5"></div>
        <div class="container p-4 mt-5">
            <div class="row justify-content-center">
                <div class="col-3"></div>
                <div class="col-5">
                    <div class="card">
                        <div class="card-body">
                            <div class="avatar">
                                <img src="Content/Imagenes/Avatar2_Login.png" class="rounded mx-auto d-block img-fluid" alt="Login de usuario" height="90" width="90" />
                            </div>
                            <h2 class="card-title text-center mt-3">Login</h2>
                            <div class="row">
                                <div class="col-2"></div>
                                <div class="form-group col-8">
                                    <asp:Label ID="labelEmail" runat="server" Text="Correo electrónico" AssociatedControlID="txtemail"></asp:Label>
                                    <asp:TextBox ID="txtemail" runat="server" CssClass="form-control" placeholder="Ingresar Correo Electrónico"></asp:TextBox>
                                </div>
                                <div class="col-2"></div>
                            </div>
                            <div class="row">
                                <div class="col-2"></div>
                                <div class="form-group col-8">
                                    <asp:Label ID="labelPassword" runat="server" Text="Contraseña" AssociatedControlID="txtemail"></asp:Label>
                                    <asp:TextBox ID="txtpassword" runat="server" TextMode="Password" CssClass="form-control" placeholder="Ingresar contraseña"></asp:TextBox>
                                </div>
                                <div class="col-2"></div>
                            </div>
                            <div class="row">
                                <div class="col-2"></div>
                                <div class="col-8">
                                    <div class="text-center">
                                        <asp:Button ID="btningresar" runat="server" Text="Iniciar sesión" CssClass="btn btn-wine-color btn-block" OnClick="btningresar_Click" />
                                        <asp:Panel Visible="false" class="form-group col-12 offset-3" ID="pnlError" runat="server">
                                            <small id="emailHelp" class="form-text text-muted" style="color: red !important;">Error en Email y/o Contraseña.</small>
                                        </asp:Panel>
                                    </div>
                                    <div class="mt-1 text-right">
                                        <asp:LinkButton ID="RegistrarmeBtn" CssClass="text-muted" runat="server" OnClick="RegistrarmeBtn_Click">Registrarme</asp:LinkButton>
                                    </div>
                                </div>
                                <div class="col-2"></div>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="col-4"></div>
            </div>
        </div>
        <div class="row mt-5"></div>
        <div class="row mt-5"></div>
        <div class="row mt-5"></div>
        <div class="row mt-5"></div>
        <div class="row mt-5"></div>
    </div>
</asp:Content>
