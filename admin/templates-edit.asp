<%@ LANGUAGE = JScript %>
<% Response.CacheControl = "no-cache" %>
<html>
<%
if (Session("LoggedIn") != "true")
	Response.Redirect("authenticate.asp?targetpage=template-edit.asp?siteID=" + Request("siteID"))
else
	{
	sqlCommand = "SELECT * FROM tblAdmins WHERE SiteID = " + Request("siteID") + " AND UserID = " + Session("UserID")
	var rs = Server.CreateObject("ADODB.Recordset")
	rs.open (sqlCommand, Application("ConnStr"))
	if (rs.eof)
		Response.Redirect("authenticate.asp?targetpage=template-edit.asp?siteID=" + Request("siteID"))
	}
var currSite = Request("SiteID")
%>

<head>
<title><%=Application("SiteName")%>: edit templates</title>
<link rel="stylesheet" type="text/css" href="normal.css">
<script>
function replace(oldString, findString, subString)
{
	stringParts = oldString.split(findString)
	newString = "";
	for (s=0;s<stringParts.length;s++)
	{
		newString += stringParts[s]
		if (s < stringParts.length - 1)
			newString += subString;
	}	
	return newString;
}

function doSave()
{
	frmTopics.action.value="save";
	if (confirm("Are you sure you want to do this?!\nIf your XML is not valid your website will not function, be sure this is perfect before you submit it!!"))
	{
		frmTopics.templatedata.value = replace(frmTopics.templatedata.value, "&", "&amp;");
		frmTopics.submit();
	}
}
function changeTemplate()
{
	frmTopics.action.value = "change";
	frmTopics.submit();
}

</script>
</head>

<body>

   <p class="PageTitle">
    Edit Templates
	</p>
<%
	if (Request("action") == "save")
	{
		var fso = new ActiveXObject("Scripting.FileSystemObject");
		var objXML = Server.CreateObject("Microsoft.XMLDOM");
		objXML.async = false;
		var templatedata = Request("templatedata");
		var checkLoad = objXML.loadXML(templatedata);
		if (checkLoad)
		{
			var ts = fso.OpenTextFile(Server.MapPath(Request("pages")),2,false);
			ts.WriteLine(templatedata);
			ts.Close();
		}
		if (!checkLoad)
		{
			Response.Write ("<i>Your XML was not well-formed! In order to avoid wrecking your site, your changes have not been saved</i>");
		}
	}
%>
	<form name="frmTopics" method="post" action="templates-edit.asp?siteid=<%=Request("siteID")%>">
	<b>Template</b>: <select name="pages" onchange="changeTemplate()">
	<option value="none">Choose...</option>
    <%
	var aItems = new Array();
	//Loop through all subdirectories
	var fso, f, fc, s;
	var currPath = Server.MapPath("../site_" + Request("siteid"));
	var currURL = "../site_" + Request("siteid");
	
	fso = new ActiveXObject("Scripting.FileSystemObject");
	f = fso.GetFolder(currPath);
	fc = new Enumerator(f.Files);
	var CurrSection = 0;
	for (; !fc.atEnd(); fc.moveNext())
	{
		if (fc.item().type == "XSL Stylesheet")	
		{
			Response.Write ("<option value='" + currURL + "/" + fc.item().name + "'");
			if (currURL + "/" + fc.item().name == Request("pages"))
				Response.Write (" selected ");
			Response.Write (">" + fc.item().name + "</option>");
		}
	}
	%>
    </select>
    &nbsp;
    <p/>
    <textarea cols="50" rows="20" name="templatedata" style="width:100%"><%
    if (Request("pages") != "none" && (Request("action") == "change" || Request("action") == "save"))
    {
		var fso = new ActiveXObject("Scripting.FileSystemObject");
		var ts = fso.OpenTextFile(Server.MapPath(Request("pages")),1,false);
		while (!ts.AtEndOfStream) {
		Response.Write(ts.ReadLine() + "\n");
		}
    }
    %></textarea>
    <br/>
    <input type="button" name="save" value="Save" onclick="doSave()">
    <input type="hidden" name="action">
    </form>
</body>

</html>
 
 
