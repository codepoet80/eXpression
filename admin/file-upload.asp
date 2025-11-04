<html>
<%
if Session("LoggedIn") <> "true" then
	Response.Redirect("authenticate.asp?targetpage=file-upload.asp?siteID=" & Request("siteID"))
else
	'See if this user is an admin for this site
	sqlCommand = "SELECT * FROM tblAdmins WHERE SiteID = " & Request("siteID") & " AND UserID = " & Session("UserID")
	set rs = Server.CreateObject("ADODB.Recordset")
	rs.open sqlCommand, Application("ConnStr")
	if rs.eof = true then
		Response.Redirect("authenticate.asp?targetpage=file-upload.asp?siteID=" & Request("siteID"))
	end if
end if
%>
<head>
<title><%=Application("SiteName")%>: Manage Files</title>
<link rel="stylesheet" type="text/css" href="normal.css">

</head>
<body marginheight="0" marginwidth="0" topmargin="0" leftmargin="0">
<p class="PageTitle">Upload a File</p>
<%

Set upl = Server.CreateObject("ABCUpload4.XForm")
if Len(upl("imgPath")) > 0 then
	set ImageField = upl("imgPath")(1)
	ImageData = ImageField.Data
	ImageType = right(ImageField.FileName, 3)
	ImageName = ImageField.FileName
	upl.Overwrite = True
	upl.MaxUploadSize = 5242880
	If ImageField.FileExists Then
		if ImageField.Length > 5242880 then
			Response.Write "The file you are uploading is too large. Please use a smaller file."
		else
			ImageField.Save "../site_" + Request.QueryString("siteid") + "/documents/" + ImageName
			Response.Write "<i>Upload complete.</i><br/>"
		end if
	End If
end if
%>
<form name="myform" method="post" action="file-upload.asp?siteid=<%=Request.QueryString("siteid")%>" enctype="multipart/form-data">
<b>Choose File:</b><br>
<input type="file" name="imgPath" size="35"></p><p>
<input type="submit" name="dosubmit" value="Upload" ID="Submit1">
<br><br>
</form>
</p>
<p class="PageTitle">My Files</p>
<iframe border="0" style="margin-left: -15px" src="file-list.asp?siteid=<%=Request.QueryString("siteid")%>&type=showOnly" width="100%" height="300"></iframe>
</body>
</html>
 
 
