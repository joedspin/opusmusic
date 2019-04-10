<cfinclude template="checkOutPageHead.cfm">
<cfinclude template="cartGetContents.cfm">
<cfparam name="url.shipID" default="0">
<cfparam name="url.countryError" default="no">
<!---<p>Checkout Using PayPal</p>
<img src="http://www.paypal.com/en_US/i/btn/btn_xpressCheckout.gif" align="left" style="margin-right:7px;"><span style="font-size:11px; font-family: Arial, Verdana;">Save time.  Checkout securely.  Pay without sharing your financial information.</span>
<p>OR</p>
<p>Checkout Using Your credit card:</p>//--->
<p>&nbsp;</p>
<cfif url.countryError EQ "yes"><p style="color:red; font-size: 20px;">ERROR: The shipping option you chose is not appropriate for the country you are shipping to.<br> Please choose a diffrerent option and try again.</p></cfif>
<h4>Choose Shipping Address</h4>
<cfset vinylCount=0>
<cfset cdCount=0>
<cfset shipmentWeight=0.5>
<cfquery name="myAddresses" datasource="#DSN#">
	select *
	from custAddressesQuery
	where custID=<cfqueryparam value="#Session.userID#" cfsqltype="integer">
	order by useFirst DESC
</cfquery>
<cfset countryList="0">
<cfset countryListIncludesUS=false>
<cfloop query="myAddresses">
	<cfset countryList=countryList&","&countryID>
    <cfif countryID EQ 1><cfset countryListIncludesUS=true></cfif>
</cfloop>
<cfset shipOrderSub=0>
<cfset noMediaMail=false>
<cfset jacket=false>
<cfset tickets=false>
<cfif Session.userID NEQ "0">
	<cfquery name="cartContents" datasource="#DSN#">
		SELECT * from orderItemsQuery
		where custID=<cfqueryparam value="#Session.userID#" cfsqltype="integer">
		AND adminAvailID=2 AND statusID=1
	</cfquery>
    <cfset remove99=0>
	<cfloop query="cartContents">
    	<cfif catnum EQ "INS2015TX"><cfset tickets=true></cfif>
        <cfif catnum NEQ "INS2015TX"><cfset tickets=false></cfif>
    	<cfif price EQ 0.99><cfset remove99=remove99+0.99></cfif>
    	<cfif mediaID EQ 20><cfset noMediaMail=true></cfif>
        <cfif left(catnum,3) EQ "TVJ" AND DateFormat(varDateODBC,"mm-dd-yyyy") LTE "02-10-2012"><cfset jacket=true></cfif>
		<!---<cfif weightException GT 0>
			<cfset shipmentWeight=shipmentWeight+(NRECSINSET*weightException*qtyOrdered)>
		<cfelse>
			<cfset shipmentWeight=shipmentWeight+(NRECSINSET*weight*qtyOrdered)>
		</cfif>//--->
		<cfif weightException GT 0>
        	<cfset vinylCount=vinylCount+(weightException*2)>
        <cfelse>
			<cfif mediaID EQ 1 OR mediaID EQ 5 OR mediaID EQ 9>
                <cfset vinylCount=vinylCount+(NRECSINSET*qtyOrdered)>
            <cfelse>
                <cfset cdCount=cdCount+(NRECSINSET*qtyOrdered)>
            </cfif>
        </cfif>
        <cfif priceOverride EQ 0>
			<cfset shipOrderSub=shipOrderSub+(qtyOrdered*price)>
		<cfelse>
        	<cfset shipOrderSub=shipOrderSub+(qtyOrdered*priceOverride)>
        </cfif>        
	</cfloop>
