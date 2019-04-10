<cfset pageName="LISTS">
<cfinclude template="pageHead.cfm">

<cfquery name="paytypes" datasource="#DSN#">
	select *
	from paymentTypes
	order by PaymtID
</cfquery>
<!---<p><a href="listsGenresAdd.cfm">ADD NEW GENRE</a></p>//--->
<p><cfoutput query="paytypes">
	<!---<a href="listsGenresEdit.cfm?ID=#ID#">EDIT</a> | <a href="listsGenresDelete.cfm?ID=#ID#">DELETE</a>//--->#PaymtID# : #PayType#<br />
</cfoutput></p>