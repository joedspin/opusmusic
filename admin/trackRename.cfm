<cfdirectory directory="d:\media" filter="*.mp3" name="trackCheck" action="list">
<cfloop query="trackCheck">
	<cfset tPos=Find("t",name)>
	<cfset pPos=Find(".",name)>
	<cfset aCount=tPos-3>
	<cfset tCount=pPos-tPos-1>
	<cfset aID=Mid(name,3,aCount)>
	<cfset tID=Mid(name,tPos+1,tCount)>
	<cffile action="rename" source="d:\media\oA#aID#t#tID#.mp3" destination="d:\media\oT#tID#.mp3">
	<cfoutput>#name# | #aID# | #tID#<br></cfoutput>
</cfloop>