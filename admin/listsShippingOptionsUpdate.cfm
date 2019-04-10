<cfquery name="newPostalNames" datasource="#DSN#">
 update shippingRates
 set name='Priority Mail International '
 where name='Parcel Post'
</cfquery>
<cfquery name="newPostalNames" datasource="#DSN#">
 update shippingRates
 set name='First Class Mail International'
 where name='Air Mail'
</cfquery>