using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Web;

namespace Kontakter.Model
{
    public class Contact
    {
        public int ContactId { get; set; }

        [Required(ErrorMessage="E-postadress måste anges.")]
        [MaxLength(50)]
        [RegularExpression(".+@.+..+", ErrorMessage="E-postadressen verkar inte vara korrekt.")]
        public string EmailAddress { get; set; }

        [Required(ErrorMessage = "Förnamn måste anges.")]
        [MaxLength(50)]
        public string FirstName { get; set; }

        [Required(ErrorMessage = "Efternamn måste anges.")]
        [MaxLength(50)]
        public string LastName { get; set; }
    }
}