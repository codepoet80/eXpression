<%
if Session("LoggedIn") <> "true" then
	Response.Redirect("authenticate.asp?targetpage=weblog-approve.asp?siteID=" & Request("siteID"))
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
		Response.Redirect("authenticate.asp?targetpage=weblog-approve.asp?siteID=" & Request("siteID"))
	end if
end if
dim currSite
currSite = Request("SiteID")
if currSite = "" then
	currSite = 1
end if
%>
<html>

<head>
<title><%=Application("SiteName")%>: maintain blog</title>


<link rel="stylesheet" type="text/css" href="normal.css">
<script>
function execICmd(cmd)
{
	var tr = frames.myEditor.document.selection.createRange()
	tr.execCommand(cmd)
	tr.select()
	frames.myEditor.focus()
}

function editFrame()
{	
	<%
	if Request("lstEntries") <> "none" and Request("txtAction") = "edit" then
	%>
	
	document.getElementById("myEditor").contentWindow.document.designMode = "On";
	if (document.all)
		editorwin = frames.myEditor.window;
	else
		editorwin = document.getElementById("myEditor").contentWindow;
	if (document.all)
	{
		
		editorwin.document.write(document.getElementById("txtEntryText").value);
	}
	else
	{
		editorwin.document.body.innerHTML = document.frm.txtEntryText.value;
	}
	
	document.frames("myEditor").document.designMode = "On";
	
	//		document.getElementById("myEditor").contentWindow.document.designMode = "On";	
	//document.getElementById("myEditor").contentWindow.document.write(document.frm.txtEntryText.value);
	//document.getElementById("myEditor").contentWindow.document.designMode = "On";
	
	//

	<%
	end if
	%>
}
</script>
</head>

<body onload="editFrame()">

<p class="PageTitle">
Manage Posts</p>
<form name="frm" method="post" action="weblog-approve.asp?SiteID=<%=Request("siteID")%>&TopicID=<%=Request("TopicID")%>">
<b>Post</b>: <select name="lstEntries">
<option value="none">Choose...</option>
<%
sqlCommand = "SELECT TOP 30 tblTopics.SiteID, tblWebLog.EntryTitle, tblWebLog.EntryID, tblWebLog.Approved, tblTopics.TopicName FROM tblWebLog INNER JOIN tblTopics ON dbo.tblWebLog.TopicID = tblTopics.TopicID WHERE tblTopics.SiteID =" & currSite
if Request("TopicID") <> "" then
	sqlCommand = sqlCommand + " AND tblTopics.TopicID = " & Request("TopicID")
end if
sqlCommand = sqlCommand & " ORDER By EntryTime DESC"
set rs = Server.CreateObject("ADODB.Recordset")
rs.open sqlCommand, Application("ConnStr")
do while rs.eof = false
	Response.Write "<option value='" & rs("EntryID") & "'>" & rs("EntryTitle") 
	if rs("Approved") = 0 then
		Response.Write " *"
	end if
	Response.Write "</option>"
	rs.MoveNext
loop
rs.close
%>
</select>
<br>
<input type="button" onClick="frm.txtAction.value='show';frm.submit()" value="Show" name="cmdShow">
<input type="button" onClick="frm.txtAction.value='approve';frm.submit()" value="Approve" name="cmdApprove">
<input type="button" onClick="frm.txtAction.value='unapprove';frm.submit()" value="UnApprove" name="cmdUnApprove">
<input type="button" onClick="frm.txtAction.value='edit';frm.submit()" value="Edit" name="cmdEdit">
<input type="button" onClick="frm.txtAction.value='delete';frm.submit()" value="Delete" name="cmdDelete">
<input type="hidden" name="txtAction" value="none">

