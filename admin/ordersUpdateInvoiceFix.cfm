<html>
<head>
<cfparam name="url.ID" default="0">
<title>Downtown 304 Invoicing</title>
</head><!---catnum NOT LIKE '%PROSH%' AND catnum NOT LIKE '%DETROIT%' AND catnum<>'JM005310SRM' AND catnum<>'SRMF8004'//--->
<!---AND dt161invoiceConfirm=0 AND otherSiteID=2//--->
<cfquery name="thisItems" datasource="#DSN#">
	SELECT qtyOrdered, orderItemID, dtID, catnum, label, artist, title, price, cost
	FROM orderItemsQuery
	where dateShipped>'2011-09-16' AND dateShipped<'2011-11-17' AND adminAvailID=6 AND shelfID=11 AND statusID=6 
	order by catnum
</cfquery>
<body>

<style type="text/css">
<!--
.style1 {
	font-size: x-small;
	font-family: Arial, Helvetica, sans-serif;
}
td {
	font-size: x-small;
	font-family: Arial, Helvetica, sans-serif;
}
.style2 {
	font-size: small;
	font-family: Arial, Helvetica, sans-serif;
	font-weight: bold;
}
.style4 {
	font-size: x-small;
	font-family: Arial, Helvetica, sans-serif;
	font-weight: bold;
}
td {vertical-align:top;}
input {font-size: xx-small; text-align: center;}
-->
</style>

<h1>Downtown 161 Invoice</h1>
<form name="updateInvoice" action="http://10.0.0.113/DT161/eGrid_Master/opusToolsInvoiceFix.php" method="post">
	    <span class="style2">
	    <cfset iAdd=0>
	    </span>
<table border="1" cellpadding="2" cellspacing="0" style="border-collapse:collapse;" width="650">
    <cfif thisItems.recordCount NEQ 0><tr><td colspan="5"><p class="style2"><b>Add to Invoice</b></p></td></tr>

		
			<cfoutput query="thisItems">
				<cfset iAdd=iAdd+1>
				<tr>
					<td align="center"><input type="text" name="qtyA#iAdd#" size="2" maxlength="3" value="#qtyOrdered#" /></td>
				  <td><input type="hidden" name="idA#iAdd#" value="#dtID#" />
                  		<input type="hidden" name="oidA#iAdd#" value="#orderItemID#" />
                        <cfif price EQ 0><cfset thisCost=0><cfelse><cfset thisCost=cost></cfif>
					  <input type="hidden" name="priceA#iAdd#" value="#NumberFormat(thisCost,"0.00")#" />
					  <span class="style1">#catnum#</span></td>
                      
                  <td>#label#</td>
                  <td>#artist#</td>
                  <td>#title#</td>
				</tr>
			</cfoutput>
	</cfif>
	<cfoutput><input type="hidden" name="iAdd" value="#iAdd#" />
	<input type="hidden" name="todaydate" value="#DateFormat(varDateODBC,"yyyy-mm-dd")#" />
<p><input type="submit" name="submit" value="Submit #iAdd# Items" /></p></cfoutput>
</form>

</body>
</html>