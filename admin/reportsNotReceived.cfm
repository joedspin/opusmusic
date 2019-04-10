<cfquery name="qtynotinstock" datasource="#DSN#">
	select *
	from catItemsQuery
	where albumStatusID=148 AND ONHAND>0 order by label, catnum
</cfquery>
<cfoutput query="qtynotinstock">
	<a href="catalogEdit.cfm?ID=#ID#" target="_blank">#catnum#</a> (#label#) #artist# - #title# <cfif NRECSINSET GT 1>#NRECSINSET#x</cfif>#media#<br>
</cfoutput>