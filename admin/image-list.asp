<html>
<head>
<title><%=Application("SiteName")%>: List Images</title>
<link rel="stylesheet" type="text/css" href="normal.css">
<script>
var imgPath;
function showPreview()
{
	imgPath = document.getElementById("lstImage").options[document.getElementById("lstImage").selectedIndex].value;
	document.getElementById("imgPreview").src = imgPath;
}
function chooseImage()
{
	if (imgPath != "none")
	{
		if (window.opener != null)
			window.opener.setImg(imgPath);
	}
}
</script>
</head>
<body style="border: 1px solid buttonface" onbeforeunload="chooseImage()">
<table border="0" width="100%" cellspacing="4">
<tr><td valign="top">
<select size="8" style="width:280; height:195" onchange="showPreview()" id="lstImage">
<option value="none" selected>None</option>
<%
	currPath = Server.MapPath("../site_" & Request.QueryString("siteid") & "/images")
	Dim fso, f, f1, fc, s
	Set fso = Server.CreateObject("Scripting.FileSystemObject")
	Set f = fso.GetFolder(currPath)
	Set fc = f.Files
	For Each f1 in fc
		if LCase(right(f1.name, 3)) = "jpg" or lCase(right(f1.name, 3)) = "gif" then
			%>
				<option value="../site_<%=Request.QueryString("siteid")%>/images/<%=f1.name%>"><%=f1.name%></option>
			<%
		end if
	Next
%>
</select>
</td>
<td valign="top" align="left" width="100%">
<img src="../images/none.jpg" id="imgPreview">
</td>
</tr></table>
</body>
</html>
 
 
