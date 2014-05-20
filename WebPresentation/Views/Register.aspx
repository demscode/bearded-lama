<%@ Page Title="Register" Language="C#" MasterPageFile="~/Templates/Container.Master" AutoEventWireup="true" CodeBehind="Register.aspx.cs" Inherits="WebPresentation.Views.Register" %>
<asp:Content ID="MainRegister" ContentPlaceHolderID="Main" runat="server">
    <section class="container">
        <h1 class="page-header"><%: Title %></h1>

        <div class="row">
            <div class="col-md-8 col-md-offset-2">
                <section class="panel panel-info">
                    <div class="panel-heading">Register</div>
                    <div class="panel-body form-horizontal">
                        <asp:CreateUserWizard RenderOuterTable="false" ID="RegisterUserWizard"
                            runat="server" ContinueDestinationPageUrl="<%$ RouteUrl:routename=home %>" CreateUserButtonStyle-CssClass="btn btn-primary btn-block">
                            <LayoutTemplate>
                                <asp:PlaceHolder ID="wizardStepPlaceholder" runat="server"></asp:PlaceHolder>
                                <asp:PlaceHolder ID="navigationPlaceholder" runat="server"></asp:PlaceHolder>
                            </LayoutTemplate>
                            <WizardSteps>
                                <asp:CreateUserWizardStep ID="RegisterUserWizardStep" runat="server" Title="Register New Account">
                                    <ContentTemplate>
                                        <div class="form-group">
                                            <asp:Label ID="UserNameLabel" runat="server" AssociatedControlID="UserName" CssClass="control-label col-md-3">Username</asp:Label>
                                            <asp:RequiredFieldValidator ID="UserNameRequired" runat="server" ControlToValidate="UserName"
                                                ErrorMessage="User Name is required." ToolTip="User Name is required." ValidationGroup="RegisterUserWizard">*</asp:RequiredFieldValidator>
                                            <div class="col-md-5">
                                                <asp:TextBox ID="UserName" runat="server" CssClass="form-control"></asp:TextBox>
                                            </div>
                                        </div>
                                        <div class="form-group">
                                            <asp:Label ID="EmailLabel" runat="server" AssociatedControlID="Email" CssClass="control-label col-md-3">Email</asp:Label>
                                            <asp:RequiredFieldValidator ID="EmailRequired" runat="server" ControlToValidate="Email" ErrorMessage="Email is required."
                                                ToolTip="Email is required." ValidationGroup="RegisterUserWizard">*</asp:RequiredFieldValidator>
                                            <div class="col-md-5">
                                                <asp:TextBox ID="Email" runat="server" CssClass="form-control"></asp:TextBox>
                                            </div>
                                        </div>
                                        <div class="form-group">
                                            <asp:Label ID="PasswordLabel" runat="server" AssociatedControlID="Password" CssClass="control-label col-md-3">Password</asp:Label>
                                            <asp:RequiredFieldValidator ID="PasswordRequired" runat="server" ControlToValidate="Password"
                                                    ErrorMessage="Password is required." ToolTip="Password is required." ValidationGroup="RegisterUserWizard">*</asp:RequiredFieldValidator>
                                            <div class="col-md-7">
                                                <asp:TextBox ID="Password" runat="server" TextMode="Password" CssClass="form-control"></asp:TextBox>
                                            </div>
                                        </div>
                                        <div class="form-group">
                                            <asp:Label ID="ConfirmPasswordLabel" runat="server" AssociatedControlID="ConfirmPassword" CssClass="control-label col-md-3">Confirm Password</asp:Label>
                                            <asp:RequiredFieldValidator ID="ConfirmPasswordRequired" runat="server" ControlToValidate="ConfirmPassword"
                                                ErrorMessage="Confirm Password is required." ToolTip="Confirm Password is required." ValidationGroup="RegisterUserWizard">*</asp:RequiredFieldValidator>
                                            <div class="col-md-7">
                                                <asp:TextBox ID="ConfirmPassword" runat="server" TextMode="Password" CssClass="form-control"></asp:TextBox>
                                            </div>
                                        </div>
                                        <div class="form-group">
                                            <div class="col-md-5">
                                            </div>
                                        </div>
                                        <tr>
                                            <td align="center" colspan="2">
                                                <asp:CompareValidator ID="PasswordCompare" runat="server" ControlToCompare="Password" ControlToValidate="ConfirmPassword"
                                                    Display="Dynamic" ErrorMessage="The Password and Confirmation Password must match." ValidationGroup="RegisterUserWizard"></asp:CompareValidator>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td align="center" colspan="2" style="color:Red;">
                                                <asp:Literal ID="ErrorMessage" runat="server" EnableViewState="False"></asp:Literal>
                                            </td>
                                        </tr>
                                    </table>
                                    </ContentTemplate>
                                </asp:CreateUserWizardStep>
                                <asp:CompleteWizardStep ID="CompleteWizardStep" runat="server">
                                    <ContentTemplate>
                                        <div class="alert alert-success">
                                            Hello <strong><%: RegisterUserWizard.UserName %></strong>, your account has been successfully created!
                                        </div>
                                        <asp:Button ID="ContinueButton" runat="server" CausesValidation="False" CommandName="Continue"
                                            Text="Continue" ValidationGroup="RegisterUserWizard" CssClass="btn btn-success btn-block" />
                                    </ContentTemplate>
                                </asp:CompleteWizardStep>
                            </WizardSteps>
                        </asp:CreateUserWizard>
                    </div>
                </section>
            </div>
        </div>
    </section>

</asp:Content>
