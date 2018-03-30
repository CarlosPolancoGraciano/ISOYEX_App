<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="login.aspx.cs" Inherits="ISOYEX_App.login" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    
 
 <div class="form-box" id="login-box">
        <div class="header">Login</div>
       
            <div class="body bg-gray"> 
            <div class="form-group"> 
               <asp:TextBox ID="txtusuario" runat="server" CssClass="form-control" placeholder="Ingresar usuario"></asp:TextBox>
            </div>
            <div class="form-group">
                <asp:TextBox ID="txtpassword" runat="server" CssClass="form-control" placeholder="Ingresar contraseña"></asp:TextBox>
             </div>
            </div>
            <div class="footer">
                <asp:Button ID="btningresar" runat="server" Text="Iniciar Sesion" CssClass="btn bg-olive btn-block"/>
            </div>
    </div>



</asp:Content>
