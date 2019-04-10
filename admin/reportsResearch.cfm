<cfset pageName="REPORTS">
<cfinclude template="pageHead.cfm">
<style>
h3 {font-size: x-small; margin-top: 3px; margin-bottom: 3px;}
h4 {font-size: x-small; color:#FFFFFF; margin-top: 3px; margin-bottom: 3px;}
td {color: #333333;}
</style>
<cfquery name="saleResearch" datasource="#DSN#" cachedwithin="#CreateTimeSpan(0, 1, 0, 0)#">
    select *
    from catItemsQuery
    where (shelfID<>11 AND countryID<>1) AND ((albumStatusID<25 AND ONHAND>0 AND price>5.00 AND price<9.00) OR (ONHAND>3 AND releaseDate<'2011-01-01'))
    order by label, catnum
</cfquery>
<p style="color:white"><cfoutput>#saleResearch.recordCount# Items</cfoutput></p>
<table border="1" cellpadding="3" cellspacing="0" style="border-collapse: collapse;" bgcolor="#CCCCCC" align="center">
<cfoutput query="saleResearch">
    <tr bgcolor="##003366">
    	<td valign="middle" style="color:##FFFFFF;"><h3>#shelfCode#</h3></td>
        <td valign="middle" style="color:##FFFFFF;"><h3>#UCase(Left(label,10))#</h3></td>
        <td valign="middle" style="color:##FFFFFF;"><h3>#catnum#</h3></td>
    	<td valign="middle" style="color:##FFFFFF;"><h3>#artist#</h3></td>
        <td valign="middle" style="color:##FFFFFF;"><h3>#title#</h3></td>
        <td valign="middle" style="color:##FFFFFF;">ONHAND: #ONHAND#<br />ONSIDE: #ONSIDE#</td>
    </tr>
    </cfoutput>
   </table>
<cfinclude template="pageFoot.cfm">
