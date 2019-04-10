<cfparam name="url.aPg" default="">
<cfset linkpage="">
<cfif url.aPg EQ "AV8"><cfset linkpage="?lf=6631"></cfif>
<cflocation url="index.cfm#linkpage#">