<cfquery name="artistCharts" datasource="#DSN#">
	select artistID, artist, listName, ID
	from artistListsQuery
	where artistID<>15387 AND active=1
	order by listDate DESC
</cfquery>
<table border="0" cellpadding="0" cellspacing="0" >
<!-- fwtable fwsrc="opussitelayout07lists.png" fwbase="opussitelayout07lists.jpg" fwstyle="Dreamweaver" fwdocid = "685216091" fwnested="0" -->
  <tr>
   <td><img src="images/spacer.gif" width="13" height="1" border="0" alt="" /></td>
   <td><img src="images/spacer.gif" width="1" height="1" border="0" alt="" /></td>
   <td><img src="images/spacer.gif" width="12" height="1" border="0" alt="" /></td>
   <td><img src="images/spacer.gif" width="1" height="1" border="0" alt="" /></td>
  </tr>

  <tr>
   <td><img name="opussitelayout07lists_r1_c1" src="images/opussitelayout07lists_r1_c1.jpg" width="13" height="10" border="0" id="opussitelayout07lists_r1_c1" alt="" /></td>
   <td background="images/opussitelayout07lists_r1_c2.jpg"><img src="images/spacer.gif" width="1" height="1" /></td>
   <td><img name="opussitelayout07lists_r1_c3" src="images/opussitelayout07lists_r1_c3.jpg" width="12" height="10" border="0" id="opussitelayout07lists_r1_c3" alt="" /></td>
   <td><img src="images/spacer.gif" width="1" height="10" border="0" alt="" /></td>
  </tr>
  <tr>
   <td><img name="opussitelayout07lists_r2_c1" src="images/opussitelayout07lists_r2_c1.jpg" width="13" height="24" border="0" id="opussitelayout07lists_r2_c1" alt="" /></td>
   <td align="left" valign="middle" bgcolor="#65FF00"><span class="style1">ARTIST PLAY LISTS</span></td>
   <td><img name="opussitelayout07lists_r2_c3" src="images/opussitelayout07lists_r2_c3.jpg" width="12" height="24" border="0" id="opussitelayout07lists_r2_c3" alt="" /></td>
   <td><img src="images/spacer.gif" width="1" height="24" border="0" alt="" /></td>
  </tr>
  <tr>
   <td><img name="opussitelayout07lists_r3_c1" src="images/opussitelayout07lists_r3_c1.jpg" width="13" height="6" border="0" id="opussitelayout07lists_r3_c1" alt="" /></td>
   <td background="images/opussitelayout07lists_r3_c2.jpg"><img src="images/spacer.gif" width="1" height="1" /></td>
   <td><img name="opussitelayout07lists_r3_c3" src="images/opussitelayout07lists_r3_c3.jpg" width="12" height="6" border="0" id="opussitelayout07lists_r3_c3" alt="" /></td>
   <td><img src="images/spacer.gif" width="1" height="6" border="0" alt="" /></td>
  </tr>
  <tr>
   <td background="images/opussitelayout07lists_r4_c1.jpg"><img src="images/spacer.gif" width="1" heigth="1" /></td>
   <td valign="top" bgcolor="#333333"><table border=0 cellpadding=4 cellspacing=0>
     <cfoutput query="artistCharts">
	 <tr>
       <td align="left"><a href="artistCharts.cfm?artistID=#artistID#&chartID=#ID#">#artist#.#listName#</a></td>
     </tr>
	 </cfoutput>  
	 <!---<tr>
	 	<td align="left"><a href="artistChartsList.cfm">See Complete List of Artist Play Lists &gt;&gt;</a></td>
	 </tr>  //--->
</table></td>
   <td background="images/opussitelayout07lists_r4_c3.jpg"><img src="images/spacer.gif" width="1" height="1" /></td>
   <td><img src="images/spacer.gif" width="1" height="78" border="0" alt="" /></td>
  </tr>
  <tr>
   <td><img name="opussitelayout07lists_r5_c1" src="images/opussitelayout07lists_r5_c1.jpg" width="13" height="12" border="0" id="opussitelayout07lists_r5_c1" alt="" /></td>
   <td background="images/opussitelayout07lists_r5_c2.jpg"><img src="images/spacer.gif" height="1" width="1" /></td>
   <td><img name="opussitelayout07lists_r5_c3" src="images/opussitelayout07lists_r5_c3.jpg" width="12" height="12" border="0" id="opussitelayout07lists_r5_c3" alt="" /></td>
   <td><img src="images/spacer.gif" width="1" height="12" border="0" alt="" /></td>
  </tr>
</table>
