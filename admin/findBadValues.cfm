<cfquery name="cartContents" datasource="#DSN#">
		SELECT * from orderItemsQuery
		where (NRECSINSET Is Null OR weight Is Null OR weightException Is Null OR qtyOrdered Is Null)
		AND adminAvailID=2 AND statusID=1
	</cfquery>
   <cfoutput query="cartContents">
   #catnum# - #label#<br>
   </cfoutput>