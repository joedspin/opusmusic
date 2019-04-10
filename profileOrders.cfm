<cfinclude template="pageHead.cfm">
<style>
	body {background-color:#333333}
	li {font-size: 12px; line-height: 120%;}
</style>
<blockquote>
<h1 style="margin-top: 12px;"><b><font color="#66FF00">My Account</font></b> Order History and Status</h1>
<cfquery name="custOrders" datasource="#DSN#">
	select *
	from ((orders LEFT JOIN orderStatus ON orders.statusID=orderStatus.ID) LEFT JOIN adminIssues ON orders.adminIssueID=adminIssues.ID)
	where custID=<cfqueryparam value="#Session.userID#" cfsqltype="integer"> AND statusID<7AND statusID>1 
	order by datePurchased DESC
</cfquery>
<ul>
<cfif custOrders.RecordCount EQ 0>
	<li>no orders on record</li>
<cfelse>
	<cfoutput query="custOrders">
		<!---<cfquery name="thisStatus" datasource="#DSN#">
			select *
			from orderStatus
			where ID=#custOrders.statusID#
		</cfquery>//--->
		<li><a href="profileOrdersView.cfm?ID=#custOrders.ID#">#DateFormat(datePurchased,"mm/dd/yy")# Order ###NumberFormat(ID,"00000")#</a> #statusName# (#DateFormat(dateUpdated,"mm/dd/yy")#) <cfif adminIssueID GT 0><font color="red">#issueName#</font></cfif></li>
	</cfoutput>
</cfif>
</ul>
	<p><a href="profile.cfm">Back to My Account</a></p>
</blockquote>
<cfinclude template="pageFoot.cfm">