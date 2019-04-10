<cfloop from="7100" to="7199" index="x">
<cfset checkSum=right((x/3)+24,1)>
<cfset gcinsert=x&"C"&checkSum>
<cfquery name="gcCreate" datasource="#DSN#">
	update giftCertificates
    set gcCode='#gcinsert#'
    where ID=#x#
</cfquery>
</cfloop>