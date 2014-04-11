using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace Kontakter.Model
{
    public class Contact
    {
        public int ContactID { get; set; }
        public string EmailAddress { get; set; }
        public string FirstName { get; set; }
        public string LastName { get; set; }
    }
}