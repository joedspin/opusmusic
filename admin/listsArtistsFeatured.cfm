<cfset pageName="LISTS">
<cfparam name="form.save" default="">
<cfparam name="form.featuredID" default="0">
<cfinclude template="pageHead.cfm">

<cfif form.save NEQ "">
	<cfquery name="clearFeature" datasource="#DSN#">
		update artists
		set featured=0
		where featured=1
	</cfquery>
	<cfquery name="setFeature" datasource="#DSN#">
		update artists
		set featured=1
		where ID=#form.featuredID#
	</cfquery>
</cfif>
<cfquery name="allArtists" datasource="#DSN#">
	select *
	from artists
	order by sort
</cfquery>
<table border="0" cellpadding="10" cellspacing="0" align="center">
	<tr>
		<td align="center" valign="top">
			<cfform name="featured" method="post" action="listsArtistsFeatured.cfm">
				<select name="featuredID">
					<cfoutput query="allArtists">
						<cfif featured EQ 1>
							<option value="#ID#" selected="selected">#name#</option>
						<cfelse>
							<option value="#ID#">#name#</option>
						</cfif>
					</cfoutput>
				</select><br>
				<input type="submit" name="save" value="Set Featured Artist">
			</cfform>
		</td>
	</tr>
	<tr>
		<td align="center" valign="top">
			<cfinclude template="../boxFeaturedArtistQuery.cfm">
		</td>
	</tr>
</table>
<cfinclude template="pageFoot.cfm">