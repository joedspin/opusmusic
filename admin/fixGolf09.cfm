<cfquery name="fixGolf09" datasource="#DSNOrders#">
	select * from tblEventReg
     where eventID=97 AND regDate>"2009-01-01"
</cfquery>
<cfoutput query="fixGolf09">
#EventID# #regFirstName# #regLastName#<br>
</cfoutput>