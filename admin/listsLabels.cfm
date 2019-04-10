<cfset pageName="LISTS">
<cfparam name="url.letter" default="a">
<cfparam name="form.find" default="">
<cfparam name="url.find" default="">
<cfinclude template="pageHead.cfm">
<form name="labelFind" action="listsLabels.cfm" method="post">
<input type="text" name="find" /><input type="submit" name="submit" value="Find" />
</form>
<cfif form.find NEQ "" OR url.find NEQ "">
	<cfquery name="allLabels" datasource="#DSN#">
		select *
		from labels
		where name LIKE '%#form.find##url.find#%' order by sort
	</cfquery>
<cfelseif url.letter EQ "nosort">
	<cfquery name="allLabels" datasource="#DSN#">
		select *
		from labels
		where sort='' or sort is Null
	</cfquery>
<cfelse>
	<cfquery name="allLabels" datasource="#DSN#">
		select *
		from labels
		where ((sort='' OR sort is Null) AND Left(name,1)='#url.letter#') OR Left(sort,1)='#url.letter#'
		order by sort
	</cfquery>
</cfif>
<cfquery name="letterList" datasource="#DSN#">
	select DISTINCT Left(sort,1) As labelLetter
	from labels ORDER BY Left(sort,1)
</cfquery>
<p><cfoutput query="letterList"><cfif labelLetter NEQ ""><a href="listsLabels.cfm?letter=#labelLetter#">#labelLetter#</a>
<cfelse><a href="listsLabels.cfm?letter=nosort">[no sort]</a></cfif> </cfoutput></p>
<p><a href="listsLabelsAdd.cfm">ADD NEW LABEL</a> | <a href="listsLabelsPrint.cfm" target="_blank">PRINT ALL IN-STOCK </a></p>
<table border="1" style="border-collapse:collapse;" cellpadding="2">
	<cfoutput query="allLabels">
	<cfset imagefile="labels/label_WhiteLabel.gif">
			<cfset imagefolder="">
			<cfif logofile NEQ "">
				<!---<cfdirectory directory="#serverPath#\images\labels" filter="#logofile#" name="logoCheck" action="list">//--->
				<cfif logofile NEQ "">
					<cfset imagefile="labels/" & logofile>
				</cfif>
			</cfif>
		<tr>
			<td><img src="../images/#imagefile#" width="25" height="25" border="0" /></td>
			<td><a href="listsLabelsEdit.cfm?ID=#ID#&letter=#url.letter#&find=#form.find#">EDIT</a></td>
			<td><a href="listsLabelsDelete.cfm?ID=#ID#&letter=#url.letter#&find=#form.find#">DELETE</a></td>
			<td><a href="listsLabelsRegular.cfm?ID=#ID#&letter=#url.letter#">MAKE REGULAR</a></td>
            <td><a href="reportsSalesByLabel.cfm?labelID=#ID#">SALES</a></td>
            <td><a href="reportsLabelZeroes.cfm?labelID=#ID#">ZEROES</a></td>
			<td>#name#</td>
		</tr>
	</cfoutput>
</table>
<cfinclude template="pageFoot.cfm">