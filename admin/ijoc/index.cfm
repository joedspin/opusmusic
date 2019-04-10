<cfparam name="url.ID" default="0">
<cfparam name="url.report" default="no">
<cfparam name="url.reportDate" default="#DateFormat(varDateODBC,"yyyy-mm-dd")#">
<cfparam name="url.newVolume" default="no">
<cfparam name="form.submit" default="">
<cfparam name="form.volumeNumber" default="0">
<cfparam name="form.articleNumber" default="1">
<cfparam name="form.sectionName" default="">
<cfparam name="form.articleDetails" default="">
<cfparam name="form.startPage" default="1">
<cfparam name="form.pageCount" default="1">
<cfparam name="form.datePosted" default="#DateFormat(varDateODBC,"yyyy-mm-dd")#">
<cfparam name="form.submit" default="">
<cfparam name="form.ID" default="#url.ID#">
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
<title>IJoC Articles | Folio Tracking</title>
<style>
body, td {font-family:Helvetica, Arial, sans-serif;
	font-size: 14px;}
td {padding: 7px;}
table {border:5px; border-collapse:collapse;}
</style>
</head>
<body>
<!---<cfif form.submit NEQ "Add"><body><!---onload="window.location.hash = '#edited';"//--->
<cfelse><body></cfif>--->
<cfif url.newVolume EQ "yes">
	<cfset nextPage=1>
    <cfset thisVolume=url.newVolNum>
    <cfset maxVolumeNumber=newVolNum>
<cfelse>
    <cfquery name="getMaxVol" datasource="#DSN#">
        select Max(volumeNumber) As maxVol
        from IJoCArticles
    </cfquery>
    <cfif isNumeric(getMaxVol.maxVol)>
        <cfset maxVolumeNumber=getMaxVol.maxVol>
    <cfelse>
        <cfset maxVolumeNumber=9>
    </cfif>
    <cfif form.volumeNumber NEQ 0 AND url.newVolume NEQ "yes">
        <cfset thisVolume=form.volumeNumber>
    <cfelse>
        <cfset thisVolume=maxVolumeNumber>
    </cfif>
    <cfquery name="maxPage" datasource="#DSN#">
        select Max(startPage) As maxStart
        from IJoCArticles
        where volumeNumber=<cfqueryparam value="#thisVolume#" cfsqltype="cf_sql_integer">
    </cfquery>
    <cfif IsNumeric(maxPage.maxStart)>
        <cfquery name="countMax" datasource="#DSN#">
            select pageCount, articleNumber
            from IJoCArticles
            where startPage=#maxPage.maxStart# AND volumeNumber=<cfqueryparam value="#thisVolume#" cfsqltype="cf_sql_integer">
        </cfquery>
        <cfset nextPage=maxPage.maxStart+countMax.pageCount>
    <cfelse>
        <cfset nextPage=1>
    </cfif>
</cfif>
<script language="javascript" type="text/javascript">
function clearBoxes () {
	document.iJoCArticles.articleNumber.value="";
	document.iJoCArticles.sectionName.value="";
	document.iJoCArticles.articleDetails.value="";
	<cfoutput>document.iJoCArticles.startPage.value="#nextPage#";
	document.iJoCArticles.pageCount.value="";
	document.iJoCArticles.datePosted.value="#DateFormat(varDateODBC,"mm/dd/yyyy")#";</cfoutput>
}
function copyText() {
	var copyText = document.getElementById("copyText");
	copyText.select();
	document.execCommand("copy");
	return false;
}
</script>
<cfset entryError=false>
<cfif form.submit EQ "Add">
    <cfif form.startPage NEQ nextPage>
    	<cfset entryError=true>
        <p style="font-size:20px; color:red;">ERROR: Start page number is invalid. Start with <cfoutput>#nextPage#.</cfoutput></p>
    <cfelse>
    	<cfquery name="addArticle" datasource="#DSN#">
        	insert into IJoCArticles (volumeNumber, articleNumber, sectionName, articleDetails, startPage, pageCount, datePosted)
            values (
            	<cfqueryparam cfsqltype="cf_sql_integer" value="#Trim(form.volumeNumber)#">,
                <cfqueryparam cfsqltype="cf_sql_integer" value="#Trim(form.articleNumber)#">,
                <cfqueryparam cfsqltype="cf_sql_char" value="#Trim(form.sectionName)#">,
                <cfqueryparam cfsqltype="cf_sql_varchar" value="#Trim(form.articleDetails)#">,
                <cfqueryparam cfsqltype="cf_sql_integer" value="#Trim(form.startPage)#">,
                <cfqueryparam cfsqltype="cf_sql_integer" value="#Trim(form.pageCount)#">,
                <cfqueryparam cfsqltype="cf_sql_date" value="#form.datePosted#">
            )
        </cfquery>
        <cflocation url="index.cfm">
    </cfif>
