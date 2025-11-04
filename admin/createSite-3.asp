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
		<p class="PageTitle" style="margin-top:0px">eXpression - Create Site: Step 3</p>
		<form method="post" action="createSite-Last.asp">
			<b>Create your default topic</b>: <input type="text" name="Topic" size="15"><br>
			This is the topic that most blog entries will go into. Usually something like 
			your name or "Current Events." You can create more topics later.<br>
			<br>
			<b>Create your first content page</b>: <input type="text" name="Page"><br>
			This is usually an "about" page describing you or your site. You can create 
			more pages later.<br>
			<br/>
			<input type="hidden" name="SiteTitle" value="<%=Request("SiteTitle")%>"/>
			<input type="hidden" name="Description" value="<%=Request("Description")%>"/>
			<input type="hidden" name="URL" value="<%=Request("URL")%>"/>
			<input type="hidden" name="commercial" value="<%=Request("commercial")%>"/>
			<input type="hidden" name="cmbStyles" value="<%=Request("cmbStyles")%>"/>
			
			<input type="button" value="&lt; Restart" onclick="document.location='createSite-1.asp'"/>
			<input type="submit" value="Finish &gt;" NAME="SubmitForm"/>
		</form>
	</body>
</html>

 
 
