using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;

namespace Kontakter.Model.DAL
{
    public class ContactDAL : DALBase
    {
        public static IEnumerable<Contact> GetContacts()
        {
            using (var conn = CreateConnection())
            {
                try
                {
                    var contacts = new List<Contact>(100);
                    var cmd = new SqlCommand("Person.uspGetContacts", conn);
                    cmd.CommandType = CommandType.StoredProcedure;
                    conn.Open();
                    using (var reader = cmd.ExecuteReader())
                    {
                        var contactIdIndex = reader.GetOrdinal("ContactID");
                        var emailAddressIndex = reader.GetOrdinal("EmailAddress");
                        var firstNameIndex = reader.GetOrdinal("FirstName");
                        var lastNameIndex = reader.GetOrdinal("LastName");
                        while (reader.Read())
                        {
                            contacts.Add(new Contact
                            {
                                ContactID = reader.GetInt32(contactIdIndex),
                                EmailAddress = reader.GetString(emailAddressIndex),
                                FirstName = reader.GetString(firstNameIndex),
                                LastName = reader.GetString(lastNameIndex)
                            });
                        }
                    }
                    contacts.TrimExcess();
                    return contacts;
                }
                catch
                {
                    throw new ApplicationException("Fel uppstod vid uppkoppling till databasen.");
                }
            }
        }
        public static Contact GetContactById(int contactId)
        {
            using (var conn = CreateConnection())
            {
                try
                {
                    var cmd = new SqlCommand("Person.uspGetContact", conn);
                    cmd.CommandType = CommandType.StoredProcedure;
                    cmd.Parameters.AddWithValue("@ContactID", contactId);
                    conn.Open();
                    using (var reader = cmd.ExecuteReader())
                    {
                        if (reader.Read())
                        {
                            var contactIdIndex = reader.GetOrdinal("ContactID");
                            var emailAddressIndex = reader.GetOrdinal("EmailAddress");
                            var firstNameIndex = reader.GetOrdinal("FirstName");
                            var lastNameIndex = reader.GetOrdinal("LastName");
                            return new Contact
                            {
                                ContactID = reader.GetInt32(contactIdIndex),
                                EmailAddress = reader.GetString(emailAddressIndex),
                                FirstName = reader.GetString(firstNameIndex),
                                LastName = reader.GetString(lastNameIndex)
                            };
                        }
                    }
                    return null;
                }
                catch
                {
                    throw new ApplicationException("Fel uppstod vid uppkoppling till databasen");
                }
            }
        }
    }
}