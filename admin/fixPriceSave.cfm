<cfparam name="url.ret" default="">
<cfparam name="url.costtoo" default="false">
<cfquery name="fixPriceSave" datasource="#DSN#">
	update catItems
    set price=priceSave, priceSave=0 where priceSave>0
</cfquery>
<cfif url.costtoo EQ "true">
    <cfquery name="fixCostSave" datasource="#DSN#">
        update catItems
        set cost=costSave, costSave=0 where costSave>0
    </cfquery>
</cfif>
<cfif url.ret NEQ "">
<cflocation url="#url.ret#">
y
</cfif>