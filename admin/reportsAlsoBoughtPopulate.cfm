<cfsetting requesttimeout="60000" enablecfoutputonly="no">
<cfparam name="url.sRow" default="1">
<cfif url.sRow EQ 1>
	<cfquery name="clearAlsoBought" datasource="#DSN#">
		delete 
		from alsoBought
	</cfquery>
</cfif>
<cfquery name="ordersAB" datasource="#DSN#" cachedwithin="#CreateTimeSpan(0,2,0,0)#">
	select DISTINCT custID, dateUpdated
	from orders
	where statusID=6
</cfquery>
<cfoutput query="ordersAB">
#custID#<br />
</cfoutput>
<cfset itemCount=0>
<cfset itemArray = ArrayNew(1)>
<cfquery name="alsoBoughtQ" datasource="#DSN#">
	select *
	from alsoBought
</cfquery>
<cfquery name="orderItemsQueryQ" datasource="#DSN#">
	select catItemID, custID
	from orderItemsQuery
	where statusID=6
	order by dateUpdated DESC
</cfquery>
<cfloop query="ordersAB" startrow="#url.sRow#" endrow="#url.sRow+19#">
	<cfset thisCustID=custID>
		<cfquery name="orderItems" dbtype="query">
			select DISTINCT catItemID
			from orderItemsQueryQ
			where custID=#thisCustID#
		</cfquery>
		<cfif orderItems.recordCount GT 1>
			<cfset Temp=ArrayClear(itemArray)>
			<cfset aCt=0>
			<cfloop query="orderItems">
				<cfset aCt=aCt+1>
				<cfset itemArray[aCt]=catItemID>
			</cfloop>
			<cfloop from="1" to="#aCt#" index="x">
				<cfloop from ="1" to="#aCt#" index="y">
					<cfif itemArray[x] NEQ itemArray[y]>
						<cfquery name="checkAB" dbtype="query">
							select *
							from alsoBoughtQ
							where abItemID=#itemArray[x]# AND abID=#itemArray[y]#
						</cfquery>
						<cfif checkAB.recordCount GT 0>
							<cfquery name="countAB" datasource="#DSN#">
								update alsoBought
								set abCount=abCount+1
								where abItemID=#itemArray[x]# AND abID=#itemArray[y]#
							</cfquery>
						<cfelse>
							<cfquery name="addAB" datasource="#DSN#">
								insert into alsoBought (abItemID, abID, abCount)
								values (#itemArray[x]#, #itemArray[y]#, 1)
							</cfquery>
						</cfif>
					</cfif>
					<cfset itemCount=itemCount+1>
				</cfloop>
			</cfloop>
		</cfif>
</cfloop>
<cfoutput>#itemCount# items processed.<br />
<a href="reportsAlsoBoughtPopulate.cfm?sRow=#url.sRow+20#">Do #sRow+50# to #sRow+99#</a> of #ordersAB.recordCount#</cfoutput>