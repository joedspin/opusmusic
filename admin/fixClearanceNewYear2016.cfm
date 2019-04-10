<style>
td {font-family:Gotham, "Helvetica Neue", Helvetica, Arial, sans-serif; font-size:x-small;}
</style><!---
<cfquery name="clearSpecial" datasource="#DSN#">
	update catItems
    set blueDate='2016-01-01' where albumStatusID<25 AND ONHAND>0
</cfquery>//--->
<p>2015 (25% Off)</p>
<cfquery name="nyclearreport" datasource="#DSN#">
	select *
    from catItemsQuery
    where albumStatusID<25 AND ONHAND>1 and shelfID<>11 and blue99=0 AND shelfID NOT IN (select ID from shelf where code IN('GG','GT','WS','AU','BF','CT','ND','RS','SK','RM','SN','DS','SY','WT')) AND albumStatusID NOT IN (21,23) AND price>3.98 AND ONHAND>2 AND realReleaseDate<'2015-11-01' AND realReleaseDate>='2015-01-01'
    order by ONHAND DESC, realReleaseDate DESC
</cfquery>
<cfquery name="nyclear" datasource="#DSN#">
	update catItems
    set priceSave=price, blueDate=<cfqueryparam value="2015-01-01" cfsqltype="cf_sql_date">, price=(price*.75)
    where albumStatusID<25 AND ONHAND>1 and shelfID<>11 and blue99=0 AND shelfID NOT IN (select ID from shelf where code IN('GG','GT','WS','AU','BF','CT','ND','RS','SK','RM','SN','DS','SY','WT')) AND albumStatusID NOT IN (21,23) AND price>3.98 AND ONHAND>2 AND realReleaseDate<'2015-11-01' AND realReleaseDate>='2015-01-01' AND priceSave=0
</cfquery>
<table border="1" cellpadding="3" cellspacing="0" style="border-collapse:collapse;">
<cfoutput query="nyclearreport">
<tr>
	<td>#ONHAND#</td>
    <td>#DateFormat(realReleaseDate,"yyyy-mm-dd")#</td>
	<td>#catnum#</td>
	<td>#label#</td>
	<td>#artist#</td>
	<td>#title#</td>
	<td><cfif NRECSINSET GT 1>#NRECSINSET#x</cfif>#media#</td> 
	<td>#DollarFormat(price)#</td>
    <td>#DollarFormat(price*.75)#</td>
</tr>
</cfoutput>
</table>
<p>2014 (40% Off)</p>
<cfquery name="nyclearreport" datasource="#DSN#">
	select *
    from catItemsQuery
    where albumStatusID<25 AND ONHAND>1 and shelfID<>11 and blue99=0 AND shelfID NOT IN (select ID from shelf where code IN('GG','GT','WS','AU','BF','CT','ND','RS','SK','RM','SN','DS','SY','WT')) AND albumStatusID NOT IN (21,23) AND price>3.98 AND
    	realReleaseDate>='2014-01-01' AND realReleaseDate<='2014-12-31'
    order by ONHAND DESC, realReleaseDate DESC
</cfquery>
<cfquery name="nyclear" datasource="#DSN#">
	update catItems
    set priceSave=price, blueDate='2014-01-01', price=price*.60
    where albumStatusID<25 AND ONHAND>1 and shelfID<>11 and blue99=0 AND shelfID NOT IN (select ID from shelf where code IN('GG','GT','WS','AU','BF','CT','ND','RS','SK','RM','SN','DS','SY','WT')) AND albumStatusID NOT IN (21,23) AND price>3.98 AND
    	realReleaseDate>='2014-01-01' AND realReleaseDate<='2014-12-31' AND priceSave=0
</cfquery>
<table border="1" cellpadding="3" cellspacing="0" style="border-collapse:collapse;">
<cfoutput query="nyclearreport">
<tr>
	<td>#ONHAND#</td>
    <td>#DateFormat(realReleaseDate,"yyyy-mm-dd")#</td>
	<td>#catnum#</td>
	<td>#label#</td>
	<td>#artist#</td>
	<td>#title#</td>
	<td><cfif NRECSINSET GT 1>#NRECSINSET#x</cfif>#media#</td> 
	<td>#DollarFormat(price)#</td>
    <td>#DollarFormat(price*.60)#</td>
</tr>
</cfoutput>
</table>
<p>2013 (50% Off)</p>
<cfquery name="nyclearreport" datasource="#DSN#">
	select *
    from catItemsQuery
    where albumStatusID<25 AND ONHAND>1 and shelfID<>11 and blue99=0 AND shelfID NOT IN (select ID from shelf where code IN('GG','GT','WS','AU','BF','CT','ND','RS','SK','RM','SN','DS','SY','WT')) AND albumStatusID NOT IN (21,23) AND price>3.98 AND
    	realReleaseDate>='2013-01-01' AND realReleaseDate<='2013-12-31'
    order by ONHAND DESC, realReleaseDate DESC