<cfelseif form.submit EQ "Save Changes">
	<cfquery name="editArticle" datasource="#DSN#">
    	update IJoCArticles
        set
        	volumeNumber=<cfqueryparam cfsqltype="cf_sql_integer" value="#Trim(form.volumeNumber)#">,
            articleNumber=<cfqueryparam cfsqltype="cf_sql_integer" value="#Trim(form.EarticleNumber)#">,
            sectionName=<cfqueryparam cfsqltype="cf_sql_char" value="#Trim(form.EsectionName)#">,
            articleDetails=<cfqueryparam cfsqltype="cf_sql_varchar" value="#Trim(form.EarticleDetails)#">,
            startPage=<cfqueryparam cfsqltype="cf_sql_integer" value="#Trim(form.EstartPage)#">,
            pageCount=<cfqueryparam cfsqltype="cf_sql_integer" value="#Trim(form.EpageCount)#">,
            datePosted=<cfqueryparam cfsqltype="cf_sql_date" value="#form.EdatePosted#">
        where ID=<cfqueryparam cfsqltype="cf_sql_integer" value="#Trim(form.ID)#">
    </cfquery>
</cfif>
<cfif url.report EQ "yes">
<cfquery name="IJoCArticles" datasource="#DSN#">
	 select *
     from IJoCArticles
     where volumeNumber=<cfqueryparam value="#thisVolume#" cfsqltype="cf_sql_char"> AND datePosted='#DateFormat(url.reportDate,"yyyy-mm-dd")#'
     order by startPage DESC
</cfquery>
<cfelse>
<cfquery name="IJoCArticles" datasource="#DSN#">
	 select *
     from IJoCArticles
     where volumeNumber=<cfqueryparam value="#thisVolume#" cfsqltype="cf_sql_char">
     order by startPage DESC
</cfquery>
</cfif>
<cfform id="iJoCArticles" name="iJoCArticles" method="post" action="index.cfm" enctype="multipart/form-data">
<cfif url.report NEQ "yes">
<cfselect name="volumeNumber" onChange="javascript:this.form.submit();">
	<cfset topVolume=maxVolumeNumber+1>
	<cfloop index="vn" from="9" to="#topVolume#">
    	<cfoutput><cfif vn EQ thisVolume><option value="#vn#" selected><cfelse><option value="#vn#"></cfif>Volume #vn#</option></cfoutput>
    </cfloop>
</cfselect>
<input type="button" name="clear" value="  CLEAR   " style="font-size: small;"  onclick="clearBoxes();" /><br />
<cfoutput><cfif url.report EQ "no"><a href="index.cfm?report=yes&reportDate=#DateFormat(varDateODBC,"yyyy-mm-dd")#">Filter Today</a><cfelse><a href="index.cfm">Remove Filter</a></cfif> <a href="index.cfm?newVolume=yes&newVolNum=#thisVolume+1#">New Volume</a></cfoutput>
</cfif>
<table border="1">
<cfif url.report EQ "no">
<cfif entryError>
<tr>
	<td valign="top"><cfif ID EQ form.articleNumber><a id="edited"></a></cfif><cfinput type="text" id="articleNumber" name="articleNumber" size="5" maxlength="5" required="yes" validate="integer" message="Article Number is required and must be an integer of 5 or fewer digits" value="#form.articleNumber#"></td>
    <td valign="top"><cfinput type="text" id="sectionName" name="sectionName" size="12" maxlength="30" required="yes" message="Section Name is required" value="#form.sectionName#"></td>
    <td valign="top"><cftextarea name="articleDetails" id="articleDetails" rows="7" cols="80" style="font-family: Helvetica, Arial, sans-serif; font-size:12px;"><cfoutput>#form.articleDetails#</cfoutput></cftextarea></td>
    <td valign="top"><cfinput type="text" id="startPage" name="startPage" size="4" maxlength="5" required="yes" validate="integer" message="Start Page is required and must be an integer of 5 or fewer digits" value="#form.startPage#"></td>
    <td valign="top"><cfinput type="text" id="pageCount" name="pageCount" size="4" maxlength="5" required="yes" validate="integer" message="Page Count is required and must be an integer of 5 or fewer digits" value="#form.pageCount#"></td>
    <td valign="top"><cfinput type="text" id="datePosted" name="datePosted" size="10" required="yes" validate="date" message="Date Posted is required and must be a valid date" value="#DateFormat(form.datePosted,"yyyy-mm-dd")#"></td>
    <td valign="top"><cfinput type="submit" name="submit" value="Add"></td>
