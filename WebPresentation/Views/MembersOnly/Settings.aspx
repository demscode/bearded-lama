<%@ Page Title="Account Settings" Language="C#" MasterPageFile="~/Templates/Container.Master" AutoEventWireup="true" CodeBehind="Settings.aspx.cs" Inherits="WebPresentation.Views.MembersOnly.Settings" %>
<%@ Register TagPrefix="uc" TagName="EditUserDetails" Src="~/Templates/UserControls/EditMembershipUserDetails.ascx" %>
<asp:Content ID="MainSettings" ContentPlaceHolderID="Main" runat="server">
    <section class="container">
        <h1 class="page-header"><%: Title %></h1>

        <div class="row">
            <div class="col-md-8 col-md-offset-2">
                <section class="panel panel-warning">
                    <div class="panel-heading">Change Password</div>
                    <div class="panel-body form-horizontal">
                        <asp:ChangePassword ID="MainChangePassword" runat="server" ContinueDestinationPageUrl="<%$RouteUrl:routename=account-settings%>" RenderOuterTable="false">
                            <ChangePasswordTemplate>
                                <div class="form-group">
                                    <asp:Label ID="CurrentPasswordLabel" runat="server" AssociatedControlID="CurrentPassword" CssClass="control-label col-md-3">Password</asp:Label>
                                    <asp:RequiredFieldValidator ID="CurrentPasswordRequired" runat="server" ControlToValidate="CurrentPassword"
                                        ErrorMessage="Password is required." ToolTip="Password is required." ValidationGroup="MainChangePassword">*</asp:RequiredFieldValidator>
                                    <div class="col-md-5">
                                        <asp:TextBox ID="CurrentPassword" runat="server" TextMode="Password" CssClass="form-control"></asp:TextBox>
                                    </div>
                                </div>
                                <div class="form-group">
                                    <asp:Label ID="NewPasswordLabel" runat="server" AssociatedControlID="NewPassword" CssClass="control-label col-md-3">New Password</asp:Label>
                                    <asp:RequiredFieldValidator ID="NewPasswordRequired" runat="server" ControlToValidate="NewPassword"
                                        ErrorMessage="New Password is required." ToolTip="New Password is required." ValidationGroup="MainChangePassword">*</asp:RequiredFieldValidator>
                                    <div class="col-md-5">
                                        <asp:TextBox ID="NewPassword" runat="server" TextMode="Password" CssClass="form-control"></asp:TextBox>
                                    </div>
                                </div>
                                <div class="form-group">
                                    <asp:Label ID="ConfirmNewPasswordLabel" runat="server" AssociatedControlID="ConfirmNewPassword" CssClass="control-label col-md-3">Confirm New Password</asp:Label>
                                    <asp:RequiredFieldValidator ID="ConfirmNewPasswordRequired" runat="server" ControlToValidate="ConfirmNewPassword"
                                        ErrorMessage="Confirm New Password is required." ToolTip="Confirm New Password is required." ValidationGroup="MainChangePassword">*</asp:RequiredFieldValidator>
                                    <div class="col-md-5">
                                        <asp:TextBox ID="ConfirmNewPassword" runat="server" TextMode="Password" CssClass="form-control"></asp:TextBox>
                                    </div>
                                </div>
                                <asp:CompareValidator ID="NewPasswordCompare" runat="server" ControlToCompare="NewPassword" ControlToValidate="ConfirmNewPassword"
                                    Display="Dynamic" ErrorMessage="The Confirm New Password must match the New Password entry." ValidationGroup="MainChangePassword"></asp:CompareValidator>
                                <asp:Literal ID="FailureText" runat="server" EnableViewState="False"></asp:Literal>
                                <asp:Button ID="ChangePasswordPushButton" runat="server" CommandName="ChangePassword" Text="Change Password"
                                    ValidationGroup="MainChangePassword" CssClass="btn btn-warning btn-block" />
                            </ChangePasswordTemplate>
                            <SuccessTemplate>
                                <div class="alert alert-success">
                                    Your password has been changed!
                                </div>
                                <asp:Button ID="ContinuePushButton" runat="server" CausesValidation="False" CommandName="Continue" Text="Continue" CssClass="btn btn-success btn-block" />
                            </SuccessTemplate>
                        </asp:ChangePassword>
                    </div>
                </section>
            </div>
        </div>
        <div class="row">
            <div class="col-md-8 col-md-offset-2">
                <uc:EditUserDetails ID="UserControlEditUserDetails" runat="server" />
            </div>
        </div>
    </section>
</asp:Content>
