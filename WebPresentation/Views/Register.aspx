<%@ Page Title="Register" Language="C#" MasterPageFile="~/Templates/Container.Master" AutoEventWireup="true" CodeBehind="Register.aspx.cs" Inherits="WebPresentation.Views.Register" %>
<asp:Content ID="MainRegister" ContentPlaceHolderID="Main" runat="server">
    <section class="container">
        <h1 class="page-header"><%: Title %></h1>

        <div class="row">
            <div class="col-md-6 col-md-offset-3">
                <section class="panel panel-info">
                    <div class="panel-heading">Register</div>
                    <div class="panel-body">
                        <asp:CreateUserWizard ID="RegisterUserWizard" runat="server" ContinueDestinationPageUrl="/">
                            <WizardSteps>
                                <asp:CreateUserWizardStep ID="RegisterUserWizardStep" runat="server" Title="Register New Account">
<%--                                    <ContentTemplate>
                                        <div class="form-group">
                                            <asp:Label ID="Label1" runat="server" AssociatedControlID="UserName">
                                                Username
                                            </asp:Label>
                                            <asp:TextBox runat="server" ID="UserName" CssClass="form-control" />
                                        </div>
                                        <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ControlToValidate="UserName"
                                            CssClass="text-danger" ErrorMessage="Username required." />

                                        <div class="form-group">
                                            <asp:Label ID="Label2" runat="server" AssociatedControlID="Email">
                                                Email
                                            </asp:Label>
                                            <asp:TextBox runat="server" ID="Email" CssClass="form-control" />
                                        </div>
                                        <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ControlToValidate="Email"
                                            CssClass="text-danger" ErrorMessage="Email required." />

                                        <div class="form-group">
                                            <asp:Label ID="Label3" runat="server" AssociatedControlID="Password">
                                                Password
                                            </asp:Label>
                                            <asp:TextBox runat="server" ID="Password" TextMode="Password" CssClass="form-control" />
                                        </div>
                                        <asp:RequiredFieldValidator ID="RequiredFieldValidator3" runat="server" ControlToValidate="Password"
                                            CssClass="text-danger" ErrorMessage="Password required." />
                                    </ContentTemplate>--%>
                                </asp:CreateUserWizardStep>
                                <asp:CompleteWizardStep ID="CompleteWizardStep" runat="server">
<%--                                    <ContentTemplate>
                                    </ContentTemplate>--%>
                                </asp:CompleteWizardStep>
                            </WizardSteps>
                        </asp:CreateUserWizard>
                    </div>
                </section>
            </div>
        </div>
    </section>

</asp:Content>
