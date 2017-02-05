<html>
<head>
<title><%=Application("SiteName")%>: List Files</title>
<link rel="stylesheet" type="text/css" href="normal.css">
<script>
var imgPath;
function showActions()
{
	imgPath = document.getElementById("lstImage").options[document.getElementById("lstImage").selectedIndex].value;
	if (document.getElementById("lstImage").options[document.getElementById("lstImage").selectedIndex].value != "none")
		document.getElementById("actions").style.display = "block";
	else
		document.getElementById("actions").style.display = "none";
}
function doDelete()
{
	document.location = "file-list.asp?siteid=<%=Request.QueryString("siteid")%>&action=delete&file=" + document.getElementById("lstImage").options[document.getElementById("lstImage").selectedIndex].value;
}
function chooseImage()
{
	/*
	if (imgPath != "none")
	{
		if (window.opener != null)
			window.opener.setFile(imgPath);
	}
	*/
}
</script>
<%
	Dim fso
if Request.QueryString("action") = "delete" then
	filePath = replace(Request.QueryString("file"), ",", "%2C")
	filePath = Server.MapPath(filePath)
	Set fso=Server.CreateObject("Scripting.FileSystemObject")
	fso.DeleteFile filePath
	Response.Write "&nbsp;<img src='../images/check.gif' align='absmiddle'> Deleted File: " & filePath
	set fso = nothing
end if
%>
</head>
<body style="border: 1px solid buttonface" onbeforeunload="chooseImage()">
<table border="0" width="100%" cellspacing="4">
<tr><td valign="top">
<select size="8" style="width:280; height:195" id="lstImage" onchange="showActions()">
<option value="none" selected>None</option>
<%
	currPath = Server.MapPath("../site_" & Request.QueryString("siteid") & "/documents")
	Dim f, f1, fc, s
	Set fso = Server.CreateObject("Scripting.FileSystemObject")
	Set f = fso.GetFolder(currPath)
	Set fc = f.Files
	For Each f1 in fc
			%>
				<option value="../site_<%=Request.QueryString("siteid")%>/documents/<%=f1.name%>"><%=f1.name%></option>
			<%
	Next
%>
</select>
</td>
<td valign="top" align="left" width="100%">
<span id="actions" style="display:none">
	<a href="javascript:doDelete()" target="_self">
		<img align="absmiddle" src="../images/delete.gif" id="imgPreview" border="0"> Delete File</span>
	</a>
</td>
</tr></table>
</body>
</html>
 
 
