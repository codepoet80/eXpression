<% Response.CacheControl = "no-cache" %>

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
<title><%=Application("SiteName")%>: view users</title>
<link rel="stylesheet" type="text/css" href="normal.css">
<script>
function doActivate()
{
	frmTopics.action.value="activate";
	frmTopics.submit();
}

function doDeactivate()
{
	frmTopics.action.value="deactivate";
	frmTopics.submit();
}

function doAggregate()
{
	frmTopics.action.value="aggregate";
	frmTopics.submit();
}

function doRename()
{
	frmTopics.action.value="rename";
	frmTopics.newname.value = prompt("Enter the name for the topic '" + frmTopics.topicid.options(frmTopics.topicid.selectedIndex).text + "':");
	if (frmTopics.newname.value != "null")
		frmTopics.submit();
}

function doNew()
{
	frmTopics.action.value="new";
	frmTopics.newname.value = prompt("Enter the name for the new topic:");
	if (frmTopics.newname.value != "null")
		frmTopics.submit();
}

function doDelete()
{
	frmTopics.action.value="delete";
	if (confirm("This is a very dangerous action -- are you sure you want to do this?!\nDeleting a topic cannot be undone and will orphan all posts under this heading!!"))
		frmTopics.submit();
}

</script>
</head>
<%
	if Request("action") = "new" then
		sqlCommand = "INSERT INTO tblTopics (TopicName, SiteID) VALUES ('" & Request("newname") &"', '" & Request("siteid") & "')"
		set us = Server.CreateObject("ADODB.Connection")
		us.open Application("ConnStr")
		us.execute sqlCommand
		us.close
	elseif Request("action") = "aggregate" then
		sqlCommand = "SELECT * FROM tblTopics WHERE TopicID = " & Request("topicid")
		set rs = Server.CreateObject("ADODB.Recordset")
		rs.open sqlCommand, Application("ConnStr")
		dim newval
		if rs.eof <> true then
			if rs("CategoryID") = 1 then
				newval = 2
			else
				newval = 1
			end if
			sqlCommand = "UPDATE tblTopics SET CategoryID = '" & newval & "' WHERE TopicID = " & Request("topicid")
			set us = Server.CreateObject("ADODB.Connection")
			us.open Application("ConnStr")
			us.execute sqlCommand
			us.close
		end if
		set rs = nothing
	elseif Request("action") = "rename" then
		sqlCommand = "UPDATE tblTopics SET TopicName = '" & Request("newname") & "' WHERE TopicID = " & Request("topicid")
		set us = Server.CreateObject("ADODB.Connection")
		us.open Application("ConnStr")
		us.execute sqlCommand
		us.close
	elseif Request("action") = "deactivate" then
		sqlCommand = "UPDATE tblTopics SET Active = '0' WHERE TopicID = " & Request("topicid")
		set us = Server.CreateObject("ADODB.Connection")
		us.open Application("ConnStr")
		us.execute sqlCommand
		us.close
	elseif Request("action") = "activate" then
		sqlCommand = "UPDATE tblTopics SET Active = '1' WHERE TopicID = " & Request("topicid")
		set us = Server.CreateObject("ADODB.Connection")
		us.open Application("ConnStr")
		us.execute sqlCommand
		us.close
	elseif Request("action") = "delete" then
		sqlCommand = "DELETE FROM tblTopics WHERE TopicID = " & Request("topicid")
		set us = Server.CreateObject("ADODB.Connection")
		us.open Application("ConnStr")
		us.execute sqlCommand
		us.close
	end if
%>
<body>

   <p class="PageTitle">
    Manage Topics
	</p>
	<form name="frmTopics" method="post" action="topics-manage.asp?siteid=<%=Request("siteID")%>">
	<b>Topic</b>: <select name="topicid" ID="topicid">
    <%
	sqlCommand = "SELECT * FROM tblTopics WHERE SiteID=" & Request("siteID")
	set rs = Server.CreateObject("ADODB.Recordset")
	rs.open sqlCommand, Application("ConnStr")
	do while rs.eof = false
		Response.Write "<option value='" & rs("TopicID") & "'"
		if rs("TopicID")*1 = currTopic*1 then
			Response.Write " selected "
		end if
		Response.Write ">"
		if rs("CategoryID") = "1" then
			Response.Write " + "
		end if
		Response.Write rs("TopicName") 
		if rs("Active") = false then
			Response.Write " *"
		end if
		Response.Write "</option>"
		rs.MoveNext
	loop
	rs.close
    %>
    </select>
    &nbsp;<input type="button" name="cmdAggregate" value="(+) Front Page" onclick="doAggregate()">
    <input type="button" name="cmdActivate" value="Activate" onclick="doActivate()">
    <input type="button" name="cmdDeactivate" value="Deactivate" onclick="doDeactivate()">
    <input type="button" name="rename" value="Rename" onclick="doRename()">
    <p/>
    <input type="button" name="new" value="Create New" onclick="doNew()">
    <input type="button" name="delete" value="Delete" onclick="doDelete()">
    <input type="hidden" name="action">
    <input type="hidden" name="newname">
    </form>
</body>

</html>
 
 
