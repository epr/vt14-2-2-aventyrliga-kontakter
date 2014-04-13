using Kontakter.Model.DAL;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace Kontakter.Model
{
    public class Service
    {
        private ContactDAL _contactDAL;
        private ContactDAL ContactDAL
        {
            get
            {
                return _contactDAL ?? (_contactDAL = new ContactDAL());
            }
        }
        public Contact GetContact(int contactId)
        {
            return ContactDAL.GetContactById(contactId);
        }
        public IEnumerable<Contact> GetContacts()
        {
            return ContactDAL.GetContacts();
        }
        public IEnumerable<Contact> GetContactsPageWise(int maximumRows, int startRowIndex, out int totalRowCount)
        {
            return ContactDAL.GetContactsPageWise(maximumRows, startRowIndex, out totalRowCount);
        }
        public void SaveContact(Contact contact)
        {
            if (contact.ContactId == 0)
            {
                ContactDAL.InsertContact(contact);
            }
            else
            {
                ContactDAL.UpdateContact(contact);
            }
        }
        public void DeleteContact(int contactId)
        {
            ContactDAL.DeleteContact(contactId);
        }
    }
}