<cfquery name="os999fix" datasource="#DSN#">
	update catItemsQuery
    set ONSIDE=999
    where (shelfID=11 Or shelfID=7) AND ONSIDE=0 and label LIKE '%IMPORT%'
</cfquery>
<cfquery name="os999" datasource="#DSN#">
	select *
    from catItemsQuery
    where Left(shelfCode,1)='D' AND ONSIDE=0 and label LIKE '%IMPORT%'
</cfquery>
<cfoutput query="os999">
#catnum# #shelfCode# #label# #artist#<br>
</cfoutput>