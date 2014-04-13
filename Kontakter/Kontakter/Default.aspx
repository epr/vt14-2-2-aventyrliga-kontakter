<%@ Page ViewStateMode="Disabled" Language="C#" AutoEventWireup="true" CodeBehind="Default.aspx.cs" Inherits="Kontakter.Default" %>

<!DOCTYPE html>
<html>
<head runat="server">
    <title>Äventyrliga kontakter - Eddy Proca</title>
</head>
<body>
    <form id="ContactsForm" runat="server">
        <div>
            <asp:ListView ID="ContactsList" runat="server" ItemType="Kontakter.Model.Contact" 
                SelectMethod="ContactsList_GetData" 
                InsertMethod="ContactsList_InsertItem" 
                UpdateMethod="ContactsList_UpdateItem" 
                DeleteMethod="ContactsList_DeleteItem">
                <LayoutTemplate>
                    <table>
                        <thead>
                            <th>Förnamn</th>
                            <th>Efternamn</th>
                            <th>E-post</th>
                        </thead>
                        <asp:PlaceHolder ID="itemPlaceHolder" runat="server"></asp:PlaceHolder>
                    </table>
                </LayoutTemplate>
                <ItemTemplate>
                    <tr>
                        <td>
                            <%#: Item.FirstName %>
                        </td>
                        <td>
                            <%#: Item.LastName %>
                        </td>
                        <td>
                            <%#: Item.EmailAddress %>
                        </td>
                    </tr>
                </ItemTemplate>
            </asp:ListView>
        </div>
    </form>
</body>
</html>
