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
                }
                catch
                {
                    ModelState.AddModelError(String.Empty, "Ett oväntat fel instäffade då kontakten skulle läggas till.");
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
                    ModelState.AddModelError(String.Empty, String.Format("Item with id {0} was not found", contactId));
                    return;
                }
                if (TryUpdateModel(contact))
                {
                    Service.SaveContact(contact);
                }
            }
            catch
            {
                ModelState.AddModelError(String.Empty, "Ett oväntat fel instäffade då kontakten skulle uppdateras.");
            }
        }
        public void ContactsList_DeleteItem(int contactId)
        {
            try
            {
                Service.DeleteContact(contactId);
            }
            catch
            {
                ModelState.AddModelError(String.Empty, "Ett oväntat fel instäffade då kontakten skulle tas bort.");
            }
        }

        protected void ShowInsertRow_Click(object sender, EventArgs e)
        {
            ContactsList.InsertItemPosition = InsertItemPosition.LastItem;
            ShowInsertRow.Enabled = false;
        }
    }
}