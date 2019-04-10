<cfquery name="getFeature" datasource="#DSN#" maxrows="6" cachedwithin="#CreateTimeSpan(0,2,0,0)#">
select DISTINCT labelID
from labelItemCountQuery
where logofile<>'' AND ID IN (select labelID
                from catItemsQuery
                where ONHAND>0 AND ONSIDE<>999 AND albumStatusID<21 AND reissue<>1 AND 
					releaseDate>'#DateFormat(DateAdd('d',-30,varDateODBC),"yyyy-mm-dd")#')
</cfquery>


        <cfquery name="featuredLabels" datasource="#DSN#" maxrows="6">
      	select DISTINCT ID, *
        from labels
        where ID IN (#getFeature.labelList#)
      </cfquery>
      <table border="0" align="center" cellpadding="3" cellspacing="10" bordercolor="#4EABFB" bgcolor="#993333">
<tr>
            <td colspan="7" align="center"><span class="style20">F E A T U R E IngD&nbsp;&nbsp; L A B E L S</span></td>
        </tr>
          <tr>
          <td width="20" align="center" valign="top">&nbsp;</td>
        <cfoutput query="featuredLabels">
          <cfset imagefile="labels/label_WhiteLabel.gif">
				<cfset imagefolder="">
		  <cfif logofile NEQ "">
			<cfif logofile NEQ "">
						<cfset imagefile="labels/" & logofile>
			</cfif>
		  </cfif>
          <td align="center" valign="top" bgcolor="##FFFFFF" nowrap="no"><a href="opussitelayout07main.cfm?lf=#ID#&amp;group=all"><img src="http://www.downtown304.com/images/#imagefile#" alt="#name#" vspace="2" border="0" hspace="2" /><span class="style21">&nbsp;&nbsp;<br />
          #UCase(Replace(name," ","<br />","all"))#</span></a></td>
            </cfoutput>
			<td width="20" align="center" valign="top">&nbsp;</td>
      </tr>
          

          <tr>
            <td colspan="7" align="center" valign="top">&nbsp;</td>
        </tr>
</table>