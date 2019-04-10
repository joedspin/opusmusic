<cfsetting requesttimeout="900">
<!--- Special Query to put old IMPORTS Back in stock //--->
<cfset lastYear=DateFormat(varDateODBC,"yyyy")-1>
<cfset todaysDate=DateFormat(varDateODBC,"mm-dd")>
<cfquery name="oldImportsBackIn" datasource="#DSN#">
	update catItems
    set albumStatusID=23, dtDateUpdated=<cfqueryparam value="#varDateODBC#" cfsqltype="cf_sql_date">
    where shelfID<>11 AND dtDateUpdated<<cfqueryparam value="#lastYear#-#todaysDate#" cfsqltype="cf_sql_date"> AND albumStatusID<25 AND ONHAND>0
</cfquery>
<cfquery name="dt161priceadjust" datasource="#DSN#">
	update catItems
    set cost=dtbuy+1 where shelfID=11
</cfquery>
<!--- Set dt 304 cost to halfway between 161 sell price and 161 buy price when that amount is less than $1.00 //--->
<cfquery name="dt161adjustmarkup" datasource="#DSN#">
	update catItems
    set cost=dtbuy+((buy-dtbuy)/2) 
    where ((buy-dtbuy)/2) < 1.00 AND shelfID=11
</cfquery>
<!--- Reset DT304 cost and price based on DT161 Sell Prices //--->
<cfquery name="dt161priceadjust" datasource="#DSN#">
	update catItems
    set price=buy*1.50 where shelfID=11 AND mediaID NOT IN (11,3,2)
</cfquery>
<cfquery name="dt161priceadjust" datasource="#DSN#">
	update catItems
    set price=cost+3.00 where price>cost+3.00 AND shelfID=11 AND mediaID NOT IN (11,3,2) AND NRECSINSET=1
</cfquery>
<!--- Make price lower for 7" //--->
<cfquery name="dt161priceadjust" datasource="#DSN#">
	update catItems
    set price=buy*1.3 where shelfID=11 AND mediaID=11
</cfquery>
<!--- make Price at least cost+2.50 for 7" //--->
<cfquery name="dt161priceadjust" datasource="#DSN#">
	update catItems
    set price=cost+2.50 where price<cost+2.50 AND shelfID=11 AND mediaID=11
</cfquery>
<!--- Make price lower for CD and CD Single //--->
<cfquery name="dt161priceadjust" datasource="#DSN#">
	update catItems
    set price=buy*1.30 where shelfID=11 AND mediaID IN (3,2)
</cfquery>
<cfquery name="dt161priceadjust" datasource="#DSN#">
	update catItems
    set price=cost+2.50 where price>cost+3.00 AND shelfID=11 AND mediaID IN (3,2) AND NRECSINSET=1
</cfquery>
<!--- Give DT304 50 cents off on Syam,GeorgeT,Deminted 
<cfquery name="dt161fixVendors" datasource="#DSN#">
	update catItems
    set  price=(buy-.5)*1.5 where shelfID=11 AND vendorID IN (6897,5439,6319)
</cfquery>//--->
<!--- ADDED January 2011 - Special Metro and Scorpio AND Downtown 161 prices for DT304 //--->
<cfquery name="dt161fixVendors" datasource="#DSN#">
	update catItems
    set price=(dtBuy+1.00)*1.8 where shelfID=11 AND vendorID IN (6978,153,5650)
</cfquery>
<!--- On Metro and Scorpio titles, set price to DT161Sell_Price + $1.50 if it is equal to or less than 161's Sell Price //--->
<cfquery name="dt161fixVendors" datasource="#DSN#">
	update catItems
    set price=buy+1.50 where price<=buy AND shelfID=11 AND vendorID IN (5650,6978,153)
</cfquery>
<!--- Make markup higher for DT161 
<cfquery name="dt161priceadjust" datasource="#DSN#">
	update catItems
    set price=buy+3.00 where price>buy+3.00 AND shelfID=11 AND mediaID=1 AND vendorID IN (5650,6978,153)
</cfquery>//--->
<cfquery name="dt161fixzeroprice" datasource="#DSN#">
	update catItems
    set price=price-0.01 where Right(price,1)='0' AND shelfID=11
