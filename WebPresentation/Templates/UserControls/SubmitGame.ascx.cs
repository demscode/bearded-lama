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
                SubmitButtonStatus("Submitting...", "info", true);
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
                        SubmitButtonStatus("Submitted!", "success", false);
                        ShowSuccessMessage(submittedPackageInfo.Name, long.Parse(submittedPackageInfo.Id));
                    }
                    catch (JsonSchemaException jsonException)
                    {
                        SubmitButtonStatus("Fix bearded-lama.json!", "warning", false);
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
                        SubmitButtonStatus("Your package is whack.", "warning", false);
                        CustomValidator newValidator = new CustomValidator();
                        newValidator.ErrorMessage = zipException.Message;
                        newValidator.IsValid = false;
                        Page.Validators.Add(newValidator);
                    }
                    catch (Exception allException)
                    {
                        SubmitButtonStatus("Oh-oh.", "danger", false);
                        CustomValidator newValidator = new CustomValidator();
                        newValidator.ErrorMessage = allException.Message;
                        newValidator.IsValid = false;
                        Page.Validators.Add(newValidator);
                    }
                }
            }
        }

        private void SubmitButtonStatus(string status, string bootstrapContext, bool disabled)
        {
            SubmitPackageButton.Text = status;
            string classDisable = "";
            if (disabled)
            {
                classDisable = " disabled";
            }
            SubmitPackageButton.CssClass = "btn btn-" + bootstrapContext + " btn-block" + classDisable;
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