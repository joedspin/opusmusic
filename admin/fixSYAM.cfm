<cfquery name="SYAM" datasource="#DSN#">
	update catItems
    set price=2.99, cost=1.00, wholesalePrice=2.99, priceSave=price
    where (ID IN (45736,43342,43687,41035,41594,38357,43213,48166,44854) OR (labelID IN (4377,4464,1763,1642,1830,2129,4073,3817,3996) AND NRECSINSET=1)) AND priceSave=0
</cfquery>