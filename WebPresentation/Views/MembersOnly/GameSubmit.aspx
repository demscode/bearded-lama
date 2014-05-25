<%@ Page Title="Submit Game" Language="C#" MasterPageFile="~/Templates/Container.Master" AutoEventWireup="true" CodeBehind="GameSubmit.aspx.cs" Inherits="WebPresentation.Views.GameSubmit" %>
<%@ Register TagPrefix="uc" TagName="SubmitGame" Src="~/Templates/UserControls/SubmitGame.ascx" %>
<asp:Content ID="MainGameSubmit" ContentPlaceHolderID="Main" runat="server">
    <section class="container">
        <h1 class="page-header">Game Submission</h1>

        <div class="row">
            <div class="col-md-8 col-md-offset-2 ">
                <uc:SubmitGame runat="server" />
            </div>
        </div>

        <h2 id="getting-started" class="page-header">Getting Started <a href="#getting-started">#</a></h2>
        <h3>Step one: Login</h3>
        <p>To get started, you first have to be logged in to a Bearded Lama account.</p>
        <h3>Step two: Tweak your Game Project</h3>
        <p>Some requirements need to be met for your game to run on Bearded Lama. The easy parts are:</p>
        <ol>
            <li>Single HTML element entry point.</li>
            <li>Javascript in seperate file(s).</li>
        </ol>
        <p>Read about the other requirements in the <a href="#documentation">documentation</a>.</p>
        <h3>Step three: Add bearded.json to your Game Project</h3>
        <p>Your <code>bearded.json</code> tells Bearded Lama information about how to use the game.</p>
<pre>
{
	"data": {
        "js": [
		    "src/game.js",
		    "src/levels.js"
	    ],
        "content": [
            "src/logo.png",
            "src/sprites.png"
        ]
    },
	"entry": {
		"element":	    "canvas",
		"elementid":    "game",
		"height":	    "480",
		"width":	    "600"
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
                <h4 class="list-group-item-heading"><code>name</code></h4>
                <p class="list-group-item-text">The games name.</p>
            </div>
            <div class="list-group-item">
                <h4 class="list-group-item-heading"><code>information</code> <small>string</small></h4>
                <p class="list-group-item-text">A description of the game.</p>
            </div>
            <div class="list-group-item">
                <h4 class="list-group-item-heading"><code>instruction</code> <small>string</small></h4>
                <p class="list-group-item-text">The instructions of a game.</p>
            </div>
            <div class="list-group-item">
                <h4 class="list-group-item-heading"><code>data</code> <small>object</small> <small class="text-danger"><strong>required</strong></small></h4>
                <p class="list-group-item-text">Files required for the Game.</p>
                <div class="list-group-item list-group-item-info">
                    <h4 class="list-group-item-heading"><code>js</code> <small>array</small> <small class="text-danger"><strong>required</strong></small></h4>
                    <p class="list-group-item-text">An array of relative path strings to each javascript file.</p>
                </div>
                <div class="list-group-item list-group-item-info">
                    <h4 class="list-group-item-heading"><code>content</code> <small>array</small></h4>
                    <p class="list-group-item-text">An array of relative path strings to additional files, like <em>images</em>.</p>
                </div>
            </div>
            <div class="list-group-item">
                <h4 class="list-group-item-heading"><code>entry</code> <small>object</small> <small class="text-danger"><strong>required</strong></small></h4>
                <p class="list-group-item-text">Describes the HTML entry point for the game.</p>
                <div class="list-group-item list-group-item-info">
                    <h4 class="list-group-item-heading"><code>element</code> <small>string</small> <small class="text-danger"><strong>required</strong></small></h4>
                    <p class="list-group-item-text">The HTML <strong>element</strong> to use for the games entry point.</p>
                </div>
                <div class="list-group-item list-group-item-info">
                    <h4 class="list-group-item-heading"><code>elementid</code> <small>string</small> <small class="text-danger"><strong>required</strong></small></h4>
                    <p class="list-group-item-text">The entry points <strong>id attribute</strong>.</p>
                </div>
                <div class="list-group-item list-group-item-info">
                    <h4 class="list-group-item-heading"><code>height</code> <small>string</small> <small class="text-danger"><strong>required</strong></small></h4>
                    <p class="list-group-item-text">The fixed <strong>height attribute</strong> for the entry point.</p>
                </div>
                <div class="list-group-item list-group-item-info">
                    <h4 class="list-group-item-heading"><code>width</code> <small>string</small> <small class="text-danger"><strong>required</strong></small></h4>
                    <p class="list-group-item-text">The fixed <strong>width attribute</strong> for the entry point.</p>
                </div>
            </div>
        </div>
    </section>
    <div class="push"></div>
</asp:Content>
