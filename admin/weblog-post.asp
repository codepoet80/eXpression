<html>
<%
	if Session("UserID") = "" then
		Response.Redirect("authenticate.asp?targetpage=weblog-post.asp?siteid=" & Request.QueryString("SiteID") & "&topicid=" & Request.QueryString("TopicID"))
	end if
	dim currTopic
	currTopic = Request("TopicID")
	if currTopic = "" then
		currTopic = 1
	end if
	
	sqlCommand = "SELECT * FROM tblAdmins WHERE SiteID = " & Request.QueryString("SiteID") & " AND UserID = " & Session("UserID")
	set rs = Server.CreateObject("ADODB.Recordset")
	rs.open sqlCommand, Application("ConnStr")
	if rs.eof = false then
		admin = true
	end if
%>
<head>
<title><%=Application("SiteName")%>: weblog post</title>
<%
dim currSite
if Request("SiteID") <> "" then
	Session("currSite") = Request("SiteID")
end if
if Session("currSite") = "" then
	Session("currSite") = 1
end if
Set upl = Server.CreateObject("ABCUpload4.XForm")

if Len(upl("txtEntryText")) > 0 then
	set wLog = Server.CreateObject("ADODB.Connection")
	wLog.Open Application("ConnStr")
	myComment = Replace(upl("txtEntryText"), "'", "''")
	if upl("chkComments") = "YES" then
		allowcomments = 1
	else
		allowcomments = 0
	end if
	sqlCommand = "INSERT INTO tblWebLog (EntryTime, SiteID, TopicID, UserID, EntryTitle, EntryText, CategoryID, Approved, AllowComments) VALUES ('" & Now & "'," & Session("currSite") & ", " & upl("TopicID") & ",'"
	sqlCommand = sqlCommand & upl("txtUserID") & "','" & Replace(upl("txtEntryTitle"), "'", "''") & "','" & myComment & "', 1,"
	if Request.QueryString("AutoApprove") = "on" and admin = true then
		sqlCommand = sqlCommand & " 1, "
	else
		sqlCommand = sqlCommand & " 0, "
	end if
	sqlCommand = sqlCommand & "'" & allowcomments & "')"
	wLog.Execute sqlCommand
	wLog.close
	set wLog = nothing

	set wLog = Server.CreateObject("ADODB.Recordset")
	sqlCommand = "SELECT TOP 1 EntryID FROM tblWebLog ORDER BY EntryID DESC"
	wLog.open sqlCommand, Application("ConnStr")
	if wLog.EOF = false then
		LastID = wLog("EntryID")
	end if
	wLog.close
	set wLog = nothing
	
	set ImageField = upl("fileImage")(1)
	if ImageField.ImageType > 0 and ImageField.ImageType <> 0 then
		set wLog = Server.CreateObject("ADODB.Connection")
		wLog.Open Application("ConnStr")
		set rs = Server.CreateObject("ADODB.Recordset")
		rs.Open "tblWebLogimages", wLog, 1, 3
		rs.AddNew
		rs("Image").Value = ImageField.Data
		rs("EntryID").Value = LastID
		rs("Align").Value = upl("lstAlign")
		rs("iHeight").Value = upl("txtHeight")
		rs("iWidth").Value = upl("txtWidth")
		iType = right(ImageField.FileName, 3)
		rs("iType").Value = iType
		rs.Update
		rs.Close
		wLog.close
		set wLog = nothing
		set rs = nothing
	end if
	
	'calcscore = "calcscore.asp?userid=" & upl("txtUserID") & "&returnpage=weblog-post.asp?siteid=" & Request.QueryString("SiteID") & "&topicid=" & Request.QueryString("TopicID") & "&post=complete"
	'Response.Redirect(calcscore)
end if
%>
<script language="javascript">
function doSubmit()
{
	if (viewMode != 1)
	{
		toggleMode();
	}
	document.getElementById("txtEntryText").value=document.getElementById("myEditor").contentWindow.document.body.innerHTML;
	if (document.getElementById("txtEntryTitle").value == "")
	{
		alert ("Please fill in all fields!");
	}
	else
	{
		document.getElementById("frmWebLog").submit();
	}
}
function addSmiley()
{
    document.getElementById("myEditor").contentWindow.document.body.insertAdjacentHTML("beforeEnd", document.frmWebLog.lstSmiley.options(document.frmWebLog.lstSmiley.selectedIndex).value);
	document.frmWebLog.lstSmiley.selectedIndex = 0;
}
function execICmd(cmd)
{
	//frames.myEditor.document.selection.createRange()
	var tr = document.getElementById("myEditor").contentWindow.document.selection.createRange();
	tr.execCommand(cmd);
	tr.select();
	document.getElementById("myEditor").contentWindow.focus();
 }

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

