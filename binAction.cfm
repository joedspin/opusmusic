<cfparam name="url.oClip" default="0">
<cfparam name="url.rClip" default="0">
<cfparam name="Session.userID" default="0">
<cfif Session.userID NEQ 0>
	<cfif url.rClip NEQ 0>
		<cfquery name="removeFromBin" datasource="#DSN#">
			delete
			from listenBin
			where ID=<cfqueryparam value="#url.rClip#" cfsqltype="cf_sql_char">
		</cfquery>
	</cfif>
	<cfif url.oClip NEQ 0>
		<cfquery name="checkBin" datasource="#DSN#">
			select *
			from listenBin
			where catItemID=<cfqueryparam value="#url.oClip#" cfsqltype="cf_sql_integer"> AND custID=<cfqueryparam value="#Session.userID#" cfsqltype="cf_sql_integer">
		</cfquery>
		<cfif checkBin.RecordCount GT 0>
			<cfquery name="updateBin" datasource="#DSN#">
				update listenBin
				set dateAdded=<cfqueryparam value="#varDateODBC#" cfsqltype="cf_sql_date">
				where ID=#checkBin.ID#
			</cfquery>
		<cfelse>
			<cfquery name="addtoBin" datasource="#DSN#">
				insert into listenBin (catItemID, dateAdded, custID)
				values (
					<cfqueryparam value="#url.oClip#" cfsqltype="cf_sql_char">,
					<cfqueryparam value="#varDateODBC#" cfsqltype="cf_sql_date">,
					<cfqueryparam value="#Session.userID#" cfsqltype="cf_sql_integer">
				)
			</cfquery>
		</cfif>
	</cfif>
	<cflocation url="opussitelayout07bins.cfm">
<cfelse>
	<cflocation url="opussitelayout07bins.cfm?si=no">
</cfif>
