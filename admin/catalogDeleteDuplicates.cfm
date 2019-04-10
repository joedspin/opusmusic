<cfquery name="clearDuplicates" datasource="#DSN#">
	select *
	from catItemsQuery
	where (shelfID=11 OR shelfID=8 OR shelfID=9) AND dtID<>0
</cfquery>
<p>
<cfloop query="clearDuplicates">
	<cfquery name="deleteDuplicate" datasource="#DSN#">
		select *
		from catItemsQuery
		where dtID=#dtID# AND shelfID=7
	</cfquery>
	<cfoutput>#dtID# | #shelfCode# | #artist# | #title#<br></cfoutput>
	<cfoutput query="deleteDuplicate">
		<font color="blue">#dtID# | #shelfCode# | #artist# | #title#</font><br>
	</cfoutput>
	<cfquery name="deleteDuplicate" datasource="#DSN#">
		delete *
		from catItems
		where dtID=#dtID# AND shelfID=7
	</cfquery>
</cfloop>
</p>
<cfoutput><p><b>#clearDuplicates.RecordCount#</b></p></cfoutput>