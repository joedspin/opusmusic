<cfquery name="GEMMorders" datasource="#DSN#">
	select *
	from GEMMBatchProcessing
	where StatusCode='300' AND ID<1262
	order by CustomerGMU
</cfquery>
<cfset lastCust="0">
<cfloop query="GEMMorders">
	<cfif CustomerGMU NEQ lastCust>
		<cfquery name="cust" datasource="#DSN#">
			select *
			from custAccounts
			where GMU=#CustomerGMU#
		</cfquery>
		<cfif cust.recordCount EQ 0>
			<cfset thisCountry=ShiptoCountry>
			<cfif thisCountry EQ "USA"><cfset thisCountry="United States"></cfif>
			<cfquery name="country" datasource="#DSN#">
				select *
				from countries
				where name='#thisCountry#'
			</cfquery>
			<cfif country.recordCount EQ 0>
				<cfquery name="addCountry" datasource="#DSN#">
					insert into countries (name)
					values ('#thisCountry#')
				</cfquery>
				<cfquery name="country" datasource="#DSN#">
					select *
					from countries
					where name='#thisCountry#'
				</cfquery>
			</cfif>	
			<cfquery name="custAdd" datasource="#DSN#">
				insert into custAccounts (firstName, lastName, countryID, username, password, dateAdded, email, GMU)
				values (
					<cfqueryparam value="" cfsqltype="cf_sql_char">,
					<cfqueryparam value="#ShiptoAttn#" cfsqltype="cf_sql_char">,
					<cfqueryparam value="#country.ID#" cfsqltype="cf_sql_char">,
					<cfqueryparam value="gemm#CustomerGMU#" cfsqltype="cf_sql_char">,
					<cfqueryparam value="#CustomerGMU#gemm" cfsqltype="cf_sql_char">,
					<cfqueryparam value="#varDateODBC#" cfsqltype="cf_sql_date">,
					<cfqueryparam value="#CustomerEmail#" cfsqltype="cf_sql_char">,
					<cfqueryparam value="#CustomerGMU#" cfsqltype="cf_sql_char">
				)
			</cfquery>
			<cfquery name="cust" datasource="#DSN#">
				select *
				from custAccounts
				where GMU=#CustomerGMU#
			</cfquery>
		</cfif>
		<cfquery name="shipAddress" datasource="#DSN#">
			select *
			from custAddresses
			where custID=#cust.ID# AND add1='#ShiptoStreet#'
		</cfquery>
		<cfif shipAddress.recordCount EQ 0>
			<cfquery name="state" datasource="#DSN#">
				select *
				from states
				where abbrev='#ShiptoState#'
			</cfquery>
			<cfif state.recordCount EQ 0>
				<cfset thisStateID=0>
			<cfelse>
				<cfset thisStateID=state.ID>
			</cfif>
			<cfif thisStateID EQ 0><cfset thisStateprov=ShiptoState><cfelse><cfset thisStateprov=""></cfif>
			<cfset thisPhone=PhoneDay>
			<cfif PhoneEve NEQ ""><cfset thisPhone=PhoneEve></cfif>
			<cfquery name="addShipAddress" datasource="#DSN#">
				insert into custAddresses (custID, addName, lastName, add1, add2, add3, city, stateID, stateprov, postCode, countryID, phone1)
				values (
					<cfqueryparam value="#cust.ID#" cfsqltype="cf_sql_char">,
					<cfqueryparam value="GEMM Shipping Address" cfsqltype="cf_sql_char">,
					<cfqueryparam value="#ShiptoAttn#" cfsqltype="cf_sql_char">,
					<cfqueryparam value="#ShiptoStreet#" cfsqltype="cf_sql_char">,
					<cfqueryparam value="#ShiptoStreet2#" cfsqltype="cf_sql_char">,
					<cfqueryparam value="#ShiptoStreet3#" cfsqltype="cf_sql_char">,
					<cfqueryparam value="#ShiptoCity#" cfsqltype="cf_sql_char">,
					<cfqueryparam value="#thisStateID#" cfsqltype="cf_sql_char">,
					<cfqueryparam value="#thisStateprov#" cfsqltype="cf_sql_char">,
					<cfqueryparam value="#ShiptoZip#" cfsqltype="cf_sql_char">,
					<cfqueryparam value="#cust.countryID#" cfsqltype="cf_sql_char">,
					<cfqueryparam value="#thisPhone#" cfsqltype="cf_sql_char">
				)
			</cfquery>
			<cfquery name="shipAddress" datasource="#DSN#">
				select *
				from custAddresses
				where custID=#cust.ID# AND add1='#ShiptoStreet#'
			</cfquery>
		</cfif>
		<cfquery name="billAddress" datasource="#DSN#">
			select *
			from custAddresses
			where custID=#cust.ID# AND add1='#BilltoStreet#'
		</cfquery>
		<cfif billAddress.recordCount EQ 0>
			<cfquery name="state" datasource="#DSN#">
				select *
				from states
				where abbrev='#BilltoState#'
			</cfquery>
			<cfif state.recordCount EQ 0>
				<cfset thisStateID=0>
			<cfelse>
				<cfset thisStateID=state.ID>
			</cfif>
			<cfset thisPhone=PhoneDay>
			<cfif PhoneEve NEQ ""><cfset thisPhone=PhoneEve></cfif>
			<cfquery name="addBillAddress" datasource="#DSN#">
				insert into custAddresses (custID, addName, lastName, add1, city, stateID, stateprov, postCode, countryID, phone1)
				values (
					<cfqueryparam value="#cust.ID#" cfsqltype="cf_sql_char">,
					<cfqueryparam value="GEMM Billing Address" cfsqltype="cf_sql_char">,
					<cfqueryparam value="#BilltoName#" cfsqltype="cf_sql_char">,
					<cfqueryparam value="#BilltoStreet#" cfsqltype="cf_sql_char">,
					<cfqueryparam value="#BilltoCity#" cfsqltype="cf_sql_char">,
					<cfqueryparam value="#thisStateID#" cfsqltype="cf_sql_char">,
					<cfqueryparam value="#BilltoState#" cfsqltype="cf_sql_char">,
					<cfqueryparam value="#BilltoZip#" cfsqltype="cf_sql_char">,
					<cfqueryparam value="#cust.countryID#" cfsqltype="cf_sql_char">,
					<cfqueryparam value="#thisPhone#" cfsqltype="cf_sql_char">
				)
			</cfquery>
			<cfquery name="billAddress" datasource="#DSN#">
				select *
				from custAddresses
				where custID=#cust.ID# AND add1='#BilltoStreet#'
			</cfquery>
		</cfif>
		<cfset custID=#cust.ID#>
		<cfquery name="shipRate" datasource="#DSN#" maxrows="1">
			select ID
			from shippingRates
			where countryID=#cust.countryID#
			order by cost1Record DESC
		</cfquery>
		<cfif shipRate.recordCount EQ 0>
			<cfset shipRateID=3>
		<cfelse>
			<cfset shipRateID=shipRate.ID>
		</cfif>
		<cfset thisStatusID=1>
		<cfif StatusCode EQ 100><cfset thisStatusID=2></cfif>
		<cfif StatusCode EQ 260><cfset thisStatusID=2></cfif>
		<cfif StatusCode EQ 300><cfset thisStatusID=6></cfif>
		<cfif StatusCode EQ 150><cfset thisStatusID=2></cfif>
		<!--- adminPayID set to 1 means it is a GEMM order //--->
		<cfquery name="orderAdd" datasource="#DSN#">
			insert into orders (custID, dateStarted, datePurchased, statusID, shipAddressID, billingAddressID, shipID, specialInstructions, comments, processingDetails, adminPayID)
			values (
				<cfqueryparam value="#custID#" cfsqltype="cf_sql_char">,
				<cfqueryparam value="#datePlaced#" cfsqltype="cf_sql_date">,
				<cfqueryparam value="#dateChanged#" cfsqltype="cf_sql_date">,
				<cfqueryparam value="#thisStatusID#" cfsqltype="cf_sql_char">,
				<cfqueryparam value="#shipAddress.ID#" cfsqltype="cf_sql_char">,
				<cfqueryparam value="#billAddress.ID#" cfsqltype="cf_sql_char">,
				<cfqueryparam value="#shipRateID#" cfsqltype="cf_sql_char">,
				<cfqueryparam value="#CustomerInstruct#" cfsqltype="cf_sql_longvarchar">,
				<cfqueryparam value="#shipMethod#" cfsqltype="cf_sql_longvarchar">,
				<cfqueryparam value="#PaymentType# ending in #Right(CCNum,4)#" cfsqltype="cf_sql_char">,
				<cfqueryparam value="1" cfsqltype="cf_sql_char">
			)
		</cfquery>
		<cfquery name="order" datasource="#DSN#">
			select ID
			from orders
			where custID=#custID# AND statusID=6 AND datePurchased=<cfqueryparam value="#dateChanged#" cfsqltype="cf_sql_date">
		</cfquery>
		<cfset orderID=order.ID>
	</cfif>
	<cfquery name="addItem" datasource="#DSN#">
		insert into orderItems (orderID, catItemID, qtyOrdered, price, adminAvailID)
		values (
			<cfqueryparam value="#orderID#" cfsqltype="cf_sql_char">,
			<cfqueryparam value="#MYREFNO#" cfsqltype="cf_sql_char">,
			<cfqueryparam value="#Quantity#" cfsqltype="cf_sql_char">,
			<cfqueryparam value="#Price#" cfsqltype="cf_sql_money">,
			<cfqueryparam value="6" cfsqltype="cf_sql_char">
		)
	</cfquery>
	<cfquery name="GEMMprocess" datasource="#DSN#">
		update GEMMBatchProcessing
		set Processed=1
		where ID=#ID#
	</cfquery>
	<cfset lastCust=CustomerGMU>
</cfloop>
Done.