function editFrame()
{
	document.getElementById("myEditor").contentWindow.document.designMode = "On"
	if (!document.all)
	{
		document.getElementById("cmdBold").disabled = true;
		document.getElementById("cmdItalic").disabled = true;
		document.getElementById("cmdUnderline").disabled = true;
		document.getElementById("cmdBullets").disabled = true;
		//document.getElementById("lstSmileys").disabled = true;
		document.getElementById("cmdMode").disabled = true;
	}
}
</script>

<link rel="stylesheet" type="text/css" href="normal.css">

</head>

<body onload="editFrame()">
<!--#include file="header.inc"-->
<p class="PageTitle" style="margin-top:0px">Post an Entry</p>
<form name="frmWebLog" id="frmWebLog" method="post" action="weblog-post.asp?SiteID=<%=Request.QueryString("SiteID")%>&TopicID=<%=Request.QueryString("TopicID")%>&post=complete&Frame=<%=Request.QueryString("Frame")%>&AutoApprove=on" enctype="multipart/form-data" ID="Form1">
<%
if Request.QueryString("post") <> "" then
	Response.Write "<b>Post Accepted!</b><br><i>If you are the site administrator your entry will appear shortly. If not, you'll have to wait for the administrator to approve your post.</i><br/>"
	Response.Write "<b><a href='default.asp?SiteID=" & Request.QueryString("SiteID") & "&TopicID=" & Request.QueryString("TopicID") & "'>Manage Site</a></b><br/><br/>"
end if
%>
<table border="0" cellpadding="0">
  <tr>
    <td width="147" height="15"><b>Your Name</b>:</td>
    <td width="450" height="15">
    <%
    Response.Write Session("UserName")
    %>
    <input type="hidden" name="txtUserID" value="<%=Session("UserID")%>" ID="Hidden1">
    </td>
  </tr>
  <tr>
    <td width="147" height="21"><b>Entry Title</b>:</td>
    <td width="450" height="21"><input type="text" name="txtEntryTitle" size="71" ID="Text1"> 
  </tr>
  <tr>
	<td><b>Topic</b>: </td>
    <td><select name="topicid" ID="Select1">
    <%
	sqlCommand = "SELECT * FROM tblTopics WHERE SiteID=" & Session("currSite")
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
    </td>
  </tr>
  <tr>
    <td width="147" valign="top"><b>Image</b>:</td>
    <td width="450"><input type="file" name="fileImage" size="28" ID="File1">
    </td>
  </tr>
  <textarea rows="10" name="txtEntryText" cols="50" style="display:none" ID="txtEntryText"></textarea>
 </table>

 <table>
  <tr>
  	<td></td><td>
  	<button onclick="execICmd('Bold')" ID="cmdBold"><img src="../images/cmdB.gif"></button>
	<button onclick="execICmd('Italic')" ID="cmdItalic"><img src="../images/cmdI.gif"></button>
	<button onclick="execICmd('Underline')" ID="cmdUnderline"><img src="../images/cmdU.gif"></button>
	<button onclick="execICmd('InsertUnorderedList')" ID="cmdBullets"><img src="../images/cmdBulleted.gif"></button>
<select size="1" name="lstSmiley" onChange="addSmiley()" ID="lstSmileys">
	<option selected>Smileys</option>
	<option value=":-)">Happy :-)</option>
	<option value=";-)">Wink ;-)</option>
	<option value=":-|">Confused :-|</option>
	<option value=":-p">Tongue Out :-p</option>
	<option value=":-D">Big Grin :-D</option>
	<option value=":-(">Sad :-(</option>
	<option value=":-o">Suprised :-o</option>
	<option value=":'(">Crying :'(</option>
	<option value=":-$">Embaressed :-$</option>
	<option value=":-@">Angry :-@</option>
	<option value=":-S">Confused :-S</option>
</select>
|<button onclick="toggleMode()" id="cmdMode"><img src="../images/toggleMode.gif" alt="Toggle Code"/></button>
  	</td>
  </tr>
  <tr>
    <td width="147" valign="top" height="164"><b>Text</b>:
      </td>
    <td width="450" height="164">
    <IFRAME ID="myEditor" width='450' height='280'></IFRAME><br>
    </td>
  </tr>
</table>
<table width="600" style="border-collapse: collapse" bordercolor="#111111" cellpadding="0" cellspacing="0" ID="Table2"><tr><td>

<input type="submit" name="cmdSubmit" onClick="doSubmit()" value="Post Entry">
</td><td align="right">
<input type="checkbox" value="YES" name="chkComments" checked> Allow Comments
 </form>
</td></tr></table>

</body>

</html>
 
 
