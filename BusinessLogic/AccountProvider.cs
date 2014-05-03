using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Web.Security;

namespace BusinessLogic
{
    // Cannot find System.Web.Security.MembershipProvider
    class AccountProvider : System.Web.Security.SqlMembershipProvider
    {

    }
}
