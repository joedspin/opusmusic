<cfset pageName="REPORTS">
<cfinclude template="pageHead.cfm">
<style>

</style>
<table border=1 style="border-collapse: collapse;" cellpadding="3" cellspacing="0">
    <cfquery name="sales" datasource="#DSN#">
        select ID, orderSub
        from orders
        where statusID<6 AND statusID>1 AND custID<>2126
        order by ID DESC
    </cfquery>
    <cfset salesTotal=0>
    <cfoutput query="sales">		
        <cfset salesTotal=salesTotal+orderSub>
            <tr>
                <td>#ID#</td>
                <td align="right"><b>#DollarFormat(orderSub)#</b></td>
            </tr>
    </cfoutput>
    <tr>
        <td align="right"><b>TOTAL:</b></td>
        <td><cfoutput><b>#DollarFormat(salesTotal)#</b></cfoutput></td>
     </tr>
</table>
<cfinclude template="pageFoot.cfm">