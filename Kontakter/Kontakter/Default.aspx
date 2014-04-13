<%@ Page ViewStateMode="Disabled" Language="C#" AutoEventWireup="true" CodeBehind="Default.aspx.cs" Inherits="Kontakter.Default" %>

<!DOCTYPE html>
<html>
<head runat="server">
    <title>Äventyrliga kontakter - Eddy Proca</title>
    <link rel="stylesheet" href="Style/screen.css">
</head>
<body>
    <form id="ContactsForm" runat="server">
        <div>
            <asp:ValidationSummary ID="ValidationSummary" runat="server" HeaderText="Fel inträffade. Korrigera det som är fel och försök igen." />
            <asp:Button ID="ShowInsertRow" runat="server" Text="Ny kontakt" OnClick="ShowInsertRow_Click" />
            <asp:ListView ID="ContactsList" runat="server" ItemType="Kontakter.Model.Contact" 
                SelectMethod="ContactsList_GetData" 
                InsertMethod="ContactsList_InsertItem" 
                UpdateMethod="ContactsList_UpdateItem" 
                DeleteMethod="ContactsList_DeleteItem"
                DataKeyNames="ContactID" InsertItemPosition="LastItem">
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
                            <asp:NumericPagerField ButtonCount="30" />
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
                            <asp:LinkButton runat="server" CommandName="Edit">Redigera</asp:LinkButton>
                            <asp:LinkButton runat="server" CommandName="Delete">Ta bort</asp:LinkButton>
                        </td>
                    </tr>
                </ItemTemplate>
                <InsertItemTemplate>
                    <tr>
                        <td>
                            <asp:TextBox ID="FirstName" runat="server" Text="<%#: BindItem.FirstName %>" MaxLength="50"></asp:TextBox>
                            <asp:RequiredFieldValidator ControlToValidate="FirstName" ID="RequiredFirstName" runat="server" ErrorMessage="Förnamn måste anges" Text="*" Display="None" SetFocusOnError="True"></asp:RequiredFieldValidator>
                        </td>
                        <td>
                            <asp:TextBox ID="LastName" runat="server" Text="<%#: BindItem.LastName %>" MaxLength="50"></asp:TextBox>
                            <asp:RequiredFieldValidator ControlToValidate="LastName" ID="RequiredLastName" runat="server" ErrorMessage="Efternamn måste anges" Text="*" Display="None" SetFocusOnError="True"></asp:RequiredFieldValidator>
                        </td>
                        <td>
                            <asp:TextBox ID="EmailAddress" runat="server" Text="<%#: BindItem.EmailAddress %>" MaxLength="50"></asp:TextBox>
                            <asp:RequiredFieldValidator ControlToValidate="EmailAddress" ID="RequiredEmailAddress" runat="server" ErrorMessage="E-post måste anges" Text="*" Display="None" SetFocusOnError="True"></asp:RequiredFieldValidator>
                        </td>
                        <td>
                            <asp:LinkButton runat="server" CommandName="Insert">Spara</asp:LinkButton>
                            <asp:LinkButton runat="server" CommandName="Cancel" CausesValidation="false">Avbryt</asp:LinkButton>
                        </td>
                    </tr>
                </InsertItemTemplate>
                <EditItemTemplate>
                    <tr>
                        <td>
                            <asp:TextBox ID="FirstName" runat="server" Text="<%#: BindItem.FirstName %>" MaxLength="50"></asp:TextBox>
                            <asp:RequiredFieldValidator ControlToValidate="FirstName" ID="RequiredFirstName" runat="server" ErrorMessage="Förnamn måste anges" Text="*" Display="None" SetFocusOnError="True"></asp:RequiredFieldValidator>
                        </td>
                        <td>
                            <asp:TextBox ID="LastName" runat="server" Text="<%#: BindItem.LastName %>" MaxLength="50"></asp:TextBox>
                            <asp:RequiredFieldValidator ControlToValidate="LastName" ID="RequiredLastName" runat="server" ErrorMessage="Efternamn måste anges" Text="*" Display="None" SetFocusOnError="True"></asp:RequiredFieldValidator>
                        </td>
                        <td>
                            <asp:TextBox ID="EmailAddress" runat="server" Text="<%#: BindItem.EmailAddress %>" MaxLength="50"></asp:TextBox>
                            <asp:RequiredFieldValidator ControlToValidate="EmailAddress" ID="RequiredEmailAddress" runat="server" ErrorMessage="E-post måste anges" Text="*" Display="None" SetFocusOnError="True"></asp:RequiredFieldValidator>
                        </td>
                        <td>
                            <asp:LinkButton runat="server" CommandName="Update">Spara</asp:LinkButton>
                            <asp:LinkButton runat="server" CommandName="Cancel" CausesValidation="false">Avbryt</asp:LinkButton>
                        </td>
                    </tr>
                </EditItemTemplate>
                <EmptyDataTemplate>
                    <p>Det finns inga kontakter.</p>
                </EmptyDataTemplate>
            </asp:ListView>
        </div>
    </form>
</body>
</html>
