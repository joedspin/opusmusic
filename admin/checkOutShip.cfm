<cfinclude template="checkOutPageHead.cfm">
<cfinclude template="cartGetContents.cfm">
<cfparam name="url.shipID" default="0">

<!---<p>Checkout Using PayPal</p>
<img src="http://www.paypal.com/en_US/i/btn/btn_xpressCheckout.gif" align="left" style="margin-right:7px;"><span style="font-size:11px; font-family: Arial, Verdana;">Save time.  Checkout securely.  Pay without sharing your financial information.</span>
<p>OR</p>
<p>Checkout Using Your credit card:</p>//--->
<p>&nbsp;</p>
<h4>Choose Shipping Address</h4>
<cfset vinylCount=0>
<cfset cdCount=0>
<cfset shipmentWeight=0.5>
<cfquery name="myAddresses" datasource="#DSN#">
	select *
	from custAddressesQuery
	where custID=<cfqueryparam value="#Session.userID#" cfsqltype="integer">
</cfquery>
<cfset countryList="0">
<cfloop query="myAddresses">
	<cfset countryList=countryList&","&countryID>
</cfloop>
<cfset shipOrderSub=0>
<cfif Session.userID NEQ "0">
	<cfquery name="cartContents" datasource="#DSN#">
		SELECT * from orderItemsQuery
		where custID=<cfqueryparam value="#Session.userID#" cfsqltype="integer">
		AND adminAvailID=2 AND statusID=1
	</cfquery>
	<cfloop query="cartContents">
		<cfif weightException GT 0>
			<cfset shipmentWeight=shipmentWeight+(NRECSINSET*weightException*qtyOrdered)>
		<cfelse>
			<cfset shipmentWeight=shipmentWeight+(NRECSINSET*weight*qtyOrdered)>
		</cfif>
		<cfif mediaID EQ 1 OR mediaID EQ 5 OR mediaID EQ 9>
			<cfset vinylCount=vinylCount+(NRECSINSET*qtyOrdered)>
		<cfelse>
			<cfset cdCount=cdCount+(NRECSINSET*qtyOrdered)>
		</cfif>
        <cfif priceOverride EQ 0>
			<cfset shipOrderSub=shipOrderSub+(qtyOrdered*price)>
		<cfelse>
        	<cfset shipOrderSub=shipOrderSub+(qtyOrdered*priceOverride)>
        </cfif>        
	</cfloop>
</cfif>
<cfif myAddresses.recordCount EQ 0><cflocation url="profileAddressesAdd.cfm?ret=cos"></cfif>
<p><a href="profileAddressesAdd.cfm?ret=cos">Add New Address</a></p>
<cfform name="shippingAddress" method="post" action="checkOutShipAction.cfm">
	<cfif myAddresses.recordCount GT 0>
	<table cellpadding="15">
	<tr>
	<cfoutput query="myAddresses">
		<td valign="top">
			<table border="0" cellpadding="2" cellspacing="0" style="border-collapse:collapse;">
			<tr>
			<td valign="top"><input type="radio" name="shipID" value="#ID#" <cfif ID EQ url.shipID OR useFirst OR myAddresses.RecordCount EQ 1>checked</cfif>></td>
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
	<cfquery name="shipOptions" datasource="#DSN#">
		select *
		from shippingRates
		where countryID IN (#countryList#)
		order by countryID DESC, cost1Record DESC
	</cfquery>
	<cfif shipOptions.recordCount EQ 0>
		<cfquery name="shipOptions" datasource="#DSN#">
			select *
			from shippingRates
			where countryID=2
			order by cost1Record DESC
		</cfquery>
	</cfif>
	<h4>Choose Shipping Method*</h4>
	<table border="0" cellpadding="2" cellspacing="0" style="border-collapse:collapse;">
		<cfset sCheck=true>
		<cfoutput query="shipOptions">
		<cfset shipCost=0>
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
		<cfif (shipCost NEQ 0 OR shipOptions.ID EQ 64) AND shipOptions.ID NEQ 71>
			<!---THIS BLOCK OF CODE (along with a similar one in checkOutShipAction.cfm produces the FREE SHIPPING/$5 OFF deal ... to reinstate, don't forget to uncomment the </cfif> below ...//--->
			<cfif shipOrderSub GTE 50 AND DateFormat(varDateODBC,"yyyy-mm-dd") LTE "2009-01-29">
                <tr>
                    <td valign="top"><cfinput type="radio" name="shipOptionID" value="#shipOptions.ID#" required="yes" message="Please choose a Shipping Method" checked="#YesNoFormat(sCheck)#">&nbsp;#shipOptions.name# - #shipOptions.shippingTime# <cfif shipOptions.ID EQ 1> <b><font color="yellow">FREE</font></b><!--- This cfelse statement enables $5 off on other shipping methods, except pickup at the office //---><cfelseif shipOptions.ID NEQ 64><s>#DollarFormat(shipCost)#</s> #DollarFormat(shipCost-5.00)#<cfelse>#DollarFormat(shipCost)#</cfif></td>
                    <cfset sCheck=false>
                </tr>
             <cfelse>   <!---END FREE SHIPPING BLOCK - EXCEPT FOR EXTRA </cfif> below //--->
                <tr>
                    <td valign="top"><cfinput type="radio" name="shipOptionID" value="#shipOptions.ID#" required="yes" message="Please choose a Shipping Method" checked="#YesNoFormat(sCheck)#">&nbsp;#shipOptions.name# - #shipOptions.shippingTime# #DollarFormat(shipCost)#</td>
                    <cfset sCheck=false>
                </tr>
              </cfif><!--- REMOVE this </cfif> when disabling FREE SHIPPING Block //--->
		</cfif>
		</cfif>
		</cfoutput>
	</table>
	<!---<h4>Free Gifts and Discounts </h4>
 <p>Choose one: (Note that we have run out of some discs. If one is not listed, we don't have it)
    &nbsp;
    <select name="promoID" id="promoID">
        <option value="0">Apply promo code (enter code below)</option>
        <option value="1">Free CD: Downtown Underground 2008 WMC Promo Series Volume 1: Distant Music</option>
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
		<option value="18">Free CD: WMC 2007 Promo 8: Unrestricted Access mixed by Quentin Harris</option>
    </select>
	<br>//--->

    <h4>Promo Code:&nbsp; </h4>
<p><cfinput type="text" name="promo" size="10" maxlength="10"></p>

<cfoutput><input type="hidden" name="shipOrderSub" value="#shipOrderSub#" /></cfoutput>
	<p><input type="submit" name="submit" value=" Next " /></p>
	<p>*NOTE: Shipping charge is estimated based on the number of items in your order. You will be charged actual shipping cost, which is often less than the estimated amount, plus a nominal handling fee.<!---<br />
	**NOTE: Only one discount or gift may be applied for each order. If you select a Free CD, you cannot apply a discount to the same order.//---></p>
</cfform>
<p><a href="index.cfm" target="_top">Continue Shopping</a></p>

<cfinclude template="checkOutPageFoot.cfm">