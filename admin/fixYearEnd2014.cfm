<!---<cfquery name="newToReg" datasource="#DSN#">
     update catItems
     set albumStatusID=24
     where albumStatusID=21 AND ID NOT IN
               (select ID from catItems
                where ((ONHAND>0  AND (albumStatusID<=22 OR albumStatusID=148)) OR ONSIDE>0 OR albumStatusID=30)
                    
                    AND releaseDate>'#DateFormat(DateAdd('d',-90,varDateODBC),"yyyy-mm-dd")#')
</cfquery>//--->
<cfquery name="pricefix" datasource="#DSN#">
	update catItems
    set price=priceSave, priceSave=0
    where priceSave>0
</cfquery>
<cfquery name="cdfix" datasource="#DSN#">
	update catItems
    set price=price/.6, cost=cost*2
    where albumStatusID<25 AND ONHAND>0 AND mediaID IN (2,3) AND albumStatusID>21
</cfquery>
<cfquery name="costfix" datasource="#DSN#">
	update catItems
    set cost=costSave, costSave=0
    where costSave>0
</cfquery>
<cfquery name="seven2014" datasource="#DSN#">
	update catItems
    set priceSave=price, costSave=cost, cost=cost/2, price=price*.70
    where albumStatusID<25 AND ONHAND>0 AND mediaID=11 AND albumStatusID>21
</cfquery>
<cfquery name="CD2014" datasource="#DSN#">
	update catItems
    set priceSave=price, costSave=cost, cost=cost*.5, price=price*.60
    where albumStatusID<25 AND ONHAND>0 AND mediaID IN (2,3) AND albumStatusID>21
</cfquery>
<!---<cfquery name="TIMMYADAM2014" datasource="#DSN#">
	update catItems
    set price=8.99, cost=4.00
    where albumStatusID<25 AND ONHAND>0 AND labelID IN (8856,1763,1642,3817,3996,4073) AND ID<>76263
</cfquery>//--->
<cfquery name="TIMMYADAM2014" datasource="#DSN#">
	update catItems
    set priceSave=price, costSave=cost, cost=cost/2, price=price*.50
    where albumStatusID<25 AND ONHAND>0 AND labelID IN (8856,1763,1642,3817,3996,4073) AND ID<>76263
</cfquery>
<cfquery name="vegamaw2014" datasource="#DSN#">
	update catItems
    set priceSave=price, costSave=cost, cost=cost/2, price=price*.50
    where albumStatusID<25 AND ONHAND>0 AND labelID IN (531,990)
</cfquery>
<cfquery name="objectivity2014" datasource="#DSN#">
	update catItems
    set priceSave=price, costSave=cost, cost=cost/2, price=price*.60
    where albumStatusID<25 AND ONHAND>0 AND labelID=3898 AND shelfID=11
</cfquery>
<cfquery name="multi2014" datasource="#DSN#">
	update catItems
    set priceSave=price, costSave=cost, cost=cost/2, price=price*.75
    where albumStatusID<25 AND ONHAND>0 AND mediaID IN (1,12,5) AND albumStatusID>21  AND NRECSINSET>1
</cfquery>
