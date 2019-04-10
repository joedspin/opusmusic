<cfparam name="form.GEMMtext" default="">
<cfif form.GEMMtext EQ "">
	ERROR<cfabort>
<cfelse>
<cffile action="write"
	file="#serverPath#/GEMMOrderProcessing.txt"
	output="#form.GEMMtext#">
<cfhttp method="Get"
	url="#webPath#/GEMMOrderProcessing.txt"
	name="GEMMorders" 
	delimiter="|"
	textqualifier=""
	columns="OrderGMR,StatusCode,Status,DatePlaced,DateChanged,ItemGML,SellerCatnum,ItemDescrip,Quantity,Price,CustomerInstruct,GEMMAdminNote,SellerNote,CustomerGMU,CustomerEmail,ShipMethod,ShiptoAttn,ShiptoStreet,ShiptoCity,ShiptoState,ShiptoZip,ShiptoCountry,BilltoName,BilltoStreet,BilltoCity,BilltoState,BilltoZip,BilltoCountry,PaymentType,CCNum,CCExp,PhoneDay,PhoneEve,PhoneFax,SellerGMV,PriceConfirmationGMRC"></cfhttp>
<cfloop query="GEMMorders">
<cfset thisStreet3="">
<cfset thisStreet2="">
<cfset thisStreet1="">
<cfset thisStreet=Replace(Replace(ShiptoStreet,";;",";; ","all"),"  "," ","all")>
<cfset thisStreet=Replace(thisStreet,";; ","|","all")>
<cfif ListLen(thisStreet,"|") EQ 4>
	<cfset thisStreet3=ListGetAt(thisStreet,3,"|")&", "&ListGetAt(thisStreet,4,"|")>
	<cfset thisStreet2=ListGetAt(thisStreet,2,"|")>
	<cfset thisStreet1=ListGetAt(thisStreet,1,"|")>
<cfelseif ListLen(thisStreet,"|") EQ 3>
	<cfset thisStreet3=ListGetAt(thisStreet,3,"|")>
	<cfset thisStreet2=ListGetAt(thisStreet,2,"|")>
	<cfset thisStreet1=ListGetAt(thisStreet,1,"|")>
<cfelseif ListLen(thisStreet,"|") EQ 2>
	<cfset thisStreet2=ListGetAt(thisStreet,2,"|")>
	<cfset thisStreet1=ListGetAt(thisStreet,1,"|")>
<cfelseif ListLen(thisStreet,"|") EQ 1>
	<cfset thisStreet1=thisStreet>
</cfif>
<cfquery name="insertOrder" datasource="#DSN#">
	insert into GEMMBatchProcessing (OrderGMR,StatusCode,Status,DatePlaced,DateChanged,ItemGML,SellerCatnum,ItemDescrip,Quantity,Price,CustomerInstruct,GEMMAdminNote,SellerNote,CustomerGMU,CustomerEmail,ShipMethod,ShiptoAttn,ShiptoStreet,ShiptoStreet2,ShiptoStreet3,ShiptoCity,ShiptoState,ShiptoZip,ShiptoCountry,BilltoName,BilltoStreet,BilltoCity,BilltoState,BilltoZip,BilltoCountry,PaymentType,CCNum,CCExp,PhoneDay,PhoneEve,PhoneFax,SellerGMV,Processed,MYREFNO)
	values ('#OrderGMR#','#StatusCode#','#Status#','#DatePlaced#','#DateChanged#','#ItemGML#','#SellerCatnum#','#ItemDescrip#','#Quantity#','#Price#','#CustomerInstruct#','#GEMMAdminNote#','#SellerNote#','#CustomerGMU#','#CustomerEmail#','#ShipMethod#','#ShiptoAttn#','#Replace(thisStreet1,",,",",","all")#','#Replace(thisStreet2,",,",",","all")#','#Replace(thisStreet3,",,",",","all")#','#ShiptoCity#','#ShiptoState#','#ShiptoZip#','#ShiptoCountry#','#BilltoName#','#BilltoStreet#','#BilltoCity#','#BilltoState#','#BilltoZip#','#BilltoCountry#','#PaymentType#','#CCNum#','#CCExp#','#PhoneDay#','#PhoneEve#','#PhoneFax#','#SellerGMV#','0','#Left(SellerCatnum,Len(SellerCatnum)-2)#')
	</cfquery>
	<cfquery name="checkML" datasource="#DSN#">
		select *
		from GEMMCustomers
		where email='#CustomerEmail#'
	</cfquery>
	<cfif checkML.recordCount EQ 0>
		<cfquery name="addML" datasource="#DSN#">
			insert into GEMMCustomers (name, email, subscribe)
			values ('#ShipToAttn#','#CustomerEmail#',1)
		</cfquery>
	</cfif>
</cfloop>
<cfquery name="ImportAssignITEMdetails" datasource="#DSN#">
	UPDATE GEMMBatchProcessing 
    SET GEMMBatchProcessing.PARTNER = catItemsQuery.shelfCode, GEMMBatchProcessing.Cost = catItemsQuery.cost,  GEMMBatchProcessing.opCATNUM=catItemsQuery.catnum, GEMMBatchprocessing.opLABEL=catItemsQuery.label, GEMMBatchProcessing.opARTIST=catItemsQuery.artist, GEMMBatchProcessing.opTITLE=catItemsQuery.title, GEMMBatchProcessing.opMEDIA=catItemsQuery.media
    FROM GEMMBatchProcessing LEFT JOIN catItemsQuery ON GEMMBatchProcessing.MYREFNO = catItemsQuery.ID 
</cfquery>
<cfquery name="fixUK" datasource="#DSN#">
	UPDATE GEMMBatchProcessing SET ShiptoCountry='UNITED KINGDOM (GREAT BRITAIN)' where ShiptoCountry='UK' or ShiptoCountry='U.K.' or ShiptoCountry='UNITED KINGDOM'
</cfquery>
<cfquery name="fixUSA" datasource="#DSN#">
	UPDATE GEMMBatchProcessing SET ShiptoCountry='UNITED STATES' where ShiptoCountry='U S A' or ShiptoCountry='USA'
</cfquery>
<cfquery name="fixUSA" datasource="#DSN#">
	UPDATE GEMMBatchProcessing SET ShiptoCountry='BRAZIL' where ShiptoCountry='BRASIL'
</cfquery>
<cflocation url="ordersGEMMConvert.cfm">
</cfif>