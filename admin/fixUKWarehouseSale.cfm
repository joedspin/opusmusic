<!---<cfquery name="doUKsale" datasource="#DSN#">
	update catItems
    set priceSave=cost+3, price=(cost+3)/2
    where ONHAND>0 AND albumStatusID<25 AND albumStatusID>21 AND NRECSINSET=1 AND countryID=2 AND blue99=0
</cfquery>//--->
<cfquery name="priceAdjust" datasource="#DSN#">
	select ID, priceSave
    from catItems
    where NRECSINSET=1 AND countryID=2 AND blue99=0 AND priceSave<>0
</cfquery>
<table>
<cfoutput>
<cfloop query="priceAdjust">
	<tr>
        <td align="right">#DollarFormat(priceSave)#</td>
        <cfif right(priceSave,2) LTE 29>
            <cfset newPrice=(left(priceSave,len(priceSave)-3)-1)+0.99>
            <td align="right">#DollarFormat(newPrice)#</td>
        <cfelse>
            <cfset newPrice=priceSave>
            <td style="color:gray" align="right">#DollarFormat(newPrice)#</td>
        </cfif>
        <td>#ID#</td>
    </tr>
<!---    <cfquery name="undoUKsale" datasource="#DSN#">
    	update catItems
        set price=<cfqueryparam cfsqltype="cf_sql_float" value="#newPrice#">, priceSave=0, specialItem=0
        where ID=<cfqueryparam cfsqltype="cf_sql_integer" value="#ID#">
    </cfquery>//--->
</cfloop>
</cfoutput>

<!---<cfquery name="undoUKsale" datasource="#DSN#">
	update catItems
    set priceSave=0, price=priceSave
    where NRECSINSET=1 AND countryID=2 AND blue99=0 AND priceSave<>0
</cfquery>//--->
