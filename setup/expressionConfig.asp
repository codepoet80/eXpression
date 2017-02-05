<%@ LANGUAGE = JScript %>
<HTML>
	<HEAD>
		<title>eXpression Server Configuration</title>
		<% Response.CacheControl = "no-cache" %>
		<LINK href="../admin/normal.css" type="text/css" rel="stylesheet">
			
	</HEAD>
	<body class="PageBody">
		<!--#include file="../admin/headerJS.inc"-->
		<p class="PageTitle" style="MARGIN-TOP:0px">
			Site Settings
		</p>
		
		<%
			if (Request("action") == "save")
			{
				try
				{
					var objXML = Server.CreateObject("Microsoft.XMLDOM");
					objXML.async = false;
					var currPath = Server.MapPath("../");
					var checkLoad = objXML.load(currPath + "/web.config");
					if (checkLoad)
					{
						var keys = objXML.selectNodes("//appSettings/add");
						for (var k=0;k<keys.length;k++)
						{
							if (keys[k].getAttribute("key") == "serverRoot")
								keys[k].setAttribute("value", Request("serverRoot"));
							if (keys[k].getAttribute("key") == "serverName")
								keys[k].setAttribute("value", Request("serverName"));
							if (keys[k].getAttribute("key") == "ASPConnString")
								keys[k].setAttribute("value", Request("ASPConnString"));
							if (keys[k].getAttribute("key") == "eXpression.ConnectionString")
								keys[k].setAttribute("value", Request("ConnectionString"));
							if (keys[k].getAttribute("key") == "adminEMail")
								keys[k].setAttribute("value", Request("adminEMail"));
							if (keys[k].getAttribute("key") == "adminMailServer")
								keys[k].setAttribute("value", Request("adminMailServer"));
							if (keys[k].getAttribute("key") == "adminMailServerUser")
								keys[k].setAttribute("value", Request("adminMailServerUser"));
							if (keys[k].getAttribute("key") == "adminMailServerPass")
								keys[k].setAttribute("value", Request("adminMailServerPass"));
						}
						objXML.save(currPath + "/web.config");
					}
					Response.Write ("<img src='../images/check.gif' align='absmiddle'> Modified web.config<br>");
					
					var fso = new ActiveXObject("Scripting.FileSystemObject");
					var globalConfig = "";
					var ts = fso.OpenTextFile(currPath + "/global.asa",1,false);
					while (!ts.AtEndOfStream) {
					globalConfig += ts.ReadLine() + "\n";
					}
					
					var globalConfigParts = globalConfig.split("'--config")
					globalConfig = globalConfigParts[0] + "";
					globalConfig += "'--config\n";
					globalConfig += "Application(\"SiteName\") = \"" + Request("serverName") + "\"\n";
					globalConfig += "Application(\"adminRoot\") = \"" + Request("serverRoot") + "\"\n";
					globalConfig += "strconn=\"" + Request("ASPConnString") + "\"\n";
					globalConfig += "'--config";
					globalConfig += globalConfigParts[2] + "\n";
					var ts = fso.OpenTextFile(currPath + "/global.asa",2,false);
					ts.WriteLine(globalConfig);
					ts.Close();
					fso = "";
					Response.Write ("<img src='../images/check.gif' align='absmiddle'> Modified global.asa<br>");
					
				}
				catch(e)
				{
					Response.Write ("<img src='../images/delete.gif' align='absmiddle'> <i>Unable to save configuration settings!</i><br>");
					Response.Write ("Please make sure the Internet User account on this machine, usually 'iusr_computername', has full control of the eXpression directory and all subdirectories.");
					Response.Write ("This is necessary for eXpression to function.<br>");
				}
				if (Request("copydefault") == "yes")
				{
					try
					{
						var fso = new ActiveXObject("Scripting.FileSystemObject");
						if (fso.FileExists((Server.MapPath("../../default.asp"))))
							fso.CopyFile (Server.MapPath("../../default.asp"), Server.MapPath("../../default-off.asp"))
						if (fso.FileExists((Server.MapPath("../../default.htm"))))
							fso.CopyFile (Server.MapPath("../../default.htm"), Server.MapPath("../../default-off.htm"))
						fso.CopyFile (Server.MapPath("default.asp"), Server.MapPath("../../default.asp"));
						Response.Write ("<img src='../images/check.gif' align='absmiddle'> Copied default.asp to root<br>");
					}
					catch(e)
					{
						Response.Write ("<img src='../images/delete.gif' align='absmiddle'> Unable to copy expression/setup/default.asp to root<br>");
					}
				}
				Response.Write ("<br><hr>");
			}
			%>

		On this page you'll configure server-wide settings for this eXpression 
		installation. You will not be able to run eXpression on this server until this 
		configuration is updated. You will only be able to run this page from the 
		computer where eXpression is installed.<br>
		These settings are used to customize your eXpression installation for this 
		computer.
		<%
		var aItems = new Array();
		//Loop through all subdirectories
		var currPath = Server.MapPath("../");
		//Read XML file
		var objXML = Server.CreateObject("Microsoft.XMLDOM");
		objXML.async = false;
		var checkLoad = objXML.load(currPath + "/web.config");
		if (checkLoad)
		{
			var keys = objXML.selectNodes("//appSettings/add");
			for (var k=0;k<keys.length;k++)
			{
				if (keys[k].getAttribute("key") == "serverRoot")
					var serverRoot = keys[k].getAttribute("value");
				if (keys[k].getAttribute("key") == "serverName")
					var serverName = keys[k].getAttribute("value");
				if (keys[k].getAttribute("key") == "ASPConnString")
					var ASPConnString = keys[k].getAttribute("value");
				if (keys[k].getAttribute("key") == "eXpression.ConnectionString")
					var ConnectionString = keys[k].getAttribute("value");
				if (keys[k].getAttribute("key") == "adminEMail")
					var adminEMail = keys[k].getAttribute("value");
				if (keys[k].getAttribute("key") == "adminMailServer")
					var adminMailServer = keys[k].getAttribute("value");
				if (keys[k].getAttribute("key") == "adminMailServerUser")
					var adminMailServerUser = keys[k].getAttribute("value");
				if (keys[k].getAttribute("key") == "adminMailServerPass")
					var adminMailServerPass = keys[k].getAttribute("value");
			}
		}
		%>
		<%
		if (Request.ServerVariables("LOCAL_ADDR")+"" == Request.ServerVariables("REMOTE_HOST")+"" || Request.ServerVariables("HTTP_HOST")+"" == Request.ServerVariables("REMOTE_HOST")+"")
		{
		%>
		<form name="frmTopics" action="expressionConfig.asp" method="post">
			<table cellSpacing="0" cellPadding="0" border="0">
				<tr>
					<td width="166"><b>Server Root:</b>
					</td>
					<td><input type=text size=25 value="<%=serverRoot%>" name="serverRoot"></td>
				</tr>
				<tr>
					<td width="166"><b>Server Name:</b>
					</td>
					<td><input id=Text1 type=text size=25 value="<%=serverName%>" name="serverName"></td>
				</tr>
				<tr>
					<td width="166"><b>ASP DB Connection String:</b>
					</td>
					<td><input id=Text2 type=text size=100 value="<%=ASPConnString%>" name="ASPConnString"></td>
				</tr>
				<tr>
					<td width="166"><b>.NET DB Connection String:</b>
					</td>
					<td><input type=text size=100 value="<%=ConnectionString%>" name="ConnectionString"></td>
				</tr>
				<tr>
					<td width="166"><b>Admin E-Mail:</b>
					</td>
					<td><input type=text size=25 value="<%=adminEMail%>" name="adminEMail"></td>
				</tr>
				<tr>
					<td width="166"><b>Mail (SMTP) Server:</b>
					</td>
					<td><input type=text size=25 value="<%=adminMailServer%>" name="adminMailServer"></td>
				</tr>
				<tr>
					<td width="166"><b>Mail Username:</b>&nbsp;
					</td>
					<td><input type=text size=25 value="<%=adminMailServerUser%>" name="adminMailServerUser"></td>
				</tr>
				<tr>
					<td width="166"><b>Mail Password:</b>&nbsp;
					</td>
					<td><input type=text size=25 value="<%=adminMailServerPass%>" name="adminMailServerPass"></td>
				</tr>
				<tr>
					<td></td>
					<td><input type="checkbox" name="copydefault" value="yes"> Allow eXpression to manage the root of this webserver?<br/>
					<i>Note this action will rename any existing default page and install the eXpression root handler page.</i></td>
				</tr>
			</table>
			<input type="hidden" value="none" name="action">
			<br>
			<input onclick="frmTopics.action.value='save';frmTopics.submit()" type="button" value="Save" name="save">
		</form>
		<%
		}
		else
		{
			Response.Write("<hr><i>No remote access.</i><br/>Please view this page from the computer with the IP Address: " + Request.ServerVariables("LOCAL_ADDR") + "<br><br>")
			Response.Write ("<i>Unmatching Remote Host</i>: " + Request.ServerVariables("REMOTE_HOST") + "<br>")
		}
		%>
		<%
		if (Request("action") == "save")
		{
		%>
			<hr/>
			<a href="http://<%=serverRoot%>/expression/expression.asmx" target="_blank">Start-up Service</a><br/>
			<a href="http://<%=serverRoot%>/expression/admin/register.asp?targetpage=../setup/expressionconfig.asp" target="_self">Register a user</a> (Note: the first user registered becomes the site admin)</br>
			<a href="http://<%=serverRoot%>/expression/admin/createSite.asp" target="_blank">Create an eXpression Site</a></br>
		<%
		}
		%>
		<p align="right"><a href="install.rtf">Installation Checklist</a></p>
	</body>
</HTML>

 
 
