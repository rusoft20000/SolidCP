<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="UserCreateSpace.ascx.cs" Inherits="SolidCP.Portal.UserCreateSpace" %>
<%@ Register Src="UserControls/UsernameControl.ascx" TagName="UsernameControl" TagPrefix="uc4" %>
<%@ Register Src="UserControls/DomainControl.ascx" TagName="DomainControl" TagPrefix="scp" %>
<%@ Register Src="UserControls/EnableAsyncTasksSupport.ascx" TagName="EnableAsyncTasksSupport" TagPrefix="scp" %>

<scp:EnableAsyncTasksSupport id="asyncTasks" runat="server"/>

<asp:ValidationSummary ID="summary" runat="server" ShowMessageBox="true" ShowSummary="true" ValidationGroup="CreateSpace" />

<asp:UpdatePanel runat="server" ID="updatePanelSpace" UpdateMode="Conditional" ChildrenAsTriggers="true">
    <ContentTemplate>
       
<div class="panel-body form-horizontal">
    
<asp:Label ID="lblMessage" runat="server" CssClass="NormalBold" ForeColor="red"></asp:Label>

<table width="100%">
    <tr>
        <td class="SubHead" style="width:150px;">
            <asp:Label ID="lblHostingPlan" meta:resourcekey="lblHostingPlan" runat="server" Text="Hosting Plan:"></asp:Label>
        </td>
        <td>
            <asp:DropDownList id="ddlPlans" runat="server" CssClass="form-control" DataTextField="PlanName" DataValueField="PlanID" AutoPostBack="True" OnSelectedIndexChanged="ddlPlans_SelectedIndexChanged">
            </asp:DropDownList>
            <asp:RequiredFieldValidator ID="valRequirePlan" runat="server" ControlToValidate="ddlPlans"
                Display="Dynamic" ErrorMessage="*" meta:resourcekey="valRequirePlan" ValidationGroup="CreateSpace"></asp:RequiredFieldValidator>
        </td>        
    </tr>
    <tr>
        <td class="SubHead"><asp:Label ID="lblStatus" runat="server" meta:resourcekey="lblStatus" Text="Space Status:"></asp:Label></td>
        <td class="Normal">
            <asp:DropDownList id="ddlStatus" runat="server" resourcekey="ddlStatus" CssClass="form-control">
                <asp:ListItem Value="1">Active</asp:ListItem>
                <asp:ListItem Value="2">Suspended</asp:ListItem>
                <asp:ListItem Value="3">Cancelled</asp:ListItem>
                <asp:ListItem Value="4">New</asp:ListItem>
            </asp:DropDownList>
        </td>
    </tr>
    <tr>
        <td rowspan="2"><div class="FormButtonsBar">
            <asp:Button ID="btnAddAddon" runat="server" meta:resourcekey="btnAddAddon" Text="Add Add-on" CssClass="Button2" OnClick="btnAddAddon_Click" />
            </div>
        </td>
        <td>
            <asp:RadioButton ID="rbPlanQuotas" runat="server" GroupName="OverrideQuotas" AutoPostBack="true"
                                meta:resourcekey="rbPlanQuotas" Text="Use quotas defined on plan level" />
        </td>
    </tr>
    <tr>
        <td>
            <asp:RadioButton ID="rbPackageQuotas" runat="server" GroupName="OverrideQuotas" AutoPostBack="true"
                                meta:resourcekey="rbPackageQuotas" Text="Override quotas on space level" />                      
        </td>
    </tr>
    <asp:Repeater ID="repHostingAddons" runat="server">
        <HeaderTemplate>
        </HeaderTemplate>
        <ItemTemplate>
        <tr>
		    <td><%--<div class="FormButtonsBar">--%>
                <CPCC:StyleButton id="btnRemoveAddAddon" CssClass="btn btn-danger" runat="server" CausesValidation="false" 
                    CommandName="Remove" CommandArgument="<%# Container.ItemIndex %>" OnCommand="btnRemoveAddAddon_OnCommand"> 
                    <i class="fa fa-times">&nbsp;</i>&nbsp;<asp:Localize runat="server" meta:resourcekey="btnRemoveAddAddonText" Text="Remove Add-on:"/> 
                </CPCC:StyleButton>
                <%--</div>--%>
            </td>
		    <td>
			    <asp:DropDownList id="ddlPlan" runat="server" CssClass="form-control-inline" DataTextField="PlanName" 
                    DataValueField="PlanID"></asp:DropDownList>
			    <asp:RequiredFieldValidator id="planValidator" CssClass="NormalBold" runat="server" ErrorMessage="*"
				    Display="Dynamic" ControlToValidate="ddlPlan" ValidationGroup="EditAddon"></asp:RequiredFieldValidator>

                <asp:Label ID="lblQuantity" runat="server" meta:resourcekey="lblQuantity" Text="Quantity:"></asp:Label>
                <asp:TextBox ID="txtQuantity" runat="server" CssClass="form-control-inline" Width="50px" Text='<%# Eval("Quantity") %>'></asp:TextBox>
                <asp:RequiredFieldValidator ID="valQuantity" runat="server" ControlToValidate="txtQuantity"
                CssClass="NormalBold" Display="Dynamic" ErrorMessage="*" ValidationGroup="EditAddon"></asp:RequiredFieldValidator>
		    </td>            
	    </tr>
        </ItemTemplate>
        <SeparatorTemplate>
            <br/>
            <%--<hr style="margin-bottom: 20px; margin-top: 10px; margin-left: 10px; margin-right: 10px;"/>--%>
        </SeparatorTemplate>
    </asp:Repeater>
    <tr>
        <td class="Normal" colspan="2">
            <br />
            <asp:CheckBox ID="chkRedirectToCreateVPS" runat="server" meta:resourcekey="chkRedirectToCreateVPS"
                Text="Redirect to create VPS" Checked="False" />
        </td>
    </tr>
    <tr>
        <td class="Normal" colspan="2">
            <br />
            <asp:CheckBox ID="chkPackageLetter" runat="server" meta:resourcekey="chkPackageLetter"
                Text="Send Space Summary Letter" Checked="True" />
        </td>
    </tr>
    <tr>
        <td class="Normal" colspan="2">
            <br />
            <asp:CheckBox ID="chkCreateResources" runat="server" meta:resourcekey="chkCreateResources"
                Text="Create Space Resources" Checked="True" AutoPostBack="True" OnCheckedChanged="chkCreateResources_CheckedChanged" />
        </td>
    </tr>
    <tr>
        <td class="Normal" colspan="2">
            <br />
            <asp:CheckBox ID="chkIntegratedOUProvisioning" runat="server" meta:resourcekey="chkIntegratedOUProvisioning"
                Text="Automated Hosted Organization Provisioning" Checked="True" />
        </td>
    </tr>

