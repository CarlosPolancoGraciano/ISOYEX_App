<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Perfil.aspx.cs" Inherits="ISOYEX_App.perfil" %>
<asp:Content ID="PerfilWebPage" ContentPlaceHolderID="MainContent" runat="server">
    <div class="container p-4 m-4">
        <div class="row justify-content-center">
            <div class="col-8">
                <div class="card">
                  <div class="card-body">
                    <h2 class="card-title text-align mt-3">Datos Personales</h2>
                      <div class="row">
                          <div class="form-group col-md-6">
                              <asp:Label ID="label1" runat="server" Text="Nombre"></asp:Label>
                              <input type="text" class="form-control" placeholder="Ingresar Nombre" />
                          </div>
                          <div class="form-group col-md-6 ">
                              <asp:Label ID="labelLastName" runat="server" Text="Apellido"></asp:Label>
                              <input type="text" class="form-control" placeholder="Ingresar Apellido" />
                          </div>
                      </div>
                      <div class="row">
                          <div class="form-group col-md-6">
                                  <asp:Label ID="fecha_nacimiento" runat="server" Text="Fecha de Nacimiento"></asp:Label>
                                  <input type="text" class="form-control" placeholder="Ingresar Fecha de Nacimiento" />
                              </div>
                              <div class="form-group col-md-6">
                                  <asp:Label ID="tipo_sangre" runat="server" Text="Tipo de Sangre"></asp:Label>
                                  <select id="Tiposangre" class="form-control">
                                      <option selected></option>
                                      <option selected></option>
                                      <option selected></option>
                                      <option selected></option>
                                  </select>
                              </div>
                      </div>
                     </div>
                  </div>
                </div>
            </div>
        </div>
    <div class="container p-0 m-4">
        <div class="row justify-content-center">
            <div class="col-8">
                <div class="card">
                  <div class="card-body">
                    <h2 class="card-title text-align mt-3">Datos de contactos y direccion</h2>
                    <div class="row"> 
                        <div class="form-group col-md-6"> 
                            <asp:Label ID="labelEmail" runat="server" Text="Correo electrónico" AssociatedControlID="txtemail"></asp:Label>
                            <asp:TextBox ID="txtemail" runat="server" CssClass="form-control" placeholder="Ingresar Correo Electrónico"></asp:TextBox>
                        </div>
                        <div class="form-group col-md-6">
                            <asp:Label ID="labelPassword" runat="server" Text="Nueva Contraseña" AssociatedControlID="txtemail"></asp:Label>
                            <asp:TextBox ID="txtpassword" runat="server" TextMode="Password" CssClass="form-control" placeholder="Ingresar contraseña"></asp:TextBox>
                        </div>
                     </div>
                      <div class="row">
                          <div class="form-group col-md-6">
                              <asp:Label ID="labelnuevacontraseña" runat="server" Text="Nueva Contraseña"></asp:Label>
                              <asp:TextBox ID="TextBox2" runat="server" CssClass="form-control" placeholder="Ingresar Nueva Contraseña"></asp:TextBox>
                          </div>
                          <div class="form-group col-md-6">
                              <asp:Label ID="labeltelefono" runat="server" Text="Numero Telefonico"></asp:Label>
                              <asp:TextBox ID="txttelefono" runat="server" CssClass="form-control" placeholder="Ingresar Numero Telefonico"></asp:TextBox>
                          </div>
                      </div>
                      <div class="row">
                          <div class="form-group col-md-6">
                              <asp:Label ID="labelcontacto" runat="server" Text="Tipo de contacto"></asp:Label>
                              <select id="tipocontacto" class="form-control">
                                  <option></option>

                              </select>
                          </div>
                          <div class="form-group col-md-6">
                              <asp:Label ID="Labelprrovincia" runat="server" Text="Provincia"></asp:Label>
                              <select id="Provincia" class="form-control">
                              </select>
                          </div>
                          </div>
                      <div class="row">
                          <div class="form-group col-md-6">
                              <asp:Label ID="Labelmunicipio" runat="server" Text="Municipio"></asp:Label>
                              <select id="Municipio" class="form-control">
                                  <option></option>
                                  <option selected></option>
                                  <option selected></option>
                                  <option selected></option>
                              </select>
                          </div>
                      </div>
                    </div>
                    </div>
                  </div>
                 </div>
               </div>
</asp:Content>
