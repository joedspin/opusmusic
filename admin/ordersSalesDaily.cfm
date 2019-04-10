<style>
body, td {font-family: Arial, Helvetica, sans-serif; font-size: x-small;}
</style>
<cfset monthlyTotal=0>
<table>
<cfloop index="y" from="1" to="9">
<cfoutput><tr><td colspan="2">#DateFormat("#y#/1/09","mmmm")#</td></tr></cfoutput>
	<cfif y EQ "2">
    	<cfset toX="28">
    <cfelseif y EQ "9" OR y EQ "4" OR y EQ "6" OR y EQ "11">
    	<cfset toX="30">
    <cfelse>
    	<cfset toX="31">
    </cfif>
    <cfloop index="x" from="1" to="#toX#">
        <cfquery name="dailyTotal" datasource="#DSN#">
            select orderTotal
        from orders
        where dateShipped='2009-#NumberFormat(y,'00')#-#NumberFormat(x,'00')#' AND paymentTypeID=7 AND statusID=6
        </cfquery>
        <cfif dailyTotal.recordCount NEQ 0>
            <cfset thisDay=0>
            <cfloop query="dailyTotal">
                <cfset thisDay=thisDay+orderTotal>
            </cfloop>
            <cfoutput>
                <tr><td align="right">#x#</td><td align="right">#DollarFormat(thisDay)#</td></tr>
                <cfset monthlyTotal=monthlyTotal+thisDay>
            </cfoutput>
        </cfif>
    </cfloop>
<cfoutput><tr><td>TOTAL</td><td><b>#DollarFormat(monthlyTotal)#</b></td></tr></cfoutput>
<cfset monthlyTotal=0>
</cfloop>
</table>