<cfparam name="Cookie.vID" default="0">
<cfif Cookie.vID EQ "0" OR Cookie.vID EQ "">NO VENDOR ID PROVIDED<cfabort></cfif>
<cfif Cookie.orderBy EQ "label"><cfset orderString="label "&Cookie.sortOrder&", catnum "&Cookie.sortOrder><cfelse><cfset orderString=Cookie.orderBy&" "&Cookie.sortOrder></cfif>
<cfquery name="thisList" datasource="#DSN#">
	select *
    from catItemsQuery
    where vendorID=#Cookie.vID# AND 
        artist LIKE <cfqueryparam value="%#Cookie.sArtist#%" cfsqltype="cf_sql_char"> AND
            label LIKE <cfqueryparam value="%#Cookie.sLabel#%" cfsqltype="cf_sql_char"> AND
            title LIKE <cfqueryparam value="%#Cookie.sTitle#%" cfsqltype="cf_sql_char"> AND
            catnum LIKE <cfqueryparam value="%#Cookie.sCatnum#%" cfsqltype="cf_sql_char"> AND (ONHAND>0 OR ONSIDE>0) AND discogsID=''
        order by #orderString#
</cfquery>
<style>td {font-family:Arial, Helvetica, sans-serif; font-size: 10px; border-color:black;}</style>
<table border="1" cellpadding="2" style="border-collapse:collapse; border-color:black;"><cfoutput query="thisList">
<tr><td width="10">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td><td>#catnum#</td><td>#UCase(left(label,20))#</td><td>#UCase(left(artist,30))#</td><td>#UCase(left(title,20))#</td><td><cfif NRECSINSET GT 1>#NRECSINSET#x</cfif>#media#</td></tr>
</cfoutput>
</table>