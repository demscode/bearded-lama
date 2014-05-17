<%@ Page Title="Login" Language="C#" MasterPageFile="~/Templates/Container.Master" AutoEventWireup="true" CodeBehind="Login.aspx.cs" Inherits="WebPresentation.Views.Login" %>
<asp:Content ID="MainLogin" ContentPlaceHolderID="Main" runat="server">
    <section class="container">
        <h1 class="page-header"><%: Title %></h1>

        <div class="row">
            <div class="col-md-6 col-md-offset-3">
                <section class="panel panel-primary">
                    <div class="panel-heading">Login</div>
                    <div class="panel-body">
                        <asp:Login ID="MainLogin" runat="server" DestinationPageUrl="<%$RouteUrl:routename=home%>">
<%--                            <LayoutTemplate>
                            </LayoutTemplate>--%>
                        </asp:Login>
                    </div>
                </section>
            </div>
        </div>
    </section>

</asp:Content>