<p class="PageTitle">Entry</p>
</font>
<%
if Request("lstEntries") <> "none" and Request("txtAction") = "show" then
	%>
	<script>
	frm.lstEntries.value = <%=Request.Form("lstEntries")%>
	</script>
	<%
	sqlCommand = "SELECT * FROM tblWebLog WHERE EntryID = " & Request("lstEntries")
	set rs = Server.CreateObject("ADODB.Recordset")
	rs.open sqlCommand, Application("ConnStr")

	if rs.eof = false then
		Response.Write "<b>Posted by:</b> "
		sqlCommand = "SELECT * FROM tblUsers WHERE UserID = '" & rs("UserID") & "'"
		set rs1 = Server.CreateObject("ADODB.Recordset")
		rs1.open sqlCommand, Application("ConnStr")
		if rs.eof = false then
			Response.Write rs1("UserName") & "<br>"
		end if
		rs1.close
		Response.Write "<b>Topic:</b> "
		sqlCommand = "SELECT * FROM tblTopics WHERE TopicID = '" & rs("TopicID") & "'"
		set rs1 = Server.CreateObject("ADODB.Recordset")
		rs1.open sqlCommand, Application("ConnStr")
		if rs.eof = false then
			Response.Write rs1("TopicName") & "<br>"
		end if
		rs1.close
		Response.Write "<b>Title:</b> " &  rs("EntryTitle") & "<br>"
		Response.Write "<b>Body:</b><br>"
		
		'Get Image
		sqlCommand = "SELECT * FROM tblWebLogImages WHERE EntryID = " & Request("lstEntries")
		set getImage = Server.CreateObject("ADODB.Recordset")
		getImage.open sqlCommand, Application("ConnStr")
		if getImage.EOF = False then
			if getImage("iType") = "jpg" or getImage("iType") = "gif" then
				if getImage("iType") = "jpg" then
					Response.Write "<img src='../showjpg.asp?imageid=" & getImage("imageid") & "'"
				elseif getImage("iType") = "gif" then
					Response.Write "<img src='../showgif.asp?imageid=" & getImage("imageid") & "'"
				end if
				Response.Write " align='left'>"
			end if
		end if
		getImage.Close
		set getImage = nothing
		'/Get Image
		Response.Write rs("EntryText") & "<br>"
		if rs("AllowComments") = 0 then
			allowcomments = "No"
		else
			allowcomments = "Yes"
		end if
		Response.Write "<b>Allow Comments:</b> " & allowcomments & "<br>"
		
	end if
	rs.close
elseif Request("lstEntries") <> "none" and Request("txtAction") = "approve" then
	%>
	<script>
	frm.lstEntries.value = <%=Request.Form("lstEntries")%>
	</script>
	<%
	sqlCommand = "SELECT * FROM tblWebLog WHERE EntryID = " & Request("lstEntries")
	set rs = Server.CreateObject("ADODB.Recordset")
	rs.open sqlCommand, Application("ConnStr")
	if rs.eof = false then
		Response.Write "<b>Title:</b> " &  rs("EntryTitle") & "<br>"
		Response.Write "<b>Body:</b><br>"
		
		'Get Image
		sqlCommand = "SELECT Align, iHeight, iWidth, iType FROM tblWebLogImages WHERE EntryID=" & Request("lstEntries")
		set getImage = Server.CreateObject("ADODB.Recordset")
		getImage.open sqlCommand, Application("ConnStr")
		if getImage.EOF = False then
			if getImage("iType") = "jpg" or getImage("iType") = "gif" then
				if getImage("iType") = "jpg" then
					Response.Write "<img src='../showjpg.asp?entryid=" & Request("lstEntries") & "'"
				elseif getImage("iType") = "gif" then
					Response.Write "<img src='..m/showgif.asp?entryid=" & Request("lstEntries") & "'"
				end if
					
				if getImage("Align") <> "" then
					Response.Write " align='" & getImage("Align") &"'"
				end if
				if getImage("iHeight") <> "" then
					Response.Write " height='" & getImage("iHeight") & "'"
				end if
				if getImage("iWidth") <> "" then
					Response.Write " width='" & getImage("iWidth") & "'"
				end if
				Response.Write ">"
			end if
		end if
		getImage.Close
		set getImage = nothing
		'/Get Image	

		Response.Write rs("EntryText") & "<br>"
		if rs("AllowComments") = 0 then
			allowcomments = "No"
		else
			allowcomments = "Yes"
		end if
		Response.Write "<b>Allow Comments:</b> " & allowcomments & "<br>"
		
	end if
	rs.close
	sqlCommand = "UPDATE tblWebLog SET Approved = 1 WHERE EntryID = " & Request("lstEntries")
	set us = Server.CreateObject("ADODB.Connection")
	us.open Application("ConnStr")
	us.execute sqlCommand
	us.close
	Response.Write "<br><b>APPROVED!</b><br>"
