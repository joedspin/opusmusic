<cfsetting requesttimeout="900">
<cfquery name="catItems" datasource="#DSN#">
	select *
	from catItems
	where descrip<>''
</cfquery>
<cfloop query="catItems">
	<cfquery name="checkTracks" datasource="#DSN#" maxrows=1>
		select *
		from catTracks
		where catID=#catItems.ID#
	</cfquery>
	<cfif checkTracks.recordCount EQ 0>
		<cfset trackQuery=ListToArray(Replace(descrip,"; ",";","all"),";")>
		<cfoutput>#catnum# --- #descrip#</cfoutput>
		<cfset tCt=ArrayLen(trackQuery)>
		<cfloop from="1" to="#tCt#" index="x">
			<cfquery name="addTrack" datasource="#DSN#">
				insert into catTracks (catID, tSort, tName)
				values (
					<cfqueryparam value="#ID#" cfsqltype="cf_sql_char">,
					<cfqueryparam value="#x#" cfsqltype="cf_sql_char">,
					<cfqueryparam value="#trackQuery[x]#" cfsqltype="cf_sql_char">
				)
			</cfquery>
		</cfloop>
		:: DONE<br />
	</cfif>
</cfloop>