</cfquery>
<!---<cfquery name="dt161fixTooHigh" datasource="#DSN#">
	update catItems
    set price=cost+3.60 where price>cost+3.60 AND NRECSINSET=1 AND shelfID IN (7,11,13)
</cfquery>
<cfquery name="dt161fixTooHigh" datasource="#DSN#">
	update catItems
    set price=8.99 where price>8.99 AND price<9.27 AND NRECSINSET=1 AND shelfID IN (7,11,13)
</cfquery>
//--->
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
<!--- Special override for Rong / DFA //--->

<cfquery name="fixNews" datasource="#DSN#">
   update catItems
   set albumStatusID=24
   where albumStatusID=21 AND ONHAND>0
        AND releaseDate<='#DateFormat(DateAdd('d',-90,varDateODBC),"yyyy-mm-dd")#'
</cfquery>
<!--- Make Prices Prettier - If between .01 and .19, make it .99 rounded down //--->
<cfquery name="makePricesPrettier" datasource="#DSN#">
	update catItems
    set price=price-.2 where right(price,2)<20 AND right(price,2)>0 AND shelfID=11
</cfquery>

<!---<cfquery name="domesticSaleSep2012" datasource="#DSN#">
	update catItems
    set price=4.99, cost=2.99
    where specialItem=0 AND priceSave>0
</cfquery>
</cfif>//--->
<!---
<cfquery name="mediasale" datasource="#DSN#">
	update catItems
    set price=2.99, cost=1
    where ONHAND>0 AND albumStatusID<25 AND mediaID=11 AND albumStatusID<>21 AND shelfID=11 AND vendorID<>7561 AND labelID NOT IN (6131,2538,3911,4014,7839,8537,8515,8889,1641,8171,1777,5720)
</cfquery>
<cfquery name="mediasale" datasource="#DSN#">
	update catItems
    set price=4.99, cost=2
    where ONHAND>0 AND albumStatusID<25 AND mediaID=9 AND albumStatusID<>21 AND shelfID=11 AND vendorID<>7561 AND labelID NOT IN (6131,2538,3911,4014,7839,8537,8515,8889,1641,8171,1777,5720)
</cfquery>
<cfquery name="mediasale" datasource="#DSN#">
	update catItems
    set price=3.99, cost=2
    where ONHAND>0 AND albumStatusID<25 AND mediaID IN (2,3) AND albumStatusID<>21 AND shelfID=11 AND vendorID<>7561 AND labelID NOT IN (6131,2538,3911,4014,7839,8537,8515,8889,1641,8171,1777,5720)
</cfquery>
<cfquery name="seriesSale" datasource="#DSN#">
		update catItems
        set price=4.99, cost=2.99
		where labelID IN (2038,706,2035,2239,2054,6807,2045,2042,6320,1858,796) AND shelfID=11
	</cfquery>//--->
<cfquery name="fixNullsInCost" datasource="#DSN#">
	update catItems
    set dt161buy=0 where dt161buy Is NULL OR dt161buy<0.01
</cfquery>
<cfquery name="fixZeroPrice" datasource="#DSN#">
	update catItems
    set price=0 where price<0
</cfquery>
<!---<cfquery name="fixDT161PriceTooLow" datasource="#DSN#">
	update catItems
    set price=price+0.49 where shelfID=11 AND price<8.50
</cfquery>//--->
<!---<cfquery name="fixDT161PriceTooLow" datasource="#DSN#">
	update catItems
    set price=buy+2 where shelfID=11 AND price<buy+2
</cfquery>//--->
<cfquery name="fixnotnew" datasource="#DSN#">
	update catItems
    set ONSIDE=0, notNew304=0
    where ONSIDE<>999
</cfquery>
<cfquery name="fixSillyStatuses" datasource="#DSN#">
	update catItems
    set albumStatusID=21 where albumStatusID IN (18,19)
</cfquery>

<cfquery name="fixRongDFA" datasource="#DSN#">
	update catItems
    set price=6.99, cost=3.99
    where labelID IN (5599,5197)
</cfquery>
<!--- Special override for ZUKI Live Garage 12"s 
<cfquery name="fixZUKI" datasource="#DSN#">
	update catItems
    set price=12.99, cost=8.99, buy=9.99
    where ID IN (61893,56156,55715,55294,55103)
</cfquery>//--->
<!--- Special override for Coati Mundi LP 
<cfquery name="fixRongCoatiMundiLP" datasource="#DSN#">
	update catItems
    set price=14.99, cost=12.99
    where ID=66667
