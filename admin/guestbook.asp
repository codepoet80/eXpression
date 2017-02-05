<html>

<head>
<title><%=Application("SiteName")%>: guestbook</title>

<%
if Request.Form("txtName") <> "" then
	set wGuests = Server.CreateObject("ADODB.Connection")
	wGuests.Open Application("ConnStr")
	sqlCommand = "INSERT INTO tblGuestBook (GuestName, EntryDate, Comment) VALUES ('" & Replace(Request.Form("txtName"), "'", "''") & "','"
	sqlCommand = sqlCommand & Date & "','" & Replace(Request.Form("txtComment"), "'", "''") & "')"
	wGuests.Execute sqlCommand
	wGuests.close
	Response.Cookies("guestbook")("signed") = "yes"
	Response.Cookies("guestbook")("name") = Request.Form("txtName")
	Response.Cookies("guestbook").Expires = Date + 180
end if
%>

<script language="javascript">
function doSubmit()
{
	if (document.frmGuests.txtName.value == "")
		{ alert ("Please enter your name!") }
	else {
		if (document.frmGuests.txtComment.value == "")
			{
			alert ("Please enter a comment!")
			return;
			}
		else { document.frmGuests.submit() }
	}
}
</script>

<link rel="stylesheet" type="text/css" href="normal.css">

</head>

<body>
<p class="PageTitle">Guestbook</p>

<form name="frmGuests" method="post" action="guestbook.asp">
<table border="0" width="500" cellpadding="0">
  <tr>
    <td width="180">Your Name:</td>
    <td width="230"><input type="text" name="txtName" size="20"></td>
  </tr>
  <tr>
    <td width="180">Your Comment:<br>
      (8000 chars max, HTML OK)</td>
    <td width="230"><textarea rows="5" name="txtComment" cols="34"></textarea></td>
  </tr>
</table>
<input type="button" value="Post" name="cmdSubmit" onClick="doSubmit()">
</form>
<hr>
<p class="PageTitle">
Comments</p>
<%
set rGuests = Server.CreateObject("ADODB.Recordset")
sqlCommand = "SELECT * FROM tblGuestBook ORDER BY EntryID DESC"
rGuests.Open sqlCommand, Application("ConnStr")
do while rGuests.EOF = False
	Response.Write "<font style='font-family: Arial; font-size: 9pt'>"
	Response.Write "<b>" & rGuests("GuestName") & "</b> - " & rGuests("EntryDate") & "<br>"
	Response.Write rGuests("Comment") & "<p>"
	Response.Write "</font>"
	rGuests.MoveNext
loop
rGuests.Close
%>
</font>
</body>

</html>
 
 
