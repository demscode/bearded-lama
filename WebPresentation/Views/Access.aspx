<%@ Page Title="Accounts" Language="C#" MasterPageFile="~/Templates/Container.Master" AutoEventWireup="true" CodeBehind="Access.aspx.cs" Inherits="WebPresentation.Views.Access" %>
<asp:Content ID="MainAccess" ContentPlaceHolderID="Main" runat="server">
    <asp:CreateUserWizard ID="CreateUserWizard" runat="server" ContinueDestinationPageUrl="~/Views/Index.aspx">
        <WizardSteps>
            <asp:CreateUserWizardStep ID="CreateUserWizardStep" runat="server">

            </asp:CreateUserWizardStep>
            <asp:CompleteWizardStep ID="CompleteWizardStep" runat="server">
            </asp:CompleteWizardStep>
        </WizardSteps>
    </asp:CreateUserWizard>
</asp:Content>
