<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="SubmitGame.ascx.cs" Inherits="WebPresentation.Templates.UserControls.SubmitGame" %>
<section class="panel panel-default">
    <p class="panel-heading">Read the <a href="#getting-started">Getting Started</a> before submitting a new game!</p>
    <div class="panel-body form-horizontal">
        <div class="form-group">
            <asp:Label ID="EditNameLabel" AssociatedControlID="EditName" Text="Name" runat="server" CssClass="control-label col-md-3" />
            <div class="col-md-5">
                <asp:TextBox ID="EditName" runat="server" CssClass="form-control" />
            </div>
        </div>
        <div class="form-group">
            <asp:Label ID="EditDescriptionLabel" AssociatedControlID="EditDescription" Text="Description" runat="server" CssClass="control-label col-md-3" />
            <div class="col-md-5">
                <asp:TextBox ID="EditDescription" TextMode="MultiLine" runat="server" CssClass="form-control" />
            </div>
        </div>
        <%-- TODO: implement tags input --%>
        <%-- nicolasbize.com/magicsuggest --%>
        <div class="form-group">
            <asp:Label ID="EditTagsLabel" AssociatedControlID="EditTags" Text="Tags" runat="server" CssClass="control-label col-md-3" />
            <div class="col-md-5">
                <asp:TextBox ID="EditTags" TextMode="MultiLine" runat="server" CssClass="form-control" />
            </div>
        </div>
        <div class="form-group">
            <asp:Label runat="server" CssClass="control-label col-md-3" AssociatedControlID="AttachPackage">Game Package</asp:Label> 
            <div class="col-md-5">
                <asp:FileUpload CssClass="well" ID="AttachPackage" runat="server" />
                <%-- FIX: use custom file upload
                    <div class="input-group">
                    <span class="input-group-btn">
                        <button class="btn btn-default">Attach</button>
                    </span>
                    <input class="form-control" id="disabledInput" value="No file attached..." disabled="" />
                </div>--%>
            </div>
        </div>
        <button class="btn btn-default btn-block">Submit Game</button>
    </div>
</section>
