<cfoutput query="ordersWaiting">
        	<cfset progressFurther=true>
            <cfif NOT isStore and setGoldLine EQ false AND url.closed NEQ "recent">
                <tr><td colspan="17" bgcolor="##FFC600">&nbsp;</td></tr>
                <cfset setGoldLine=true>
			<cfelseif pickupReady AND NOT isStore and setGreenLine EQ false AND url.closed NEQ "recent">
                <tr><td colspan="17" bgcolor="##669933">&nbsp;</td></tr>
                <cfset setGreenLine=true>
			<cfelseif lastOtherSiteID NEQ otherSiteID AND url.closed NEQ "recent">
                <tr><td colspan="17" bgcolor="##336699">&nbsp;</td></tr>
			</cfif>
			<cfset lastOtherSiteID=otherSiteID>
				<cfif ID EQ url.editedID><cfset thisBG="999999"><cfset doHashtag=true><cfelse><cfset thisBG="FFFFFF"><cfset doHashtag=false></cfif>
                <tr bgcolor="###thisBG#" style="background-color:###thisBG#">
					<!---<td nowrap>#
					<cfset theStatusName=statusName>cfif statusID EQ 2 OR statusID EQ 3>
						<cfquery name="thisItems" datasource="#DSN#" maxrows="1">
							SELECT ID
							FROM orderItems
							where orderID=#ID# AND adminAvailID=2
						</cfquery>
						<cfif thisItems.recordCount GT 0>
							<cfset theStatusName="New">
						<cfelseif statusID EQ 3>
							<cfset theStatusName="Payment Authorized">
						</cfif>
					<cfelseif statusID EQ 4>
						<cfset theStatusName="Paid">
					<cfelse>
						<cfset theStatusName="Picked">
					</cfif>
					<cfif statusID EQ 1>
							<font color="red">
						<cfelseif statusID EQ 2 OR statusID EQ 3>
							<font color="yellow">
						<cfelseif statusID EQ 4>
							<font color="green">
						</cfif>#theStatusName#</font></td>//--->
                        <cfif NOT IsDate(datePurchased)><cfset thisDP=dateUpdated><cfelse><cfset thisDP=datePurchased></cfif><cfset rowColor="">
                        <cfif NOT IsDate(thisDP)><cfset thisDP=varDateODBC></cfif>
                        <cfif dateFormat(varDateODBC,"ddd") EQ "Mon"><cfset compareDateNumber=3><cfelse><cfset compareDateNumber=1></cfif>
                       <cfif picklistPrinted AND NOT issueRaised><cfif DateDiff("d",thisDP,varDateODBC) EQ compareDateNumber><cfset rowColor="yellow"><cfelseif DateDiff("d",thisDP,varDateODBC) GT compareDateNumber><cfset rowColor="red"><cfelse><cfset rowColor=""></cfif></cfif>
					<td nowrap align="right" bgcolor="#rowColor#"><cfif doHashtag><a id="edited"></a></cfif><b><a href="ordersEdit.cfm?ID=#ordersWaiting.ID#"<cfif ID EQ url.editedID> name="paidone"</cfif>>#ID#</a></b></a></td>
                    <td nowrap align="right"><b>#DateDiff("d",thisDP,varDateODBC)#</b></td>
