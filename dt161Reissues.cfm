<style>
td {vertical-align:top;
	font-family:Arial, Helvetica, sans-serif;
	font-size: xx-small;}
body {font-family: Arial, Helvetica, sans-serif;
	font-size: xx-small;}
</style>
<cfset siteChoice="161">
<cfset sitePage="dt161main.cfm">
<cfset trackChoice="dt161tracks">
<!---<cfinclude template="topNav.cfm">//--->
<cfquery name="dt161news" dbtype="query">
	select *
    from Application.dt161Items
    where reissue=1 OR genreID=7
    order by label, artist, title
</cfquery>
<p>&nbsp;</p>
<cfset lastLabel="">
<table border="1" bordercolor="#CCCCCC" cellpadding="0" width="90%" cellspacing="0" style="border-collapse:collapse;" align="center">
	<tr>
		<td colspan="6"><span style="font-size: medium;"><b>REISSUES</b></span></td>
    </tr>
    <tr>
        <td align="center"><b>Catalog#</b></td>
        <td align="center"><b>Label</b></td>
        <td align="center"><b>Artist</b></td>
        <td align="center"><b>Title</b></td>
        <td align="center"><b>Config</b></td>
        <td align="center"><b>Price</b></td>
    </tr>
	<cfoutput query="dt161news">
    	<cfif lastLabel NEQ label>
        <tr bgcolor="##99CCFF">
        	<td colspan="6">*#label#</td>
        </tr>
        </cfif>
        <cfset lastLabel=label>
        <tr>
            <td><a href="dt161main.cfm?sID=#ID#">#Ucase(catnum)#</a></td>
            <td>*#Left(Ucase(label),20)#</td>
            <td>#Left(Ucase(artist),27)#</td>
            <td>#Left(Ucase(title),29)#</td>
            <td><cfif NRECSINSET GT 1>#NRECSINSET#x</cfif>#media#</td>
            <td align="right">#DollarFormat(buy)#</td>
        </tr>
    </cfoutput>
</table>