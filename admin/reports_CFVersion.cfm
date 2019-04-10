<!--- Dump out the server scope. --->
<cfdump var="#SERVER#" />

<!--- Store the ColdFusion version. --->
<cfset strVersion = SERVER.ColdFusion.ProductVersion />

<!--- Store the ColdFusion level. --->
<cfset strLevel = SERVER.ColdFusion.ProductLevel />

<cfoutput>#strVersion#<br>
	#strLevel#</cfoutput>