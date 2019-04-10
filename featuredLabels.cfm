<!--- <cfquery name="theLabelList" datasource="#DSN#">
	select *
	from labelsFeaturedList
	where ID=1
</cfquery>//--->



        <cfquery name="Application.featuredLabels" datasource="#DSN#" maxrows="30" cachedwithin="#CreateTimeSpan(0,2,0,0)#">
      	select DISTINCT labels.ID As ID, name, logofile, releaseDate, catItems.ID As catItemID, catnum, title
        from labels LEFT JOIN catItems ON labels.ID=catItems.labelID
        where labels.ID IN (select DISTINCT labelID
from labelItemCountQuery
where (numItems>3 AND numItems<25)) AND labels.ID IN (select DISTINCT labelID
                from catItems
                where ONHAND>0 AND ONSIDE<>999 AND (albumStatusID=21 OR albumStatusID=18) AND reissue<>1 AND 
					releaseDate>'#DateFormat(DateAdd('d',-30,varDateODBC),"yyyy-mm-dd")#') order by releaseDate DESC, catItems.ID DESC
      </cfquery><table border="0" align="center" cellpadding="3" cellspacing="5" bgcolor="#669934">
<tr>
            <td colspan="8" align="center"><span style="color:#FFFFFF; font-size: medium; font-weight:bold;">Featured Labels</span></td>
        </tr>
          <tr>
          <td width="20" align="center" valign="top">&nbsp;</td>
          <cfset usedCount=0>
          <cfset usedlabelID=arrayNew(1)>
        <cfoutput query="Application.featuredLabels">
        	<cfif usedCount LT 6>
            <cfset usedAlready=false>
            <cfif usedCount GT 0>
            <cfloop index="usedloop" from="1" to="#usedCount#">
            	<cfif ID EQ usedLabelID[usedloop]><cfset usedAlready=true></cfif>
            </cfloop>
            </cfif>
		<cfif NOT usedAlready>
			<cfset usedCount=usedCount+1>
            <cfset usedLabelID[#usedCount#]=ID>
                  <cfset imagefile="labels/label_WhiteLabel.gif">
				<cfset imagefolder="">
		  <cfif logofile NEQ "">
			<cfif logofile NEQ "">
						<cfset imagefile="labels/" & logofile>
			</cfif>
		  </cfif>
          <td align="center" valign="top" bgcolor="##000000" nowrap="no"><a href="opussitelayout07main.cfm?lf=#ID#&amp;group=all"><img src="http://www.downtown304.com/images/#imagefile#" alt="#name#" vspace="2" border="0" hspace="2" /><span class="style21">#UCase(Replace(name," ","<br />","1"))#</span></a></td>
          </cfif>
		  </cfif>
            </cfoutput>
			<td width="20" align="center" valign="top">&nbsp;</td>
      </tr>
          <tr>
            <td colspan="8" align="center" valign="top">&nbsp;</td>
        </tr>
</table>
      