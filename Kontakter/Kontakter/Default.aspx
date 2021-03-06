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
            <asp:ValidationSummary ValidationGroup="InsertValidation" ShowModelStateErrors="false" ID="ValidationSummary1" CssClass="ValidationSummary" runat="server" HeaderText="Fel inträffade. Korrigera det som är fel och försök igen." />
            <asp:ValidationSummary ValidationGroup="EditValidation" ID="ValidationSummary2" CssClass="ValidationSummary" runat="server" HeaderText="Fel inträffade. Korrigera det som är fel och försök igen." />
            <asp:PlaceHolder ID="SuccessMessageHolder" runat="server" Visible="false">
                <div id="MessageBox">
                    <asp:Label ID="SuccessMessage" runat="server"></asp:Label>
                    <button ID="CloseMessage">✖</button>
                </div>
            </asp:PlaceHolder>
            <%-- Kontaktlista --%>
            <asp:ListView ID="ContactsList" runat="server" ItemType="Kontakter.Model.Contact" SelectMethod="ContactsList_GetData" InsertMethod="ContactsList_InsertItem" UpdateMethod="ContactsList_UpdateItem" DeleteMethod="ContactsList_DeleteItem" DataKeyNames="ContactID" InsertItemPosition="LastItem">
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
                            <asp:LinkButton runat="server" CommandName="Edit" CausesValidation="false">Redigera</asp:LinkButton>
                            <asp:LinkButton runat="server" CommandName="Delete" OnClientClick="if (!confirm('Ta bort kontakten permanent?')) return false;" CausesValidation="false">Ta bort</asp:LinkButton>
                        </td>
                    </tr>
                </ItemTemplate>
                <%-- Infoga ny kontakt --%>
                <InsertItemTemplate>
                    <tr>
                        <th colspan="4">Lägg till en ny kontakt</th>
                    </tr>
                    <tr>
                        <td>
                            <asp:TextBox ID="FirstName" runat="server" Text="<%#: BindItem.FirstName %>" MaxLength="50" placeholder="Förnamn"></asp:TextBox>
                            <asp:RequiredFieldValidator ValidationGroup="InsertValidation" ControlToValidate="FirstName" ID="RequiredFirstName" runat="server" ErrorMessage="Förnamn måste anges" Text="*" Display="None" SetFocusOnError="True"></asp:RequiredFieldValidator>
                        </td>
                        <td>
                            <asp:TextBox ID="LastName" runat="server" Text="<%#: BindItem.LastName %>" MaxLength="50" placeholder="Efternamn"></asp:TextBox>
                            <asp:RequiredFieldValidator ValidationGroup="InsertValidation" ControlToValidate="LastName" ID="RequiredLastName" runat="server" ErrorMessage="Efternamn måste anges" Text="*" Display="None" SetFocusOnError="True"></asp:RequiredFieldValidator>
                        </td>
                        <td>
                            <asp:TextBox ID="EmailAddress" runat="server" Text="<%#: BindItem.EmailAddress %>" MaxLength="50" placeholder="E-post"></asp:TextBox>
                            <asp:RequiredFieldValidator ValidationGroup="InsertValidation" ControlToValidate="EmailAddress" ID="RequiredEmailAddress" runat="server" ErrorMessage="E-post måste anges" Text="*" Display="None" SetFocusOnError="True"></asp:RequiredFieldValidator>
                            <asp:RegularExpressionValidator ValidationGroup="InsertValidation" ControlToValidate="EmailAddress" ID="CorrectEmailAddress" runat="server" ErrorMessage="E-postadressen verkar inte vara korrekt." ValidationExpression=".+\@.+\..+" Display="None" SetFocusOnError="true"></asp:RegularExpressionValidator>
                        </td>
                        <td>
                            <asp:LinkButton runat="server" CommandName="Insert" ValidationGroup="InsertValidation">Spara</asp:LinkButton>
                            <asp:LinkButton runat="server" CommandName="Cancel" CausesValidation="false">Avbryt</asp:LinkButton>
                        </td>
                    </tr>
                </InsertItemTemplate>
                <%-- Redigera kontakt --%>
                <EditItemTemplate>
                    <tr>
                        <td>
                            <asp:TextBox ID="FirstName" runat="server" Text="<%#: BindItem.FirstName %>" MaxLength="50" placeholder="Förnamn"></asp:TextBox>
                            <asp:RequiredFieldValidator ValidationGroup="EditValidation" ControlToValidate="FirstName" ID="RequiredFirstName" runat="server" ErrorMessage="Förnamn måste anges" Text="*" Display="None" SetFocusOnError="True"></asp:RequiredFieldValidator>
                        </td>
                        <td>
                            <asp:TextBox ID="LastName" runat="server" Text="<%#: BindItem.LastName %>" MaxLength="50" placeholder="Efternamn"></asp:TextBox>
                            <asp:RequiredFieldValidator ValidationGroup="EditValidation" ControlToValidate="LastName" ID="RequiredLastName" runat="server" ErrorMessage="Efternamn måste anges" Text="*" Display="None" SetFocusOnError="True"></asp:RequiredFieldValidator>
                        </td>
                        <td>
                            <asp:TextBox ID="EmailAddress" runat="server" Text="<%#: BindItem.EmailAddress %>" MaxLength="50" placeholder="E-post"></asp:TextBox>
                            <asp:RequiredFieldValidator ValidationGroup="EditValidation" ControlToValidate="EmailAddress" ID="RequiredEmailAddress" runat="server" ErrorMessage="E-post måste anges" Text="*" Display="None" SetFocusOnError="True"></asp:RequiredFieldValidator>
                            <asp:RegularExpressionValidator ValidationGroup="EditValidation" ControlToValidate="EmailAddress" ID="CorrectEmailAddress" runat="server" ErrorMessage="E-postadressen verkar inte vara korrekt." ValidationExpression=".+\@.+\..+" Display="None" SetFocusOnError="true"></asp:RegularExpressionValidator>
                        </td>
                        <td>
                            <asp:LinkButton runat="server" CommandName="Update" ValidationGroup="EditValidation">Spara</asp:LinkButton>
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
