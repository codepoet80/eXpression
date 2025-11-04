<html>
<head>
<title><%=Application("SiteName")%>: view a user</title>
<link rel="stylesheet" type="text/css" href="normal.css">
<base target="_blank">
<script>
function sizeImg()
{
	if (document.profile.height > 200)
		document.profile.height = 200
}
</script>
</head>
<body topmargin="0" marginheight="0">
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
%>
<p class="PageTitle" style="margin-top:0px"><%=rComments("username")%></p>

<%
	'Get Image
	'set rImg = server.createobject("ADODB.Recordset")
	'sqlCmd = "SELECT * FROM tblWebLogImages WHERE EntryID = " & rComments("UserID") & " AND Loc='Users'"
	'rImg.open sqlCmd, Application("ConnStr")
	'if rImg.eof = false then
	'	if rImg("iType") = "jpg" or rImg("iType") = "gif" then
	'		if rImg("iType") = "jpg" then
	'			Response.Write "<img name='profile' src='showjpg.asp?entryid=" & rComments("UserID") & "&type=users'"
	'		elseif rImg("iType") = "gif" then
	'			Response.Write "<img name='profile' src='showgif.asp?entryid=" & rComments("UserID") & "&type=users'"
	'		end if
	'		Response.Write ">&nbsp;&nbsp;"
	'	end if
	'else
	'	Response.Write "<img name='profile' src='../images/anonymous.gif' height=150>"
	'end if
	'/Get Image
%>
<table border="0" cellpadding="1" cellspacing="1">
<%
if Session("LoggedIn") = "true" then
%>
<tr><td><b>Real Name:</b></td><td><%=rComments("RealName")%></td></tr>
<tr><td><b>E-Mail:</b></td><td><a href="mailto:<%=rComments("EMail")%>"><%=rComments("EMail")%></a></td></tr>
<%
end if
%>
<tr><td width="135"><b>Website:</b></td><td> <a href="<%=rComments("Website")%>"><%=rComments("Website")%></a></td></tr>
<tr><td><b>Association:</b></td><td> <%=rComments("Relationship")%></td></tr>
<tr><td><b>Favourite Book:</b></td><td> <%=rComments("FavBook")%></td></tr>
<tr><td><b>Favourite Movie:</b></td><td> <%=rComments("FavMovie")%></td></tr>
<tr><td><b>Favourite Colour:</b></td><td> <%=rComments("FavColor")%></td></tr>
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
	Response.Write "<tr><td><b>Articles Posted:</b></td><td>" & count & "</td></tr>"

	set rCounts = server.createobject("ADODB.Recordset")
	sqlCmd = "SELECT * FROM tblComments WHERE UserID = " & rComments("UserID")
	rCounts.open sqlCmd, Application("ConnStr")
	count = 0
	do while rCounts.eof = false
		count = count + 1
		rCounts.movenext
	loop
	set rCounts = nothing
	Response.Write "<tr><td><b>Comments Posted:</b></td><td>" & count & "</td></tr>"
%>
<tr><td valign="top"><b>About me:</b></td><td> <%=rComments("Bio")%></td></tr>
<%
end if
%>
</table>
<br/>
<%
   	Response.Write "<b><a href='user-modify.asp?frame=" & Request.QueryString("frame") & "&userid=" & rComments("UserID") & "&siteid=" & request("siteid") & "' target='_self'>Change</a></b> "
%>
</body>
</html>
 
 
