<cfsetting requesttimeout="900">
<cfquery name="catItemsQuery" datasource="#DSN#">
	update catItems
    set discogsID=0
    where discogsID=1
</cfquery>	
<cfset pageName="REPORTS">
<cfinclude template="pageHead.cfm">
<cfset joedspin=""><!--- Removed code to include Razor Maid titles    OR (ONHAND>0 AND labelID=8492) //--->
<cfquery name="inventoryReport" datasource="#DSN#">
	select *
	from catItemsQuery
	where ((((isVendor=1 OR shelfCode='BS') OR left(shelfCode,1)='D') AND (ONHAND>0 AND albumStatusID<25))) AND discogsID>2
    order by dtDateUpdated, label, catnum
</cfquery>
<cfset joedspin="release_id,price,media_condition,sleeve_condition,comments#lineFeed#">
<table border="1" cellpadding="1" cellspacing="0" style="border-collapse:collapse">
<cfloop query="inventoryReport">
<!---<cfif DateFormat(DTDateUpdated,"yyyy-mm-dd") LT "2008-08-01" AND Left(shelfCode,1) NEQ 'D' AND shelfCode NEQ 'BS' AND albumStatusID NEQ 23><cfset thisPrice=NumberFormat(PRICE/2,'0.00')><cfelseif shelfCode EQ 'BS'><cfset thisPrice=NumberFormat(PRICE*0.60,'0.00')><cfelse><cfset thisPrice=NumberFormat(PRICE,'0.00')></cfif><cfif shelfCode EQ "BS"><cfset thisPrice=price*.8><cfelse><cfset thisPrice=PRICE></cfif>//--->
<!---<cfif DateFormat(varDateODBC,"mm/dd/yy") LTE "10/12/10">//--->
<!---<cfif shelfCode EQ "DT"><cfset thisPrice=price+1><cfelse>//---><!---</cfif>//---><!---<cfelse><cfset thisPrice=PRICE+1></cfif>//--->
<!---<cfif reissue OR genreID EQ 7><cfset thisComm="Reissue Edition - Brand New Never Played"><cfelse>//---><cfif vendorID EQ 6978><cfset thisComm="Still Sealed"><cfelse><cfset thisComm="Brand New Copy - Never Played"></cfif>
<cfif mediaID EQ 2><cfset thisItemPrice=price+1><cfelse><cfset thisItemPrice=price+NRECSINSET></cfif>
<cfset joedspin=joedspin&"#discogsID#,#thisItemPrice#,Mint (M),Mint (M),#thisComm##lineFeed#">
<!---<cfif ONHAND GT 2>
<cfset joedspin=joedspin&"#discogsID#,#price#,Near Mint (NM or M-),Near Mint (NM or M-),#thisComm##lineFeed#">
</cfif>//--->
<cfoutput><tr><td>#discogsID#</td><td>#label#</td><td>#catnum#</td><td>#artist#</td><td>#title#</td><td><cfif NRECSINSET GT 1>#NRECSINSET#x</cfif>#media#</td><td>#DollarFormat(thisItemPrice)#</td></tr></cfoutput>
</cfloop>
</table>
<cffile action="write"
	file="#serverPath#\joedspinDiscogs.csv"
	output="#joedspin#">
	
	
<cfmail to="order@downtown304.com, order@downtown304.com" from="order@downtown304.com" subject="Discogs Export File Attached" mimeattach="#serverPath#\joedspinDiscogs.csv"></cfmail>

<!---<cfftp 
	server="gemm.com"
	directory="place_catalogs_here"
	username="anonymous"
	password="marianne@downtown304.com"
	action="putfile"
	remotefile="joedspin_replace.txt"
	failifexists="no"
	stoponerror="no"
	localfile="#serverPath#\joedspin_replace.txt" 
	transfermode="ascii" passive="no">//--->


<p>Export file SENT<br />
<cfoutput>#inventoryReport.RecordCount# Items included</cfoutput></p>
<cfinclude template="pageFoot.cfm">