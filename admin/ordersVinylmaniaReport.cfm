<cfparam name="url.vmdate" default="#varDateODBC#">
<cfparam name="url.showdetails" default="false">
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<style>
table, td {border-collapse:collapse; border-color: black;}
body, td {font-family:Arial, Helvetica, sans-serif; font-size: small;}
h1 {{font-family:Arial, Helvetica, sans-serif; font-size: large;}
h2 {{font-family:Arial, Helvetica, sans-serif; font-size: medium;}
h3 {{font-family:Arial, Helvetica, sans-serif; font-size: small;}
h1, h2, h3 {margin-top: 0px; margin-bottom: 0px;}
.style2 {color: #CCCCCC; }
.style3 {color: #FFFFFF}
.report {font-size: 12px; vertical-align:middle;}
</style>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>Vinylmania Report</title>
</head>
<cfquery name="vmRegister" datasource="#DSN#">
	select *
    from orderItemsQuery
    where statusID=6 AND adminAvailID=6 AND
    	dateShipped=<cfqueryparam value="#url.vmdate#" cfsqltype="cf_sql_date"> AND 
        isVinylmania=1
    order by orderID
</cfquery>
<body>
<p><font style="font-size: x-large;">Vinylmania <cfoutput>#DateFormat(url.vmdate,"mmmm d, yyyy")#</cfoutput></font></p>
<cfset totalSold=0>
<cfset totalDT=0>
<cfset totalVM=0>
<cfset total304=0>
<cfset importCount=0>
<cfset DTCount=0>
<cfset lastOrderID="0">
<cfif url.showdetails><table></cfif>
<cfoutput query="vmRegister">
<cfif orderID NEQ lastOrderID and url.showdetails><tr><td colspan="8"><h1>#orderID#</h1></td></tr></cfif>
<cfset lastOrderID=orderID>
<cfif url.showdetails><tr>
		<td align="center">#qtyOrdered#</td>
		<td valign="top">#catnum#</td>
		<td valign="top">#label#</td>
		<td valign="top">#artist#</td>
		<td valign="top">#title#</td>
		<td valign="top"><cfif NRECSINSET GT 1>#NRECSINSET# x </cfif>#media#</td>
		<td valign="top" align="right">#DollarFormat(price)#</td>
		<td valign="top" align="center">#shelfCode#</td>
	</tr></cfif>
    <cfif left(shelfCode,1) EQ 'D'><cfset totalDT=totalDT+(qtyOrdered*price)><cfset totalVM=totalVM+(qtyOrdered*buy)><cfset DTCount=DTcount+qtyOrdered><cfelse><cfset total304=total304+(qtyOrdered*price)><cfset importCount=importCount+qtyOrdered></cfif>
    <cfset totalSold=totalSold+(qtyOrdered*price)>
</cfoutput>
<cfif url.showdetails></table><p>&nbsp;</p></cfif>
<cfoutput><table height="73" border="1" cellpadding="6" cellspacing="0" width="850">
  <tr valign="middle">
    <td nowrap bgcolor="##666666"><h3 class="style2">DT161 Sales</h3></td>
    <td align="right" nowrap>
      <h2>#DollarFormat(totalDT)#</h2>    </td>
    <td nowrap bgcolor="##666666"><h3 class="style2">DT304 Sales</h3></td>
    <td align="right" nowrap>
      <h2>#DollarFormat(total304)#</h2>    </td>
    <td rowspan="2" valign="top" nowrap bgcolor="##000000"><h2 class="style3">Total Sales</h2></td>
    <td rowspan="2" valign="top" nowrap><h2>#DollarFormat(totalSold)#</h2></td>
  </tr>
  
<!---  <tr valign="middle">
    <td nowrap bgcolor="##666666"><h3 class="style2">VM Invoice  DT161</h3></td>
    <td align="right" nowrap>
      <h2>#DollarFormat(totalVM)#</h2>    </td>
    <td nowrap bgcolor="##666666"><h3 class="style2">DT304 Drawer</h3></td>
    <td align="right" nowrap>
      <h2>#DollarFormat(total304-importCount)#</h2>    </td>
    </tr>
  
  <tr valign="middle">
    <td nowrap bgcolor="##666666"><h3 class="style2">VM Share</h3></td>
    <td align="right" nowrap>
      <h2>#DollarFormat(totalDT-totalVM)#</h2></td>
    <td nowrap bgcolor="##666666"><h3 class="style2">VM Share</h3></td>
    <td align="right" nowrap>
      <h2>#DollarFormat(importCount)#</h2>    </td>
    <td valign="top" nowrap bgcolor="##000000"><h2 class="style3">VM Share</h2></td>
    <td align="right" valign="top" nowrap><h2>#DollarFormat((totalDT-totalVM)+importCount)#</h2></td>
  </tr>//--->
  <tr valign="middle">
    <td colspan="2" nowrap><h2 align="right">#DTCount# items</h2> </td>
    <td colspan="2" align="right" nowrap><h2>#importCount# items</h2> </td>
    <td valign="top" nowrap bgcolor="##000000"><h2 class="style3">Total items</h2></td>
    <td valign="top" nowrap align="right"><h2>#importCount+DTCount# items</h2></td>
  </tr>
</table>
</cfoutput>
<p>
  <cfquery name="dtitems" dbtype="query">
	select *
    from vmRegister
    where shelfCode IN ('DI','DT')
    order by catnum
</cfquery>
</p>
<table border="1" cellpadding="5" width="850">
<cfoutput query="dtitems">
<tr>
		<td align="center" class="report">#qtyOrdered#</td>
		<td class="report">#UCase(catnum)#</td>
		<td class="report">#UCase(label)#</td>
		<td class="report">#UCase(artist)#</td>
		<td class="report">#UCase(title)#</td>
		<td class="report"><cfif NRECSINSET GT 1>#NRECSINSET# x </cfif>#UCase(media)#</td>
		<td align="right" class="report">#DollarFormat(price)#</td>
		<td align="center" class="report">#shelfCode#</td>
	</tr>
</cfoutput>
</table>
</body>
</html>
