<cfparam name="form.submit" default="">
<cfparam name="form.cart" default="checkout">
<cfinclude template="cartGetContents.cfm">
    <cfloop query="cartContents">
        <cfparam name="form.qty#orderItemID#" default="0">
        <cfquery name="checkOrderStatus" datasource="#DSN#">
            select *
            from orderItemsQuery
            where orderItemID=<cfqueryparam value="#orderItemID#" cfsqltype="cf_sql_integer"> AND (datePurchased IS NULL OR datePurchased='')
        </cfquery>
        <cfif checkOrderStatus.recordCount GT 0>
            <cfquery name="updateCart" datasource="#DSN#">
                update orderItems
                set qtyOrdered=<cfqueryparam value="#Evaluate("form.qty" & orderItemID)#" cfsqltype="cf_sql_integer">
                where ID=<cfqueryparam value="#orderItemID#" cfsqltype="cf_sql_integer">
            </cfquery>
        </cfif>
    </cfloop>
    <cfquery name="removeZeroQ" datasource="#DSN#">
        delete 
        from orderItems
        where qtyOrdered=0
    </cfquery>
<cfif form.submit EQ "Update Quantities">
	<cflocation url="checkOut.cfm?cart=#form.cart#">
<cfelse>
	<cflocation url="checkOutShip.cfm">    
</cfif>