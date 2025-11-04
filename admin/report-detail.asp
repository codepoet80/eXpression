<html>
	<%
if Session("LoggedIn") <> "true" then
	Response.Redirect("authenticate.asp?targetpage=reports.asp?siteID=" & Request("siteID"))
else
	'See if this user is an admin for this site
	sqlCommand = "SELECT * FROM tblAdmins WHERE SiteID = " & Request("siteID") & " AND UserID = " & Session("UserID")
	set rs = Server.CreateObject("ADODB.Recordset")
	rs.open sqlCommand, Application("ConnStr")
	if rs.eof = true then
		Response.Redirect("authenticate.asp?targetpage=reports.asp?siteID=" & Request("siteID"))
	end if
end if
dim currSite
currSite = Request("SiteID")
if currSite = "" then
	currSite = 1
end if
%>
	<head>
		<title>
			<%=Application("SiteName")%>
			: Detail Report</title>
		<link rel="stylesheet" type="text/css" href="normal.css">
			<base target="_blank">
	</head>
	<body>
		<p class="PageTitle">
	Detail Report
	</p>
		<%
		'sqlCommand = "SELECT * FROM InternetLog WHERE target='/ipodcontrol/'"
		sqlCommand = Request("sqlCommand")
		set rs = Server.CreateObject("ADODB.Recordset")
		rs.open sqlCommand, Application("ConnStr")
		Response.Write "<table>"
		For Each objField In rs.Fields
			Response.Write("<td style='background-color:#C0C0C0'>" & objField.name & "</td>")
		Next
		do while rs.eof = false
			Response.Write "<tr>"
			For Each Item In rs.Fields
				Response.Write "<td style='background-color:#D8D8D8'>" & rs(Item.Name) & "</td>"
			next
			Response.Write "</tr>"
			rs.movenext
		loop
		Response.Write "</table>"
		rs.close
		%>
	</body>
</html>

 
 
