<cfquery name="makehiphopandnotnew" datasource="#DSN#">
	update catItems
	set genreID=4, reissue=1
	where labelID IN (5707,2036,2413,4662,4663,4664,4665,4666,4667,4669,4676)
</cfquery>