</cfquery>//--->
<!--- Special override for Thriller LP 
<cfquery name="fixThriller" datasource="#DSN#">
	update catItems
    set price=14.99, cost=9.99
    where ID=48335
</cfquery>//--->
<!--- Special override for Tevo Howard TTHR005 
<cfquery name="fixTevo5" datasource="#DSN#">
	update catItems
    set price=16.99
    where ID=69233
</cfquery>//--->
<!--- Special override for Madonna Hard Candy //--->
<cfquery name="fixMadonnaHard" datasource="#DSN#">
	update catItems
    set price=6.99, cost=3.99, wholesalePrice=5.99
    where ID=49049
</cfquery>
<!--- Special override for Happiness LP 
<cfquery name="fixHappinessLP" datasource="#DSN#">
	update catItems
    set price=29.99
    where ID=71760
</cfquery>//--->
<!--- Special override for Undaworld 
<cfquery name="fixUnda" datasource="#DSN#">
	update catItems
    set price=12.99
    where ID=55558
</cfquery>//--->
<!--- Special override for Out the Box LP //--->
<cfquery name="SYDLP" datasource="#DSN#">
	update catItems
    set price=6.99, cost=2.49, buy=4.99, wholesalePrice=4.99
    where ID=44854
</cfquery>
<!--- Special override for Madhouse Slipmats 
<cfquery name="fixMHSLIP" datasource="#DSN#">
	update catItems
    set price=9.99, cost=8, buy=8
    where ID=66889
</cfquery>//--->
<!--- Special override for Mariah AND Janet //--->
<cfquery name="fixMariahJanet" datasource="#DSN#">
	update catItems
    set price=5.99, cost=3.99, wholesalePrice=4.99, buy=4.99
    where ID=48875 OR ID=48029
</cfquery>
<!--- Special override for Stupid Fresh LPs
<cfquery name="fixStupidFresh" datasource="#DSN#">
	update catItems
    set price=7.49, cost=5.49
    where ID=39735 OR ID=39826
</cfquery> //--->
<!--- Special override for Mahogani LP MM24
<cfquery name="fixMM24" datasource="#DSN#">
	update catItems
    set price=18.99, cost=11.99
    where ID=62325
</cfquery> //--->
<!--- Special override for FELA BOX 
<cfquery name="fixFELA" datasource="#DSN#">
	update catItems
    set price=44.99, cost=34.99
    where ID=63189
</cfquery>//--->
<!--- Special override for ANASTASIA 12" 
<cfquery name="fixANASTASIA" datasource="#DSN#">
	update catItems
    set price=6.99, cost=5.99
    where ID=64666
</cfquery>//--->
<!--- Special override for SECRETS SHH1 //--->
<cfquery name="fixSHH" datasource="#DSN#">
	update catItems
    set price=8.49, cost=4.49, wholesalePrice=5.99, buy=5.99
    where ID=63401
</cfquery>
<!--- Special override for SADE Soldier of Love LP 
<cfquery name="fixSADESOLDIER" datasource="#DSN#">
	update catItems
    set price=19.99
    where ID=63343
</cfquery>//--->
<!--- Special override for I Feel Love Red Vinyl 
<cfquery name="fixDONNARED" datasource="#DSN#">
	update catItems
    set price=11.99, cost=7.49, buy=7.49
    where ID=44452
</cfquery>//--->
<!--- Special override for Downtown 304 CDs 
<cfquery name="fixDT304CD" datasource="#DSN#">
	update catItems
    set price=5.99, cost=3.99
    where mediaID=3 AND labelID=4158
</cfquery>//--->
<!--- Special override for Antonio Ocasio CD 
<cfquery name="fixTWCD" datasource="#DSN#">
	update catItems
    set price=15.99, cost=13.33
    where ID=67555
</cfquery>//--->
<!--- Special override for TA label AND Ballroom label //--->
<cfquery name="fixTAlabel" datasource="#DSN#">
	update catItems
    set price=6.99, cost=3.99, wholesalePrice=4.99, buy=4.99
    where labelID IN (8856, 2042)
</cfquery>
<!--- Special override for CORE 1994A 
<cfquery name="fixCORE" datasource="#DSN#">
	update catItems
    set price=11.99, cost=7.99, buy=8.99
    where ID=65249
