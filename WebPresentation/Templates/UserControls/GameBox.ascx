<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="GameBox.ascx.cs" Inherits="WebPresentation.Templates.UserControls.GameBox" %>

<div class="col-xs-6 col-md-3">
    <article class="thumbnail game-short">
        <img src="http://placehold.it/600x150" class="img-responsive img-rounded" alt="placeholder for game image if avail" />
        <asp:HyperLink CssClass="btn btn-primary btn-sm btn-block" ID="PlayButton" runat="server" Text="Play »" />
        <hr />
        <h3><span id="gameName" runat="server"></span> <small>in <span id="category" runat="server"></span></small></h3>
        <p id="gameDesc" runat="server"></p>
    </article>
</div>