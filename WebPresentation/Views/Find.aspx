<%@ Page Title="Search Results" Language="C#" MasterPageFile="~/Templates/Container.Master" AutoEventWireup="true" CodeBehind="Find.aspx.cs" Inherits="WebPresentation.Views.Find" %>

<%@ Register Src="~/Templates/UserControls/GameBox.ascx" TagPrefix="uc1" TagName="GameBox" %>

<asp:Content ID="Content1" ContentPlaceHolderID="Main" runat="server">
    <section class="container">
        <h1 class="page-header">Search Results</h1>
        <h2>Query: <span id="searchQuery" runat="server"></span></h2>

        <section class="container">
            <div class="row">
                <h3>Name matches</h3>
                <section class="container-fluid">
                    <div class="row">
                        <h4 id="nameResultsHeader" runat="server"></h4>
                        <asp:Repeater ID="nameRepeater" runat="server">
                            <ItemTemplate>
                                <uc1:GameBox ID="GameBox1" runat="server"
                                    GameId='<%#DataBinder.Eval(Container.DataItem, "gameId")%>'
                                    GameName='<%#DataBinder.Eval(Container.DataItem, "gameName")%>'
                                    GameCategory='<%#DataBinder.Eval(Container.DataItem, "category")%>'
                                    GameDescription='<%#DataBinder.Eval(Container.DataItem, "gameDesc")%>' />
                            </ItemTemplate>
                        </asp:Repeater>
                    </div>
                </section>
            </div>
            <div class="row">
                <h3>Category matches</h3>
                <section class="container-fluid">
                    <div class="row">
                        <h4 id="categoryResultsHeader" runat="server"></h4>
                        <asp:Repeater ID="categoryRepeater" runat="server">
                            <ItemTemplate>
                                <uc1:GameBox ID="GameBox2" runat="server"
                                    GameId='<%#DataBinder.Eval(Container.DataItem, "gameId")%>'
                                    GameName='<%#DataBinder.Eval(Container.DataItem, "gameName")%>'
                                    GameCategory='<%#DataBinder.Eval(Container.DataItem, "category")%>'
                                    GameDescription='<%#DataBinder.Eval(Container.DataItem, "gameDesc")%>' />
                            </ItemTemplate>
                        </asp:Repeater>
                    </div>
                </section>
            </div>
            <div class="row">
                <h3>Tags matches</h3>
                <section class="container-fluid">
                    <div class="row">
                        <h4 id="tagsResultsHeader" runat="server"></h4>
                        <asp:Repeater ID="tagsRepeater" runat="server">                            
                            <ItemTemplate>
                                <uc1:GameBox ID="GameBox3" runat="server"
                                    GameId='<%#DataBinder.Eval(Container.DataItem, "gameId")%>'
                                    GameName='<%#DataBinder.Eval(Container.DataItem, "gameName")%>'
                                    GameCategory='<%#DataBinder.Eval(Container.DataItem, "category")%>'
                                    GameDescription='<%#DataBinder.Eval(Container.DataItem, "gameDesc")%>' />
                            </ItemTemplate>
                        </asp:Repeater>
                    </div>
                </section>
            </div>
        </section>
    </section>

</asp:Content>
