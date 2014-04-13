using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Kontakter.Model;

namespace Kontakter
{
    public partial class Default : System.Web.UI.Page
    {
        private Service _service;
        private Service Service
        {
            get
            {
                return _service ?? (_service = new Service());
            }
        }
        protected void Page_Load(object sender, EventArgs e)
        {
            ContactsList.InsertItemPosition = InsertItemPosition.None;
        }
        public IEnumerable<Contact> ContactsList_GetData(int maximumRows, int startRowIndex, out int totalRowCount)
        {
            return Service.GetContactsPageWise(maximumRows, startRowIndex, out totalRowCount);
        }
        public void ContactsList_InsertItem(Contact contact)
        {
            if (ModelState.IsValid)
            {
                try
                {
                    Service.SaveContact(contact);
                    SuccessMessageHolder.Visible = true;
                    SuccessMessage.Text = "Kontaktuppgiften har lagts till.";
                }
                catch
                {
                    ModelState.AddModelError(String.Empty, "Ett oväntat fel instäffade när kontakten skulle läggas till.");
                }
            }
        }
        public void ContactsList_UpdateItem(int contactId)
        {
            try
            {
                var contact = Service.GetContact(contactId);
                if (contact == null)
                {
                    // Hittade inte kontakten
                    ModelState.AddModelError(String.Empty, "Kontakten hittades inte.");
                    return;
                }
                if (TryUpdateModel(contact))
                {
                    Service.SaveContact(contact);
                    SuccessMessageHolder.Visible = true;
                    SuccessMessage.Text = "Kontaktuppgiften har uppdaterats.";
                }
            }
            catch
            {
                ModelState.AddModelError(String.Empty, "Ett oväntat fel inträffade när kontakten skulle uppdateras.");
            }
        }
        public void ContactsList_DeleteItem(int contactId)
        {
            try
            {
                Service.DeleteContact(contactId);
                SuccessMessageHolder.Visible = true;
                SuccessMessage.Text = "Kontaktuppgiften har tagits bort.";
            }
            catch
            {
                ModelState.AddModelError(String.Empty, "Ett oväntat fel inträffade när kontakten skulle tas bort.");
            }
        }

        protected void ShowInsertRow_Click(object sender, EventArgs e)
        {
            ContactsList.InsertItemPosition = InsertItemPosition.LastItem;
            ShowInsertRow.Enabled = false;
        }
    }
}