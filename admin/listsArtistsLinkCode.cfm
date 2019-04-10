<cfparam name="url.ID" default="0"><cfquery name="thisArtist" datasource="#DSN#">
	select *
    from artists
    where ID=#url.ID#
</cfquery><cfoutput query="thisartist"><pre>&lt;a href=&quot;http://www.downtown304.com/index.cfm?af=#url.ID#&quot;&gt;Click here for #name# releases on Downtown 304&lt;/a&gt;</pre></cfoutput>