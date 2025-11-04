<html>
<%
if Session("LoggedIn") <> "true" then
	Response.Redirect("authenticate.asp?targetpage=default.asp?siteID=" & Request("siteID"))
else
	if Request("siteID") = "" then
		sqlCommand = "SELECT * FROM tblAdmins WHERE UserID = " & Session("UserID")
		set rs = Server.CreateObject("ADODB.Recordset")
		rs.open sqlCommand, Application("ConnStr")
		if rs.eof = false then
			Response.Write("<script>window.parent.document.location='default.asp?siteID=" & rs("SiteID") & "'</script>")
		end if
	end if
	'See if this user is an admin for this site
	sqlCommand = "SELECT * FROM tblAdmins WHERE SiteID = " & Request("siteID") & " AND UserID = " & Session("UserID")
	set rs = Server.CreateObject("ADODB.Recordset")
	rs.open sqlCommand, Application("ConnStr")
	if rs.eof = true then
		Response.Redirect("authenticate.asp?targetpage=default.asp?siteID=" & Request("siteID"))
	end if
end if
%>
<head>
<title>eXpression: Manage Your Site</title>
</head>

<frameset rows="56,*" framespacing="0" border="0" frameborder="0">
	<frame name="titlebar" scrolling="no" noresize target="contents" src="adminTitle.htm">
	<frameset cols="110,*">
		<frame name="taskbar" scrolling="no" target="main" src="adminTaskbar.asp?siteid=<%=Request("siteid")%>&topicid=<%=Request("topicid")%>">
		<frame name="view" scrolling="yes" src="../../expression/expression.asmx/getBlogTransformed?blogID=0&topicID=&startDate=&entries=10&style=&contentType=HTML&privateKey=0">
	</frameset>
</frameset>

</html>
 
 
