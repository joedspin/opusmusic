Test CF
<cfset x = GetHttpRequestData()>
<cfoutput>
<table cellpadding = "2" cellspacing = "2">
  <tr>
    <td><b>HTTP Request item</b></td>
    <td><b>Value</b></td> </tr>
<cfloop collection = #x.headers# item = "http_item">
    <tr>
      <td>#http_item#</td>
      <td>#StructFind(x.headers, http_item)#</td>   </tr>
</cfloop>
<tr>
   <td>request_method</td>
   <td>#x.method#</td></tr>
<tr>
   <td>server_protocol</td>
   <td>#x.protocol#</td></tr>
</table>
<b>http_content --- #x.content#</b>
</cfoutput>
<cfdump var="#x#">
<cfdump var="#CGI#">