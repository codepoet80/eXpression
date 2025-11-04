<html>
	<head>
		<title>
			<%=Application("SiteName")%>
			: weblog post</title>
		<script language="javascript" src="../../../jsobjects/jsUI-Global/common.js"></script>
		<script language="javascript" src="../../../jsobjects/jsUI-Global/uiCommon.js"></script>
		<script language="javascript" src="../../../jsobjects/jsUI-HTMLEdit/component.js"></script>
		<script language="javascript" src="../../../jsobjects/jsUI-Toolbar/component.js"></script>
		<script language="javascript" src="../../../jsobjects/jsDA-wsBind/component.js"></script>
		<script language="javascript" src="editor.js"></script>
		<link rel="stylesheet" type="text/css" href="normal.css">
			<script>
		var myws = new Object();
		var queryString = getQueryString();
		function initws()
		{
			myws = wsbindNew("myws", "http://" + document.location.host + "/expression/expression.asmx");
			if (!myws)
				alert ("Unable to bind to a remote webservice. You will not be able to post");
			else
			{
				alert(myws.postBlogData(queryString.siteid, document.getElementById("topicid").options[document.getElementById("topicid").selectedIndex].value, document.getElementById("txtUserName"), document.getElementById("txtPassword"), document.getElementById("txtEntryTitle"), myeditor.getHTML()));
			}
		}
		
		function doSave()
		{
			initws();
		}
	</script>
	</head>
	<body onload="initPage(false)" topmargin="0" leftmargin="0" marginheight="0" marginwidth="0"
		style="background-color: buttonface;"> <!--#include file="header.inc"-->
		<p class="PageTitle" style="margin-top:0px">Post an Entry</p>
			<table style="margin-bottom:5px">
				<tr>
					<%
	if Session("UserID") = "" then
	%>
					<td>
						<b>Username:</b></td>
					<td>
						<input type="text" id="txtUserName" NAME="txtUserName">&nbsp;
					</td>
					<td>
						<b>Password:</b></td>
					<td>
						<input type="password" id="txtPassword" NAME="txtPassword">
					</td>
					<%
	else
		sqlCommand = "SELECT * FROM tblUsers WHERE UserID = " & Session("UserID")
		set rs = Server.CreateObject("ADODB.Recordset")
		rs.open sqlCommand, Application("ConnStr")
		if rs.eof = false then
		%>
					<td>
						<font color="darkgray"><b>Username:</b></font>
					</td>
					<td><input disabled="true" type="text" id="txtUserName" NAME="txtUserName" value="<%=rs("Username")%>">&nbsp;
					</td>
					<td>
						<font color="darkgray"><b>Password:</b></font>
					</td>
					<td><input disabled="true" type="password" id="txtPassword" NAME="txtPassword" value="<%=rs("Password")%>">
					</td>
					<%	
		end if
	end if
	%>
				</tr>
				<tr>
					<td>
						<b>Title:</b></td>
					<td><input type="text" name="txtEntryTitle" id="txtEntryTitle">
					</td>
					<td>
						<b>Topic:</b></td>
					<td>
						<select name="topicid" ID="topicid" class="ToolbarMain" style="width:145px">
							<%
	sqlCommand = "SELECT * FROM tblTopics WHERE SiteID=" & Request("siteid")
	set rs = Server.CreateObject("ADODB.Recordset")
	rs.open sqlCommand, Application("ConnStr")
	do while rs.eof = false
		Response.Write "<option value='" & rs("TopicID") & "'"
		if rs("TopicID")*1 = currTopic*1 then
			Response.Write " selected "
		end if
		Response.Write ">" & rs("TopicName")
		if rs("Active") = 0 then
			Response.Write " * "
		end if
		Response.Write "</option>"
		rs.MoveNext
	loop
	rs.close
    %>
						</select>
					</td>
				</tr>
			</table>
			<table border="0" cellpadding="0" cellspacing="0" style="width:450; height:500" ID="Table1">
				<tr>
					<td colspan="2" id="cellTB" width="100%" style="background-color: buttonface; border-bottom: 1px solid threedshadow">
					</td>
				</tr>
				<tr>
					<td colspan="2" id="cellTB2" style="background-color:buttonface;">
					</td>
				</tr>
				<tr>
					<td colspan="2" id="cellEdit" width="100%" height="100%" style="padding-top:5px;background-color: buttonface; border: 1px solid buttonface">
					</td>
				</tr>
				<tr>
					<td colspan="2" align="right"><button class="ToolbarItemOut" style="height:24px;width:60px;margin-top:5px" onmouseover="this.className='ToolbarItemOver'"
							onmouseout="this.className='ToolbarItemOut'" onclick="doSave()"><img src="../images/cmdSave.gif" align=texttop> Post</button></td>
				</tr>
			</table>
	</body>
</html>

 
 
