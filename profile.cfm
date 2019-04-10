<cfinclude template="pageHead.cfm">
<style>
	body {background-color:#000000; font-family:Gotham, "Helvetica Neue", Helvetica, Arial, sans-serif; font-size: medium;}
	h1 {font-family:Gotham, "Helvetica Neue", Helvetica, Arial, sans-serif; font-size: large; color:CCCCCC; margin-top: 24px; margin-bottom: 18px;}
</style>
<blockquote>
	<h1 style=""><b>My Account</b> <br>
	Logged in as <cfoutput>#Session.username#</cfoutput></h1>
	<ul><li><a href="profilePassword.cfm">Change Password</a></li>
	<li><a href="profileEmail.cfm">Change Email Address</a></li>
	<li><a href="profileAddresses.cfm">Manage Address Book</a></li>
	<li><a href="profileCards.cfm">Manage Stored Credit Cards</a></li>
	<li><a href="profileOrders.cfm">View Order History and Status</a></li>
	<li><a href="profileBackorders.cfm">View and Manage Backorders</a></li>
	<li><a href="profileWishlist.cfm">View and Manage Wishlist</a></li>
	<li><a href="profileListeningBin.cfm">View and Manage Listening Bin</a></li>
	</ul>
	<blockquote>
	<p><a href="opusviewlists.cfm">Continue Shopping</a></p>
	</blockquote>
</blockquote>
<cfinclude template="pageFoot.cfm">