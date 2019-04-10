<cfsetting requesttimeout="90000">
<cfquery name="getAllWaveTracks" datasource="#DSN#">
	select *
    from catTracksQuery
    where labelID IN (6581,2303,1695,1969,3257) AND catnum>'WT50165'
    order by catnum, tSort 
</cfquery>
<cfoutput query="getAllWaveTracks">
#catnum#_#tSort# 
<cfdirectory name="checkTrack" directory="c:\Inetpub\wwwroot\downtown304\media\" filter="oT#itemID#.mp3" action="list">
	<cfif checkTrack.recordCount GT 0>
<cffile action="copy"
	source="c:\Inetpub\wwwroot\downtown304\media\oT#itemID#.mp3" destination="c:\Inetpub\wwwroot\downtown304\wave\#catnum#_#tsort#.mp3" nameconflict="overwrite"><font color="red">DONE</font>
    <cfelse>
    NOT FOUND
    </cfif>
    <br>
</cfoutput>
