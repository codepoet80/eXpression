<html>
<%
admin = false
if Session("LoggedIn") <> "true" then
	Response.Redirect("authenticate.asp?targetpage=user-modify.asp?try=1&frame=" & Request("frame") & "&userid=" & Request("userid"))
else
	'See if this user is an admin for this site
	sqlCommand = "SELECT * FROM tblAdmins WHERE SiteID = 0 AND UserID = " & Session("UserID")
	set rs = Server.CreateObject("ADODB.Recordset")
	rs.open sqlCommand, Application("ConnStr")
	if rs.eof = true then
		admin = true
		if Session("userid")*1 <> Request("userid")*1 then
			if Request("try") = 1 then
				Response.Redirect("user-view.asp?userid=" & Request("userid"))				
			else
				Response.Redirect("authenticate.asp?targetpage=user-modify.asp?try=1&frame=" & Request("frame") & "&userid=" & Request("userid"))
			end if
		end if
	end if
end if
%>
<head>
<title><%=Application("SiteName")%>: modify a user</title>
<link rel="stylesheet" type="text/css" href="normal.css">
<base target="_blank">
<script>
function doSubmit()
{
if (document.frm.UserName.value == "")
	{
	alert ("Please fill in a value for username!")
	return;
	}
if (document.frm.Password1.value != document.frm.Password2.value)
	{
	alert ("Your passwords do not match! Please re-type them!")
	return;
	}
frm.submit()
}
</script>
</head>
<%
if Request.Form("RealName") <> "" then
	sqlCmd = "UPDATE tblUsers SET UserName='" & Replace(Request.Form("username"), "'", "''") & "', Password='" & Replace(Request.Form("password1"), "'", "''") & "', RealName='" & Replace(Request.Form("realname"), "'", "''") & "', EMail='" & Request.Form("email") & "', Website='" & Request.Form("website") & "', Relationship='" & Replace(Request.Form("relationship"), "'" , "''") & "', Bio='" & Replace(Request.Form("bio"), "'", "''") & "', favcolor='" & Replace(Request.Form("favcolor"), "'", "''") & "', FavBook='" & Replace(Request.Form("favbook"), "'", "''") & "', FavMovie='" & Replace(Request.Form("favmovie"), "'", "''") & "', Active=1"
	sqlCmd = sqlCmd & " WHERE UserID = '" & Request.QueryString("userid") & "'"
	set nUser = Server.CreateObject("ADODB.Connection")
	nUser.Open = Application("ConnStr")
	nUser.Execute sqlCmd
	nUser.Close
	set nUser = nothing
	
	Response.Redirect("user-view.asp?frame=" & Request("frame") & "&userid=" & Request.QueryString("userid"))
	'calcscore = "calcscore.asp?userid=" & Request.QueryString("userid") & "&returnpage=user-view.asp?siteid=" & Request("siteid")
	'Response.Redirect(calcscore)
end if
%>
<body>
<!--#include file="header.inc"-->
<%
set rComments = Server.CreateObject("ADODB.Recordset")
if Request.QueryString("userid") <> "" or Request("username") <> "" then
	if Request.QueryString("userid") <> "" then
		sqlCommand = "SELECT * FROM tblUsers WHERE UserID =" & Request.QueryString("userid")
	else
		sqlCommand = "SELECT * FROM tblUsers WHERE UserName = '" & Request("username") & "'"
	end if
	rComments.open sqlCommand, Application("ConnStr")
'if Session("username") = rComments("username") or admin = true then
%>
<p class="PageTitle">Modify User</p>

<table width="100%" cellspacing="0" cellpadding="0"><tr>
<td align="left" valign="top" style="padding-right: 5">
	<%
	'Get Image
	'set rImg = server.createobject("ADODB.Recordset")
	'sqlCmd = "SELECT * FROM tblWebLogImages WHERE EntryID = " & rComments("UserID") & " AND Loc='Users'"
	'rImg.open sqlCmd, Application("ConnStr")
	'if rImg.eof = false then
	'	if rImg("iType") = "jpg" or rImg("iType") = "gif" then
	'		if rImg("iType") = "jpg" then
	'			Response.Write "<img src='showjpg.asp?entryid=" & rComments("UserID") & "&type=user'"
	'		elseif rImg("iType") = "gif" then
	'			Response.Write "<img src='showgif.asp?entryid=" & rComments("UserID") & "&type=user'"
	'		end if
	'		Response.Write ">&nbsp;&nbsp;"
	'	end if
	'else
	'	Response.Write "<img src='../images/anonymous.gif' height=150>"
	'end if
	'/Get Image
	%>
