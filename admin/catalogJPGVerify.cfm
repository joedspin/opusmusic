<cfsetting requesttimeout="60000">
<cfdirectory directory="#serverPath#\images\items" filter="oI*.jpg" name="imageCheck" action="list">
<cfloop query="imageCheck">
	<cfquery name="updateItem" datasource="#DSN#">
		update catItems
		set jpgLoaded=1
		where ID=#Replace(Replace(name,"oI","","all"),".jpg","","all")#
	</cfquery>
</cfloop>