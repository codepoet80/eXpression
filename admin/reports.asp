<%@ LANGUAGE = JScript %>
<% Response.CacheControl = "no-cache" %>
<html>
<%
if (Session("LoggedIn") != "true")
	Response.Redirect("authenticate.asp?targetpage=reports.asp?siteID=" + Request("siteID"))
else
	{
	sqlCommand = "SELECT * FROM tblAdmins WHERE SiteID = " + Request("siteID") + " AND UserID = " + Session("UserID")
	var rs = Server.CreateObject("ADODB.Recordset")
	rs.open (sqlCommand, Application("ConnStr"))
	if (rs.eof)
		Response.Redirect("authenticate.asp?targetpage=reports.asp?siteID=" + Request("siteID"))
	}
var currSite = Request("SiteID")
%>
	<head>
		<title>
			<%=Application("SiteName")%>
			: Reports</title>
		<link rel="stylesheet" type="text/css" href="normal.css">
			<base target="_self">
	</head>
	<body>
		<p class="PageTitle">
    Site Reports
	</p>
		<ul>
		Note: Report totals are starting from October 22, 2004<br/>&nbsp;
		<%
		//Loop through all subdirectories
		var currPath = Server.MapPath("../site_" + Request("siteid"));
		var currURL = "../site_" + Request("siteid");

		//Read XML file
		var objXML = Server.CreateObject("Microsoft.XMLDOM");
		objXML.async = false;
		var checkLoad = objXML.load(currPath + "/site.xml");
		if (checkLoad)
		{
			var items = objXML.selectNodes("//Reports/report");
			for (var i=0;i<items.length;i++)
			{	
				if (items[i].getAttribute("type") == "detail")
					Response.Write ("<li><a href=\"report-detail.asp?siteid=" + Request("siteid") + "&sqlcommand=" + Server.URLEncode(items[i].text) + "\">" + items[i].getAttribute("name") + "</a></li>")
			}
		}
		%>
		</ul>
	</body>
</html>

 
 
