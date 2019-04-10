<cfset pageName="LISTS">
<cfparam name="form.save" default="">
<cfparam name="form.featuredID1" default="0">
<cfparam name="form.featuredID2" default="0">
<cfparam name="form.featuredID3" default="0">
<cfparam name="form.featuredID4" default="0">
<cfparam name="form.featuredID5" default="0">
<cfparam name="form.featuredID6" default="0">
<cfinclude template="pageHead.cfm">

<cfif form.save NEQ "">
	<!---<cfquery name="clearFeature" datasource="#DSN#">
		update artists
		set featured=0
		where featured=1
	</cfquery>
	<cfquery name="setFeature" datasource="#DSN#">
		update artists
		set featured=1
		where ID=#form.featuredID#
	</cfquery>//--->
	<cfquery name="updateFeature" datasource="#DSN#">
		update labelsFeaturedList
		set labelList=<cfqueryparam value="#form.fLabelList#" cfsqltype="cf_sql_char">
		where ID=1
	</cfquery>
</cfif>
<cfquery name="getFeature" datasource="#DSN#">
	select *
	from labelsFeaturedList
	where ID=1
</cfquery>
<cfoutput query="getFeature">
<form name="fLabels" action="listsLabelsFeatured.cfm" method="post" >
	<input type="text" name="fLabelList" size="100" value="#labelList#" />	<input type="submit" value="Save" id="save" name="save" />
</form>
</cfoutput>
<cfinclude template="../boxFeaturedLabels.cfm">
<cfinclude template="pageFoot.cfm">