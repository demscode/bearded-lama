<%@ Page Title="Account Settings" Language="C#" MasterPageFile="~/Templates/Container.Master" AutoEventWireup="true" CodeBehind="Settings.aspx.cs" Inherits="WebPresentation.Views.MembersOnly.Settings" %>
<asp:Content ID="MainSettings" ContentPlaceHolderID="Main" runat="server">
    <section class="container">
        <h1 class="page-header"><%: Title %></h1>

        <div class="row">
            <div class="col-md-6 col-md-offset-3">
                <section class="panel panel-warning">
                    <div class="panel-heading">Change Password</div>
                    <div class="panel-body">
                        <asp:ChangePassword ID="MainChangePassword" runat="server" ContinueDestinationPageUrl="<%$RouteUrl:routename=account-settings%>">

                        </asp:ChangePassword>
                    </div>
                </section>
            </div>
        </div>
        <div class="row">
            <div class="col-md-6 col-md-offset-3">
                <section class="panel panel-default">
                    <div class="panel-heading">Change User Details</div>
                    <div class="panel-body">
                        <%-- Get user data and edit it. Use a data view controller ie DetailsView, FormView, GridView, Repeater. --%>
                    </div>
                </section>
            </div>
        </div>
    </section>
</asp:Content>
