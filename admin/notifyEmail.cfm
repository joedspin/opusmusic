<cfmail query="customer" to="#email#" from="info@downtown304.com" bcc="order@downtown304.com" subject="#thisNotice#" type="html">
    <p>#firstName#,</p>
    <p>This item is now in stock:</p>
    <cfquery name="notifyItem" datasource="#DSN#">
		select *
		from catItemsQuery
		where ID=#selectedID#
	</cfquery>
    <style>
	tr {font-family:Gotham, 'Helvetica Neue', Helvetica, Arial, sans-serif;}
	.artist {font-family:Gotham, 'Helvetica Neue', Helvetica, Arial, sans-serif; font-size: 14px; font-weight:bold; margin-top: 0px; margin-bottom: 0px;}
	.title {font-family:Gotham, 'Helvetica Neue', Helvetica, Arial, sans-serif; font-size: 14px; margin-top: 0px; margin-bottom: 6px;}
	.label {font-family:Gotham, 'Helvetica Neue', Helvetica, Arial, sans-serif; font-size: 12px; margin-top: 6px; margin-bottom: 12px;}
	.tracks {font-family:Gotham, 'Helvetica Neue', Helvetica, Arial, sans-serif; font-size: 10px; line-height:120%; margin-top: 0px; margin-bottom: 0px;}
	</style>
<cfloop query="notifyItem">
<table border="0" style="border-collapse:collapse;" cellpadding="5" cellspacing="0">
	<tr>
    	<td valign="top"><cfif fullImg NEQ ""><cfset imagefile="items/oI#ID#full.jpg"><cfset imagesize="150">
        <cfelseif jpgLoaded>
		<cfset imagefile="items/oI#ID#.jpg"><cfset imagesize="75">
	<cfelseif logofile NEQ "">
		<cfset imagefile="labels/"&logofile><cfset imagesize="75">
	<cfelse>
		<cfset imagefile="labels/label_WhiteLabel.gif"><cfset imagesize="75">
	</cfif><img src="http://www.downtown304.com/images/#imagefile#" alt="#artist# - #title#" width="#imagesize#"></td>
    <td valign="top">
    	<p style="font-family:Gotham, 'Helvetica Neue', Helvetica, Arial, sans-serif; font-size: 24px; font-weight:bold; margin-top: 0px; margin-bottom: 0px;">#artist#</p>
    	<p style="font-family:Gotham, 'Helvetica Neue', Helvetica, Arial, sans-serif; font-size: 24px; margin-top: 0px; margin-bottom: 6px;">#title# <cfif Remastered>[Remastered]</cfif> <cfif reissue>[Reissue]</cfif> <cfif warehouseFind>[Warehouse Find]</cfif> <cfif vinyl180g>[180g Vinyl]</cfif> <cfif Repress>[Re-press]</cfif> <cfif notched>[Notched]</cfif> <cfif limitedEdition>[Limited Edition]</cfif></p>
        <p style="font-family:Gotham, 'Helvetica Neue', Helvetica, Arial, sans-serif; font-size: 14px; margin-top: 6px; margin-bottom: 18px;"><b>Label:</b> #label#<br>
        	<b>Catalog ##:</b> #catnum#<br>
            <b>Media:</b> <cfif NRECSINSET GT 1>#NRECSINSET#x</cfif>#media#<br>
            <b>Style:</b> #genre#<br>
            <!---<b>Price:</b> #DollarFormat(price)#</p>//--->
            <cfset releaseID=ID>
	<cfquery name="tracks" datasource="#DSN#">
		select *
		from catTracks
		where catID=#notifyItem.ID#
		order by tSort
	</cfquery>
	<cfloop query="tracks">
    	<p style="font-family:Gotham, 'Helvetica Neue', Helvetica, Arial, sans-serif; font-size: 14px; line-height:120%; margin-top: 0px; margin-bottom: 0px;"><cfif tracks.mp3Loaded OR mp3Alt NEQ 0><!---<a href="http://www.downtown304.com/media/oT#tracks.ID#.mp3" title="Play">//---><a href="http://www.downtown304.com/index.cfm?sID=#releaseID#">LISTEN</a></cfif> #tName#</p>
	  </cfloop></td></tr>
</table>
<hr noshade>
</cfloop>
    <p>You can manage your backorders or view your email notification requests in the "My Account" section after you login on our website.</p>
    <p><a href="http://www.downtown304.com">Downtown304.com</a></p>
            </cfmail>