<%@ Page Title="Accounts" Language="C#" MasterPageFile="~/Templates/Container.Master" AutoEventWireup="true" CodeBehind="Access.aspx.cs" Inherits="WebPresentation.Views.Access" %>
<asp:Content ID="MainAccess" ContentPlaceHolderID="Main" runat="server">
    <section class="container">
        <h1 class="page-header"><%: Title %></h1>

        <div class="row">
            <div class="col-md-5 col-md-offset-1">
                <section class="panel panel-info">
                    <div class="panel-heading">Register</div>
                    <div class="panel-body">
                        <asp:CreateUserWizard ID="RegisterUserWizard" runat="server" ContinueDestinationPageUrl="/" InvalidQuestionErrorMessage="">
                            <WizardSteps>
                                <asp:CreateUserWizardStep ID="RegisterUserWizardStep" runat="server">
                                    <ContentTemplate>
                                        <div class="form-group">
                                            <asp:Label runat="server" AssociatedControlID="UserName" CssClass="sr-only" />
                                            <asp:TextBox runat="server" ID="UserName" CssClass="form-control" />
                                        </div>
                                        <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ControlToValidate="UserName"
                                            CssClass="text-danger" ErrorMessage="Username required." />

                                        <div class="form-group">
                                            <asp:Label ID="Label1" runat="server" AssociatedControlID="Email" CssClass="sr-only" />
                                            <asp:TextBox runat="server" ID="Email" CssClass="form-control" />
                                        </div>
                                        <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ControlToValidate="Email"
                                            CssClass="text-danger" ErrorMessage="Email required." />

                                        <div class="form-group">
                                            <asp:Label ID="Label2" runat="server" AssociatedControlID="Password" CssClass="sr-only" />
                                            <asp:TextBox runat="server" ID="Password" CssClass="form-control" />
                                        </div>
                                        <asp:RequiredFieldValidator ID="RequiredFieldValidator3" runat="server" ControlToValidate="Password"
                                            CssClass="text-danger" ErrorMessage="Password required." />
                                    </ContentTemplate>
                                </asp:CreateUserWizardStep>
                                <asp:CompleteWizardStep ID="CompleteWizardStep" runat="server">
                                    <ContentTemplate>
                                    </ContentTemplate>
                                </asp:CompleteWizardStep>
                            </WizardSteps>
                        </asp:CreateUserWizard>
                    </div>
                </section>
            </div>
            <div class="col-md-5">
                <section class="panel panel-primary">
                    <div class="panel-heading">Login</div>
                    <div class="panel-body">
                        <asp:Login ID="Login" runat="server">
                            <LayoutTemplate>
                                
                            </LayoutTemplate>
                        </asp:Login>
                    </div>
                </section>
            </div>
        </div>
    </section>
</asp:Content>
