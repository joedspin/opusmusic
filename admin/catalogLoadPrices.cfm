<cfsetting requesttimeout="900">
<!--- Special Query to put old IMPORTS Back in stock //--->
<cfset lastYear=DateFormat(varDateODBC,"yyyy")-1>
<cfset todaysDate=DateFormat(varDateODBC,"mm-dd")>
<cfquery name="oldImportsBackIn" datasource="#DSN#">
	update catItems
    set albumStatusID=23, dtDateUpdated=<cfqueryparam value="#varDateODBC#" cfsqltype="cf_sql_date">
    where shelfID NOT IN (7,11,13) AND dtDateUpdated<<cfqueryparam value="#lastYear#-#todaysDate#" cfsqltype="cf_sql_date"> AND albumStatusID<25 AND ONHAND>0
</cfquery>
<!--- Reset DT304 cost and price based on DT161 Sell Prices //--->
<cfquery name="dt161priceadjust" datasource="#DSN#">
	update catItems
    set cost=buy, price=buy*1.5 where shelfID IN (7,11,13) AND mediaID NOT IN (11,3,2)
</cfquery>
<!--- Make price lower for 7" //--->
<cfquery name="dt161priceadjust" datasource="#DSN#">
	update catItems
    set cost=buy, price=buy*1.4 where shelfID IN (7,11,13) AND mediaID IN (11,3,2)
</cfquery>
<!--- Make price lower for CD and CD Single //--->
<cfquery name="dt161priceadjust" datasource="#DSN#">
	update catItems
    set cost=buy, price=buy*1.5 where shelfID IN (7,11,13) AND mediaID IN (11,3,2)
</cfquery>
<!--- Give DT304 50 cents off on Syam,GeorgeT,Deminted //--->
<cfquery name="dt161fixVendors" datasource="#DSN#">
	update catItems
    set cost=buy-.5, price=(buy-.5)*1.80 where shelfID IN (7,11,13) AND vendorID IN (6897,5439,6319)
</cfquery>
<!--- ADDED January 2011 - Special Metro and Scorpio prices for DT304 //--->
<cfquery name="dt161fixVendors" datasource="#DSN#">
	update catItems
    set cost=dtBuy+1.00, price=(dtBuy+1.00)*1.8 where shelfID IN (7,11,13) AND vendorID IN (5650,6978,153)
</cfquery>
<!--- On Metro and Scorpio titles, set price to DT161Sell_Price + $2.00 if it is equal to or less than 161's Sell Price //--->
<cfquery name="dt161fixVendors" datasource="#DSN#">
	update catItems
    set price=buy+2.00 where price<=buy AND shelfID=11 AND vendorID IN (5650,6978,153)
</cfquery>

<!---<cfquery name="dt161fixTooHigh" datasource="#DSN#">
	update catItems
    set price=cost+3.60 where price>cost+3.60 AND NRECSINSET=1 AND shelfID IN (7,11,13)
</cfquery>
<cfquery name="dt161fixTooHigh" datasource="#DSN#">
	update catItems
    set price=8.99 where price>8.99 AND price<9.27 AND NRECSINSET=1 AND shelfID IN (7,11,13)
</cfquery>
<cfquery name="makePricesPrettier" datasource="#DSN#">
	update catItems
    set price=price-.2 where right(price,2)<20 AND right(price,2)>0
</cfquery>//--->
<!--- This little bit of code here is just for the Paradise Garage Sale May 2009 
<cfif DateFormat(varDateODBC,"yyyy-mm-dd") LTE "2009-05-31">
    <cfquery name="fixSpecialPG" datasource="#DSN#">
        update catItems
        set cost=4.99, price=6.49
        where specialItem=1
    </cfquery>
</cfif>//--->
<!--- This little bit of code here is just for the Vega Sale July 2009 
<cfif DateFormat(varDateODBC,"yyyy-mm-dd") LTE "2009-07-20">
    <cfquery name="fixSpecialSale" datasource="#DSN#">
        update catItems
        set cost=4.79, price=6.79
        where specialItem=1 AND labelID=990
    </cfquery>
