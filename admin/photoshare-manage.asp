<html>
<%
if Session("LoggedIn") <> "true" then
	Response.Redirect("authenticate.asp?targetpage=photoshare-manage.asp?siteID=" & Request("siteID"))
else
	'See if this user is an admin for this site
	sqlCommand = "SELECT * FROM tblAdmins WHERE SiteID = " & Request("siteID") & " AND UserID = " & Session("UserID")
	set rs = Server.CreateObject("ADODB.Recordset")
	rs.open sqlCommand, Application("ConnStr")
	if rs.eof = true then
		Response.Redirect("authenticate.asp?targetpage=photoshare-manage.asp?siteID=" & Request("siteID"))
	end if
end if
%>
<head>
<title><%=Application("SiteName")%>: Manage Images</title>
<script language="javascript" src="../../../jsObjects/jsUI-Global/common.js"></script>
<script language="javascript" src="../../../jsObjects/jsDA-wsBind/component.js"></script>
<script language="javascript" src="../../../photoshare/photoshare.js"></script>
<script>
var myws = new Object();
var mwspath;
var picturePath;
function initws()
{
	picturePath = "\\expression\\site_<%=Request.QueryString("siteid")%>\\pictures";
	try
	{
		wspath = "http://" + document.location.host + "/photoshare/photoshare.asmx";
		myws = wsbindNew("myws", wspath);
		if (!myws)
			alert ("Unable to bind to a remote webservice (the webservice host is different than this page host).\nIf your sure you want to allow this interaction, please make the appropriate security setting changes in your browser.");
		else
		{
			fillList(picturePath);
		}
	}
	catch(e)
	{
		document.getElementById("divItems").innerHTML = "<i>Your browser is not capable of displaying our pictures...</i>";
	}
}

function DoUpload() 
{
	theFeats = "height=120,width=500,location=no,menubar=no,resizable=no,scrollbars=no,status=no,toolbar=no";
	theUniqueID = (new Date()).getTime() % 1000000000;
	window.open("progressbar.asp?ID=" + theUniqueID, theUniqueID, theFeats);
	document.myform.action = 'photoshare-manage.asp?siteid=<%=Request.QueryString("siteid")%>&ID=' + theUniqueID;
	document.myform.submit();
}

function fillList(path)
{
	window.scrollTo(0,0);
	var pathName = path.split("\\");
	pathName = pathName[pathName.length-1];

	path = urlEncode(path);
		
	var fileList = myws.ListFiles(path, "");
	document.getElementById("divItems").innerHTML = "";
	if (document.all)
	{
		var xmlDoc = new ActiveXObject("MSXML2.DOMDocument");
		xmlDoc.async = false;
		if (xmlDoc.loadXML(fileList))
		{
			var items = xmlDoc.selectNodes("//Item");
			for (var i=0;i<items.length;i++)
			{
				dirPath = replace(path, "\\", "\\\\") + "\\\\" + urlEncode(items[i].attributes.getNamedItem("Name").value);
				if (items[i].attributes.getNamedItem("Type").value == "folder")
					document.getElementById("divItems").innerHTML += "<a href=javascript:doDelete(\"" + urlEncode(items[i].attributes.getNamedItem("Name").value) + "\")><img alt='Delete this album' src='../images/delete.gif' align='absmiddle' border='0'></a> " + items[i].attributes.getNamedItem("Name").value + "<br/>";
				else if (items[i].attributes.getNamedItem("Type").value == "jpg" || items[i].attributes.getNamedItem("Type").value == "gif")
					drawImage(items[i].attributes.getNamedItem("Path").value, items[i].attributes.getNamedItem("Date").value, items[i].attributes.getNamedItem("Size").value);
			}
			var pathParts = path.split("\\");
			var parentPath = "";
			var foundRoot = false;
			for (var p=0;p<pathParts.length-1;p++)
			{
				if (pathParts[p] == "pictures")
				{
					pathParts[p] = picturePath;
					foundRoot = true;
				}
				if (foundRoot)
					parentPath += pathParts[p] + "\\";
			}
		}
		else
			document.getElementById("divItems").innerHTML = "Could not load pictures";
	}
	else
	{
		try
		{
			xmlParser = new DOMParser();
			xmlDoc = xmlParser.parseFromString(fileList, 'text/xml');
			document.getElementById("divItems").innerHTML = "";
			items = xmlDoc.getElementsByTagName("Item");
			for (var e=0;e<items.length;e++)
			{
				dirPath = replace(path, "\\", "\\\\") + "\\\\" + urlEncode(items[e].getAttribute("Name"));
				if (items[e].getAttribute("Type") == "folder")
					document.getElementById("divItems").innerHTML += "<a href=javascript:doDelete(\"" + urlEncode(items[e].getAttribute("Name")) + "\")><img alt='Delete this album' src='../images/delete.gif' align='absmiddle' border='0'></a> " + items[e].getAttribute("Name") + "<br/>";
				else if (items[e].getAttribute("Type") == "jpg" || items[e].getAttribute("Type") == "gif")					
					drawImage(items[e].getAttribute("Path"), items[e].getAttribute("Date"), items[e].getAttribute("Size"));
			}
			var pathParts = path.split("\\");
			var parentPath = "";
			var foundRoot = false;
			for (var p=0;p<pathParts.length-1;p++)
			{
				if (pathParts[p] == "pictures")
				{
					pathParts[p] = picturePath;
					foundRoot = true;
				}
				if (foundRoot)
					parentPath += pathParts[p] + "\\";
			}
		}
		catch(e)
		{
			document.getElementById("divItems").innerHTML = "Could not load pictures";
		}
	}
}
function doDelete(path)
{
	if (confirm("Are you sure you want to do this?!\nDeleting an album cannot be undone and all it's pictures will be lost!!"))
		document.location = "photoshare-manage.asp?siteid=<%=Request.QueryString("siteid")%>&folder=" + urlEncode(path) + "&action=delete";
}
</script>
<link rel="stylesheet" type="text/css" href="normal.css">