elseif Request("lstEntries") <> "none" and Request("txtAction") = "unapprove" then
	%>
	<script>
	frm.lstEntries.value = <%=Request.Form("lstEntries")%>
	</script>
	<%
	sqlCommand = "SELECT * FROM tblWebLog WHERE EntryID = " & Request("lstEntries")
	set rs = Server.CreateObject("ADODB.Recordset")
	rs.open sqlCommand, Application("ConnStr")
	if rs.eof = false then
		Response.Write "<b>Title:</b> " &  rs("EntryTitle") & "<br>"
		Response.Write "<b>Body:</b><br>"
		
		'Get Image
		sqlCommand = "SELECT Align, iHeight, iWidth, iType FROM tblWebLogImages WHERE EntryID=" & Request("lstEntries")
		set getImage = Server.CreateObject("ADODB.Recordset")
		getImage.open sqlCommand, Application("ConnStr")
		if getImage.EOF = False then
			if getImage("iType") = "jpg" or getImage("iType") = "gif" then
				if getImage("iType") = "jpg" then
					Response.Write "<img src='../showjpg.asp?entryid=" & Request("lstEntries") & "'"
				elseif getImage("iType") = "gif" then
					Response.Write "<img src='../showgif.asp?entryid=" & Request("lstEntries") & "'"
				end if
					
				if getImage("Align") <> "" then
					Response.Write " align='" & getImage("Align") &"'"
				end if
				if getImage("iHeight") <> "" then
					Response.Write " height='" & getImage("iHeight") & "'"
				end if
				if getImage("iWidth") <> "" then
					Response.Write " width='" & getImage("iWidth") & "'"
				end if
				Response.Write ">"
			end if
		end if
		getImage.Close
		set getImage = nothing
		'/Get Image	

		Response.Write rs("EntryText") & "<br>"
		if rs("AllowComments") = 0 then
			allowcomments = "No"
		else
			allowcomments = "Yes"
		end if
		Response.Write "<b>Allow Comments:</b> " & allowcomments & "<br>"

	end if
	rs.close
	sqlCommand = "UPDATE tblWebLog SET Approved = 0 WHERE EntryID = " & Request("lstEntries")
	set us = Server.CreateObject("ADODB.Connection")
	us.open Application("ConnStr")
	us.execute sqlCommand
	us.close
	Response.Write "<br><b>UNAPPROVED!</b>"
elseif Request("lstEntries") <> "none" and Request("txtAction") = "delete" then
	sqlCommand = "SELECT * FROM tblWebLog WHERE EntryID = " & Request("lstEntries")
	set rs = Server.CreateObject("ADODB.Recordset")
	rs.open sqlCommand, Application("ConnStr")
	if rs.eof = false then
		Response.Write "<b>Title:</b> " &  rs("EntryTitle") & "<br>"
		Response.Write "<b>Body:</b><br>"
		
		'Get Image
		sqlCommand = "SELECT Align, iHeight, iWidth, iType FROM tblWebLogImages WHERE EntryID=" & Request("lstEntries")
		set getImage = Server.CreateObject("ADODB.Recordset")
		getImage.open sqlCommand, Application("ConnStr")
		if getImage.EOF = False then
			if getImage("iType") = "jpg" or getImage("iType") = "gif" then
				if getImage("iType") = "jpg" then
					Response.Write "<img src='../showjpg.asp?entryid=" & Request("lstEntries") & "'"
				elseif getImage("iType") = "gif" then
					Response.Write "<img src='../showgif.asp?entryid=" & Request("lstEntries") & "'"
				end if
					
				if getImage("Align") <> "" then
					Response.Write " align='" & getImage("Align") &"'"
				end if
				if getImage("iHeight") <> "" then
					Response.Write " height='" & getImage("iHeight") & "'"
				end if
				if getImage("iWidth") <> "" then
					Response.Write " width='" & getImage("iWidth") & "'"
				end if
				Response.Write ">"
			end if
		end if
		getImage.Close
		set getImage = nothing
		'/Get Image	

		Response.Write rs("EntryText") & "<br>"
		if rs("AllowComments") = 0 then
			allowcomments = "No"
		else
			allowcomments = "Yes"
		end if
		Response.Write "<b>Allow Comments:</b> " & allowcomments & "<br>"
	end if
	rs.close
	sqlCommand = "DELETE FROM tblWebLog WHERE EntryID = " & Request("lstEntries")
	set us = Server.CreateObject("ADODB.Connection")
	us.open Application("ConnStr")
	us.execute sqlCommand
	sqlCommand = "DELETE FROM tblWebLogImages WHERE EntryID = " & Request("lstEntries")
	us.execute sqlCommand
	us.close
	Response.Write "<br><b>DELETED!</b>"
