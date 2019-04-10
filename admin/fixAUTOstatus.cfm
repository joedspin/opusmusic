<cfquery name="fixStati" datasource="#DSN#">
	select * from catItemsQuery
	where albumStatusID=27 AND ONHAND<1
    order by label, catnum
</cfquery>
<cfoutput query="fixStati">
#ONHAND# | #ONSIDE# | #label# | #catnum# | #artist# | #title# | <cfif NRECSINSET GT 1>#NRECSINSET#x</cfif>#media#<br />
</cfoutput>
<cfquery name="fixStati" datasource="#DSN#">
	update catItems
    set albumStatusID=25, ONHAND=0 where albumStatusID=27 AND ONHAND<1
</cfquery>