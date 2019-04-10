<cfquery name="sqltest" datasource="#DSN#">
Select Plant.Name as name, AVG(Cast(Amount/Seeds AS numeric(4,2))) AS avg_yield from ((Picked INNER JOIN Planted ON Planted.PlantFK=Picked.PlantFK AND Planted.LocationFK=Picked.LocationFK) INNER JOIN Plant ON Picked.PlantFK=Plant.PlantID) GROUP BY Plant.Name


</cfquery>
<cfoutput query="sqltest">
#name# | #avg_yield#<br>
</cfoutput>
<style>.test { color : red; }

#test { color : blue; }

div { color : yellow; }</style>
<div class="test" id="test">Text</div>
