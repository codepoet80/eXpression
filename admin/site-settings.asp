<%@ LANGUAGE = JScript %>
<% Response.CacheControl = "no-cache" %>
<html>
<%
if (Session("LoggedIn") != "true")
	Response.Redirect("authenticate.asp?targetpage=pageEdit.asp?siteID=" + Request("siteID"))
else
	{
	sqlCommand = "SELECT * FROM tblAdmins WHERE SiteID = " + Request("siteID") + " AND UserID = " + Session("UserID")
	var rs = Server.CreateObject("ADODB.Recordset")
	rs.open (sqlCommand, Application("ConnStr"))
	if (rs.eof)
		Response.Redirect("authenticate.asp?targetpage=weblog-approve.asp?siteID=" + Request("siteID"))
	}
var currSite = Request("SiteID")
%>

<head>
<title><%=Application("SiteName")%>: Site Settings</title>
<link rel="stylesheet" type="text/css" href="normal.css">

<script>
	function showPreview()
	{
		document.getElementById("imgPreview").src = "../styles/" + document.getElementById("style").options[document.getElementById("style").selectedIndex].text + ".jpg";
	}
	
	var chooseImage;
	function addImage() 
	{ 
		chooseImage = window.open("image-list.asp?siteid=<%=Request("siteid")%>", "chooseImage", "height=260, width=580, menubar=no, resizable=yes, toolbar=no");
	}
	  
	function setImg(imgPath)
	{
		if (chooseImage != null)
			chooseImage.window.close();

		if(imgPath != null) 
		{
			imgPath = imgPath.replace("../site", "expression/site");
			document.getElementById("image").value = imgPath;
		}
	}
</script>
</head>
<%
	if (Request("action") == "save")
	{
		var objXML = Server.CreateObject("Microsoft.XMLDOM");
		objXML.async = false;
		var currPath = Server.MapPath("../site_" + Request("siteid"));
		var currURL = "../site_" + Request("siteid");
		var checkLoad = objXML.load(currPath + "/site.xml");
		if (checkLoad)
		{
			var items = objXML.selectSingleNode("//Site");
			items.setAttribute("Name", Request("sitename"));
			items.setAttribute("Description", Request("description"));
			items.setAttribute("BaseURL", Request("urls"));
			items.setAttribute("defaultURL", Request("url"));
			items.setAttribute("home", Request("homepage"));
			items.setAttribute("query", Request("query"));
			items.setAttribute("image", Request("image"));
			if (Request("style") == "custom")
				items.setAttribute("defaultStyle", "site_" + Request("siteID") + "/custom.xsl");			
			else
				items.setAttribute("defaultStyle", "styles/" + Request("style") + ".xsl");
			objXML.save(currPath + "/site.xml");
		}
	}
%>
<body class="PageBody" onload="showPreview()">

   <p class="PageTitle">
    Site Settings
	</p>
	<form name="frmTopics" method="post" action="site-settings.asp?siteid=<%=Request("siteID")%>">	
    <%
	var aItems = new Array();
	//Loop through all subdirectories
	var currPath = Server.MapPath("../site_" + Request("siteid"));
	var currURL = "../site_" + Request("siteid");

	//Read XML file
	var objXML = Server.CreateObject("Microsoft.XMLDOM");
	objXML.async = false;
	var checkLoad = objXML.load(currPath + "/site.xml");
	if (checkLoad)
	{
		var items = objXML.selectSingleNode("//Site");
		var sitename = items.getAttribute("Name");
		var description = items.getAttribute("Description");
		var urls = items.getAttribute("BaseURL");
		var url = items.getAttribute("defaultURL");
		var query = items.getAttribute("query");
		var homepage = items.getAttribute("home");
		var image = items.getAttribute("image");
		var style = items.getAttribute("defaultStyle");
	}
	%>
	<table cellpadding="0" cellspacing="0" border="0">
    <tr><td><b>Site Title:</b> </td><td><input type="text" name="sitename" value="<%=sitename%>" size="25"></td>
    <tr><td><b>Description:</b> </td><td><input type="text" name="description" value="<%=description%>" size="50"></td>
    <tr><td><b>Domains:</b> </td><td><input type="text" name="urls" value="<%=urls%>" size="50"> (comma, no space delimiter)</td>
    <tr><td><b>Default URL:</b> </td><td><input type="text" name="url" value="<%=url%>" size="50"></td>
    <tr><td><b>Homepage</b> </td><td><input type="text" name="homepage" value="<%=homepage%>" size="50"> (advanced!)</td>
    <tr><td><b>Query:</b> </td><td><input type="text" name="query" value="<%=query%>" size="50"> (advanced!)</td>
    <tr><td><b>Default Image:</b> </td><td><input type="text" id="image" name="image" value="<%=image%>" size="50"><input type="button" value="Choose" onclick="addImage()"/></td>
    </table>
    <b>Style:</b><br/>
    <table><tr>
	<td valign="top">
	<select size="5" style="width:150px" onchange="showPreview()" id="style" name="style">
		<%
		var aItems = new Array();
		//Loop through all subdirectories
		var fso, f, fc, s;
		var currPath = Server.MapPath("../styles");
		
		fso = new ActiveXObject("Scripting.FileSystemObject");
		f = fso.GetFolder(currPath);
		fc = new Enumerator(f.Files);
		var found = false;
		for (; !fc.atEnd(); fc.moveNext())
		{
			if (fc.item().type == "XSL Stylesheet")	
			{
				var currStyle = fc.item().name;
				currStyle = currStyle.split(".");
				currStyle = currStyle[0];
				Response.Write ("<option value='" + currStyle + "'");
				if ("styles/" + currStyle + ".xsl" == style)
				{
					Response.Write (" selected ");
					found = true;
				}
				Response.Write (">" + currStyle + "</option>");
			}
		}
		Response.Write ("<option value=")
		if (!found)
			Response.Write ("'custom' selected")
		else
			Response.Write ("'custom'")
		Response.Write (">Custom</option>")
		
		%>
	</select>
	</td>
	<td>&nbsp;&nbsp;</td>
	<td valign="bottom">
		<img src="../images/none.jpg" height="184" width="250" id="imgPreview"/>
	</td>
	</tr></table>
    <input type="hidden" name="action" value="none">
    <br/><input type="button" name="save" value="Save" onclick="frmTopics.action.value='save';frmTopics.submit()">
    </form>
</body>

</html>
 
 