</cfquery>//--->
<!--- Special override for New Order LP 
<cfquery name="fixNOLP" datasource="#DSN#">
	update catItems
    set price=14.99, cost=7.99, buy=14.99
    where ID=41137
</cfquery>//--->
<!--- Special override for Madonna MDNA //--->
<cfquery name="fixMDNA" datasource="#DSN#">
	update catItems
    set price=9.99, cost=6.99, wholesalePrice=8.49
    where ID=69354
</cfquery>
<!--- Special override for Ashord & Simpson Box Set 
<cfquery name="fixASHFORDBOX" datasource="#DSN#">
	update catItems
    set price=17.99, cost=13.99
    where ID=52252
</cfquery>//--->
<!--- Special override for Mr. V LP //--->
<cfquery name="fixMRVLP" datasource="#DSN#">
	update catItems
    set price=14.99, cost=12.99
    where ID=43462
</cfquery>
<!--- Special override for Anane Picture Disc //--->
<cfquery name="fixANANPIC" datasource="#DSN#">
	update catItems
    set price=9.99, cost=6.99, wholesalePrice=8.49
    where ID=51031
</cfquery>
<!--- Special override for Dope Jams 116 
<cfquery name="fixDOPEJAMS116" datasource="#DSN#">
	update catItems
    set price=11.99
    where ID=33112
</cfquery>//--->
<!--- Special override for DJ Spinna P&P Vinyl
<cfquery name="fixSpinnaPP" datasource="#DSN#">
	update catItems
    set price=23.99
    where ID=33341
</cfquery> //--->
<!--- Special override for DJ Spinna P&P CD 
<cfquery name="fixDOPEJAMS116" datasource="#DSN#">
	update catItems
    set price=15.99
    where ID=33342
</cfquery>//--->
<!--- Special override for What It Is Box Set 
<cfquery name="fixFUNKBOX" datasource="#DSN#">
	update catItems
    set price=69.99, cost=44.99, mediaID=11
    where ID=67576
</cfquery>//--->
<!--- Special override for Dinosaur L CD //--->
<cfquery name="fix24CD" datasource="#DSN#">
	update catItems
    set mediaID=2
    where ID=68514
</cfquery>
<!--- George T sale 2011 
<cfif DateFormat(varDateODBC,"yyyy-mm-dd") LTE "2011-07-27">
<cfquery name="dt161fixVendors" datasource="#DSN#">
	update catItems
    set cost=3.50, price=9.52 where mediaID=1 AND NRECSINSET=1 AND shelfID=11 AND vendorID=5439
</cfquery>
</cfif>//--->
<!--- Special override for DOUBLE-PAKS - Exclude Joe Claussell from special price //--->
<cfquery name="fixDOUBLEPAKS" datasource="#DSN#">
	update catItems
    set price=6.99, cost=2.00, buy=3.99, wholesalePrice=3.99
    where labelID=8107 AND ID NOT IN (64866,64867,64875,65998,65997,65996)
</cfquery>
<!--- Special override for WEST END DOUBLE-PAKS  
<cfquery name="fixDOUBLEPAKS" datasource="#DSN#">
	update catItems
    set price=14.99, cost=9.99
    where ID IN (65998,65997,65996)
</cfquery>//--->
<!--- Special override for TEVO HOWARD RECORD 
<cfquery name="fixtevospecificity" datasource="#DSN#">
	update catItems
    set price=9.99, cost=6.99
    where ID=70690
</cfquery>//--->
<!--- Special override for AMY LIONESS//--->
<cfquery name="fixAMYLIONESS" datasource="#DSN#">
	update catItems
    set price=11.99, cost=7.99, wholesalePrice=9.99
    where ID=68509
</cfquery>
<!--- Special override for P&P HITS CD Box Set
<cfquery name="fixPANDPBOX" datasource="#DSN#">
	update catItems
    set price=39.99, cost=37.99, NRECSINSET=15, mediaID=2
    where ID=69956
</cfquery>//--->
<!--- Special override for P&P LP 
<cfquery name="fixPANDPLP" datasource="#DSN#">
	update catItems
    set price=23.99
    where ID=69433
</cfquery>//--->
<!--- Special override for GAGA BORN REMIX
<cfquery name="fixGAGABORNREMIX" datasource="#DSN#">
	update catItems
    set price=14.99, cost=12.99
    where ID=68510
