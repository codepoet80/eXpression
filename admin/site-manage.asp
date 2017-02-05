<html>
<%
if Session("LoggedIn") <> "true" then
	Response.Redirect("authenticate.asp?targetpage=site-manage.asp?siteID=" & Request("siteID"))
else
	'See if this user is an admin for this site
	sqlCommand = "SELECT * FROM tblAdmins WHERE SiteID = " & Request("siteID") & " AND UserID = " & Session("UserID")
	set rs = Server.CreateObject("ADODB.Recordset")
	rs.open sqlCommand, Application("ConnStr")
	if rs.eof = true then
		Response.Redirect("authenticate.asp?targetpage=weblog-approve.asp?siteID=" & Request("siteID"))
	end if
end if
dim currSite
currSite = Request("SiteID")
if currSite = "" then
	currSite = 1
end if
%>
<head>
<title><%=Application("SiteName")%>: manage site</title>
<link rel="stylesheet" type="text/css" href="normal.css">
<base target="_blank">
</head>

<body class="PageBody">

   <p class="PageTitle">
    Manage Site
	</p>
	<ul>
	<li><a href="site-settings.asp?siteID=<%=Request("siteID")%>" target="_self">Change Settings</a></li>
	<li><a href="topics-manage.asp?siteID=<%=Request("siteID")%>" target="_self">Manage Topics</a></li>
	<li><a href="pages-manage.asp?siteID=<%=Request("siteID")%>" target="_self">Manage Pages</a></li>
	<li><a href="image-upload.asp?siteID=<%=Request("siteID")%>" target="_self">Manage Pictures</a></li>
	<li><a href="templates-manage.asp?siteID=<%=Request("siteID")%>" target="_self">Edit Stylesheets</a></li>
	<li><a href="reports.asp?siteID=<%=Request("siteID")%>" target="_self">View Reports</a></li>
	</ul>
</body>

</html>
 
 
