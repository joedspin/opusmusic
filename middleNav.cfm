<cfif Find("opus",sitePage) GT 0><cfset homelink="opusviewlists.cfm"><cfelse><cfset homelink="dt161landing.cfm"></cfif>
<cfoutput>
	<table style="border-collapse:collapse; margin-top: 20px;  margin-bottom:20px; width:100%;" border="0" cellpadding="0" cellspacing="0" align="left">
		<tr>
			<td style="width:55px;">&nbsp;</td>
			<td style="font-size:18px; vertical-align: top; line-height: 130%;"><a href="#sitePage#?group=new">NEW RELEASES</a><br>
				<a href="#sitePage#?group=back">BACK IN STOCK</a><br>
				<a href="opussitelayout07main.cfm?group=preview">FORTHCOMING</a><br>
				<a href="#sitePage#?group=sale">SALE</a>
			</td>
			<td style="width:80px;">&nbsp;</td>
			<td style="font-size:18px; vertical-align: top; line-height: 130%;"><a href="labelList.cfm">LABELS</a><br>
				<a href="artistList.cfm">ARTISTS</a><br>
				<a href="listsGenres.cfm">GENRES</a><br>
				<a href="opussitelayout07main.cfm?group=cds">CDs</a>
			</td>
			<td style="width:80px;">&nbsp;</td>
			<td style="font-size:18px; vertical-align: top; line-height: 130%;"><a href="opussitelayout07main.cfm?group=under7">UNDER $7</a><br>
				<a href="opussitelayout07main.cfm?group=under4">UNDER $4</a><br>
				<a href="opusviewcharts.cfm">CHARTS</a><br>
				<a href="#sitePage#?group=reissues">REISSUES
			</td>
			<td style="width:55px;">&nbsp;</td>
		</tr>
	</table>
</cfoutput>
		<cfif DateFormat(varDateODBC,"yyyy-mm-dd") LTE "2018-01-04" AND DateFormat(varDateODBC,"yyyy-mm-dd") GTE "2017-12-29">
	<table style="border-collapse:collapse; margin-top: 20px;  margin-bottom:20px; width:100%;" border="0" cellpadding="0" cellspacing="0" align="left">
		<tr>
			<td style="width:55px;">&nbsp;</td>
			<td style="vertical-align: top; line-height: 60%;" colspan="2">
				<p><font style="font-size:36px;">Warehouse Clearance Sale </font> <font style="font-size:18px;">EXTENDED thru Thursday!</font><p></td><td style="width:55px;">&nbsp;</td></tr>
		<tr>
			<td style="width:55px;">&nbsp;</td>
			<td style="font-size:16px; vertical-align: top; line-height: 130%;">
					<p><a href="opussitelayout07main.cfm?group=cyber1&so=ASC&ob=releaseDate">$1.99 BACK CATALOG 12&rdquo; &gt;&gt;</a><br>
	   <a href="opussitelayout07main.cfm?group=cyber2&so=ASC&ob=releaseDate">50% OFF SELECT IMPORT 12&rdquo; &amp; 10&rdquo; &gt;&gt;</a></p></td><td style="font-size:16px; vertical-align: top; line-height: 130%;"><p>
	   <a href="opussitelayout07main.cfm?group=cyber3&so=ASC&ob=releaseDate">50% OFF SELECT CDs AND 7&rdquo; &gt;&gt;</a><br>
	   <a href="opussitelayout07main.cfm?group=cyber4&so=ASC&ob=releaseDate">35% SELECT LPs &gt;&gt;</a><br>
	   <a href="opussitelayout07main.cfm?group=cyberall&so=ASC&ob=releaseDate">SHOP ALL DEALS &gt;&gt;</a><br>
			</p></td><td style="width:55px;">&nbsp;</td></tr>
	</table>	
</cfif>