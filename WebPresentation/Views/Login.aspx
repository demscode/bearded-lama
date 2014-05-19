<%@ Page Title="Login" Language="C#" MasterPageFile="~/Templates/Container.Master" AutoEventWireup="true" CodeBehind="Login.aspx.cs" Inherits="WebPresentation.Views.Login" %>
<asp:Content ID="MainLogin" ContentPlaceHolderID="Main" runat="server">
    <section class="container">
        <h1 class="page-header"><%: Title %></h1>

        <div class="row">
            <div class="col-md-8 col-md-offset-2">
                <section class="panel panel-primary">
                    <div class="panel-heading">Login</div>
                    <div class="panel-body form-horizontal">
                        <asp:Login ID="LoginControl" runat="server" DestinationPageUrl="<%$RouteUrl:routename=home%>" RenderOuterTable="false">
                            <LayoutTemplate>
                                <div class="form-group">
                                    <asp:Label ID="UserNameLabel" runat="server" AssociatedControlID="UserName" CssClass="control-label col-md-3">Username</asp:Label>
                                    <asp:RequiredFieldValidator ID="UserNameRequired" runat="server" ControlToValidate="UserName"
                                        ErrorMessage="User Name is required." ToolTip="User Name is required." ValidationGroup="LoginControl">*</asp:RequiredFieldValidator>
                                    <div class="col-md-5">
                                        <asp:TextBox ID="UserName" runat="server" CssClass="form-control"></asp:TextBox>
                                    </div>
                                </div>
                                <div class="form-group">
                                     <asp:Label ID="PasswordLabel" runat="server" AssociatedControlID="Password" CssClass="control-label col-md-3">Password</asp:Label>
                                    <asp:RequiredFieldValidator ID="PasswordRequired" runat="server" ControlToValidate="Password"
                                        ErrorMessage="Password is required." ToolTip="Password is required." ValidationGroup="LoginControl">*</asp:RequiredFieldValidator>
                                    <div class="col-md-5">
                                        <asp:TextBox ID="Password" runat="server" TextMode="Password" CssClass="form-control"></asp:TextBox>
                                    </div>
                                </div>
                                <div class="form-group">
                                    <asp:Label ID="RememberMeLabel" AssociatedControlID="RememberMe" runat="server" CssClass="control-label col-md-3">Remember Login</asp:Label>
                                    <div class="col-md-1">
                                        <asp:CheckBox ID="RememberMe" runat="server" CssClass="checkbox" />
                                    </div>
                                </div>
                                <asp:Literal ID="FailureText" runat="server" EnableViewState="False"></asp:Literal>
                                <asp:Button ID="LoginButton" runat="server" CommandName="Login" Text="Log In" ValidationGroup="LoginControl" CssClass="btn btn-primary btn-block" />
                            </LayoutTemplate>
                        </asp:Login>
                    </div>
                </section>
            </div>
        </div>
    </section>

</asp:Content>