elseif Request("lstEntries") <> "none" and Request("txtAction") = "edit" then
	%>
	<script>
	frm.lstEntries.value = <%=Request.Form("lstEntries")%>
	
	var viewMode = 1;
	var iHTML, iText;
	function toggleMode()
	{
		if (viewMode == 1)
		{
			iHTML = document.getElementById("myEditor").contentWindow.document.body.innerHTML; 
			document.getElementById("myEditor").contentWindow.document.body.innerText = iHTML;
			viewMode = 2;
		}
		else
		{
			iText = document.getElementById("myEditor").contentWindow.document.body.innerText; 
			document.getElementById("myEditor").contentWindow.document.body.innerHTML = iText; 
			viewMode = 1;
		}
	}
	</script>
	<%
	sqlCommand = "SELECT * FROM tblWebLog WHERE EntryID = " & Request("lstEntries")
	set rs = Server.CreateObject("ADODB.Recordset")
	rs.open sqlCommand, Application("ConnStr")
	if rs.eof = false then
		Response.Write "<b>Title:</b> <input type='text' name='txtEntryTitle' id='txtEntryTitle' value=" & chr(34) &  rs("EntryTitle") & chr(34) & "> &nbsp;&nbsp;"
		Response.Write "<b>Topic:</b> "
		Response.Write "<select name='lstTopicID'>"
    
		sqlCommand = "SELECT * FROM tblTopics WHERE SiteID=" & Request("siteid")
		set rs1 = Server.CreateObject("ADODB.Recordset")
		rs1.open sqlCommand, Application("ConnStr")
		do while rs1.eof = false
			Response.Write "<option value='" & rs1("TopicID") & "'"
			if rs1("TopicID") = rs("topicid") then
				Response.Write " selected "
			end if
			Response.Write ">" & rs1("TopicName")
			if rs1("Active") = 0 then
				Response.Write " * "
			end if
			Response.Write "</option>"
			rs1.MoveNext
		loop
		rs1.close
		Response.Write "</select>"
		%>
		<br/>
		<table><tr><td>
		<button id="cmdSave" onClick="frm.txtAction.value='save';if (viewMode !=1){toggleMode()};frm.txtEntryText.value=document.getElementById('myEditor').contentWindow.document.body.innerHTML;frm.submit()" value="Save" align="absmiddle"><img src="../images/cmdSave.gif" alt="Save" height="16" width="16"></button>
		|&nbsp;<button id="cmdBold" onclick="execICmd('Bold')"><img src="../images/cmdB.gif"></button>
		<button id="cmdItalic" onclick="execICmd('Italic')"><img src="../images/cmdI.gif"></button>
		<button id="cmdUnderline" onclick="execICmd('Underline')"><img src="../images/cmdU.gif"></button>
		<button id="cmdBullets" onclick="execICmd('InsertUnorderedList')"><img src="../images/cmdBulleted.gif"></button>
		|&nbsp;<button onclick="toggleMode()" id="cmdMode"><img src="../images/toggleMode.gif" alt="Toggle Code"/></button>
		</td></tr></table>
		<script>
			if (!document.all)
			{
				document.getElementById("cmdBold").disabled = true;
				document.getElementById("cmdItalic").disabled = true;
				document.getElementById("cmdUnderline").disabled = true;
				document.getElementById("cmdBullets").disabled = true;
				document.getElementById("cmdMode").disabled = true;
			}
		</script>
		<IFRAME ID=myEditor width='100%' height='300'></IFRAME><br>
		<%
		Response.Write "<textarea rows='8' cols='50' name='txtEntryText' style='display:none' id='txtEntryText'>" &  rs("EntryText") & "</textarea><br>"
		%>
		<%
		Response.Write "<b>Allow Comments:</b> <input type='checkbox' name='chkComments' value='YES'"
		if rs("AllowComments") = 1 then
			Response.Write "checked"
		end if
		Response.Write "/>"
		%>
		<br>
		
		<%
	end if
	rs.close
elseif Request("lstEntries") <> "none" and Request("txtAction") = "save" then
	%>
	<script>
	frm.lstEntries.value = <%=Request.Form("lstEntries")%>
	</script>
	<%
	set wLog = Server.CreateObject("ADODB.Connection")
	wLog.Open Application("ConnStr")
	if Request("chkComments") = "YES" then
		allowcomments = 1
	else
		allowcomments = 0
	end if
	sqlCommand = "UPDATE tblWebLog SET EntryTitle='" & Replace(Request("txtEntryTitle"), "'", "''") & "', TopicID='" & Request("lstTopicID") & "', EntryText = '" & Replace(Replace(Request("txtEntryText"), "'", "''"), vbCrLf, vbCrLf) & "', CategoryID = 1, AllowComments = " & allowcomments & " WHERE EntryID = '" & Request("lstEntries") & "'"
	'response.write sqlCommand
	wLog.Execute sqlCommand
	wLog.close
	Response.Write "UPDATED!"
end if
%>
</form>
</td></tr></table>
</body>

</html>
 
 