</tr>
<cfelseif form.ID EQ 0 OR form.submit EQ "Save Changes">
<tr>
	<td valign="top"><cfinput type="text" id="articleNumber" name="articleNumber" size="5" maxlength="5" required="yes" validate="integer" message="Article Number is required and must be an integer of 5 or fewer digits"></td>
    <td valign="top"><cfinput type="text" id="sectionName" name="sectionName" size="12" maxlength="30" required="yes" message="Section Name is required"></td>
    <td valign="top"><cftextarea id="articleDetails" name="articleDetails" rows="7" cols="80"  style="font-family: Helvetica, Arial, sans-serif; font-size:12px;"></cftextarea></td>
    <td valign="top"><cfinput type="text" id="startPage" name="startPage" size="4" maxlength="5" required="yes" validate="integer" message="Start Page is required and must be an integer of 5 or fewer digits" value="#nextPage#"></td>
    <td valign="top"><cfinput type="text" id="pageCount" name="pageCount" size="4" maxlength="5" required="yes" validate="integer" message="Page Count is required and must be an integer of 5 or fewer digits"></td>
    <td valign="top"><cfinput type="text" id="datePosted" name="datePosted" size="10" required="yes" validate="date" message="Date Posted is required and must be a valid date" value="#DateFormat(varDateODBC,"yyyy-mm-dd")#"></td>
    <td valign="top"><cfinput type="submit" name="submit" value="Add"></td>
</tr>
</cfif>
</cfif>
<cfset needCopyButton=true>
<cfoutput query="IJoCArticles">
<cfif ID EQ form.ID AND form.submit NEQ "Save Changes">
<cfif entryError><tr style="background-color:hsla(359,51%,43%,1.00)"><cfelse><tr></cfif>
	<td valign="top"><cfif ID EQ form.articleNumber><a id="edited"></a></cfif><cfinput type="text" id="EarticleNumber" name="EarticleNumber" size="5" maxlength="5" required="yes" validate="integer" message="Article Number is required and must be an integer of 5 or fewer digits" value="#Trim(articleNumber)#"></td>
    <td valign="top"><cfinput type="text" id="EsectionName" name="EsectionName" size="12" maxlength="30" required="yes" message="Section Name is required" value="#Trim(sectionName)#"></td>
    <td valign="top"><cftextarea id="EarticleDetails" name="EarticleDetails" rows="4" cols="80"  style="font-family: Helvetica, Arial, sans-serif; font-size:12px;">#articleDetails#</cftextarea></td>
    <cfif entryError><tr style="background-color:hsla(359,97%,14%,1.00);"><cfelse><td valign="top"></cfif><cfinput type="text" id="EstartPage" name="EstartPage" size="4" maxlength="5" required="yes" validate="integer" message="Start Page is required and must be an integer of 5 or fewer digits" value="#startPage#"></td>
    <td valign="top"><cfinput type="text" id="EpageCount" name="EpageCount" size="4" maxlength="5" required="yes" validate="integer" message="Page Count is required and must be an integer of 5 or fewer digits" value="#pageCount#"></td>
    <td valign="top"><cfinput type="text" id="EdatePosted" name="EdatePosted" size="10" required="yes" validate="date" message="Date Posted is required and must be a valid date" value="#DateFormat(datePosted,"yyyy-mm-dd")#"></td>
    <cfif url.report EQ "no"><td valign="top"><!--NOTE: The "Start Page" and "Page Count" fields are disabled because the cross-check to validate page count on edited articles has not yet been written//--><cfinput type="submit" name="submit" value="Save Changes"><cfinput type="hidden" name="ID" id="ID" value="#form.ID#"></td></cfif>
</tr>
<cfelse>
<cfif articleNumber EQ form.articleNumber><tr style="background-color:hsla(359,51%,43%,1.00)"><cfelse><tr></cfif>
	<td valign="top" align="center"><cfif ID EQ form.articleNumber><a id="edited"></a></cfif><a id="an#articleNumber#"></a><cfif url.report EQ "no"><a href="index.cfm?ID=#ID#">#articleNumber#</a><cfelse>#articleNumber#</cfif></td>
    <td valign="top">#sectionName#</td>
    <td valign="top"><cfif needCopyButton><div id="copyText" onClick="copyText();"></cfif><font style="font-family: Helvetica, Arial, sans-serif; font-size:12px;">#Replace(articleDetails,chr(13)&chr(10),"<br>","all")#<cfif url.report EQ "no"><br>
    	http://IJoC.org/ojs/index.php/IJoC/about/submissions##copyrightNotice</cfif></font><cfif needCopyButton></div></cfif></td>
    <td valign="top">#startPage#&ndash;#startPage+pageCount-1#</td>
    <td valign="top" align="right">#pageCount#</td>
    <td valign="top">#DateFormat(datePosted,"mmm dd, yyyy")#</td>
    <cfif url.report EQ "no"><td valign="top">&nbsp;</td></cfif>
</tr>
<cfset needCopyButton=false>
</cfif>
</cfoutput>
</table>
</cfform>
</body>
</html>