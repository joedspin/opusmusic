<cfquery name="MakeRegular" datasource="#DSN#">
	update catItems
    set albumStatusID=24
    where releaseDate<'#DateFormat(DateAdd('d',-60,varDateODBC),"yyyy-mm-dd")#' AND dtDateUpdated<'#DateFormat(DateAdd('d',-60,varDateODBC),"yyyy-mm-dd")#' AND albumStatusID<25
</cfquery>
