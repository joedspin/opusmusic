<cfquery name="fixPrices" datasource="#DSN#">
	update catItems
	set cost=5.99, price=7.99
	where catnum IN ('KSS1146','KSS1252','KSS1204','KSS1106','KSS1249','KSS1197', 'KSS1194','KSS1218','KSS1184','KSS1177','KSS1134','KSS1170','KSS1119', 'KSS1141','KSS1122','KSS1126','KSS1053','KNG145','KNG169','KNG171','KNG189', 'KNG191','KNG215','KNG224','KNG235','KNG239','KNG249','KNG259','KNG91')
</cfquery>