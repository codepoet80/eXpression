<html>

<head>
<title><%=Application("SiteName")%>: register</title>
<link rel="stylesheet" type="text/css" href="normal.css">
<%
if Request("targetpage") = "" then
	targetpage = "http://" & Application("adminRoot")
else
	targetpage = Request("targetpage")
end if
If Request("txtUserName") <> "" then
	sqlCommand = "INSERT INTO tblUsers (UserName, Password, RealName, EMail, Website, Active) VALUES ("
	sqlCommand = sqlCommand & "'" & Request.Form("txtUserName") & "', '" & Request.Form("txtPassword") & "',"
	sqlCommand = sqlCommand & "'" & Request.Form("txtRealName") & "', '" & Request.Form("txtEMail") & "',"
	sqlCommand = sqlCommand & "'" & Request.Form("txtWebsite") & "', 1)"
	set nUser = Server.CreateObject("ADODB.Connection")
	nUser.Open = Application("ConnStr")
	nUser.Execute sqlCommand
	nUser.Close
	set nUser = nothing
	Response.Redirect("authenticate.asp?action=newuser&targetpage=" & targetpage)
end if
%>
<script>
function doSubmit()
{
if(document.frmRegister.txtPassword.value != document.frmRegister.txtPasswordV.value)
	{
	alert ("Your passwords do not match! Please re-type them, ensuring that they are both the same!")
	}
else
	{
	if (document.frmRegister.txtUserName.value == "" || document.frmRegister.txtRealName.value == "" || document.frmRegister.txtEMail.value == "" || document.frmRegister.txtPassword.value == "")
		{
		alert ("Please fill in all required fields!")
		}
	else
		{
		document.frmRegister.submit()
		}
	}
}
</script>
</head>

<body>
<!--#include file="header.inc"-->
		<p class="PageTitle" style="margin-top:0px">eXpression - Register</p>
Registration allows you to participate in discussion, and contribute to any sites hosted on this server. 
When you register, you create an account that you can 
log in with in the future for all your activity on the system. With this account, 
you can avoid filling in forms all the time, as your information is recorded 
only once.<br><br>
Personal information will be viewable only by other site members and will not be shared with any third parties
including, but not limited to distribution lists, sales or marketing organizations, or government officials of
any country without appropriate authorization.<br>
<p>
Create your account here by filling in all the applicable fields. Required 
fields are marked with a star (*)
<br/><br/>
Your user name is what you'll be known as on sites hosted on this server, you can use an actual 
name, a handle, or just your initials. Your real name and e-mail address are for 
the account, please make sure these fields are accurate -- you'll never have to 
enter them again!<br/>
You can make changes to this information and add more details once your registration has been accepted.</p>
<hr>
<form method="post" action="register.asp?targetpage=<%=targetpage%>" target="_self" name="frmRegister">
<table border="0" cellpadding="0" cellspacing="0" style="border-collapse: collapse" bordercolor="#111111" width="298" id="AutoNumber1">
  <tr>
    <td width="103">User Name:</td>
    <td width="192"><input type="text" name="txtUserName" size="20"> *</td>
  </tr>
  <tr>
    <td width="103">Real Name:</td>
    <td width="192"><input name="txtRealName" size="20"> *</td>
  </tr>
  <tr>
    <td width="103">E-Mail Address:</td>
    <td width="192"><input name="txtEMail" size="20"> *</td>
  </tr>
  <tr>
    <td width="103">Website URL:</td>
    <td width="192"><input name="txtWebsite" size="20"></td>
  </tr>
  <tr>
    <td width="103">Password:</td>
    <td width="192"><input type="password" name="txtPassword" size="20"> *</td>
  </tr>
  <tr>
    <td width="103">Verify Password:</td>
    <td width="192"><input type="password" name="txtPasswordV" size="20"> *</td>
  </tr>
  <tr>
    <td width="103">&nbsp;</td>
    <td width="192">
    <input type="button" value="Save" name="cmdSubmit" style="float: left" onClick="doSubmit()"></td>
  </tr>
</table>
</form>
</body>

</html>
 
 
