<%@ Page Title="Profile" Language="C#" MasterPageFile="~/Templates/Container.Master" AutoEventWireup="true" CodeBehind="User.aspx.cs" Inherits="WebPresentation.Views.User" %>
<asp:Content ID="MainUser" ContentPlaceHolderID="Main" runat="server">
    <section class="container">
        <h1 id="UserPageHeader" class="page-header" runat="server"></h1>

        <section class="container">
            <div class="row">
                <h2>Details</h2>
                <dl class="dl-horizontal">
                    <dt>Joined</dt>
                    <dd id="ddJoined" runat="server"></dd>
                    <dt>Email</dt>
                    <dd id="ddEmail" runat="server"></dd>
                    <dt>Description</dt>
                    <dd id="ddDescription" runat="server"></dd>
                </dl>
            </div>
            <div class="row">
                <h2>History</h2>
                <dl>
                    <dt>Favourite categories</dt>
                    <dd id="ddFavCategories" runat="server">
                        <span class="label label-success">Dungeon</span>
                        <span class="label label-success">Shooter</span>
                        <span class="label label-success">Craft</span>
                    </dd>
                    <dt>Recently played</dt>
                    <dd class="ddRecentPlayed" runat="server"></dd>
                </dl>
            </div>
        </section>
    </section>
</asp:Content>
