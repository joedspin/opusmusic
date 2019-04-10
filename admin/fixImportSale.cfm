<!---<cfquery name="saleProspects" datasource="#DSN#">
    update catItems
    set specialItem=1, priceSave=price, price=price*.5
    where ONHAND>0  AND albumStatusID<25 AND blue99<>1 AND specialItem=0 AND priceSave=0
        AND releaseDate<'#DateFormat(DateAdd('d',-75,varDateODBC),"yyyy-mm-dd")#'
        AND dtDateUpdated<'#DateFormat(DateAdd('d',-75,varDateODBC),"yyyy-mm-dd")#'
        AND countryID<>1
</cfquery>
<cfquery name="saleProspects" datasource="#DSN#">
    select *
    from catItemsQuery
    where specialItem=1
    order by artist, title
</cfquery>
<table border="1" cellpadding="2" cellspacing="0" style="border-collapse: collapse;">
<cfoutput query="saleprospects">
<tr>	
		<td>#artist#</td>
		<td>#title#</td>
        <td>#label#</td>
		<td>#catnum#</td>
        <td><cfif NRECSINSET GT 1>#NRECSINSET#x</cfif>#media#</td>
		<td align="right">#DollarFormat(price)#</td>
	</tr>
</cfoutput>
</table>//--->

<cfquery name="undoImportSale" datasource="#DSN#">
	update catItems
    set specialItem=0, price=priceSave
    where specialItem=1 and priceSave>0 AND blue99<>1
</cfquery>