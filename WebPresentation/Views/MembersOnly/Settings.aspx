<%@ Page Title="Account Settings" Language="C#" MasterPageFile="~/Templates/Container.Master" AutoEventWireup="true" CodeBehind="Settings.aspx.cs" Inherits="WebPresentation.Views.MembersOnly.Settings" %>
<asp:Content ID="MainSettings" ContentPlaceHolderID="Main" runat="server">
    <section class="container">
        <h1 class="page-header"><%: Title %></h1>

        <div class="row">
            <div class="col-md-8 col-md-offset-2">
                <section class="panel panel-warning">
                    <div class="panel-heading">Change Password</div>
                    <div class="panel-body">
                        <asp:ChangePassword ID="MainChangePassword" runat="server" ContinueDestinationPageUrl="<%$RouteUrl:routename=account-settings%>">

                        </asp:ChangePassword>
                    </div>
                </section>
            </div>
        </div>
        <div class="row">
            <div class="col-md-8 col-md-offset-2">
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
                            </div>
                        </div>
                        <div class="form-group">
                            <asp:Label ID="EditUserDescriptionLabel" AssociatedControlID="EditUserDescription" Text="Description" runat="server" CssClass="control-label col-md-3" />
                            <div class="col-md-5">
                                <asp:TextBox ID="EditUserDescription" runat="server" TextMode="MultiLine" CssClass="form-control" />
                            </div>
                        </div>
                        <div class="form-group">
                            <asp:Label ID="EditAdultLabel" AssociatedControlID="EditAdult" Text="Adult Content" runat="server" CssClass="control-label col-md-3" />
                            <div class="col-md-1">
                                <asp:CheckBox ID="EditAdult" runat="server" CssClass="checkbox" />
                            </div>
                        </div>
                        <asp:Button ID="SaveUserDetailsButton" Text="Save" runat="server" CssClass="btn btn-primary btn-block" />
                    </div>
                </section>
            </div>
        </div>
    </section>
</asp:Content>
