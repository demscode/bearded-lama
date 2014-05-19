<%@ Page Title="Account Settings" Language="C#" MasterPageFile="~/Templates/Container.Master" AutoEventWireup="true" CodeBehind="Settings.aspx.cs" Inherits="WebPresentation.Views.MembersOnly.Settings" %>
<%@ Register TagPrefix="uc" TagName="EditUserDetails" Src="~/Templates/UserControls/EditMembershipUserDetails.ascx" %>
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
                <uc:EditUserDetails ID="UserControlEditUserDetails" runat="server" />
            </div>
        </div>
    </section>
</asp:Content>
