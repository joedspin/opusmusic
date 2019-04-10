<cfparam name="form.Specialtext" default="">
<cfif form.Specialtext EQ "">
	ERROR<cfabort>
<cfelse>
<cffile action="write" 
	file="#serverPath#/SpecialLoad.txt"
	output="#form.Specialtext#">
<cfhttp method="Get" 
	url="#webPath#/SpecialLoad.txt"
	name="SpecialLoad" 
	delimiter="|"
	textqualifier=""
	columns="specialCatnum,qtySold"></cfhttp>
    <table>
<cfloop query="SpecialLoad">
	<cfquery name="thisItem" dataSource="#DSN#">
    	select *
        from catItemsQuery
        where catnum='#specialCatnum#'
    </cfquery>
    <cfif thisItem.recordCount GT 1>
    <cfoutput query="thisItem">
        <tr>
        	<td>#SpecialLoad.qtySold#</td>
            <td>#catnum#</td>
            <td>#label#</td>
            <td>#artist#</td>
            <td>#title#</td>
            <td><cfif NRECSINSET GT 1>#NRECSINSET#x</cfif>#media#</td>
        </tr>
    </cfoutput>
    <cfelse>
    <cfoutput><tr>
    	<td>#SpecialLoad.qtySold#</td>
        <td>#SpecialLoad.specialCatnum#</td>
        <td>NOT FOUND</td>
        <td>NOT FOUND</td>
        <td>NOT FOUND</td>
        <td>&nbsp;</td>
    </tr>
    </cfoutput>
    </cfif>
</cfloop>
</table>
</cfif>