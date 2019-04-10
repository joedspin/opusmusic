<cfquery name="fixScorpioLps99" datasource="#DSN#">
	update catItems
    set specialItem=0, priceSave=0
    where vendorID=6978 AND mediaID=5
</cfquery>
<cfquery name="fixScorpioLps99" datasource="#DSN#">
	update catItems
    set specialItem=0, priceSave=0
    where vendorID=5615
</cfquery>