</cfquery>//--->
<!--- Fix 10.19 items make them 9.99  
<cfquery name="fixDOUBLEPAKS" datasource="#DSN#">
	update catItems
    set price=9.99
    where shelfID=11 AND cost=6.79 AND price>9.99 AND labelID IN (8178,8107)
</cfquery>
<cfquery name="fixPROSH" datasource="#DSN#">
	update catItems
	set vendorID=5650
	where shelfID=11 AND catnum LIKE '%PROSH%' OR catnum LIKE '%COOLX%'
</cfquery>
<cfquery name="fixPICT" datasource="#DSN#">
	update catItems
   	set price=13.99, cost=13.99, buy=14.79, countryID=5
    where shelfID=11 and labelID IN (4135,8859,9110) AND price>13.99
</cfquery>//--->
<cfquery name="fixFallOutClearance" datasource="#DSN#">
	update catItems
	set cost=1.99, price=4.99, wholesaleprice=2.99
	where labelID=72 AND mediaID=1 AND ONHAND>0 AND albumStatusID<25
</cfquery>
<!---<cfquery name="fixPriceTooLow" datasource="#DSN#">
	update catItems
    set price=8.99
    where ONHAND>0 AND albumStatusID<25 AND shelfID=11 AND price>7.99 AND price<8.99
</cfquery>//--->
<cfquery name="dt304distprices" datasource="#DSN#">
	update catItems
    set cost=dtBuy
    where albumStatusID<25 and shelfID=11 AND cost>dtBuy
</cfquery>
<cfquery name="dt304distprices" datasource="#DSN#">
	update catItems
    set wholesalePrice=buy
    where shelfID=11 AND wholesalePrice<buy
</cfquery>

Done.
<!--- Sacred Rhythm / Slow to Speak SALE 
<cfif DateFormat(varDateODBC,"yyyy-mm-dd") LTE "2014-01-13">

<cfquery name="sale199" datasource="#DSN#">
	update catItems
    set priceSave=price, cost=0.99, price=1.99, wholesalePrice=1.49
    where (vendorID IN (7680,7301,6036,7686,5320,5384,6323,7221) OR labelID IN (1206,6194,8691,754,4920,1772)) AND catnum NOT LIKE '%SHL1004%' AND NRECSINSET=1 AND mediaID=1
</cfquery>
<cfquery name="sale299" datasource="#DSN#">
	update catItems
    set priceSave=price, cost=1.49, price=2.99, wholesalePrice=1.99
    where (vendorID IN (6319,5667,1652) OR labelID IN (2318,2303,793)) AND catnum NOT LIKE '%SHL1004%' AND NRECSINSET=1 AND mediaID=1
</cfquery>
<cfquery name="sale399" datasource="#DSN#">
	update catItems
    set priceSave=price, cost=1.99, price=3.99, wholesalePrice=2.99
    where (vendorID IN (7842,6897,7949,8031) OR labelID=796) AND catnum NOT LIKE '%SHL1004%'  AND NRECSINSET=1 AND mediaID=1 AND shelfID=11
</cfquery>
<cfquery name="sale499" datasource="#DSN#">
	update catItems
    set priceSave=price, cost=2.49, price=4.99, wholesalePrice=3.49
    where vendorID IN (471,7009,6978,6882,907,3475,7561) AND catnum NOT LIKE '%SHL1004%'  AND NRECSINSET=1 AND mediaID=1
</cfquery>
<cfquery name="sale599" datasource="#DSN#">
	update catItems
    set priceSave=price, cost=2.99, price=5.99, wholesalePrice=3.99
    where vendorID IN (7848,4799) AND catnum NOT LIKE '%SHL1004%'  AND NRECSINSET=1 AND mediaID=1
</cfquery>
<cfquery name="sale699" datasource="#DSN#">
	update catItems
    set priceSave=price, cost=4.99, price=6.99, wholesalePrice=5.99
    where vendorID IN (7561,7064,470,7438,3942) AND catnum NOT LIKE '%SOIL%' AND catnum NOT LIKE '%RESIDUE%' AND catnum<>'CORE94TU' AND catnum NOT LIKE '%SHL1004%' AND NRECSINSET=1 AND mediaID=1
</cfquery>
</cfif>//--->