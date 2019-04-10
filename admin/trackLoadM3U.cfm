<cfparam name="form.submitm3u" default="">
<cfparam name="form.junosubmit" default="">
<cfparam name="form.ID" default="">
<cfparam name="form.getjunoprefix" default="">
<cfparam name="form.j0101" default="0">
<cfparam name="form.j0102" default="0">
<cfparam name="form.j0103" default="0">
<cfparam name="form.j0104" default="0">
<cfparam name="form.j0105" default="0">
<cfparam name="form.j0106" default="0">
<cfparam name="form.j0201" default="0">
<cfparam name="form.j0202" default="0">
<cfparam name="form.j0203" default="0">
<cfparam name="form.j0204" default="0">
<cfparam name="form.j0205" default="0">
<cfparam name="form.j0206" default="0">
<cfset formm3u="remotename"&linefeed&form.submitm3u>
<cfif form.junosubmit NEQ "">
	<cfset junolist="remotename"&linefeed>
    <cfset thisjunoprefix=Trim(Replace(getjunoprefix,"01-01-01.mp3","","all"))>
	<cfloop from="1" to="2" index="disc">
    	<cfloop from="1" to="6" index="side">
        	<cfset trackMax=Evaluate("form.j"&NumberFormat(disc,"00")&NumberFormat(side,"00"))>
            <cfif trackMax NEQ "" AND trackMax NEQ 0>
            <cfloop from="1" to="#trackMax#" index="track">
            	<cfset junolist=junolist&thisjunoprefix&NumberFormat(disc,"00")&"-"&NumberFormat(side,"00")&"-"&NumberFormat(track,"00")&".mp3"&linefeed>
            </cfloop>
            </cfif>
        </cfloop>
    </cfloop>	
    <cffile action="write" 
            file="#serverPath#\loadm3u.txt"
        output="#junolist#">
        <cfoutput>#junolist#</cfoutput>
<cfelseif form.submitm3u NEQ "">
	<cfset formm3u="remotename"&linefeed&form.submitm3u>
    <cffile action="write" 
            file="#serverPath#\loadm3u.txt"
        output="#formm3u#">
<cfelseif form.getm3u NEQ "">
	<cfhttp method="Get"
    	url="#Trim(form.getm3u)#">
    <cfset loadgetm3u="remotename"&linefeed&cfhttp.FileContent>
    <cffile action="write"
    	file="#serverPath#\loadm3u.txt"
        output="#loadgetm3u#">  
</cfif>
<cfhttp method="Get"
    url="#webPath#/loadm3u.txt"
    name="loadm3u"
    delimiter="|"
    textqualifier="" columns="remotename">
<!---<cfoutput query="loadm3u">
#remotename#<br>
</cfoutput><cfabort>//--->
<cfif loadm3u.RecordCount GT 0>
	<cfloop query="loadm3u">
		<cfif remotename NEQ "" AND remotename NEQ "remotename">
            <cfquery name="tracks" datasource="#DSN#" maxrows="1">
                select *
                from catTracks
                where catID=#form.ID# AND mp3Loaded<>1
                order by tSort
            </cfquery>
            <cfif tracks.recordcount EQ 1>
				<cfoutput>LOADING: #remotename#<br></cfoutput>
                <cfhttp 
                    method="Get" 
                    url="#Trim(remotename)#" 
                    path="c:\Inetpub\wwwroot\downtown304\media" 
						file="oT#tracks.ID#.mp3"> 
                <!---cfif cfhttp.MIMEType EQ "audio/mpeg">//--->
                    <cfquery name="updateTrack" datasource="#DSN#">
                        update catTracks
                        set mp3Loaded=1, mp3Alt=0
                        where ID=#tracks.ID#
                    </cfquery>
                    <cfquery name="updateItem" datasource="#DSN#">
                        update catItems
                        set mp3Loaded=1
                        where ID=#form.ID#
                    </cfquery>
               <!---<cfelse>
                    <cfoutput>#cfhttp.MIMEType#</cfoutput><cfabort>
                </cfif>//--->
        	</cfif>
        </cfif>
	</cfloop>
</cfif>
<cfquery name="tracks" datasource="#DSN#">
        select *
        from catTracks
        where catID=#form.ID# AND mp3Loaded<>1
        order by tSort
    </cfquery>
<cfif tracks.recordcount EQ 0>
	<cflocation url="artLoad.cfm?ID=#form.ID#">
<cfelse>
	<cflocation url="trackLoad.cfm?ID=#form.ID#">
</cfif>