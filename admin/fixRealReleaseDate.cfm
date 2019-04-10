<cfsetting requesttimeout="100000" enablecfoutputonly="no">
<cfquery name="realRelease" datasource="#DSN#">
	select ID, descrip
    from catItems
    where descrip<>''
</cfquery>
<cfloop query="realRelease">
	<cfif IsDate(descrip)>
	<cfquery name="realReleaseSet" datasource="#DSN#">
    	update catItems
        set realReleaseDate=<cfqueryparam value="#descrip#" cfsqltype="cf_sql_date">, descrip=''
        where ID=#ID#
    </cfquery>
    </cfif>
</cfloop>