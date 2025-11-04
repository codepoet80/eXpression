<%@ Language="JScript" %>
<html>
<HEAD>
		<title>eXpression - Site List</title>
		<link rel="stylesheet" type="text/css" href="normal.css">
	</HEAD>
	<body>
		<!--#include file="headerJS.inc"-->
		<p class="PageTitle" style="margin-top:0px">eXpression - Site List</p>
	<%
	var fso, f, fc, s;
	var defaultURL = "";
	var found = false;

	//Banned IP Addresses
	if (Request.ServerVariables("REMOTE_ADDR") == "64.187.16.34")
	{
		Response.Redirect ("http://www.eff.org/~barlow/Declaration-Final.html");
	}
	fso = new ActiveXObject("Scripting.FileSystemObject");
	f = fso.GetFolder(Server.MapPath("../"));
	fc = new Enumerator(f.SubFolders);
	for (; !fc.atEnd(); fc.moveNext())
	{
	//Find XML file
		if (fso.FileExists((fc.item() + "/site.xml")))
		{
			//Read XML file
			var objXML = Server.CreateObject("Microsoft.XMLDOM");
			objXML.async = false;
			var vPath = fc.item() + "";
			var vPaths = vPath.split("\\");
			vPath = vPaths[vPaths.length-1];
			var checkLoad = objXML.load(fc.item() + "/site.xml");
			if (checkLoad)
			{
				var siteNum = fc.item() + "";
				siteNum = siteNum.split("_");
				siteNum = siteNum[siteNum.length-1];
				if (siteNum > 0)
				{
				Response.Write ("<b># " + siteNum + " - ");
				var sections = objXML.selectSingleNode("//Site");
				var pages = objXML.selectNodes("//add");
				
				Response.Write (sections.getAttribute("Name") + "</b><br>");
				Response.Write (fc.item() + "<br>");
				Response.Write (sections.getAttribute("BaseURL") + "<br>");
				Response.Write ("<a target='_blank' href='" + sections.getAttribute("defaultURL") + "'>" + sections.getAttribute("defaultURL") + "</a><br>");
				Response.Write ("<i>Style:</i> " + sections.getAttribute("defaultStyle") + "</a><br>");
				Response.Write ("<br>Pages and Links: " + pages.length+"<br>");

				sqlCommand = "SELECT * FROM tblTopics WHERE SiteID='" + siteNum + "'";
				us = Server.CreateObject("ADODB.Recordset");
				us.open (sqlCommand, Application("ConnStr"));
				var count=0;
				while (!us.EOF)
				{
					count++;
					us.MoveNext;
				}
				Response.Write ("Topics: "+ count + "<br>");
				sqlCommand = "SELECT * FROM tblWebLog WHERE SiteID='" + siteNum + "'";
				us = Server.CreateObject("ADODB.Recordset");
				us.open (sqlCommand, Application("ConnStr"));
				var count=0;
				while (!us.EOF)
				{
					count++;
					us.MoveNext;
				}
				Response.Write ("Posts: "+ count + "<br>");
				Response.Write ("<hr>");
				}
			}
		}
	}
%>	
	</body>

</html>
 
 
