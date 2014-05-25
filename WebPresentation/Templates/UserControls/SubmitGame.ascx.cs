using System;
using System.Collections.Generic;
using System.Configuration;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.IO;
using BusinessLogic.Games;
using JsonSchemaException = Newtonsoft.Json.Schema.JsonSchemaException;
using ZipException = Ionic.Zip.ZipException;
using System.Web.Routing;

namespace WebPresentation.Templates.UserControls
{
    public partial class SubmitGame : System.Web.UI.UserControl
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void submitPackageButton_ServerClick(object sender, EventArgs e)
        {
            if (Page.IsValid)
            {
                ChangePanelStatus("Submitting...", "info", true, "info");
                if (AttachPackage.HasFile)
                {
                    string fullPath = Path.GetFullPath( ConfigurationManager.AppSettings["UploadPath"] + "/Temp/" + AttachPackage.FileName );
                    AttachPackage.SaveAs(fullPath);
                    try
                    {
                        // each word into seperate array values
                        string[] tags = EditTags.Text.Split(' ');
                        string[] categories = { EditCategory.SelectedValue };

                        PackageInfo submittedPackageInfo =
                            Package.SubmitNewPackage(fullPath, (long)System.Web.Security.Membership.GetUser().ProviderUserKey,
                            EditName.Text, EditDescription.Text, tags, categories, EditAdult.Checked);
                        ChangePanelStatus("Submitted!", "success", false, "success");
                        ShowSuccessMessage(submittedPackageInfo.Name, long.Parse(submittedPackageInfo.Id));
                    }
                    catch (JsonSchemaException jsonException)
                    {
                        ChangePanelStatus("Fix bearded-lama.json!", "warning", false, "warning");
                        IList<string> messages = (List<string>)jsonException.Data["validationMessages"];
                        foreach (string message in messages)
                        {
                            CustomValidator newValidator = new CustomValidator();
                            newValidator.ErrorMessage = "" + message;
                            newValidator.IsValid = false;
                            Page.Validators.Add(newValidator); // shows in the pages ValidationSummary control
                        }
                    }
                    catch (ZipException zipException)
                    {
                        ChangePanelStatus("Your package is whack.", "warning", false, "warning");
                        CustomValidator newValidator = new CustomValidator();
                        newValidator.ErrorMessage = zipException.Message;
                        newValidator.IsValid = false;
                        Page.Validators.Add(newValidator);
                    }
                    catch (Exception allException)
                    {
                        ChangePanelStatus("Oh-oh.", "danger", true, "danger");
                        CustomValidator newValidator = new CustomValidator();
                        newValidator.ErrorMessage = allException.Message;
                        newValidator.IsValid = false;
                        Page.Validators.Add(newValidator);
                    }
                }
            }
        }

        private void ChangePanelStatus(string buttonStatusText, string buttonContext = "default", bool buttonDisabled = false,
            string panelContext = "default")
        {
            SubmitPackageButton.Text = buttonStatusText;
            string classDisable = "";
            if (buttonDisabled)
            {
                classDisable = " disabled";
            }
            SubmitPackageButton.CssClass = "btn btn-" + buttonContext + " btn-block" + classDisable;
            contentPanel.Attributes.Remove("class");
            contentPanel.Attributes.Add("class", "panel panel-" + panelContext);
        }

        private void ShowSuccessMessage(string newGameName, long gameId)
        {
            gameName.InnerText = newGameName;
            RouteValueDictionary parameters = new RouteValueDictionary {
                {"id", gameId}
            };
            SubmittedGamePage.NavigateUrl = GetRouteUrl("game-page", parameters);

            formContent.Attributes.Add("hidden", "hidden");
            submissionSuccessMessage.Attributes.Remove("hidden");
        }
    }
}