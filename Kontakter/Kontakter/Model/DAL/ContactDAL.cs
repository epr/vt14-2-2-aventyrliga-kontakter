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
            using (var conn = CreateConnection()) // skapa uppkoppling
            {
                try
                {
                    var contacts = new List<Contact>(100); // skapa lista för kontakter
                    var cmd = new SqlCommand("Person.uspGetContacts", conn); // nytt kommando
                    cmd.CommandType = CommandType.StoredProcedure; // av typen lagrad procedur
                    conn.Open(); // öppna uppkopplingen
                    using (var reader = cmd.ExecuteReader()) // läs från kontakterna som returneras
                    { // hämta index
                        var contactIdIndex = reader.GetOrdinal("ContactID");
                        var emailAddressIndex = reader.GetOrdinal("EmailAddress");
                        var firstNameIndex = reader.GetOrdinal("FirstName");
                        var lastNameIndex = reader.GetOrdinal("LastName");
                        while (reader.Read()) // så länge det finns rader att läsa
                        {
                            contacts.Add(new Contact // skapa ny kontakt och lägg till den i listan
                            { // hämta kontaktegenskaper med hjälp av index
                                ContactId = reader.GetInt32(contactIdIndex),
                                EmailAddress = reader.GetString(emailAddressIndex),
                                FirstName = reader.GetString(firstNameIndex),
                                LastName = reader.GetString(lastNameIndex)
                            });
                        }
                    }
                    contacts.TrimExcess(); // trimma listan
                    return contacts; // returnera listan
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
                    cmd.Parameters.AddWithValue("@ContactID", contactId); // lägg till parameter till den lagrade proceduren
                    conn.Open();
                    using (var reader = cmd.ExecuteReader())
                    {
                        if (reader.Read()) // om det finns något att läsa
                        {
                            var contactIdIndex = reader.GetOrdinal("ContactID");
                            var emailAddressIndex = reader.GetOrdinal("EmailAddress");
                            var firstNameIndex = reader.GetOrdinal("FirstName");
                            var lastNameIndex = reader.GetOrdinal("LastName");
                            return new Contact
                            {
                                ContactId = reader.GetInt32(contactIdIndex),
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
        public static IEnumerable<Contact> GetContactsPageWise(int maximumRows, int startRowIndex, out int totalRowCount)
        {
            using (var conn = CreateConnection())
            {
                try
                {
                    var contacts = new List<Contact>(20);
                    var cmd = new SqlCommand("Person.uspGetContactsPageWise", conn);
                    cmd.CommandType = CommandType.StoredProcedure;
                    cmd.Parameters.AddWithValue("@PageIndex", startRowIndex / maximumRows + 1);
                    cmd.Parameters.AddWithValue("@PageSize", maximumRows);
                    cmd.Parameters.Add("@RecordCount", SqlDbType.Int).Direction = ParameterDirection.Output; // lägg till output-parameter
                    conn.Open();
                    cmd.ExecuteNonQuery();
                    totalRowCount = (int)cmd.Parameters["@RecordCount"].Value; // sätt output-värdet
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
                                ContactId = reader.GetInt32(contactIdIndex),
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
                    throw new ApplicationException("Fel uppstod vid uppkoppling till databasen");
                }
            }
        }
        public static void InsertContact(Contact contact)
        {
            using (var conn = CreateConnection())
            {
                try
                {
                    var cmd = new SqlCommand("Person.uspAddContact", conn);
                    cmd.CommandType = CommandType.StoredProcedure;
                    cmd.Parameters.AddWithValue("@FirstName", contact.FirstName);
                    cmd.Parameters.AddWithValue("@LastName", contact.LastName);
                    cmd.Parameters.AddWithValue("@EmailAddress", contact.EmailAddress);
                    cmd.Parameters.Add("@ContactID", SqlDbType.Int).Direction = ParameterDirection.Output;
                    conn.Open();
                    cmd.ExecuteNonQuery();
                    contact.ContactId = (int)cmd.Parameters["@ContactID"].Value;
                }
                catch
                {
                    throw new ApplicationException("Fel uppstod vid uppkoppling till databasen");
                }
            }
        }
        public static void DeleteContact(int contactId)
        {
            using (var conn = CreateConnection())
            {
                try
                {
                    var cmd = new SqlCommand("Person.uspRemoveContact", conn);
                    cmd.CommandType = CommandType.StoredProcedure;
                    cmd.Parameters.AddWithValue("@ContactID", contactId);
                    conn.Open();
                    cmd.ExecuteNonQuery();
                }
                catch
                {
                    throw new ApplicationException("Fel uppstod vid uppkoppling till databasen");
                }
            }
        }
        public static void UpdateContact(Contact contact)
        {
            using (var conn = CreateConnection())
            {
                try
                {
                    var cmd = new SqlCommand("Person.uspUpdateContact", conn);
                    cmd.CommandType = CommandType.StoredProcedure;
                    cmd.Parameters.AddWithValue("@ContactID", contact.ContactId);
                    cmd.Parameters.AddWithValue("@FirstName", contact.FirstName);
                    cmd.Parameters.AddWithValue("@LastName", contact.LastName);
                    cmd.Parameters.AddWithValue("@EmailAddress", contact.EmailAddress);
                    conn.Open();
                    cmd.ExecuteNonQuery();
                }
                catch
                {
                    throw new ApplicationException("Fel uppstod vid uppkoppling till databasen");
                }
            }
        }
    }
}