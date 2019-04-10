<cfparam name="form.MStext" default="">
<cfif form.MStext EQ "">
	ERROR<cfabort>
<cfelse>
<cffile action="write"
	file="#serverPath#/MSOrderProcessing.txt"
	output="#form.MStext#">
<cfhttp method="Get"
	url="#webPath#/MSOrderProcessing.txt"
	name="MSorders" 
	delimiter="|"
	textqualifier=""
	columns="CustomerGMU,OrderGMR,ItemGML,DatePlaced,Band_NOTUSED,Title_NOTUSED,Media_NOTUSED,Price,Quantity,Tracking_NOTUSED,Label_NOTUSED,Condition_NOTUSED,SellerCatnum,Genre_NOTUSED,Status,ItemDescrip,ShiptoAttn,ShiptoStreet1,ShiptoStreet2,ShiptoCity,ShiptoState,ShiptoZip,ShiptoCountry,CustomerInstruct,BilltoName,BilltoStreet1,BilltoStreet2,BilltoCity,BilltoState,BilltoZip,BilltoCountry,PhoneDay,CustomerEmail,CCNum,CCCCV,CCExp,PaymentType,ShipMethod,Switch_NOTUSED,ValidFromDate_NOTUSED,ShippingTax_NOTUSED">
</cfhttp>
<!--- GEMM Columns not used in MusicStack export: "StatusCode,DateChanged,GEMMAdminNote,SellerNote,PhoneEve,PhoneFax,SellerGMV,PriceConfirmationGMRC"//--->
<cfset StatusCode=0>
<cfset DateChanged=DateFormat(varDateODBC,"yyyy-mm-dd")>
<cfset GEMMAdminNote="">
<cfset SellerNote="">
<cfset PhoneEve="">
<cfset PhoneFax="">
<cfset SellerGMV="">
<cfset PriceConfirmationGMRC="">
<cfset ShiptoStreet3="">
<cfloop query="MSorders">
<cfif BilltoStreet2 NEQ "">
	<cfset BilltoStreet=BilltoStreet1&";;"&BilltoStreet2>
<cfelse>
	<cfset BilltoStreet=BilltoStreet1>
</cfif>
<cfif ShiptoStreet2 NEQ "">
	<cfset ShiptoStreet=ShiptoStreet1&";;"&ShiptoStreet2>
<cfelse>
	<cfset ShiptoStreet=ShiptoStreet1>
</cfif>
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
	values ('#OrderGMR#','#StatusCode#','#Status#','#Left(DatePlaced,10)#','#DateChanged#','#ItemGML#','#SellerCatnum#','#Left(ItemDescrip,250)#','#Quantity#','#Price#','#CustomerInstruct#','#GEMMAdminNote#','#SellerNote#','#CustomerGMU#','#CustomerEmail#','#ShipMethod#','#ShiptoAttn#','#Replace(thisStreet1,",,",",","all")#','#Replace(thisStreet2,",,",",","all")#','#Replace(thisStreet3,",,",",","all")#','#ShiptoCity#','#ShiptoState#','#ShiptoZip#','#ShiptoCountry#','#BilltoName#','#BilltoStreet#','#BilltoCity#','#BilltoState#','#BilltoZip#','#BilltoCountry#','#PaymentType#','#CCNum#','#CCExp#','#PhoneDay#','#PhoneEve#','#PhoneFax#','#SellerGMV#','0','#Left(SellerCatnum,Len(SellerCatnum)-2)#')
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
<cflocation url="ordersGEMMConvert.cfm?third=ms">
</cfif>