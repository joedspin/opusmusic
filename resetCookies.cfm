<cfparam name="Cookie.cart" default="">
<cfparam name="Cookie.userID" default="">
<cfparam name="Cookie.orderID" default="">
<cfparam name="Cookie.username" default="">
<cfparam name="Session.orderID" default="">
<cfparam name="Session.userID" default="">
<cfparam name="Session.username" default="">
<cfparam name="Session.cart" default="">
<cfset Cookie.cart EQ "">
<cfset Cookie.userID EQ "0">
<cfset Cookie.orderID EQ "0">
<cfset Cookie.username EQ "">
<cfset Session.orderID="0">
<cfset Session.userID="0">
<h1>Downtown 304 site administration</h1>
<p>Your user cookies have been reset.</p>
<a href="http://www.downtown304.com">Click here to return to the site</a>