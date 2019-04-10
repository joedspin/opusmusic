<cfquery name="artistCharts" datasource="#DSN#" maxrows="18" cachedwithin="#CreateTimeSpan(0, 3, 0, 0)#">
	select artistID, artist, listName, ID
	from artistListsQuery
	where artistID<>15387 AND active=1
	order by listDate DESC
</cfquery>
<table width="320" border="0" cellspacing="0" cellpadding="0" align="center">
  <tr>
    <td><img src="images/boxHead_PlayLists.jpg" width="320" height="48" /></td>
  </tr>

  <tr>
    <td bgcolor="#333333">
    <table border=0 align="left" cellpadding=4 cellspacing=0>
	<tr>
  		<td><img src="images/spacer.gif" width="1" height="7" /></td>
  	</tr>
     <cfoutput query="artistCharts">
	 <tr>
       <td align="left"><a href="artistCharts.cfm?artistID=#artistID#&chartID=#ID#"><b>#artist#</b> &nbsp;&nbsp;#listName#</a></td>
     </tr>
	 </cfoutput>  
	 <tr>
	 	<td align="left"><a href="artistChartsList.cfm" style="color:#FFCC33;">See Complete List of Artist Play Lists &gt;&gt;</a></td>
	 </tr> 
</table>
       </td>
  </tr>
</table>
