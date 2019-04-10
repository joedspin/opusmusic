<cfquery name="allMailList" datasource="#DSN#">
	select email, subscribe
	from GEMMCustomers where subscribe=1
	order by ID DESC
</cfquery>
<cfoutput query="allMailList">
#Replace(email," ","","all")#<br />
</cfoutput>