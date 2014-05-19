<%@ Page Title="Submit Game" Language="C#" MasterPageFile="~/Templates/Container.Master" AutoEventWireup="true" CodeBehind="GameSubmit.aspx.cs" Inherits="WebPresentation.Views.GameSubmit" %>
<asp:Content ID="MainGameSubmit" ContentPlaceHolderID="Main" runat="server">
    <section class="container">
        <div class="row">
            <%-- Game submission form --%>
        </div>

        <h2 id="getting-started" class="page-header">Getting Started <a href="#getting-started">#</a></h2>
        <h3>Step one: Login</h3>
        <p>To get started, you first have to be logged in to a Bearded Lama account.</p>
        <h3>Step two: Tweak your Game Project</h3>
        <p>Some requirements need to be met for your game to run on Bearded Lama. The easy parts are:
            <ol>
                <li>Single HTML element entry point.</li>
                <li>Javascript in seperate file(s).</li>
            </ol>
        </p>
        <p>Read about the other requirements in the <a href="#documentation">documentation</a>.</p>
        <h3>Step three: Add bearded.json to your Game Project</h3>
        <p>Your <code>bearded.json</code> tells Bearded Lama information about how to use the game.</p>
<pre>
{
	"js": [
		"/src/game2.js",
		"/src/levels.js"
	],
	"entry": {
		"element":	"canvas",
		"id":		"game",
		"height":	"480",
		"width":	"600"
	}
}
</pre>
        <p>Read about the configuration options in the <a href="#documentation">documentation</a>.</p>

        <h2 id="documentation" class="page-header">Documentation <a href="#documentation">#</a></h2>
        <h3>Requirements</h3>
        <p>Your game must be configured and packaged a particular way, before Bearded Lama can use it.</p>
        <div class="list-group">
            <div class="list-group-item">
                <h4 class="list-group-item-heading">Tweaking</h4>
                <ul class="list-unstyled">
                    <li>Your game must have only <strong>one</strong> entry into the page.
                        <ol>
                            <li>Specified HTML element. Usually <code>&lt;canvas /&gt;</code></li>
                            <li>Specified id attribute.
                            <em>ie.</em> You chose to use <code>game</code>, your entry point would look like <code>&lt;canvas id="game" /&gt;</code></li>
                        </ol>
                    </li>
                    <li>The javascript files for the game must be in <strong>seperate</strong> files.
                        <ul>
                            <li>Accessing the game logic would be impossible, otherwise.</li>
                            <li>If you have more than one js file, take note of the load order.</li>
                        </ul>
                    </li>
                </ul>
            </div>
            <div class="list-group-item">
                <h4 class="list-group-item-heading">Packaging</h4>
                <ul class="list-unstyled">
                    <li>It is required to have <code>bearded.json</code> in <code>/</code>.</li>
                    <li>Suggested:
<pre>
/
/bearded.json
/src/game.js
/src/levels.js
/img/sprites.png
/sounds/hit.ogg
</pre>
                    </li>
                    <li>The game must compressed in a <code>.zip</code> when submitting to Bearded Lama.</li>
                </ul>
            </div>
        </div>

        <h3>Configuration <small>bearded.json</small></h3>
        <p>The <code>bearded.json</code> is a configuration file that is interpreted by Bearded Lama. Without it, the game cannot be submitted.</p>
        <p>Here are the recognised attributes in <code>bearded.json</code>:</p>
        <div class="list-group">
            <div class="list-group-item">
                <h4 class="list-group-item-heading">entry</h4>
                <p class="list-group-item-text">Describes the HTML entry point for the game.</p>
                <div class="list-group-item list-group-item-info">
                    <h4 class="list-group-item-heading">element</h4>
                    <p class="list-group-item-text">The HTML <strong>element</strong> to use for the games entry point.</p>
                </div>
                <div class="list-group-item list-group-item-info">
                    <h4 class="list-group-item-heading">id</h4>
                    <p class="list-group-item-text">The entry points <strong>id attribute</strong>.</p>
                </div>
                <div class="list-group-item list-group-item-info">
                    <h4 class="list-group-item-heading">height</h4>
                    <p class="list-group-item-text">The fixed <strong>height attribute</strong> for the entry point.</p>
                </div>
                <div class="list-group-item list-group-item-info">
                    <h4 class="list-group-item-heading">width</h4>
                    <p class="list-group-item-text">The fixed <strong>width attribute</strong> for the entry point.</p>
                </div>
            </div>
            <div class="list-group-item">
                <h4 class="list-group-item-heading">js</h4>
                <p class="list-group-item-text">An array of relative path strings to each javascript file.</p>
            </div>
        </div>
    </section>
    <div class="push"></div>
</asp:Content>
