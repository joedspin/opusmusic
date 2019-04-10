<cfquery name="ontheside" datasource="#DSN#">
	select *
	from catItemsQuery
	where shelfCode='OD' OR shelfCode='DO'
</cfquery>
<cfoutput query="ontheside">
	#catnum# #label# [#ONHAND# - #ONSIDE#] #artist# #title# #media#<br />
</cfoutput>