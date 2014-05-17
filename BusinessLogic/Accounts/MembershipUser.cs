using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Web.Security;

namespace BusinessLogic.Accounts
{
    /// <summary>
    /// Exposes an instance of a users membership information.
    /// </summary>
    public class User : MembershipUser
    {
        public User(string providername,
            string username,
            object providerUserKey,
            string email,
            string comments,
            bool adult,
            DateTime creationDate) :
            base()
        {
        }
    }
}
