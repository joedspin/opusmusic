<html>
<head>
<style>
td {vertical-align:top;
	font-family:Arial, Helvetica, sans-serif;
	font-size: xx-small;}
body {font-family: Arial, Helvetica, sans-serif;
	font-size: xx-small;
	background-color:#FFFFFF;
	color: #000000;}
</style>
</head>
<body>
<cfset siteChoice="161">
<cfset sitePage="dt161main.cfm">
<cfset trackChoice="dt161tracks">
<!---<cfinclude template="topNav.cfm">//--->
<cfquery name="dt161news" dbtype="query">
	select *
    from Application.dt161Items
    where albumStatusID<=21 AND albumStatusID<>19
    order by dtDateUpdated DESC, label ASC, catnum ASC
</cfquery>
<cfquery name="dt161featured" dbtype="query">
	select *
    from Application.dt161Items
    where albumStatusID=19
    order by dtDateUpdated DESC, label, catnum ASC
</cfquery>
<cfquery name="dt161exclusives" dbtype="query">
	select *
    from Application.dt161Items
    where albumStatusID=18
    order by dtDateUpdated DESC, label, catnum ASC
</cfquery>
<p>&nbsp;</p>
<cfset lastDateUpdated="">
<cfset showedHighlights=false>
<cfset showedDateLine=false>
<table border="1" bordercolor="#CCCCCC" cellpadding="0" width="90%" cellspacing="0" style="border-collapse:collapse;" align="center">
	<!---<tr>
		<td colspan="6"><span style="font-size: medium;"><b>NEW RELEASE SUMMARY</b></span></td>
    </tr>//--->
    <tr>
        <td align="center"><b>Catalog#</b></td>
        <td align="center"><b>Label</b></td>
        <td align="center"><b>Artist</b></td>
        <td align="center"><b>Title</b></td>
        <td align="center"><b>Config</b></td>
        <td align="center"><b>Price</b></td>
    </tr>
	<cfif dt161exclusives.recordCount GT 0>
    	<tr bgcolor="#FFFF00">
        	<td colspan="6"><b><font size="2">EXCLUSIVE NEW RELEASES</font></b></td>
        </tr>
    <cfoutput query="dt161exclusives">
        <cfset lastDateUpdated=DateFormat(dtDateUpdated,"dddd - mmmm d, yyyy")>
        <tr>
            <td><a href="dt161main.cfm?sID=#ID#">#Ucase(catnum)#</a></td>
            <td><cfif reissue OR genreID EQ 7>*</cfif>#Left(Ucase(label),20)#</td>
            <td>#UCase(artist)#</td>
            <td>#UCase(title)#</td>
            <td><cfif NRECSINSET GT 1>#NRECSINSET#x</cfif>#media#</td>
            <td align="right">#DollarFormat(buy)#</td>
        </tr>
    </cfoutput>
    </cfif>
    <cfif dt161featured.recordCount GT 0>
     <tr bgcolor="#FFFF00">
        	<td colspan="6"><b><font size="2">FEATURED RESTOCKS</font></b></td>
        </tr>
    <cfoutput query="dt161featured">
        <cfset lastDateUpdated=DateFormat(dtDateUpdated,"dddd - mmmm d, yyyy")>
        <tr>
            <td><a href="dt161main.cfm?sID=#ID#">#Ucase(catnum)#</a></td>
            <td><cfif reissue OR genreID EQ 7>*</cfif>#Left(Ucase(label),20)#</td>
            <td>#Left(Ucase(artist),27)#</td>
            <td>#Left(Ucase(title),29)#</td>
            <td><cfif NRECSINSET GT 1>#NRECSINSET#x</cfif>#media#</td>
            <td align="right">#DollarFormat(buy)#</td>
        </tr>
    </cfoutput>
    </cfif>
    <cfset starthere=true>
	<cfoutput query="dt161news">
    	<cfset thisDate=DateFormat(dtDateUpdated,"dddd - mmmm d, yyyy")>
    	<cfif lastDateUpdated NEQ thisDate OR starthere>
			<cfif DateFormat(dtDateUpdated,"dddd") EQ "Friday" OR NOT showedDateLine>
            <tr bgcolor="##99CCFF">
                <td colspan="6"><b><font size="2">NEW RELEASES - Week ending #thisDate#</font></b></td>
            </tr>        
	        <cfset showedDateLine=true>
            </cfif>
        </cfif>
        <cfset lastDateUpdated=DateFormat(dtDateUpdated,"dddd - mmmm d, yyyy")>
        <tr>
            <td><a href="dt161main.cfm?sID=#ID#">#Ucase(catnum)#</a></td>
            <td><cfif reissue OR genreID EQ 7>*</cfif>#Left(Ucase(label),20)#</td>
            <td>#Left(Ucase(artist),27)#</td>
            <td>#Left(Ucase(title),29)#</td>
            <td><cfif NRECSINSET GT 1>#NRECSINSET#x</cfif>#media#</td>
            <td align="right">#DollarFormat(buy)#</td>
        </tr>
        <cfset starthere=false>
        <cfset showedDateLine=true>
    </cfoutput>
</table>




<!--- 
<cfoutput query="dt161news">
    	<cfif lastDateUpdated NEQ DateFormat(dtDateUpdated,"dddd - mmmm d, yyyy")>
        <cfif DateFormat(dtDateUpdated,"mm/dd/yy") GT DateFormat(varDateODBC,"mm/dd/yy")>
        <tr bgcolor="##FFFF00">
        	<td colspan="6"><b><font size="2">THIS WEEK&rsquo;S EXCLUSIVES</font></b></td>
        </tr>
        <cfelse>
        <cfif NOT showedHighlights AND dt161highlights.recordCount GT 0><!---<cfif (DateFormat(dtDateUpdated,"dddd") EQ "Sunday" OR DateFormat(dtDateUpdated,"dddd") EQ "Saturday" OR DateFormat(dtDateUpdated,"dddd") EQ "Friday") AND NOT showedHighlights AND dt161highlights.recordCount GT 0>//--->
        <tr bgcolor="##FFFF00">
        	<td colspan="6"><b><font size="2">FEATURED</font></b></td>
        </tr>
        	<cfloop query="dt161highlights">
                <tr>
                    <td><a href="dt161main.cfm?sID=#ID#">#Ucase(dt161highlights.catnum)#</a></td>
                    <td><cfif reissue OR genreID EQ 7>*</cfif>#Left(Ucase(dt161highlights.label),20)#</td>
                    <td>#Left(Ucase(dt161highlights.artist),27)#</td>
                    <td>#Left(Ucase(dt161highlights.title),29)#</td>
                    <td><cfif dt161highlights.NRECSINSET GT 1>#dt161highlights.NRECSINSET#x</cfif>#dt161highlights.media#</td>
                    <td align="right">#DollarFormat(dt161highlights.buy)#</td>
                </tr>
            </cfloop>
            <cfset showedHighlights=true>
        </cfif>
        <tr bgcolor="##99CCFF">
        	<cfset thisDate=DateFormat(dtDateUpdated,"dddd - mmmm d, yyyy")>
        	<td colspan="6"><b><font size="2"><cfif FindNoCase(thisDate,'Saturday') EQ 1 OR FindNoCase(thisDate,'Sunday') EQ 1>LAST WEEK'S FEATURED<cfelse>#thisDate#</cfif></font></b></td>
        </tr>
        </cfif>
        </cfif>
        <cfset lastDateUpdated=DateFormat(dtDateUpdated,"dddd - mmmm d, yyyy")>
        <tr>
            <td><a href="dt161main.cfm?sID=#ID#">#Ucase(catnum)#</a></td>
            <td><cfif reissue OR genreID EQ 7>*</cfif>#Left(Ucase(label),20)#</td>
            <td>#Left(Ucase(artist),27)#</td>
            <td>#Left(Ucase(title),29)#</td>
            <td><cfif NRECSINSET GT 1>#NRECSINSET#x</cfif>#media#</td>
            <td align="right">#DollarFormat(buy)#</td>
        </tr>
    </cfoutput>
//--->
</body>
</html>