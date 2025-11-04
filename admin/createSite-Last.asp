<%@ LANGUAGE = JScript %>
<% Response.CacheControl = "no-cache" %>
<html>
<%
if (Session("LoggedIn") != "true")
	Response.Redirect("authenticate.asp?targetpage=createSite-1.asp")
%>
	<head>
		<title>eXpression - Create Site</title>
		<link rel="stylesheet" type="text/css" href="normal.css">
	</head>
	<body>
<!--#include file="headerJS.inc"-->
		<p class="PageTitle" style="margin-top:0px">eXpression - Site Creation</p>
		<%
		
		// Create Folder
		fso = new ActiveXObject("Scripting.FileSystemObject");
		f = fso.GetFolder(Server.MapPath("../"));
		fc = new Enumerator(f.SubFolders);
		var highNum = 0;
		for (; !fc.atEnd(); fc.moveNext())
		{
			if (fc.item().name.indexOf("_") != -1)	
			{
				var currFolder = fc.item().name.split("_");
				if (currFolder[1] * 1 > highNum)
					highNum = currFolder[1] * 1;
			}
		}
		highNum ++;
		newFolder = Server.MapPath("../Site_" + highNum);
		fso.CreateFolder(newFolder);
		Response.Write ("<img src='../images/check.gif' align='absmiddle'> Created folder: " + newFolder + "<br>");
		
		// Create Images Directory
		fso.CreateFolder(newFolder + "/images");
		Response.Write ("<img src='../images/check.gif' align='absmiddle'> Created folder: " + newFolder + "/images<br>");
		
		// Create PhotoShare Directory
		fso.CreateFolder(newFolder + "/Pictures");
		Response.Write ("<img src='../images/check.gif' align='absmiddle'> Created PhotoShare folder: " + newFolder + "/pictures<br>");
		
		// Create PhotoShare Directory
		fso.CreateFolder(newFolder + "/Documents");
		Response.Write ("<img src='../images/check.gif' align='absmiddle'> Created Documents folder: " + newFolder + "/documents<br>");

		// Create XML file
		fso.CopyFile (Server.MapPath("../setup/site.xml"), newFolder + "/site.xml");
		Response.Write ("<img src='../images/check.gif' align='absmiddle'> Created XML file<br>");
		
		// Create XSL file
		fso.CopyFile (Server.MapPath("../styles/grayBlue.xsl"), newFolder + "/custom.xsl");
		Response.Write ("<img src='../images/check.gif' align='absmiddle'> Created XSL file<br>");
		
		// Modify XML file
		var objXML = Server.CreateObject("Microsoft.XMLDOM");
		objXML.async = false;
		var checkLoad = objXML.load(newFolder + "/site.xml");
		if (checkLoad)
		{
			var items = objXML.selectSingleNode("//Site");
			items.setAttribute("Name", Request("SiteTitle"));
			items.setAttribute("Description", Request("Description"));
			items.setAttribute("BaseURL", Request("URL"));
			items.setAttribute("defaultURL", "http://" + Request("URL"));
			if (Request("commercial") == "true")
			{
				items.setAttribute("query", "getWebPageTransformed?blogID=" + highNum + "&page=" + Request("Page") + ".htm&style=&contentType=HTML&privateKey=0");
				items.setAttribute("type", "commercial");
			}
			else
			{
				items.setAttribute("query", "getBlogTransformed?blogID=" + highNum + "&topicID=&startDate=&entries=&style=&contentType=HTML&privateKey=0");
				items.setAttribute("type", "personal");
			}
				
			//items.setAttribute("image", Request("image"));
			if (Request("cmbStyles") != "custom")
				items.setAttribute("defaultStyle", "styles/" + Request("cmbStyles") + ".xsl");
			else
				items.setAttribute("defaultStyle", "site_" + highNum + "/custom.xsl");
				
			linkXML = "<Links>"
			if (Request("Page") != "")
			{
				linkXML += "<add pos='1' value='" + Request("Page") + "' key='" + Request("Page") + ".htm'/>"
			}
			linkXML += "</Links>"
			
			var objXML2 = Server.CreateObject("Microsoft.XMLDOM");
			objXML2.async = false;
			var checkLoad = objXML2.loadXML(linkXML);
			linkNode = objXML2.selectSingleNode("//Links");
			items.appendChild(linkNode);
			
			reportXML = "<Reports>"
			if (Request("Page") != "")
			{
				reportXML += "<report name='Home Page Counter' type='detail'>SELECT Count(*) as Hits FROM InternetLog WHERE target='//expression//images//expression.gif' AND parameters='siteid=" + highNum + "'</report>"
			}
			reportXML += "</Reports>"
			
			var objXML2 = Server.CreateObject("Microsoft.XMLDOM");
			objXML2.async = false;
			var checkLoad = objXML2.loadXML(reportXML);
			reportNode = objXML2.selectSingleNode("//Reports");
			items.appendChild(reportNode);
			
			objXML.save(newFolder + "/site.xml");
			
		}
		Response.Write ("<img src='../images/check.gif' align='absmiddle'> Set-up XML file<br>");
		
		// Create Page
		if (Request("Page") != "")
		{
			var fso = new ActiveXObject("Scripting.FileSystemObject");
			var ts = fso.OpenTextFile(newFolder + "/" + Request("Page") + ".htm",2,true);
			ts.WriteLine("<h2>" + Request("Page") + "</h2>");
			ts.Close();
			Response.Write ("<img src='../images/check.gif' align='absmiddle'> Created page: " + newFolder + "/" + Request("Page") + ".htm<br>");
		}		
		
		// Create Topic
		sqlCommand = "INSERT INTO tblTopics (TopicName, SiteID) VALUES ('" + Request("Topic") +"', '" + highNum + "')"
		us = Server.CreateObject("ADODB.Connection")
		us.open (Application("ConnStr"));
		us.execute (sqlCommand)
		sqlCommand = ""
		Response.Write ("<img src='../images/check.gif' align='absmiddle'> Created topic: " + Request("Topic") + "<br/>");
		
		// Create Admins
		sqlCommand = "INSERT INTO tblAdmins (SiteID, UserID) VALUES (" + highNum + ", 1)"
		us.execute (sqlCommand)
		if (Session("UserID") != 1 && Session("UserID") != "1")
			sqlCommand = "INSERT INTO tblAdmins (SiteID, UserID) VALUES (" + highNum + ", " + Session("UserID") + ")"
		us.execute (sqlCommand)
		Response.Write ("<img src='../images/check.gif' align='absmiddle'> Created site administrator" + "<br/>");
		us.close
		
		// E-Mail Me
		try
		{
			var rs = Server.CreateObject("ADODB.Recordset");
			sqlCommand = "SELECT * FROM tblUsers WHERE UserID = '" + Session("UserID") + "'";
			rs.open (sqlCommand, Application("ConnStr"));
			var username, realname,	useremail
			if (!rs.eof)
			{
				realname = rs("RealName")
				username = rs("Username")
				useremail = rs("EMail")
			}
			
			var mailCopy = useremail;
			var mailSubject = "New eXpression site created!";
			var mailBody = username + " has created a new eXpression website (number " + highNum + ")! The following domain name needs to be registered or confirmed...<br>"
			mailBody += "http://" + Request("URL") + "<br><br>"
			mailBody += realname + ", domain name activation can take up to 24 hours. You will receive an e-mail when your site is working.<br>"
		
			requestString = "messageData=" + mailBody;
			requestString += "&messageSubject=" + mailSubject;
			requestString += "&copyEMail=" + mailCopy;
	
			var xmlhttp = Server.CreateObject("MSXML2.ServerXMLHTTP.3.0");
			xmlhttp.open ("POST", "http://" + Request.ServerVariables("LOCAL_ADDR") + "/expression/expression.asmx/notifyAdmin", false);
			xmlhttp.setRequestHeader ("Content-Type", "application/x-www-form-urlencoded");
			xmlhttp.send (requestString);
			
			if (xmlhttp.responseText.indexOf("Mail Sent") != -1)
				Response.Write ("<img src='../images/check.gif' align='absmiddle'> Sent activation request" + "<br/>");
			else
				Response.Write ("<img src='../images/delete.gif' align='absmiddle'> Could not e-mail activiation request. Please e-mail the administrator to request your site be enabled." + "<br/>");
		}
		catch(e)
		{
			Response.Write ("<img src='../images/delete.gif' align='absmiddle'> Could not e-mail activiation request. Please e-mail the administrator to request your site be enabled." + "<br/>");
		}
		%>
		<p class="PageTitle">New Site Access</p>
		<b>Domain Activation</b><br/>
		Your domain name likely still needs to be created. An attempt will be made to activate your site at the address:<br/>
		<a target="_blank" href="http://<%=Request("URL")%>">http://<%=Request("URL")%></a><br/>
		Or<br/>
		<a target="_blank" href="http://<%=Request("URL")%>/expression">http://<%=Request("URL")%>/expression</a><br/>
		<br/>
		If the domain name is already in use, you may be asked to select another name. If you've previously activated the domain or are using your own, the link should be active and you can begin using your site immediately.<br/>
		<br/>
		<b>Viewing and Managing</b><br/>
		Until your domain is active, you can view your site <a target="_blank" href="http://<%=Application("adminRoot")%>/expression/expression.asmx/getBlogTransformed?blogID=<%=highNum%>&topicID=&startDate=&entries=&style=&contentType=HTML&privateKey=0">here</a>.<br/>
		You can edit your site <a target="_blank" href="http://<%=Application("adminRoot")%>/expression/admin/?siteid=<%=highNum%>">here</a>, or by clicking "Manage Site" on your homepage.<br/>
		<br/>
		<b>Thanks for using eXpression!</b><br/>
		<a target="_top" href="http://<%=Application("adminRoot")%>/expression/expression.asmx/getBlogTransformed?blogID=<%=highNum%>&topicID=&startDate=&entries=&style=&contentType=HTML&privateKey=0">Go to your new site</a>!
	</body>
</html>

 
 
