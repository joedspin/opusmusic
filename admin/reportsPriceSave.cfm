<cfquery name="checkpricesave" datasource="#DSN#">
	select *
    from catItemsquery where priceSave>0 AND blue99=0
</cfquery>
<cfoutput>#checkpricesave.recordcount#</cfoutput>