</cfquery>
<cfquery name="nyclear" datasource="#DSN#">
	update catItems
    set priceSave=price, blueDate='2013-01-01', price=price*.50
    where albumStatusID<25 AND ONHAND>1 and shelfID<>11 and blue99=0 AND shelfID NOT IN (select ID from shelf where code IN('GG','GT','WS','AU','BF','CT','ND','RS','SK','RM','SN','DS','SY','WT')) AND albumStatusID NOT IN (21,23) AND price>3.98 AND realReleaseDate>='2013-01-01' AND realReleaseDate<='2013-12-31' AND priceSave=0
</cfquery>
<table border="1" cellpadding="3" cellspacing="0" style="border-collapse:collapse;">
<cfoutput query="nyclearreport">
<tr>
	<td>#ONHAND#</td>
    <td>#DateFormat(realReleaseDate,"yyyy-mm-dd")#</td>
	<td>#catnum#</td>
	<td>#label#</td>
	<td>#artist#</td>
	<td>#title#</td>
	<td><cfif NRECSINSET GT 1>#NRECSINSET#x</cfif>#media#</td> 
	<td>#DollarFormat(price)#</td>
    <td>#DollarFormat(price*.5)#</td>
</tr>
</cfoutput>
</table>
<p>2012 (60% Off)</p>
<cfquery name="nyclearreport" datasource="#DSN#">
	select *
    from catItemsQuery
    where albumStatusID<25 AND ONHAND>1 and shelfID<>11 and blue99=0 AND shelfID NOT IN (select ID from shelf where code IN('GG','GT','WS','AU','BF','CT','ND','RS','SK','RM','SN','DS','SY','WT')) AND albumStatusID NOT IN (21,23) AND price>3.98 AND
    	realReleaseDate<='2014-01-01'
    order by ONHAND DESC, realReleaseDate DESC
</cfquery>
<cfquery name="nyclear" datasource="#DSN#">
	update catItems
    set priceSave=price, blueDate='2012-01-01', price=price*.4
    where albumStatusID<25 AND ONHAND>1 and shelfID<>11 and blue99=0 AND shelfID NOT IN (select ID from shelf where code IN('GG','GT','WS','AU','BF','CT','ND','RS','SK','RM','SN','DS','SY','WT')) AND albumStatusID NOT IN (21,23) AND price>3.98 AND realReleaseDate>='2012-01-01' AND realReleaseDate<='2012-12-31' AND priceSave=0
</cfquery>
<table border="1" cellpadding="3" cellspacing="0" style="border-collapse:collapse;">
<cfoutput query="nyclearreport">
<tr>
	<td>#ONHAND#</td>
    <td>#DateFormat(realReleaseDate,"yyyy-mm-dd")#</td>
	<td>#catnum#</td>
	<td>#label#</td>
	<td>#artist#</td>
	<td>#title#</td>
	<td><cfif NRECSINSET GT 1>#NRECSINSET#x</cfif>#media#</td> 
	<td>#DollarFormat(price)#</td>
    <td>#DollarFormat(price*.25)#</td>
</tr>
</cfoutput>
</table>
<p>2011 and before (75% Off)</p>
<cfquery name="nyclearreport" datasource="#DSN#">
	select *
    from catItemsQuery
    where albumStatusID<25 AND ONHAND>1 and shelfID<>11 and blue99=0 AND shelfID NOT IN (select ID from shelf where code IN('GG','GT','WS','AU','BF','CT','ND','RS','SK','RM','SN','DS','SY','WT')) AND albumStatusID NOT IN (21,23) AND price>3.98 AND
    	realReleaseDate<='2012-01-01'
    order by ONHAND DESC, realReleaseDate DESC
</cfquery>
<cfquery name="nyclear" datasource="#DSN#">
	update catItems
    set priceSave=price, blueDate='2011-01-01', price=price*.25
    where albumStatusID<25 AND ONHAND>1 and shelfID<>11 and blue99=0 AND shelfID NOT IN (select ID from shelf where code IN('GG','GT','WS','AU','BF','CT','ND','RS','SK','RM','SN','DS','SY','WT')) AND albumStatusID NOT IN (21,23) AND price>3.98 AND realReleaseDate<='2011-12-31' AND priceSave=0
</cfquery>
<table border="1" cellpadding="3" cellspacing="0" style="border-collapse:collapse;">
<cfoutput query="nyclearreport">
<tr>
	<td>#ONHAND#</td>
    <td>#DateFormat(realReleaseDate,"yyyy-mm-dd")#</td>
	<td>#catnum#</td>
	<td>#label#</td>
	<td>#artist#</td>
	<td>#title#</td>
	<td><cfif NRECSINSET GT 1>#NRECSINSET#x</cfif>#media#</td> 
	<td>#DollarFormat(price)#</td>
    <td>#DollarFormat(price*.25)#</td>
</tr>
</cfoutput>
</table>