</td>
<td width="100%">
<form name="frmModify" method="post" action="user-modify.asp?frame=<%=Request("frame")%>&userid=<%=rComments("UserID")%>&siteid=<%=Request("siteid")%>" target="_self">
<table border="0" cellpadding="0" cellspacing="0">
<tr><td>
<b>User Name:</b> 
</td><td>
<input type="text" name="UserName" value="<%=rComments("UserName")%>" size="20"><br>
<tr><td>
<b>Password:</b> 
</td><td>
<input type="password" name="Password1" value="<%=rComments("Password")%>" size="20"><br>
<tr><td>
<b>Confirm Password:</b> 
</td><td>
<input type="password" name="Password2" value="<%=rComments("Password")%>" size="20"><br>
</td></tr>
<tr><td>
<b>Real Name:</b> 
</td><td>
<input type="text" name="RealName" value="<%=rComments("RealName")%>" size="20"><br>
</td></tr>
<tr><td>
<b>E-Mail:</b> 
</td><td>
<input type="text" name="EMail" value="<%=rComments("EMail")%>" size="20"><br>
</td></tr>
<tr><td>
<b>Website:</b> 
</td><td>
<input type="text" name="Website" value="<%=rComments("Website")%>" size="40"><br>
</td></tr>
<tr><td>
<b>Association:</b> 
</td><td>
<input type="text" name="Relationship" value="<%=rComments("Relationship")%>" size="40"><br>
</td></tr>
<tr><td>
<b>Favourite Book:</b> 
</td><td>
<input type="text" name="FavBook" value="<%=rComments("FavBook")%>" size="20"><br>
<tr><td>
<b>Favourite Movie:</b> 
</td><td>
<input type="text" name="FavMovie" value="<%=rComments("FavMovie")%>" size="20"><br>
</td></tr>
<tr><td>
<b>Favourite Colour:</b> 
</td><td>
<input type="text" name="FavColor" value="<%=rComments("FavColor")%>" size="20"><br>
</td></tr>
<tr><td valign="top">
<b>About me:</b><br>
</td><td>
<textarea name="Bio" rows="12" cols="61"><%=rComments("Bio")%></textarea><br>
<!--<input type="button" name="addPic" value="Add/Change Picture" onClick="window.open('image-upload.asp?entryid=<%=rComments("UserID")%>&type=users','Upload','left=22,top=22,toolbar=no,directories=no,width=390,height=200')">-->
</td></tr>
</table>
<input type="submit" name="submit" value="Save">
</form>
<hr>
<%
	set rCounts = server.createobject("ADODB.Recordset")
	sqlCmd = "SELECT * FROM tblWebLog WHERE UserID = " & rComments("UserID")
	rCounts.open sqlCmd, Application("ConnStr")
	count = 0
	do while rCounts.eof = false
		count = count + 1
		rCounts.movenext
	loop
	set rCounts = nothing
	Response.Write "<b>Number of Articles Posted:</b> " & count & "<br>"

	set rCounts = server.createobject("ADODB.Recordset")
	sqlCmd = "SELECT * FROM tblComments WHERE UserID = " & rComments("UserID")
	rCounts.open sqlCmd, Application("ConnStr")
	count = 0
	do while rCounts.eof = false
		count = count + 1
		rCounts.movenext
	loop
	set rCounts = nothing
	Response.Write "<b>Number of Comments Posted:</b> " & count & "<br>"
%>

<%
end if
'else
'	Response.Write "Insufficent Rights to modify this user"
'end if
%>
</font>
</body>

</html>
 
 
