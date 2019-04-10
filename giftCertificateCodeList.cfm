<cfquery name="gc" datasource="#DSN#">
	select *
    from giftCertificates
</cfquery>
<p><cfoutput query="gc">#gcCode#,</cfoutput></p>
<p><cfoutput query="gc">#gcCode#<br /></cfoutput></p>