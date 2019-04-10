<cfsetting requesttimeout="6000" enablecfoutputonly="no">
<cfquery name="allOpusItems" datasource="#DSN#">
	select *
	from catItemsQuery
</cfquery>
<cfquery name="zeroDT" datasource="#DSN#">
	update catItems
    set ONHAND=0
    where (shelfID=7 OR shelfID=9 OR shelfID=11) AND (albumStatusID=25 OR albumStatusID=44)
</cfquery>
<cfparam name="form.DTCatText" default="">
<cfparam name="form.uu" default="">
<cfparam name="form.pp" default="">
<cfparam name="form.loadType" default="UPDATE ONSIDE">
<cfparam name="form.loadDate" default="today">
<cfif form.uu NEQ "DT161" OR form.pp NEQ "ggHy77Tjx8H">ERROR - Access Denied</cfif>
<cfif form.DTCatText EQ "">
	ERROR
<cfelse>
	<cffile action="write" 
		file="#serverPath#\DTonside.txt"
	output="#form.DTCatText#">
</cfif>		<cfhttp method="Get"
		url="#webPath#/DTonside.txt"
		name="DTonside"
		delimiter="|"
		textqualifier="" columns="Album_Detail_ID,Catalog_Number,Quantity_Requested,Album_Status_ID,In_Stock_Num" >
	<cfif DTonside.RecordCount GT 0>
		<cfquery name="DTInvLoad" dbtype="query">
			select * from DTonside
		</cfquery>
	<cfquery name="clearONSIDE" datasource="#DSN#">
    	update catItems
        set ONSIDE=0
        where ONSIDE<>999
    </cfquery>
		<cfoutput query="DTInvLoad">
        	<cfset thisID=Album_Detail_ID>
            <cfset thisQty=Quantity_Requested>
            <cfset thisNum=In_Stock_Num>
            <cfset thisStat=Album_Status_ID>
            <cfif thisNum LT 0><cfset thisNum=0></cfif>
            #Catalog_Number# - #Album_Status_ID# [#In_Stock_Num#/#Quantity_Requested#]<br />
            <cfquery name="fixONSIDE" datasource="#DSN#">
            	update catItems
                set ONSIDE=<cfqueryparam value="#thisQty#" cfsqltype="cf_sql_integer">,
                	albumStatusID=<cfqueryparam value="#thisStat#" cfsqltype="cf_sql_integer">,
                    ONHAND=<cfqueryparam value="#thisNum#" cfsqltype="cf_sql_integer">
                 where dtID=<cfqueryparam value="#thisID#" cfsqltype="cf_sql_integer">
            </cfquery>
            
        </cfoutput>
		<cfset numRows=DTInvLoad.RecordCount>

		<cfquery name="logAction" datasource="#DSN#">
			insert into DTLoadHistory (dateLoaded,numRows,loadType,comment)
			values (
				<cfqueryparam value="#varDateODBC#" cfsqltype="cf_sql_date">,
				<cfqueryparam value="#numRows#" cfsqltype="cf_sql_char">,
				<cfqueryparam value="CATALOG" cfsqltype="cf_sql_char">,
				<cfqueryparam value="#form.loadType#" cfsqltype="cf_sql_longvarchar">)
		</cfquery>
	<cfelse>
		<p>No Items found.</p>
	</cfif>
<cfquery name="fixPre" datasource="#DSN#">
	update catItems
    set albumStatusID=24
    where ONSIDE>0 AND albumStatusID=148
</cfquery>
	
<cfoutput>

		<p>Downtown 304 - Update ONSIDE Invoice</p>
		<p><b>#DateFormat(varDateODBC,"mm/dd/yyyy")#<br />
		#numRows# Items Processed</b></p>
		<p>Done.</p>
	</cfoutput>
