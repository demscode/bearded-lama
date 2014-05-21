<%@ Page Title="Home" Language="C#" MasterPageFile="~/Templates/Container.Master" AutoEventWireup="true" CodeBehind="Chat template.aspx.cs" Inherits="WebPresentation.Views.Index" %>
<%@ Register TagPrefix="cc" TagName="Chat" 
    Src="~/Templates/Chat.ascx" %>
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
        <form id="Form1" runat="server">
    <cc:Chat id="chatContainer" 
        runat="server" 
        />
</form>
    </section>
</asp:Content>
