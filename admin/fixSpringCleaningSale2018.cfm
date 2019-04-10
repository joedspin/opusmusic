<!---<cfquery name="spring2018clear" datasource="#DSN#">
	update catItems
	set specialItem=0
</cfquery>
<cfquery name="spring2018s1" datasource="#DSN#">
	update catItems
	set saleSave=price, specialItem=1, price=price*.75
	where releaseDate<<cfqueryparam value="2018-01-01"> AND releaseDate>=<cfqueryparam value="2017-01-01"> AND ONHAND>0 AND albumStatusID<25 and shelfID IN (2103,28,48,2107,2138,2073,23,45,2124,2133,1063,2119,42,33,35,2108,31,2072,15,2134,32,2096,2091,46,25,30,1054,27,2075,22,2106,2086,37,16,1066,2102,2087,21,26,2130) AND specialItem=0
</cfquery>
<cfquery name="spring2018s2" datasource="#DSN#">
	update catItems
	set saleSave=price, specialItem=1, price=price*.50
	where releaseDate<<cfqueryparam value="2017-01-01"> AND ONHAND>0 AND albumStatusID<25 AND shelfID IN (2103,28,48,2107,2138,2073,23,45,2124,2133,1063,2119,42,33,35,2108,31,2072,15,2134,32,2096,2091,46,25,30,1054,27,2075,22,2106,2086,37,16,1066,2102,2087,21,26,2130) AND specialItem=0
</cfquery>//--->
<!--- THIS IS THE UNDO //--->
<cfquery name="spring2018undo" datasource="#DSN#">
	update catItems
	set price=saleSave, saleSave=0, specialItem=0
	where specialItem=1
</cfquery>