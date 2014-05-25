<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="SubmitGame.ascx.cs" Inherits="WebPresentation.Templates.UserControls.SubmitGame" %>
<script>
    function jsValidateAttachmentSize(source, args) {
        args.IsValid = false;
        var maxSize = 200000;

        var size = ($('#' + source.controltovalidate).get())[0].files[0].size;
        args.IsValid = size <= maxSize;
    }
</script>
<section id="contentPanel" class="panel panel-default" runat="server">
    <p class="panel-heading">Read the <a href="#getting-started">Getting Started</a> before submitting a new game!</p>
    <div class="panel-body form-horizontal">
        <div id="formContent" runat="server">
            <div class="form-group">
                <asp:Label ID="EditNameLabel" AssociatedControlID="EditName" Text="Name" runat="server" CssClass="control-label col-md-3" />
                <div class="col-md-5">
                    <asp:TextBox ID="EditName" runat="server" CssClass="form-control" />
                    <ul class="list-unstyled">
                        <li>
                            <asp:RequiredFieldValidator ID="EditNameValidator" ControlToValidate="EditName" runat="server"
                                ErrorMessage="Name required."></asp:RequiredFieldValidator>
                        </li>
                        <li>
                            <asp:RegularExpressionValidator ID="EditNameLengthValidator" ControlToValidate="EditName" runat="server"
                                ErrorMessage="Name must be between 4 and 50 characters." ValidationExpression="[\s\S]{4,50}"></asp:RegularExpressionValidator>
                        </li>
                    </ul>
                </div>
            </div>
            <div class="form-group">
                <asp:Label ID="EditDescriptionLabel" AssociatedControlID="EditDescription" Text="Description" runat="server" CssClass="control-label col-md-3" />
                <div class="col-md-5">
                    <asp:TextBox ID="EditDescription" TextMode="MultiLine" runat="server" CssClass="form-control" />
                    <ul class="list-unstyled">
                        <li>
                            <asp:RequiredFieldValidator ID="EditDescriptionValidator" ControlToValidate="EditDescription" runat="server"
                                ErrorMessage="Description required."></asp:RequiredFieldValidator>
                        </li>
                        <li>
                            <asp:RegularExpressionValidator ID="EditDescriptionLengthValidator" ControlToValidate="EditDescription" runat="server"
                                ErrorMessage="Description must be between 20 and 300 characters." ValidationExpression="[\s\S]{20,300}"></asp:RegularExpressionValidator>
                        </li>
                    </ul>
                </div>
            </div>
            <div class="form-group">
                <asp:Label ID="EditCategoryLabel" AssociatedControlID="EditCategory" Text="Category" runat="server" CssClass="control-label col-md-3" />
                <div class="col-md-5">
                    <asp:DropDownList ID="EditCategory" runat="server" DataSourceID="CategoriesDataSource" DataTextField="categoryName"
                        DataValueField="categoryName"></asp:DropDownList>
                    <asp:ObjectDataSource runat="server" ID="CategoriesDataSource" OldValuesParameterFormatString="original_{0}"
                        SelectMethod="GetAllCategories" TypeName="BusinessLogic.Games.Categories"></asp:ObjectDataSource>
                </div>
            </div>
            <div class="form-group">
                <asp:Label ID="EditAdultLabel" AssociatedControlID="EditAdult" Text="Adult Content" runat="server" CssClass="control-label col-md-3" />
                <div class="col-md-1"> <%-- not required. defaults to false. --%>
                    <asp:CheckBox ID="EditAdult" runat="server" CssClass="checkbox" Checked="false" />
                </div>
            </div>
            <%-- TODO: implement tags input --%>
            <%-- nicolasbize.com/magicsuggest --%>
            <div class="form-group">
                <asp:Label ID="EditTagsLabel" AssociatedControlID="EditTags" Text="Tags" runat="server" CssClass="control-label col-md-3" />
                <div class="col-md-5">
                    <asp:TextBox ID="EditTags" TextMode="MultiLine" runat="server" CssClass="form-control" />
                    <ul class="list-unstyled">
                        <li>
                            <asp:RequiredFieldValidator ID="EditTagsValidator" ControlToValidate="EditTags" runat="server"
                                ErrorMessage="Tag(s) required."></asp:RequiredFieldValidator>
                        </li>
                        <li>
                            <asp:RegularExpressionValidator ID="EditTagsLengthValidator" ControlToValidate="EditTags" runat="server"
                                ErrorMessage="Atleast one tag must be declared. 200 character limit." ValidationExpression="[\s\S]{4,200}"></asp:RegularExpressionValidator>
                        </li>
                    </ul>
                
                </div>
            </div>
            <div class="form-group">
                <asp:Label runat="server" CssClass="control-label col-md-3" AssociatedControlID="AttachPackage">Game Package</asp:Label> 
                <div class="col-md-6">
                    <asp:FileUpload CssClass="well" ID="AttachPackage" runat="server" />
                    <ul class="list-unstyled">
                        <li>
                            <asp:RequiredFieldValidator ID="AttachPackageRequiredValidator" ControlToValidate="AttachPackage" runat="server"
                                ErrorMessage="Attached package required."></asp:RequiredFieldValidator>
                        </li>
                        <li>
                            <asp:RegularExpressionValidator ID="AttachPackageRegexValidator" ControlToValidate="AttachPackage" runat="server"
                                ErrorMessage="Only .zip formatted file allowed."
                                ValidationExpression="^.+\.(zip)$" />
                        </li>
                        <li>
                            <asp:CustomValidator ID="AttachPackageSizeValidator" ControlToValidate="AttachPackage" EnableClientScript="true"
                                ClientValidationFunction="jsValidateAttachmentSize" runat="server"
                                ErrorMessage="Attached file needs to be under 200kb." />
                        </li>
                    </ul>
                    <%-- TODO: validate extension and size --%>
                    <%-- FIX: use custom file upload
                        <div class="input-group">
                        <span class="input-group-btn">
                            <button class="btn btn-default">Attach</button>
                        </span>
                        <input class="form-control" id="disabledInput" value="No file attached..." disabled="" />
                    </div>--%>
                </div>
            </div>
            <asp:ValidationSummary ID="SubmitPackageValidationSummary" CssClass="alert alert-danger" runat="server" />
            <asp:Button ID="SubmitPackageButton" OnClick="submitPackageButton_ServerClick" CssClass="btn btn-default btn-block" Text="Submit Game" runat="server" />
        </div>
        <div id="submissionSuccessMessage" class="alert alert-success" hidden="hidden" runat="server">
            <p>Your game, <span id="gameName" runat="server"></span>, was successfully submitted!</p>
            <p><asp:HyperLink ID="SubmittedGamePage" Text="Play it" runat="server" /> now!</p>
        </div>
    </div>
</section>
