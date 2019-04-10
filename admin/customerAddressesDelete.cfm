<cfinclude template="pageHead.cfm">
<cfparam name="url.ID" default="0">
<cfquery name="thisAddress" datasource="#DSN#">
	select *
	from custAddressesQuery
	where ID=<cfqueryparam value="#url.ID#" cfsqltype="cf_sql_char">
</cfquery>
<cfquery name="states" datasource="#DSN#">
	select *
	from statesQuery
	order by abbrev
</cfquery>
<cfquery name="countries" datasource="#DSN#">
	select *
	from countries
	order by name
</cfquery>
<cfoutput query="thisAddress">
<style>
	body {background-color:##333333}
</style>
<blockquote>
	<h1 style="margin-top: 12px;"><b><font color="##66FF00">My Account</font></b> Address Book: Delete</h1>
		<h2><font color="red">are you sure you want to delete this address?</font><br />
			this action cannot be undone!</h2>
		<blockquote>
			<p><b>#addName#</b><br />
			#firstName# #lastName#<br />
			#add1#<br />
			<cfif add2 NEQ "">#add2#<br /></cfif>
			<cfif add3 NEQ "">#add3#<br /></cfif>
			#city# <cfif state NEQ "">#state# </cfif><cfif stateprov NEQ "">#stateprov# </cfif> #postcode#<br />
			#country#</p>
		</blockquote>
		<p><a href="customerAddressesDeleteAction.cfm?ID=#ID#">Yes</a> . . <a href="customerAddresses.cfm">No</a></p>
		<p><a href="customerAddresses.cfm">back to manage addresses</a><br />
			<a href="profile.cfm">back to my account</a></p>
	</blockquote>
</cfoutput>
<cfinclude template="pageFoot.cfm">