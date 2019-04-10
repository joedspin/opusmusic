<cfparam name="form.active" default="no">
<cfquery name="addList" datasource="#DSN#">
	insert into artistLists (artistID, listName, listDate, dateAdded, active)
	values (
		<cfqueryparam value="#form.artistID#" cfsqltype="cf_sql_char">,
		<cfqueryparam value="#form.listName#" cfsqltype="cf_sql_char">,
		<cfqueryparam value="#form.listDate#" cfsqltype="cf_sql_date">,
		<cfqueryparam value="#varDateODBC#" cfsqltype="cf_sql_date">,
		<cfqueryparam value="#form.active#" cfsqltype="cf_sql_bit">
	)
</cfquery>
<cfquery name="newList" datasource="#DSN#">
	select Max(ID) as MaxID
	from artistLists
	where artistID=#form.artistID# AND listName=<cfqueryparam value="#form.listName#" cfsqltype="cf_sql_char">
</cfquery>
<cflocation url="listsPlayListsEdit.cfm?ID=#newList.MaxID#">