</cfif>//--->
<!--- Special override for Rong / DFA 
<cfquery name="fixRongDFA" datasource="#DSN#">
	update catItems
    set price=6.89, cost=3.99
    where labelID=5599 OR labelID=5197
</cfquery>//--->
<!--- Special override for Rong / DFA //--->
<cfquery name="fixRongCoatiMundiLP" datasource="#DSN#">
	update catItems
    set cost=12.99, price=16.99
    where ID=66667
</cfquery>
<!--- Special override for Madonna Hard Candy //--->
<cfquery name="fixMadonnaHard" datasource="#DSN#">
	update catItems
    set price=9.99, cost=7.99
    where ID=49049
</cfquery>
<!--- Special override for Undaworld //--->
<cfquery name="fixUnda" datasource="#DSN#">
	update catItems
    set price=12.99
    where ID=55558
</cfquery>
<!--- Special override for Kerri CD //--->
<cfquery name="fixKerriCD" datasource="#DSN#">
	update catItems
    set price=7.99, cost=5.49
    where ID=44854
</cfquery>
<!--- Special override for Mariah AND Janet //--->
<cfquery name="fixMariahJanet" datasource="#DSN#">
	update catItems
    set price=7.99, cost=5.39
    where ID=48875 OR ID=48029
</cfquery>
<!--- Special override for Stupid Fresh LPs //--->
<cfquery name="fixStupidFresh" datasource="#DSN#">
	update catItems
    set price=8.99, cost=5.99
    where ID=39735 OR ID=39826
</cfquery>
<!--- Special override for Mahogani LP MM24 
<cfquery name="fixMM24" datasource="#DSN#">
	update catItems
    set price=18.99, cost=11.99
    where ID=62325
</cfquery>//--->
<!--- Special override for Mahogani LP MM24 
<cfquery name="fixFELA" datasource="#DSN#">
	update catItems
    set price=44.99, cost=34.99
    where ID=63189
</cfquery>//--->
<!--- Special override for ANASTASIA 12" 
<cfquery name="fixANASTASIA" datasource="#DSN#">
	update catItems
    set price=8.99, cost=6.99
    where ID=64666
</cfquery>//--->
<!--- Special override for SADE Soldier of Love LP //--->
<cfquery name="fixSADESOLDIER" datasource="#DSN#">
	update catItems
    set price=22.99
    where ID=63343
</cfquery>
<!--- Special override for Downtown 304 CDs //--->
<cfquery name="fixDT304CD" datasource="#DSN#">
	update catItems
    set price=6.99, cost=3.99
    where mediaID=3 AND labelID=4158
</cfquery>
<!--- Special override for DOUBLE-PAKS - Exclude Joe Claussell from special price //--->
<cfquery name="fixDOUBLEPAKS" datasource="#DSN#">
	update catItems
    set price=8.99, cost=5.99
    where labelID=8107 AND ID NOT IN (64866,64867,64875,65998,65997,65996)
</cfquery>
<!--- Special override for WEST END DOUBLE-PAKS  
<cfquery name="fixDOUBLEPAKS" datasource="#DSN#">
	update catItems
    set price=14.99, cost=9.99
    where ID IN (65998,65997,65996)
</cfquery>//--->
<!--- Special override for CORE 1994A //--->
<cfquery name="fixCORE" datasource="#DSN#">
	update catItems
    set price=11.99, cost=7.99, buy=8.99
    where ID=65249
</cfquery>
<!--- Special override for New Order LP //--->
<cfquery name="fixSADESOLDIER" datasource="#DSN#">
	update catItems
    set price=15.98, cost=9.99, buy=14.99
    where ID=41137
</cfquery>
<cfquery name="setWholesale" datasource="#DSN#">
	update catItems
    set wholesalePrice=cost+1+((NRECSINSET-1)*1)
    where shelfID=11
</cfquery>
Done.