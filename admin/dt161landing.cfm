<style>
td {vertical-align:top;
	font-family:Arial, Helvetica, sans-serif;
	font-size: xx-small;}
body {font-family: Arial, Helvetica, sans-serif;
	font-size: xx-small;}
</style>
<cfquery name="dt161news" dbtype="query">
	select *
    from dt161Items
    where albumStatusID=21
    order by dtDateUpdated DESC, catnum ASC
</cfquery>
<p><b><ul>NEW RELEASE</ul></b></p>
<table border="1" bordercolor="#CCCCCC" cellpadding="0" cellspacing="0" style="border-collapse:collapse;">
    <tr>
        <td align="center"><b>Catalog#</b></td>
        <td align="center"><b>Label</b></td>
        <td align="center"><b>Artist</b></td>
        <td align="center"><b>Title</b></td>
        <td align="center"><b>Config</b></td>
        <td align="center"><b>Price</b></td>
    </tr>
	<cfoutput query="dt161news">
        <tr>
            <td><a href="dt161main.cfm?sID=#ID#">#Ucase(catnum)#</a></td>
            <td>#Left(Ucase(label),20)#</td>
            <td>#Left(Ucase(artist),27)#</td>
            <td>#Left(Ucase(title),29)#</td>
            <td><cfif NRECSINSET GT 1>#NRECSINSET#x</cfif>#media#</td>
            <td>#NumberFormat(price,"0.00")#</td>
        </tr>
    </cfoutput>
</table>