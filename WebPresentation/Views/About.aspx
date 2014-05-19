<%@ Page Title="About" Language="C#" MasterPageFile="~/Templates/Container.Master" AutoEventWireup="true" CodeBehind="About.aspx.cs" Inherits="WebPresentation.Views.About" %>
<asp:Content ID="MainAbout" ContentPlaceHolderID="Main" runat="server">
    <section class="container">
        <div class="push"></div>
        <div class="row">
            <article class="col-md-6 well">
                <h2>About Bearded Lama</h2>
                <p>Browser games can be pretty cool. Making them; even cooler. We want our users to play the games our other users have submitted.
                    We also think that being social, for any kind of online gameplay, is something that people inherently expect. So we got that covered too.</p>
                <p>When it comes down to it, Bearded Lama is a games portal. Submit games or play games. Up to you.</p>
                <p class="muted">Yes, it should probably be spelt Bearded <em>Llama</em>, but we live in an imperfect world. We're not even referring
                    to a Llama but instead a <a href="//google.com/search?q=define+lama">Mongolian Buddhist monk</a>.</p>
            </article>
            <div class="col-md-6">
                <h2>Plans</h2>
                <p>You can find our issue tracker at our <a href="//github.com/knotsoftware/bearded-lama/issues">GitHub repository</a>.</p>
                <p>Some generally planned features:</p>
                <ul class="">
                    <li>New Name</li>
                    <li>Submission
                        <ul>
                            <li>GitHub/Bitbucket Repositores</li>
                            <li><em>Push</em> API</li>
                        </ul>
                    </li>
                    <li>Single Sign-on
                        <ul>
                            <li>GitHub</li>
                            <li>Google+</li>
                            <li>Twitter</li>
                        </ul>
                    </li>
                    <li>Server-side Game Logic</li>
                    <li><a href="mono-project.com">Mono</a> Support</li>
                </ul>
            </div>
        </div>
    </section>

</asp:Content>