</cfif>
<cfset shipmentWeight=shipmentWeight+(vinylCount*.5)+(cdCount*.3)>
<cfif myAddresses.recordCount EQ 0><cflocation url="profileAddressesAdd.cfm?ret=cos"></cfif>
<p><a href="profileAddressesAdd.cfm?ret=cos">Add New Address</a></p>
<cfset usingGenericShippingForCountry=false>
<cfform name="shippingAddress" method="post" action="checkOutShipAction.cfm">
	<cfif myAddresses.recordCount GT 0>
	<table cellpadding="15">
	<tr>
	<cfset oneIsChecked=false>
	<cfoutput query="myAddresses">
		<cfset checkedString="">
		<cfif ID EQ url.shipID>
			<cfset checkedString="checked">
			<cfset oneIsChecked=true>
		</cfif>
		<cfif NOT oneIsChecked>
			<cfif useFirst OR myAddresses.RecordCount EQ 1>
				<cfset checkedString="checked">
				<cfset oneIsChecked=true>
			</cfif>
		</cfif>
        <cfset theLookupCountryID=myAddresses.countryID>
        <cfquery name="checkForCountry" datasource="#DSN#">
            select *
            from shippingRatesQuery
            where countryID=#theLookupCountryID#
        </cfquery>
        <cfif checkForCountry.recordCount EQ 0><cfset usingGenericShippingForCountry=true></cfif>
		<td valign="top">
			<table border="0" cellpadding="2" cellspacing="0" style="border-collapse:collapse;">
			<tr>
			<td valign="top"><input type="radio" name="shipID" value="#ID#" #checkedString#></td>
			<td><b>#addName#</b><br />
			#firstName# #LastName#<br />
			#add1#<br />
			<cfif add2 NEQ "">#add2#<br /></cfif>
			<cfif add3 NEQ "">#add3#<br /></cfif>
			#city# <cfif state NEQ "">#state# </cfif><cfif stateprov NEQ "">#stateprov# </cfif> #postcode#<br />
			#country# [ <a href="profileAddressesEdit.cfm?ID=#ID#&ret=cos">edit</a> ]</li></td>
			</tr>
			</table>
		</td>
	</cfoutput>
	</tr>
	</table>
	</cfif>
    <cfif noMediaMail>
    	<cfset mmcode=" AND ID>1">
    <cfelse>
    	<cfset mmcode="">
    </cfif>
    <cfset mmcode="">
    <cfif  usingGenericShippingForCountry>
		<cfset countryList=countryList&",3">
    </cfif>
	<cfquery name="shipOptions" datasource="#DSN#">
		select *
		from shippingRatesQuery
		where countryID IN (#countryList#) #mmcode# AND ID NOT IN (121,127,138,139,140,141)
		order by countryID DESC, cost1Record DESC
	</cfquery>

	<h4>Choose Shipping Method*</h4>
	<table border="0" cellpadding="2" cellspacing="0" style="border-collapse:collapse;">
		<cfset sCheck=true>
        <cfif tickets>
            <cfquery name="shipOptions" datasource="#DSN#">
                select *
                from shippingRates
                where ID=141
            </cfquery>
        </cfif>
        <cfset countryCount=0>
        <cfset lastCountry=0>
		<cfoutput query="shipOptions">
        <cfif countryID NEQ lastCountry><cfset countryCount=countryCount+1></cfif>
        <cfset lastCountry=countryID>
		<cfset shipCost=0>
        <!---<cfif jacket><cfset vinylCount=9></cfif>//--->
		<cfif (vinylCount+cdCount GTE minimumItems) AND ((vinylCount+cdCount LTE maximumItems) OR (maximumItems EQ 0)) AND (shipmentWeight GTE minimumWeight) AND ((shipmentWeight LTE maximumWeight) OR (maximumWeight EQ 0))>
        	
			<cfif vinylCount GT 0>
				<cfset shipCost=shipCost+cost1Record+(costplusrecord*(vinylCount-1))>
				<cfif cdCount GT 0>
					<cfset shipCost=shipCost+(costpluscd*(cdCount-1))>
				</cfif>
			<cfelse>
				<cfif cdCount GT 0>
				<cfset shipCost=shipCost+cost1CD+(costpluscd*(cdCount-1))>
			</cfif>
		</cfif>
		<cfif (shipCost NEQ 0 OR shipOptions.ID EQ 64) AND shipOptions.ID NEQ 71 AND shipOptions.ID NEQ 121>
        	<cfset subtotalForFree=shipOrderSub-remove99>
			<!---THIS BLOCK OF CODE (along with a similar one in checkOutShipAction.cfm produces the FREE SHIPPING/$5 OFF deal ... to reinstate, don't forget to uncomment the </cfif> below ...//--->
			<cfif subtotalForFree GTE 75 AND DateFormat(varDateODBC,"yyyy-mm-dd") LTE "2040-12-31" AND shipOptions.ID EQ 1 AND NOT Session.isStore>
            <!--- NOTE: Currently this is setup for FREE Media Mail shipping on all orders over $75. This setup does NOT include the $5 off other shipping methods to reinstate the discount on other shipping methods, move the comment and below to before the cfelseif tag. //--->
                <tr>
                    <td valign="top"><cfinput type="radio" name="shipOptionID" value="#shipOptions.ID#" required="yes" message="Please choose a Shipping Method" checked="#YesNoFormat(sCheck)#">&nbsp;<b style="color:hsla(201,76%,64%,1.00)"><cfif usingGenericShippingForCountry AND countryID EQ 3>Other Country<cfelse>#shipOptions.country#</cfif></b> #shipOptions.name# - #shipOptions.shippingTime# <cfif shipOptions.ID EQ 1> <b><font color="yellow">FREE</font></b><!--- This cfelse statement enables $5 off on other shipping methods, except pickup at the office <cfelseif shipOptions.ID NEQ 64><s>#DollarFormat(shipCost)#</s> #DollarFormat(shipCost-5.00)#//---><cfelse>#DollarFormat(shipCost)#</cfif></td>
                    <cfset sCheck=false>
                </tr>
             <!---<cfelseif Find('UPS',shipOptions.name) GT 0 AND DateFormat(varDateODBC,"yyyy-mm") EQ "2009-08">
             <tr>
                    <td valign="top"><cfinput type="radio" name="shipOptionID" value="#shipOptions.ID#" required="yes" message="Please choose a Shipping Method" checked="#YesNoFormat(sCheck)#">&nbsp;#shipOptions.name# - #shipOptions.shippingTime# <cfif shipOrderSub GTE 50 AND shipOrderSub LT 75> <b><font color="yellow">5% OFF</font></b> <s>#DollarFormat(shipCost)#</s> #DollarFormat(shipCost*.95)#<cfelseif shipOrderSub GTE 75><b><font color="yellow">10% OFF</font></b> <s>#DollarFormat(shipCost)#</s> #DollarFormat(shipCost*.9)#</cfif></td>
                    <cfset sCheck=false>
                </tr>//--->
             <cfelse><!---   END FREE SHIPPING BLOCK - EXCEPT FOR EXTRA </cfif> below //--->
				<cfif NOT (shipOptions.ID EQ 91 AND vinylCount GT 0)><!--- hide first class mail when vinyl is included //--->
                    <tr>
                        <td valign="top"><cfinput type="radio" name="shipOptionID" value="#shipOptions.ID#" required="yes" message="Please choose a Shipping Method" checked="#YesNoFormat(sCheck)#">&nbsp;<b style="color:hsla(201,76%,64%,1.00)"><cfif usingGenericShippingForCountry AND countryID EQ 3>Other Country<cfelse>#shipOptions.country#</cfif></b> #shipOptions.name# - #shipOptions.shippingTime# #DollarFormat(shipCost)#<cfif shipOptions.ID EQ 64><br><font color="red">If paying cash, you must pick up and pay for your order within 14 days or it will be cancelled and put back.</font></cfif></td>
                        <cfset sCheck=false>
                    </tr>
                </cfif>
              </cfif><!--- REMOVE this </cfif> when disabling FREE SHIPPING Block //--->
		</cfif>
		</cfif>
        <!---<cfif tickets>
        	<cfset shipCost=cost1cd>
        	<tr>
                        <td valign="top"><cfinput type="radio" name="shipOptionID" value="#shipOptions.ID#" required="yes" message="Please choose a Shipping Method" checked="#YesNoFormat(sCheck)#">&nbsp;#shipOptions.name# - #shipOptions.shippingTime# #DollarFormat(shipCost)#</td>
                        <cfset sCheck=false>
                    </tr>
        </cfif>//--->
		</cfoutput>
	</table>
    <cfoutput>
    <input type="hidden" name="countryCount" value="#countryCount#">
    <cfif usingGenericShippingForCountry>
    	<input type="hidden" name="usingGenericShippingForCountry" value="yes" checked>
    </cfif>
    </cfoutput>
    <cfif countryCount GT 1>
    <p style="color:red; font-size: 14px;">Please be sure to choose an option that is appropriate for the country you are shipping to.</p></cfif>
<!---	<h4>Free Gifts and Discounts </h4>
 <p>Choose one: 
    &nbsp;
    <select name="promoID" id="promoID">
        <option value="0">No free gift (you must select this option if you want to use a Promo Code below)</option>
        <cfquery name="checkInventoryWMC" datasource="#DSN#" cachedwithin="#CreateTimeSpan(0, 1, 0, 0)#">
        	select ID, artist, title from
            catItemsQuery where (ID>=54297 AND ID<=54301) AND albumStatusID<25
            order by catnum
        </cfquery>
        <cfoutput query="checkInventoryWMC">
        <option value="#ID#">Free CD: #title# #artist#</option>
        </cfoutput>
        <!---<option value="1">Free CD: Downtown Underground 2008 WMC Promo Series Volume 1: Distant Music</option>
        <option value="2">Free CD: Downtown Underground 2008 WMC Promo Series Volume 2: Soul Groove Records</option>
        <option value="3">Free CD: Downtown Underground 2008 WMC Promo Series Volume 3: Hector Works</option>
        <option value="4">Free CD: Downtown Underground 2008 WMC Promo Series Volume 4: Underground Quality</option>
        <option value="5">Free CD: Downtown Underground 2008 WMC Promo Series Volume 5: Mixx Records, SOM, & Jersey Underground</option>
        <option value="11">Free CD: WMC 2007 Promo 1: Ibadan Records mixed by Jerome Sydenham</option>
        <option value="12">Free CD: WMC 2007 Promo 2: Fall-Out Records mixed by Daryl James and Fred McFarlane (D.F.A.)</option>
        <option value="13">Free CD: WMC 2007 Promo 3: Fetish Recordings mixed by Joey Youngman</option>
        <option value="14">Free CD: WMC 2007 Promo 4: Jay-J and Friends mixed by Jay-J: Shifted Music</option><option value="15">Free CD: WMC 2007 Promo 5: objektivity, sfere, and Dennis Ferrer mixed by The Martinez Brothers</option>
		<option value="16">Free CD: WMC 2007 Promo 6: Downtown 161 Records mixed by Kerri Chandler</option>
        <option value="17">Free CD: WMC 2007 Promo 7: Magnetic Records and Oomph Recordings mixed by DJ Sneak</option>
		<option value="18">Free CD: WMC 2007 Promo 8: Unrestricted Access mixed by Quentin Harris</option>//--->
    </select>
	<br>//--->
    <cfif NOT tickets>
    <h4>Promo Code or Gift Certificate Number:&nbsp; </h4>
<p><cfinput type="text" name="promo" size="10" maxlength="15"></p></cfif>
<cfoutput><input type="hidden" name="shipOrderSub" value="#shipOrderSub#" /><input type="hidden" name="tickets" value="#YesNoFormat(tickets)#"></cfoutput>
	<p><input type="submit" name="submit" value=" Next " /></p>
	<p><!---*NOTE: Shipping charge is estimated based on the number of items in your order. You will be charged actual shipping cost, which is often less than the estimated amount, plus a nominal handling fee.<br />//--->
	*NOTE: Only one discount or gift may be used with each order. If you select a Free CD, you cannot apply a discount to the same order.</p>
</cfform>
<p><a href="http://downtown304.com/index.cfm" target="_top">Continue Shopping</a></p>

<cfinclude template="checkOutPageFoot.cfm">