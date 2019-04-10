<cfparam name="url.letter" default="a">
<cfset pageName="CUSTOMERS">
<cfinclude template="pageHead.cfm">
<p>Downtown 304 online admin tool</p>
<cfquery name="letterList" datasource="#DSN#">
	select DISTINCT Left(email,1) As emailLetter
	from GEMMCustomers
</cfquery>
<cfquery name="countMailList" datasource="#DSN#">
	select email, subscribe
	from GEMMCustomers
</cfquery>
<cfquery name="activeMailList" dbtype="query">
	select *
	from countMailList
	where subscribe='yes'
</cfquery>
<cfquery name="allMailList" datasource="#DSN#">
	select *
	from GEMMCustomers
	where Left(email,1)='#url.letter#'
	order by email
</cfquery>
<style>
.subNo {color:#999999;}
.subYes {color:#CCCCCC;}
</style>
<p><cfoutput query="letterList"><a href="customersMailingList.cfm?letter=#LCase(emailLetter)#">#UCase(emailLetter)#</a> </cfoutput></p>

<cfform name="addemail" method="post" action="customersMailingListAddAction.cfm">
Name: <cfinput type="text" name="name" size="20" maxlength="50" required="yes" message="Name is required."> 
Email: <cfinput type="text" name="email" size="25" maxlength="50" required="yes" message="Email is required."> 
<cfinput type="submit" name="submit" value="  Add  ">
</cfform>
<p><cfoutput>#activeMailList.recordCount# Active Subscribers (#countMailList.recordCount-activeMailList.recordCount# Inactive)</cfoutput></p>
<table border="1" style="border-collapse:collapse;" cellpadding="2">
<cfoutput query="allMailList">
	<tr>
		<td><a href="customersMailingListEdit.cfm">EDIT</a> <a href="customersMailingListRemove.cfm?ID=#ID#&letter=#url.letter#">REMOVE</a> <a href="customersMailingListDelete.cfm?ID=#ID#&letter=#url.letter#">DELETE</a></td>
		<td class="sub#YesNoFormat(subscribe)#">#email#</td>
		<td class="sub#YesNoFormat(subscribe)#">#name#</td>
		<td class="sub#YesNoFormat(subscribe)#">#YesNoFormat(subscribe)#</td>
	</tr>
</cfoutput>
</table>
<cfinclude template="pageFoot.cfm">