<!---                    <td nowrap align="center"><a href="ordersWithPics.cfm?ID=#ID#" target="OrderPics">[ ]</a></td>   //--->
						<td nowrap valign="top"><a href="customersOpusEdit.cfm?ID=#custID#" target="_blank"><!---<cfif otherSiteID EQ 2>#UCase(username)# &mdash; </cfif>//---><cfif badCustomer><font color="red">#UCase(firstName)# #UCase(lastName)#</font><cfelse><cfif isStore>#UCase(billingName)#<cfelse>#UCase(firstName)# #UCase(lastName)#</cfif></cfif></a></td>                     
					<td nowrap><a href="ordersShop.cfm?orderID=#ordersWaiting.ID#"><font color="##CC3399">SHOP</font></a></td>
					<cfif badCustomer><td nowrap><font color="red">BAD</font></td><cfelseif picklistPrinted EQ 1 OR issueRaised EQ 1><td nowrap><a href="ordersViewAll.cfm?ID=#ordersWaiting.ID#"><font color="##666666">REPRINT</font></a></td><cfelseif NOT readyToPrint><td nowrap><font color="##993300">NOT PRINTED</font></td><cfset progressFurther=false><cfelse><td nowrap><a href="ordersViewAll.cfm?ID=#ordersWaiting.ID#">PRINT</a></td><cfset progressFurther=false></cfif>
                    
					<cfif badCustomer><td nowrap><font color="red">BAD</font></td><cfelse><td nowrap><cfif NOT issueRaised AND progressFurther><a href="ordersAllAvail.cfm?ID=#ordersWaiting.ID#">ALL AVAILABLE</a><cfset progressFurther=false><cfelseif issueRaised><a href="ordersAllAvailUndo.cfm?ID=#ordersWaiting.ID#"><font color="##666666">RESET</font></a><cfelse>&nbsp;</cfif></td></cfif>
                    
					<td nowrap><cfif NOT issueResolved AND progressFurther>
							<a href="ordersUpdateInvoice.cfm?ID=#ordersWaiting.ID#">INVOICE</a><cfset progressFurther=false>
                         <cfelseif progressFurther>
                            <a href="ordersUpdateInvoice.cfm?ID=#ordersWaiting.ID#&undo=true"><font color="##666666">UNINVOICE</font></a><cfelse>&nbsp;</cfif>
						</td>
					</td>
							<!--- removed from below so CHARGE button will always appear NOT pickupReady AND //--->
					<td nowrap<cfif adminIssueID EQ 2 OR adminIssueID EQ 3 OR adminIssueID EQ 4> bgcolor="red"</cfif>><cfif paymentTypeID EQ 6 AND adminIssueID EQ 1><cfset progressfurther=true><cfelseif (otherSiteID EQ 0 AND statusID NEQ 4 AND issueResolved) AND progressFurther AND NOT (shipID EQ 64 AND (paymentTypeID EQ 5 OR paymentTypeID EQ 0))><a href="ordersPay.cfm?ID=#ordersWaiting.ID#">CHARGE</a><cfset progressFurther=false><cfelseif progressFurther AND pickupReady><a href="ordersPay.cfm?ID=#ordersWaiting.ID#">CHARGE</a><cfset progressFurther=true><cfelse>&nbsp;</cfif></td><!--- move the "TOTAL" function down to be clickable on the actual dollar total //--->
                    
							<cfif shipID EQ 64 AND statusID NEQ 4 AND custID NEQ 2126 AND progressFurther AND NOT pickupReady><td nowrap><a href="ordersUpdateStatus.cfm?ID=#ordersWaiting.ID#&dateShipped=#DateFormat(varDateODBC,"mm/dd/yy")#&notice=ready">NOTIFY</a><cfset pickup="PICKUP"><cfset progressFurther=false></td><!---<cfelseif statusID NEQ 4 AND progressFurther AND paymentTypeID EQ 6 AND custID NEQ 2126><td nowrap><a href="ordersUpdateStatus.cfm?ID=#ordersWaiting.ID#&notice=moneyorder">NOTIFY</a><cfset progressFurther=false></td>//--->
							<cfelseif statusID NEQ 4 AND progressFurther>
								<td nowrap><a href="ordersPaid.cfm?ID=#ordersWaiting.ID#&paid=4"><cfif otherSiteID EQ 2 AND Trim(otherSiteOrderNum) NEQ "">#Trim(otherSiteOrderNum)#<cfelse>PAID</cfif></a><cfset progressFurther=false></td>
                                <cfelseif statusID NEQ 2 AND progressFurther>
								<td nowrap><a href="ordersPaid.cfm?ID=#ordersWaiting.ID#&paid=2"><font color="##666666">NOT PAID</font></a></td>
                                
								<cfelse><td nowrap><font color="###thisBG#">NOT PAID</font></td>
							</cfif>
						<!---<td nowrap><cfif statusID EQ 4 AND progressFurther><a target="_blank" href="ordersPrintLabels.cfm?ID=#ordersWaiting.ID#">LABEL</a><cfelse>&nbsp;</cfif></td>//--->
						<cfset pickup="<img src='images/spacer.gif' height='16' width='76'>">
					<td nowrap><!---<cfif shipID EQ 64 AND pickupReady AND statusID NEQ 4 AND progressFurther>
								<td nowrap><a href="ordersPaid.cfm?ID=#ordersWaiting.ID#&paid=4">PAID</a></td>//---><cfif shipID EQ 64 AND statusID EQ 4 AND progressFurther><a href="ordersUpdateStatus.cfm?ID=#ordersWaiting.ID#&dateShipped=#DateFormat(varDateODBC,"mm/dd/yy")#&notice=readypaid">COMPLETE</a><cfelseif shipID EQ 64 AND pickupReady AND progressFurther><a href="ordersUpdateStatus.cfm?ID=#ordersWaiting.ID#&dateShipped=#DateFormat(varDateODBC,"mm/dd/yy")#&notice=complete">COMPLETE</a><cfelseif (statusID EQ 3 OR statusID EQ 4) AND progressFurther><a href="ordersUpdateStatus.cfm?ID=#ordersWaiting.ID#&dateShipped=#DateFormat(varDateODBC,"mm/dd/yy")#&notice=final">FINAL</a><cfelse><font color="###thisBG#">COMPLETE</font></cfif></td>
						<td nowrap valign="top">#DateFormat(datePurchased,"mm/dd/yy")#</td>
						<td nowrap><cfif paymentTypeID NEQ 7><a href="ordersMerge.cfm?ID=#ordersWaiting.ID#&custID=#ordersWaiting.customerID#">MERGE</a><cfelse><font color="##336699"><b><i>PayPal</i></b></font></cfif></td>
						<td nowrap valign="top" align="center" style="color: white"<cfif shipID EQ 62 OR shipID EQ 63 OR shipID EQ 57 OR shipID EQ 76 OR shipID EQ 117 OR shipID EQ 118 OR shipID EQ 119 OR shipID EQ 120>background="images/ups.jpg"<cfelseif shipID EQ 64>bgcolor="##669933"<cfelse>bgcolor="##336699"</cfif>><cfif otherSiteID NEQ 0>#UCase(otherSiteName)#<cfelse>#pickup#</cfif></td>
                        <td nowrap align="right"><cfif otherSiteID EQ 2 AND Trim(otherSiteOrderNum) NEQ ""><a href="https://www.discogs.com/sell/order/10096-#otherSiteOrderNum#" target="discogsFrame">###otherSiteOrderNum#</a>
                            <cfelse><a href="ordersPay.cfm?ID=#ordersWaiting.ID#&printonly=true" title="Recalculate Total">#DollarFormat(orderTotal)#</a></cfif></td>			
					</tr>
					
		</cfoutput>