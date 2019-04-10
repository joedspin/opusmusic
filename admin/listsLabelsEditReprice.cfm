<cfparam name="form.costAdjust" default="-0.50">
<cfparam name="form.labelID" default="0">
<cfset pageName="LISTS">
<cfinclude template="pageHead.cfm">
<cfquery name="reprice1" datasource="#DSN#">
	update catItems
    set cost=buy+#form.costAdjust#, price=buy+2.40+#form.costAdjust#
    where labelID=#form.labelID# AND shelfID IN (11,9,7,13) AND buy>#form.costAdjust#
</cfquery>
<cfquery name="lookupLabel" datasource="#DSN#">
	select *
    from catItemsQuery
    where labelID=#form.labelID# AND shelfID IN (11,9,7,13)
    order by catnum
</cfquery>
<p><a href="listsLabels.cfm">Continue</a></p>
<table>
<cfoutput query="lookupLabel">
<tr>
	<td>#catnum#</td>
	<td>#label#</td>
    <td>#artist#</td>
    <td>#title#</td>
    <td><cfif NRECSINSET GT 1>#NRECSINSET#x</cfif>#media#</td>
    <td>#DollarFormat(price)#</td>
	<td>#dollarFormat(cost)#</td>
</tr>
</cfoutput>
</table>
<cfinclude template="pageFoot.cfm">