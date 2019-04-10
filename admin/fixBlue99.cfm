<cfquery name="the99" datasource="#DSN#">
	select *
    from catItemsQuery
    where blue99=1 AND albumStatusID<25 AND ONHAND>0
    order by artist, title
</cfquery>

<cfoutput Query="the99">
	<a href="http://www.downtown304.com/index.cfm?sID=#ID#"> <b>#artist#</b> #title#</a> (#label# - #catnum#)</a> #media#<cfif NRECSINSET GT 1>x#NRECSINSET#</cfif> Regularly #DollarFormat(priceSave)#/Now <b>#DollarFormat(price)#</b> <cfif price GT priceSave><font color="red">ERROR</font></cfif><br>
</cfoutput>
<!---<cfquery name="sale99" datasource="#DSN#">
	update catItems
    set priceSave=price, price=cost, wholesalePrice=cost
    where blue99=1
</cfquery>//--->