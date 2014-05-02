<%@ Page Title="Home" Language="C#" MasterPageFile="~/Templates/Container.Master" AutoEventWireup="true" CodeBehind="Index.aspx.cs" Inherits="WebPresentation.Views.Index" %>
<asp:Content ID="MainIndex" ContentPlaceHolderID="Main" runat="server">
    <section class="jumbotron intro">
        <div class="container">
            <h1>Game Hub <small>Games made by <em>you!</em></small></h1>
            <p>
                Find and play some pretty okay <abbr title="Browser driven games, written with web technologies.">HTML5 Games</abbr>.
            </p>
            <button class="btn btn-block btn-lg btn-info" type="button">Sign Up »</button>
        </div>
            <button class="close" type="button" aria-hidden="true" onclick="$('.intro').toggle();$('.jumbopush').toggle();">&times;</button>
    </section>
    <div class="jumbopush push" style="display:none;"></div>

    <%-- This could be some other asp page --%>
    <section class="container-fluid">
        <div class="row">
            <div class="col-xs-6 col-md-3">
                <article class="thumbnail game-short">
                    <img src="http://placehold.it/600x150" class="img-responsive img-rounded" alt="placeholder for game image if avail" />
                    <button class="btn btn-primary btn-sm btn-block" type="button">Play »</button>
                    <hr />
                    <h3>Small Game <small>by John Smith</small></h3>
                    <p>Fly around, or walk.. Or jump. Kill aliens or zombies. Grow farms. Be a ninja.</p>
                    <span class="btn-primary badge pull-right">3 playing</span>
                    <span class="btn-info badge pull-right">42 plays</span>
                </article>
            </div>
        </div>
    </section>
</asp:Content>
