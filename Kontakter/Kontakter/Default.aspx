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

            </asp:ListView>
        </div>
    </form>
</body>
</html>
