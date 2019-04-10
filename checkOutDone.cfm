<cfinclude template="checkOutPageHead.cfm">
<cfparam name="url.paypal" default="no">
<p>&nbsp;</p>
  <h4>Your order is complete.</h4>
  <!---<cfif url.paypal EQ "yes">
    <p style="font-size: medium; color: #FF0000">You have selected <img src="https://www.paypal.com/en_US/i/logo/PayPal_mark_37x23.gif" alt="PayPal" border="0" align="baseline" style="margin-right:7px;" />as your payment method. We are experiencing technical difficulties with the integrate PayPal option.</p>
    <p style="font-size: medium; color: #FF0000">      Please send the total amount due from your <span style="color: #3399CC">PayPal</span> account to<span style="color: #3399CC"> info@downtown304.com</span></p>
    <p style="font-size: medium; color: #FFFFFF">You have not yet been charged and your order will not be processed until you send payment.</p>
    <p style="font-size: medium; color: #FFFFFF"> Thank you.</p>
  </cfif>//--->
<p>An email confirmation will arrive shortly</p>
  <p><a href="http://www.downtown304.com/index.cfm" target="_top">Return to the store.</a></p>

<cfinclude template="checkOutPageFoot.cfm">