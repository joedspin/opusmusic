            <cfquery name="clearspecial" datasource="#DSN#">
            	update catItems
                set specialItem=0
            </cfquery>
          <cfquery name="markSpecial" datasource="#DSN#">
            	update catItems
                set specialItem=1
                where ONHAND>0 AND ((albumStatusID=21 AND releaseDate>'#DateFormat(DateAdd('d',-75,varDateODBC),"yyyy-mm-dd")#') OR (albumStatusID=23 AND dtDateUpdated>'#DateFormat(DateAdd('d',-60,varDateODBC),"yyyy-mm-dd")#'))
            </cfquery>
            <cfquery name="markRegular" datasource="#DSN#">
            	update catItems
                set albumStatusID=24
                where albumStatusID<25 AND specialItem=0
            </cfquery>