</head>
<body marginheight="0" marginwidth="0" topmargin="0" leftmargin="0" onload="setTimeout('initws()', 500)">
<p class="PageTitle">Upload an Album</p>
<%
Response.Expires = -10000
Server.ScriptTimeOut = 4200
Set upl = Server.CreateObject("ABCUpload4.XForm")
upl.ID = Request.QueryString("ID")
upl.Overwrite = True
upl.MaxUploadSize = 52428800

if Len(upl("imgPath")) > 0 then
	set ImageField = upl("imgPath")(1)
	ImageData = ImageField.Data
	ImageType = right(ImageField.FileName, 3)
	ImageName = ImageField.FileName

	if ImageType <> "zip" then
		Response.Write "This file type cannot be uploaded! Please use only Zip archives."
	else
		If ImageField.FileExists Then 
			if ImageField.Length > 52428800 then
				Response.Write "The album you are uploading is too large. Please split it into multiple albums."
			else
				ImageField.Save "../site_" + Request.QueryString("siteid") + "/pictures/" + ImageName
				folderName = replace(ImageName, "_", " ")
				folderName = replace(folderName, "." + ImageType, "")
				Dim fs
				Set fs=Server.CreateObject("Scripting.FileSystemObject")
				if fs.FolderExists(newFolder & "\" & folderName)=false then
					newFolder = Server.MapPath("../Site_" & Request.QueryString("siteid") & "/pictures")
					fs.CreateFolder newFolder & "\" & folderName
					Response.Write "<img src='../images/check.gif' align='absmiddle'> Created album folder: " & newFolder & "\" & folderName & "<br>"
			
					Dim objZip
					Set objZip = Server.CreateObject("XStandard.Zip")
					objZip.UnPack Server.MapPath("../site_" + Request.QueryString("siteid") + "/pictures/" + ImageName), newFolder & "\" & folderName
					Set objZip = Nothing
					Response.Write "<img src='../images/check.gif' align='absmiddle'> Unzipped archive: " & ImageName & "<br>"
					
					fs.DeleteFile Server.MapPath("../site_" + Request.QueryString("siteid") + "/pictures/" + ImageName)
					Response.Write "<img src='../images/check.gif' align='absmiddle'> Cleaned up archive: " & ImageName & "<br>"
					
					if fs.FolderExists(newFolder & "\" & folderName & "\__MACOSX")=true then
						fs.DeleteFolder newFolder & "\" & folderName & "\__MACOSX"
						Response.Write "<img src='../images/check.gif' align='absmiddle'> Cleaned up Mac Data <br>"
					end if
				else
					Response.Write "<i>Error: An album with this name already exists.</i><br>"
				end if
				
				Response.Write "<br>"
				set fs=nothing
			end if
		End If
	end if
end if
%>
<form name="myform" method="post" action="photoshare-manage.asp?siteid=<%=Request.QueryString("siteid")%>" enctype="multipart/form-data">
<b>Choose Zipped Album:</b><br>
<input type="file" name="imgPath" size="35"></p><p>
<input type="button" name="dosubmit" value="Upload" onclick="DoUpload()">
<br><br>
</form>
</p>
<p class="PageTitle">PhotoShare Albums</p>
<%
if Request.QueryString("action") = "delete" then
	folderPath = replace(Request.QueryString("folder"), ",", "%2C")
	picturePath = "\expression\site_" & Request.QueryString("siteid") & "\pictures"
	folderPath = Server.MapPath(picturePath & "\" & folderPath)
	folderPath = replace(folderPath, "%2C", ",")
	Dim fso
	Set fso=Server.CreateObject("Scripting.FileSystemObject")
	fso.DeleteFolder folderPath
	set fso = nothing
	Response.Write "<img src='../images/check.gif' align='absmiddle'> Deleted album: " + folderPath + "<br/>&nbsp;<br/>"
end if
%>
<div id="divItems" style="width: 100%;">
<br/><i>Loading Image List...</i>
</div>
<div id="divNav" class="PostFooter"></div>
</body>
</html>
 
 
