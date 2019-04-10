<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
<title>Downtown 304 site admin :: New Release Report</title>
<link rel="stylesheet" type="text/css" href="styles/opusadmin.css" />
</head>
<body>
<cfquery name="catalogFind" datasource="#DSN#">
	select *
	from catItemsQuery
	where active=1 AND ONHAND>0 AND (albumStatusID=21) AND (Left(shelfCode,1)='D' OR shelfCode<>'OD') AND reissue=no
	order by dtDateUpdated DESC, label ASC
</cfquery>
<table  bordercolor="#000000" border="1" cellpadding="2" cellspacing="0" style="border-collapse: collapse; border-color:#000000;">
	<cfoutput query="catalogFind">
		<cfset trackStatus="false">
		<cfset mp3Status="false">
		<cfset imageStatus="false">
		<cfset labelStatus="false">
		<cfquery name="tracks" datasource="#DSN#">
			select *
			from catTracks
			where catID=#catalogFind.ID#
		</cfquery>
		<cfif tracks.RecordCount NEQ 0>
			<cfset trackStatus="true">
			<cfdirectory directory="d:\media" filter="oT#tracks.ID#.mp3" name="trackCheck" action="list">
			<cfif trackCheck.recordCount NEQ 0>
				<cfset mp3Status="true">
			</cfif>
		</cfif>
		<cfdirectory directory="#serverPath#\images\items" filter="oI#catalogFind.ID#.jpg" name="imageCheck" action="list">
		<cfif imageCheck.recordCount NEQ 0>
			<cfset imageStatus="true">
		</cfif>
		<cfif logofile NEQ "">
			<cfdirectory directory="#serverPath#\images\labels" filter="#logofile#" name="logoCheck" action="list">
			<cfif logoCheck.recordCount NEQ 0>
				<cfset labelStatus="true">
			</cfif>
		</cfif>
		<tr>
			<td align="left" valign="top" class="detailsReport" ><b>#artist#</b>
				<br />#title#</td>
			<td align="left" valign="top" class="detailsReport"><b>#label#</b><br />
				Cat. No.: #catnum#</td>
			<td align="left" valign="top" class="detailsReport">Item No.: #ID##shelfCode#<br />
				<cfif NRECSINSET GT 1>#NRECSINSET# x </cfif>#media# / #DollarFormat(cost)#</td>
			<td align="left" valign="top" class="detailsReport" nowrap><font size="1"><input type='checkbox' name='tracks' value='yes' <cfif trackStatus>checked</cfif> /> Tracks<br>
				<input type='checkbox' name='mp3s' value='yes' <cfif mp3Status>checked</cfif> /> MP3s</font></td>
			<td align="left" valign="top" class="detailsReport" nowrap><font size="1"><input type='checkbox' name='itemimage' value='yes' <cfif imageStatus>checked</cfif> /> Item Image<br>
				<input type='checkbox' name='labelimage' value='yes' <cfif labelStatus>checked</cfif> /> Label Image</font></td>
	  </tr>
	</cfoutput>
</table>
</body>
</html>