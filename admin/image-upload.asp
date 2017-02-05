<html>
<%
if Session("LoggedIn") <> "true" then
	Response.Redirect("authenticate.asp?targetpage=image-upload.asp?siteID=" & Request("siteID"))
else
	'See if this user is an admin for this site
	sqlCommand = "SELECT * FROM tblAdmins WHERE SiteID = " & Request("siteID") & " AND UserID = " & Session("UserID")
	set rs = Server.CreateObject("ADODB.Recordset")
	rs.open sqlCommand, Application("ConnStr")
	if rs.eof = true then
		Response.Redirect("authenticate.asp?targetpage=image-upload.asp?siteID=" & Request("siteID"))
	end if
end if
%>
<head>
<title><%=Application("SiteName")%>: Manage Images</title>
<link rel="stylesheet" type="text/css" href="normal.css">

</head>
<body marginheight="0" marginwidth="0" topmargin="0" leftmargin="0">
<p class="PageTitle">Upload a Picture</p>
<%

Set upl = Server.CreateObject("ABCUpload4.XForm")
if Len(upl("imgPath")) > 0 then
	set ImageField = upl("imgPath")(1)
	ImageData = ImageField.Data
	ImageType = right(ImageField.FileName, 3)
	ImageName = ImageField.FileName
	if ImageType <> "jpg" and ImageType <> "gif" then
		Response.Write "This file type cannot be uploaded! Please use only JPG or GIF images."
	else
		upl.Overwrite = True
		upl.MaxUploadSize = 512000
		If ImageField.FileExists Then
			if ImageField.Length > 512000 then
				Response.Write "The image you are uploading is too large. Please use a smaller image."
			else
				ImageField.Save "../site_" + Request.QueryString("siteid") + "/images/" + ImageName
				Response.Write "<i>Upload complete.</i><br/>"
			end if
		End If
	end if
end if
%>
<form name="myform" method="post" action="image-upload.asp?siteid=<%=Request.QueryString("siteid")%>" enctype="multipart/form-data">
<b>Choose Picture:</b><br>
<input type="file" name="imgPath" size="35"></p><p>
<input type="submit" name="dosubmit" value="Upload" ID="Submit1">
<br><br>
</form>
</p>
<p class="PageTitle">My Pictures</p>
<iframe border="0" style="margin-left: -15px" src="image-list.asp?siteid=<%=Request.QueryString("siteid")%>&type=showOnly" width="100%" height="300"></iframe>
</body>
</html>
 
 