</table>

<asp:Panel ID="ResourcesPanel" runat="server">
 
    <fieldset id="fsSystem" runat="server">
        <legend>
            <asp:Label ID="lblSystemGroup" meta:resourcekey="lblSystemGroup" runat="server" Text="System" CssClass="NormalBold"></asp:Label>&nbsp;
        </legend>
        <table width="100%" cellpadding="4" style="margin-bottom:20px;" cellspacing="0">
            <tr>
                <td class="Normal" width="100%">
                    <scp:DomainControl ID="txtDomainName" runat="server" RequiredEnabled="True" ValidationGroup="CreateSpace" OnTextChanged="txtDomainName_OnTextChanged"></scp:DomainControl>
                </td>
            </tr>
        </table>
    </fieldset>
    
    
    <fieldset id="fsWeb" runat="server">
        <legend>
            <asp:Label ID="lblWebGroup" meta:resourcekey="lblWebGroup" runat="server" Text="Web" CssClass="NormalBold"></asp:Label>&nbsp;
        </legend>
        <table width="100%" cellpadding="4" cellspacing="0">
            <tr>
                <td class="Normal" width="40" nowrap rowspan="2"></td>
                <td class="Normal">
                    <asp:CheckBox ID="chkCreateWebSite" runat="server" meta:resourcekey="chkCreateWebSite"
                        Text="Create Web Site" Checked="True" />
                </td>
            </tr>
            <tr>
		        <td class="Normal" width="100%">
		            <asp:Label ID="lblHostName" runat="server" meta:resourcekey="lblHostName" Text="Host name:"></asp:Label>
			        <asp:TextBox ID="txtHostName" runat="server" CssClass="form-control" MaxLength="64" ></asp:TextBox>
                </td>
            </tr>
        </table>
    </fieldset>
    
    
    <fieldset id="fsFtp" runat="server">
        <legend>
            <asp:Label ID="lblFtpGroup" meta:resourcekey="lblFtpGroup" runat="server" Text="FTP" CssClass="NormalBold"></asp:Label>&nbsp;
        </legend>
        <table width="100%" cellpadding="4" cellspacing="0">
            <tr>
                <td class="Normal" width="40" nowrap rowspan="2"></td>
                <td class="Normal">
                    <asp:CheckBox ID="chkCreateFtpAccount" runat="server" meta:resourcekey="chkCreateFtpAccount"
                        Text="Create FTP Account" Checked="True" />
                </td>
            </tr>
            <tr>
                <td class="Normal" width="100%">
                    <asp:RadioButtonList ID="rbFtpAccountName" runat="server" CssClass="Normal"
                            RepeatDirection="Horizontal" AutoPostBack="true" resourcekey="rbFtpAccountName" OnSelectedIndexChanged="rbFtpAccountName_SelectedIndexChanged">
                        <asp:ListItem Value="Default" Selected="True">Default</asp:ListItem>
                        <asp:ListItem Value="Custom">Custom</asp:ListItem>
                    </asp:RadioButtonList>
                    <uc4:UsernameControl ID="ftpAccountName" runat="server" RequiredField="false" ValidationGroup="CreateSpace" />
                </td>
            </tr>
        </table>
    </fieldset>

    
    
    <fieldset id="fsMail" runat="server">
        <legend>
            <asp:Label ID="lblMailGroup" meta:resourcekey="lblMailGroup" runat="server" Text="Mail" CssClass="NormalBold"></asp:Label>&nbsp;
        </legend>
        <table width="100%" cellpadding="4" cellspacing="0">
            <tr>
                <td class="Normal" width="40" nowrap></td>
                <td class="Normal" width="100%">
                    <asp:CheckBox ID="chkCreateMailAccount" runat="server" meta:resourcekey="chkCreateMailAccount"
                        Text="Create 'Catch-all' Mail Account" Checked="True" /></td>
            </tr>
        </table>
    </fieldset>

 </asp:Panel>
 

</div>

</ContentTemplate>
</asp:UpdatePanel>

<div class="panel-footer text-right">
    <CPCC:StyleButton id="btnCancel" CssClass="btn btn-warning" runat="server" CausesValidation="False" OnClick="btnCancel_Click"> <i class="fa fa-times">&nbsp;</i>&nbsp;<asp:Localize runat="server" meta:resourcekey="btnCancel"/> </CPCC:StyleButton>&nbsp;
    <CPCC:StyleButton id="btnCreate" CssClass="btn btn-success" runat="server" OnClick="btnCreate_Click" ValidationGroup="CreateSpace" OnClientClick="ShowProgressDialog('Creating hosting space...');"> <i class="fa fa-plus">&nbsp;</i>&nbsp;<asp:Localize runat="server" meta:resourcekey="btnCreateText"/> </CPCC:StyleButton>
</div>