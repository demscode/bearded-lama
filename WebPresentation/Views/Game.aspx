<%@ Page Title="Game" Language="C#" MasterPageFile="~/Templates/Container.Master" AutoEventWireup="true" CodeBehind="Game.aspx.cs" Inherits="WebPresentation.Views.Game" %>
<asp:Content ID="MainGame" ContentPlaceHolderID="Main" runat="server">
    <section class="container">
        <h1 id="GamePageHeader" class="page-header" runat="server"></h1>

        <section class="container">
            <div class="row">
                <h2>Details</h2>
                <dl class="dl-horizontal">
                    <dt>Description</dt>
                    <dd id="gameDescription" runat="server"></dd>
                    <dt>Category</dt>
                    <dd id="gameCategory" runat="server"></dd>
                    <dt>Tags</dt>
                    <dd id="gameTags" runat="server"></dd>
                    <dt>Rating</dt>
                    <dd id="gameRating" runat="server"></dd>
                    <dt>Uploader</dt>
                    <dd id="gameUploader" runat="server"></dd>
                    <dt>Date uploaded</dt>
                    <dd id="gameUpDate" runat="server"></dd>
                    <dt>Restricted</dt>
                    <dd id="gameRestrict" runat="server"></dd>
                </dl>
            </div>
            <div class="row">
                <h2>Similar Games</h2>
                <section class="container-fluid">
                    <div class="row">
                        <div class="col-xs-6 col-md-3" id="recommendedGame1" runat="server">
                        </div>
                        <div class="col-xs-6 col-md-3" id="recommendedGame2" runat="server">
                        </div>
                        <div class="col-xs-6 col-md-3" id="recommendedGame3" runat="server">
                        </div>
                        <div class="col-xs-6 col-md-3" id="recommendedGame4" runat="server">
                        </div>
                    </div>
                </section>
            </div>
        </section>
    </section>

</asp:Content>
