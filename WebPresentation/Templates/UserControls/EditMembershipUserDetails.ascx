<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="EditMembershipUserDetails.ascx.cs" Inherits="WebPresentation.Templates.UserControls.EditMembershipUserDetails" %>
<script language="javascript"> // requires jquery
    function jsValidateEditEmail(source, args) {
        var emailRegex = /^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$/
        var isValid = args.Value.match(emailRegex);

        args.IsValid = flagInputError(source.id, args.Value, isValid);
    }

    function jsValidateEditUserDescription(source, args) {
        var maxChars = 200;
        var isValid = args.Value.trim().length <= maxChars;

        args.IsValid = flagInputError(source.id, args.Value, isValid);
    }

    function flagInputError(elementId, elementValue, validityExpression) {
        var isValid = false;

        if (elementValue.trim() == "") {
            isValid = true; // empty input
        } else {
            isValid = validityExpression;
        }

        if (isValid) {
            $("#" + elementId).prev(".form-control").parent().parent().removeClass("has-error");
        } else {
            $("#" + elementId).prev(".form-control").parent().parent().addClass("has-error");
        }

        console.log(isValid);
        return isValid;
    }
</script>

<section class="panel panel-primary">
    <div class="panel-heading">Change User Details</div>
    <div class="panel-body form-horizontal">
        <div class="form-group">
            <label class="control-label col-md-3">Username</label>
            <div class="col-md-5">
                <p id="staticUsername" class="form-control-static" runat="server"></p>
            </div>
        </div>
        <div class="form-group">
            <asp:Label ID="EditEmailLabel" AssociatedControlID="EditEmail" Text="Email" runat="server" CssClass="control-label col-md-3" />
            <div class="col-md-5">
                <asp:TextBox ID="EditEmail" runat="server" AutoCompleteType="Email" CssClass="form-control" />
                <asp:CustomValidator ValidateEmptyText="true" ID="EditEmailValidator" ControlToValidate="EditEmail" Display="None"
                    ClientValidationFunction="jsValidateEditEmail" ValidationGroup="EditDetailsValidatorGroup" runat="server"
                    OnServerValidate="EditEmailValidator_ServerValidate" ErrorMessage="Enter valid email address" />
            </div>
        </div>
        <div class="form-group">
            <asp:Label ID="EditUserDescriptionLabel" AssociatedControlID="EditUserDescription" Text="Description" runat="server" CssClass="control-label col-md-3" />
            <div class="col-md-5">
                <asp:TextBox ID="EditUserDescription" runat="server" TextMode="MultiLine" CssClass="form-control" />
                <asp:CustomValidator ValidateEmptyText="true" ID="EditUserDescriptionValidator" ControlToValidate="EditUserDescription"
                    ClientValidationFunction="jsValidateEditUserDescription" ValidationGroup="EditDetailsValidatorGroup" runat="server"
                    ErrorMessage="Description should be 200 characters or less" OnServerValidate="EditUserDescriptionValidator_ServerValidate"
                    Display="None" CssClass="hide" />
            </div>
        </div>
        <div class="form-group">
            <asp:Label ID="EditAdultLabel" AssociatedControlID="EditAdult" Text="Adult Content" runat="server" CssClass="control-label col-md-3" />
            <div class="col-md-1">
                <asp:CheckBox ID="EditAdult" runat="server" CssClass="checkbox" />
            </div>
        </div>
        <asp:ValidationSummary ID="EditUserDetailsValidatorSummary" ValidationGroup="EditDetailsValidatorGroup" DisplayMode="BulletList"
            HeaderText="You must correct these:" runat="server" CssClass="alert alert-danger" />
        <asp:Button ID="SaveUserDetailsButton" Text="Save" runat="server" CssClass="btn btn-primary btn-block"
            ValidationGroup="EditDetailsValidatorGroup" OnClick="SaveUserDetailsButton_Click" />
    </div>
</section>