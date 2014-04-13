﻿<%@ Page ViewStateMode="Disabled" Language="C#" AutoEventWireup="true" CodeBehind="Default.aspx.cs" Inherits="Kontakter.Default" %>

<!DOCTYPE html>
<html>
<head runat="server">
    <title>Äventyrliga kontakter - Eddy Proca</title>
    <link rel="stylesheet" href="Style/screen.css">
</head>
<body>
    <h1>Äventyrliga kontakter</h1>
    <form id="ContactsForm" runat="server">
        <div>
            <%-- Fel- och rättmeddelanden --%>
            <asp:ValidationSummary ID="ValidationSummary" runat="server" HeaderText="Fel inträffade. Korrigera det som är fel och försök igen." />
            <asp:PlaceHolder ID="SuccessMessageHolder" runat="server" Visible="false">
                <div id="MessageBox">
                    <asp:Label ID="SuccessMessage" runat="server" Text="hej"></asp:Label>
                    <button ID="CloseMessage">✖</button>
                </div>
            </asp:PlaceHolder>
            <%-- Visa rad för ny post --%>
            <asp:Button ID="ShowInsertRow" runat="server" Text="Ny kontakt" OnClick="ShowInsertRow_Click" />
            <%-- Kontaktlista --%>
            <asp:ListView ID="ContactsList" runat="server" ItemType="Kontakter.Model.Contact" SelectMethod="ContactsList_GetData" InsertMethod="ContactsList_InsertItem" 
                UpdateMethod="ContactsList_UpdateItem" DeleteMethod="ContactsList_DeleteItem" DataKeyNames="ContactID" InsertItemPosition="LastItem">
                <LayoutTemplate>
                    <table>
                        <thead>
                            <th>Förnamn</th>
                            <th>Efternamn</th>
                            <th>E-post</th>
                            <th>Redigera/Ta bort</th>
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
                <%-- Kontakttemplate --%>
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
                            <asp:LinkButton runat="server" CommandName="Delete" OnClientClick="if (!confirm('Ta bort kontakten permanent?')) return false;" CausesValidation="false">Ta bort</asp:LinkButton>
                        </td>
                    </tr>
                </ItemTemplate>
                <%-- Infoga ny kontakt --%>
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
                            <asp:RegularExpressionValidator ControlToValidate="EmailAddress" ID="CorrectEmailAddress" runat="server" ErrorMessage="E-postadressen verkar inte vara korrekt." ValidationExpression=".+\@.+\..+" Display="None" SetFocusOnError="true"></asp:RegularExpressionValidator>
                        </td>
                        <td>
                            <asp:LinkButton runat="server" CommandName="Insert">Spara</asp:LinkButton>
                            <asp:LinkButton runat="server" CommandName="Cancel" CausesValidation="false">Avbryt</asp:LinkButton>
                        </td>
                    </tr>
                </InsertItemTemplate>
                <%-- Redigera kontakt --%>
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
                            <asp:RegularExpressionValidator ControlToValidate="EmailAddress" ID="CorrectEmailAddress" runat="server" ErrorMessage="E-postadressen verkar inte vara korrekt." ValidationExpression=".+\@.+\..+" Display="None" SetFocusOnError="true"></asp:RegularExpressionValidator>
                        </td>
                        <td>
                            <asp:LinkButton runat="server" CommandName="Update">Spara</asp:LinkButton>
                            <asp:LinkButton runat="server" CommandName="Cancel" CausesValidation="false">Avbryt</asp:LinkButton>
                        </td>
                    </tr>
                </EditItemTemplate>
                <%-- Visas om det inte finns några kontakter --%>
                <EmptyDataTemplate>
                    <p>Det finns inga kontakter.</p>
                </EmptyDataTemplate>
            </asp:ListView>
        </div>
    </form>
    <script src="Scripts/kontakter.js"></script>
</body>
</html>
