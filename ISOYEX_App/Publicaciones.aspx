<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Publicaciones.aspx.cs" Inherits="ISOYEX_App.Publicaciones" %>

<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">
    <div class="row mt-5"></div>
    <div class="container p-4 mt-5">
        <div class="row justify-content-center">
            <div class="col-3"></div>
          <div class="col-5">
              <div class="card">
                  <div class="card-body">
                      <div class="text-center mb-3">
                          <span class="h3">Publicaciones</span>
                      </div>
                      <div class="row">
                          <div class="form-group col-md-6">
                              <asp:Label ID="txtTituloLabel" runat="server" Text="Titulo"></asp:Label>
                              <asp:TextBox ID="txtTitulo" placeholder="Ingresar Titulo" CssClass="form-control" runat="server"></asp:TextBox>
                          </div>
                      </div>
                  </div>
              </div>
          </div>
        </div>
    </div>

   </asp:Content>
