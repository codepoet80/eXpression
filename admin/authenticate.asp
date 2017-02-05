<html>

<head>
<title><%=Application("SiteName")%>: sign in</title>
<link rel="stylesheet" type="text/css" href="normal.css">
<base target="_blank">
<%

function getPrivateKey()
	'get date
	'divide by hour
	'multiply by some number
	'divide by site number
	getPrivateKey = "1"
end function

urlparts = split(Request.QueryString, "targetpage=")
if (ubound(urlparts) > 0) then
	returnpage = urlparts(ubound(urlparts))
end if
If Request("targetaction") <> "" then
	doaction = Request("targetaction")
else
	doaction = "login"
end if
If Request("action") = "login" or Request("action") = "signin" or Request("action") = "remotelogin" then
	' Record login attempt
	set wLog = Server.CreateObject("ADODB.Connection")
	wLog.Open Application("ConnStr")
	sqlCommand = "INSERT INTO tblWebCounter (Request, EntryTime, IP, Referrer, UserName) VALUES ('" & returnpage & "','" & Now & "', '" & Request.ServerVariables("REMOTE_HOST") & "','" & Request.ServerVariables("HTTP_REFERER") & "', '" & Request("txtUserName") & "')"
	wLog.Execute sqlCommand
	wLog.close
	set wLog = nothing
	
	sqlCmd = "SELECT * FROM tblUsers WHERE UserName = '" & Request("txtUserName") & "' AND Password = '" & Request("txtPassword") & "'"
	set rLogin = Server.CreateObject("ADODB.Recordset")
	rLogin.Open sqlCmd, Application("ConnStr")
	if rLogin.EOF = false then
		if rLogin("Active") = 1 then
			Session("LoggedIn") = "true"
			Session("UserName") = rLogin("UserName")
			Session("UserID") = rLogin("UserID")
			Session("UserLevel") = rLogin("UserLevel")
			Session("Counted") = "no"
			if rLogin("Bio") <> "" or rLogin("Relationship") <> "" then
				Session("Profile") = "yes"
			else
				Session("Profile") = "no"
			end if
			rLogin.Close
			set rLogin = nothing
			if Request.Form("chkCookie")="Yes" then
				Response.Cookies("Username") = Request("txtUserName")
				Response.Cookies("Password") = Request("txtPassword")
				Response.Cookies("UserID").Expires = Date + 180
			end if
			if returnpage <> "" then
				if Request("action") = "signin" then
					Response.Redirect(returnpage & getPrivateKey())
				elseif Request("action") = "login" then
					Response.Redirect(returnpage)
				elseif Request("action") = "remotelogin" then
					Response.Redirect(returnpage & "?userid=" & Session("UserID"))
				end if
			else
				Response.Redirect("default.asp")
			end if
		elseif rLogin("Active") = 3 then
			Session("LoggedIn") = "notapproved"
			rLogin.Close
			set rLogin = nothing
		else
			Session("LoggedIn") = "inactive"
			rLogin.Close
			set rLogin = nothing
		end if
	else
		Session("LoggedIn") = "rejected"
		rLogin.Close
		set rLogin = nothing
	end if
ElseIf Request("action") = "logout" then
	Session("LoggedIn") = ""
	Session("UserName") = ""
	Session("UserID") = ""
	Session("UserLevel") = 0
	Session("Profile") = ""
	'Response.Cookies("UserID") = ""
	if returnpage <> "" then
		Response.Redirect(returnpage)
	else
		Response.Redirect("default.asp")
	end if	
End If
%>
</head>

<body class="PageBody">
<!--#include file="header.inc"-->
		<p class="PageTitle" style="margin-top:0px">eXpression - Sign In</p>

Please log in to participate in discussion on this site. If you do not have an 
account, you can get one quickly and for free...<br>
<b><a target="_self" href="register.asp">Register Now!</a></b><br>
<br>
<hr>
<%
If Session("LoggedIn") = "rejected" then
	Response.Write "<i><b>Error:</b> Your username or password could not be found!</i>"
	Session("LoggedIn") = ""
elseif Session("LoggedIn") = "inactive" then
	Response.Write "<i><b>Error:</b> Your account has been deactivated due to either inactivity or a breach of trust. An account reactivation request has been sent to the administrator on your behalf. Please try again after your account has been reactivated..</i>"

	sqlCmd = "UPDATE tblUsers SET Active=3"
	sqlCmd = sqlCmd & " WHERE UserName = '" & Request.Form("txtUserName") & "'"
	set nUser = Server.CreateObject("ADODB.Connection")
	nUser.Open = Application("ConnStr")
	nUser.Execute sqlCmd
	nUser.Close
	set nUser = nothing

	Session("LoggedIn") = ""
elseif Session("LoggedIn") = "notapproved" then
	Response.Write "<i><b>Error:</b> Your account has been created but the administrator has not yet approved it. If you provided a valid e-mail address, you should be notified when your account is active. Otherwise, please try again later.</i>"
	Session("LoggedIn") = ""
elseif Request("action") = "newuser" then
	Response.Write "<i>Login with your new account below.</i>"
elseif Request("action") = "reply" then
	Response.Write "<i>Sorry! You can't post replies until you've signed in. If you have an account, please sign in below, otherwise follow the link above to register</i>"
end if
%>
<form method="post" action="authenticate.asp?targetpage=<%=returnpage%>" target="_self">
<table border="0" cellpadding="0" cellspacing="0" style="border-collapse: collapse" bordercolor="#111111" width="320" id="AutoNumber1">
  <tr>
    <td width="87">Username:</td>
    <td width="230"><input type="text" name="txtUserName" size="20" value="<%=Request.Cookies("Username")%>"></td>
  </tr>
  <tr>
    <td width="87">Password:</td>
    <td width="230"><input type="password" name="txtPassword" size="20" value="<%=Request.Cookies("Password")%>"></td>
  </tr>
  <tr>
    <td width="87">&nbsp;</td>
    <td width="230">
    <input type="checkbox" name="chkCookie" value="Yes" disabled="true"> <font color=Gray>Keep me logged in on this computer</font>
    </td>
  </tr>
  <tr>
    <td width="87">&nbsp;</td>
    <td width="230">
    <input type="hidden" name="action" value="<%=doaction%>">
    <input type="submit" value="Submit" name="cmdSubmit" style="float: left"></td>
  </tr>
</table>
</form>
</body>

</html>
 
 
