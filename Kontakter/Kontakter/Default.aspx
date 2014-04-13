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
                DeleteMethod="ContactsList_DeleteItem"
                DataKeyNames="ContactID" InsertItemPosition="FirstItem">
                <LayoutTemplate>
                    <table>
                        <thead>
                            <th>Förnamn</th>
                            <th>Efternamn</th>
                            <th>E-post</th>
                        </thead>
                        <asp:PlaceHolder ID="itemPlaceHolder" runat="server"></asp:PlaceHolder>
                    </table>
                    <asp:DataPager ID="ContactsPager" runat="server" PagedControlID="ContactsList" PageSize="20">
                        <Fields>
                            <asp:NextPreviousPagerField ButtonType="Button" ShowFirstPageButton="true" ShowPreviousPageButton="false" ShowNextPageButton="false" FirstPageText="Första" />
                            <asp:NumericPagerField />
                            <asp:NextPreviousPagerField ButtonType="Button" ShowLastPageButton="true" ShowPreviousPageButton="false" ShowNextPageButton="false" LastPageText="Sista" />
                        </Fields>
                    </asp:DataPager>
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
                        <td>
                            <asp:LinkButton ID="DeleteButton" runat="server" CommandName="Delete">Ta bort</asp:LinkButton>
                        </td>
                    </tr>
                </ItemTemplate>
                <InsertItemTemplate>
                    <tr>
                        <td>
                            <asp:TextBox ID="FirstNameInput" runat="server" Text="<%#: BindItem.FirstName %>"></asp:TextBox>
                        </td>
                        <td>
                            <asp:TextBox ID="LastNameInput" runat="server" Text="<%#: BindItem.LastName %>"></asp:TextBox>
                        </td>
                        <td>
                            <asp:TextBox ID="EmailInput" runat="server" Text="<%#: BindItem.EmailAddress %>"></asp:TextBox>
                        </td>
                        <td>
                            <asp:LinkButton ID="InsertButton" runat="server" CommandName="Insert">Spara</asp:LinkButton>
                            <asp:LinkButton ID="CancelButton" runat="server" CommandName="Cancel">Avbryt</asp:LinkButton>
                        </td>
                    </tr>
                </InsertItemTemplate>
                <EmptyDataTemplate>
                    <p>Det finns inga kontakter.</p>
                </EmptyDataTemplate>
            </asp:ListView>
        </div>
    </form>
</body>
</html>
