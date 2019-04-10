<style>
td {font-family:Gotham, "Helvetica Neue", Helvetica, Arial, sans-serif; font-size: 12px; border: 1px solid black; margin: 2px; padding: 0; border-collapse:collapse;}
</style>
<cfquery name="notifyMe" datasource="#DSN#">
	select *
    from (notifyMe LEFT JOIN catItemsQuery ON catItemsQuery.ID=notifyMe.catItemID) LEFT JOIN custAccounts ON custAccounts.ID=notifyMe.custID
    order by shelf, label, catnum
</cfquery>
<table cellpadding="0" cellspacing="0">
<cfset lastVendor="">
<cfset lastCatItemID="">
<cfset titleCount=0>
<cfoutput query="notifyMe">
	<cfif catItemID NEQ lastCatItemID>
    	<cfif titleCount GT 1>
            <tr>
                <td colspan="7" align="right"><b>#titleCount#</b></td>
            </tr>
        </cfif>
        <cfset titleCount=0></cfif></cfoutput></table>
<table><cfoutput query="notifyMe"><cfif catItemID NEQ lastCatItemID>
    </cfif>
    <cfset titleCount=titleCount+1>
    <cfif shelf NEQ lastVendor>
        <tr>
            <td colspan="7"><b>#shelf#</b></td>
        </tr>
    </cfif>
    <cfset lastVendor=shelf>
    <cfset lastCatItemID=catItemID>
    <tr>
        <td>#label#</td>
        <td>#catnum#</td>
        <td>#artist#</td>
        <td>#title#</td>
        <td><cfif NRECSINSET GT 1>#NRECSINSET#x</cfif>#media#</td>
        <td><cfif isStore>#billingName#<cfelse>#firstName# #lastName#</cfif></td>
        <td>#DateFormat(dateRequested,"MM/DD/YYYY")#</td>
    </tr>
</cfoutput>
</table>