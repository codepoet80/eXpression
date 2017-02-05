<% Response.CacheControl = "no-cache" %>
<html>
<%
if Session("LoggedIn") <> "true" then
	Response.Redirect("authenticate.asp?targetpage=user-list.asp?siteID=" & Request("siteID"))
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
<title><%=Application("SiteName")%>: view users</title>
<link rel="stylesheet" type="text/css" href="normal.css">
<base target="_blank">
</head>

<body>
<!--#include file="header.inc"-->
<%
set rComments = Server.CreateObject("ADODB.Recordset")
sqlCommand = "SELECT * FROM tblUsers WHERE Active > 0 ORDER BY Active Desc, Score Desc, UserName"
rComments.open sqlCommand, Application("ConnStr")
%>
   <p class="PageTitle" style="margin-top:0px">
    User List
	</p>
<%
do while rComments.eof = false
if rComments("Active") = 1 or (rComments("Active") > 1) then
%>
<b>User Name:</b>
<%
	if rComments("Active") > 1 then
		Response.Write "<img src='../images/lock.gif'>"
	end if
%>
<a href='user-view.asp?frame=yes&userid=<%=rComments("UserID")%>&siteid=<%=Request("siteid")%>' target='_self'><%=rComments("UserName")%></a><br>
<%
	set rCounts = server.createobject("ADODB.Recordset")
	sqlCmd = "SELECT Bio, Relationship FROM tblUsers Where UserID =" & rComments("UserID")
	rCounts.open sqlCmd, Application("ConnStr")
	bcount = 0
	if rCounts.eof = false then
		if rCounts("Bio") <> "" or rCounts("Relationship") <> "" then
			bcount = 1
		end if
	end if
	set rCounts = nothing
	
	Response.Write "Score: " & rComments("score") & ", Rank: "
	if rComments("score")> 200 then
		Response.Write "*****"
	elseif rComments("score")> 150 and score < 200 then
		Response.Write "****"
	elseif rComments("score")> 50 and score < 150 then
		Response.Write "***"
	elseif rComments("score")> 10 and score < 50 then
		Response.Write "**"
	elseif rComments("score")> 5 and score < 10 then
		Response.Write "*"
	end if	
	Response.Write "<br>"
	Response.Write "Profile: "
	if bcount > 0 then
		Response.Write "Yes"
	else
		Response.Write "No"
	end if
	Response.Write "<br>"
end if
rComments.movenext
Response.Write "<br>"
loop

%>
<br>
</body>

</html>
 
 
