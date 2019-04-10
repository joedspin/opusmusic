<cfparam name="url.runit" default="no">
<cfif url.runit EQ "no">
	<p><a href="fixOnhandOutOfStock.cfm?runit=yes">Change all to Back in Stock</a></p>
	<cfquery name="ForceBackInStock" datasource="#DSN#">
		select * from orderItemsQuery
		where ONHAND>(select sum(qtyOrdered) from orderItems where adminAvailID IN (2,4,5) AND statusID NOT IN (1,7)) AND albumStatusID>24
		ORDER BY label, catnum
	</cfquery>
	<table border='1' cellpadding='3' cellspacing='0' style="border-collapse:collapse;">
	<tr>
			<td>LABEL</td>
			<td>CATNUM</td>
			<td>ARTIST</td>
			<td>TITLE</td>
			<td>MEDIA</td>
			<td>ONHAND</td>
		 </tr>
	<cfoutput query="ForceBackInStock">
		<tr>
			<td>#label#</td>
			<td>#catnum#</td>
			<td>#artist#</td>
			<td>#title#</td>
			<td><cfif NRECSINSET GT 1>#NRECSINSET# x </cfif>#media#</td>
			<td align="center">#ONHAND#</td>
		 </tr>
	</cfoutput>
	</table>
	
<cfelse>

<cfquery name="ForceBackInStock" datasource="#DSN#">
	update catItems
	set albumStatusID=23, dtDateUpdated='2019-04-03', dateUpdated='2019-04-03'
	where ONHAND>(select sum(qtyOrdered) from orderItemsQuery where adminAvailID IN (2,4,5) AND statusID NOT IN (1,7)) AND albumStatusID>24
</cfquery>
	<p>Done.</p>
</cfif>