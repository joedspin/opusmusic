<cflogout>
<cfset pageName="Login">
<cfinclude template="pageHead.cfm">
<cfset refPage="#CGI.script_name#">
					<cfif CGI.query_string IS NOT "">
   					<cfset refPage=refPage & "?#CGI.query_string#">
					</cfif>

<form action="<cfoutput>#refPage#</cfoutput>" method="Post">	
<table border="0" cellpadding="6" cellspacing="0" >

      <cfif userMessage NEQ "">
                    
       
        <tr>
                      
          <td colspan="2" align="left"><font face="Arial, Helvetica, sans-serif" color="red" size="2"><b><cfoutput>#userMessage#</cfoutput></b></font></td>
        </tr>
                  
      </cfif>
                  
      <tr>
                    
        <td align="right">
<font size="2" face="Arial, Helvetica, sans-serif">username:</font></td>
        <td>
<input class="text" type="text" name="j_username" maxlength="15" size="18">
        </td>
      </tr>
                  
      <tr>
                    
        <td align="right">
<font size="2" face="Arial, Helvetica, sans-serif">password:</font></td>
        <td>
<input class="text" type="password" name="j_password" maxlength="15" size="20"></td>
      </tr>
                  
      <tr>
        <td>&nbsp;</td>       
        <td align="left"><input type="submit" value="  Login  " name="loginButton"></td>
      </tr>

    </table>
		<p>&nbsp;</p>
</form>
<!---<form action="../forgotUserPass.cfm" method="Post">	
<table  border="0" cellpadding="6" cellspacing="0">
                  
                    
        <tr>
          <td>&nbsp;</td>
					<td align="left"><font face="Arial, Helvetica, sans-serif" color="gray" size="1">If you have forgotten your username or password,<br>
					submit your email address below to have them sent to you.</font></td>
        </tr>
                  
                  
      <tr>
                    
        <td align="right">
<font size="2" face="Arial, Helvetica, sans-serif">email:</font></td>
        <td>
<input class="text" type="text" name="email" maxlength="30" size="20">
        </td>
      </tr>
                  
                  
      <tr>
        <td>&nbsp;</td>       
        <td align="left"><input type="submit" value="  Submit  " name="submit"></td>
      </tr>

    </table>
		<p>&nbsp;</p>
	</form>//--->
<cfinclude template="pageFoot.cfm">