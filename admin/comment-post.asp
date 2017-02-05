<html>
<head>
<title><%=Application("SiteName")%>: add comment</title>
<%
if Request.Form("txtComment") <> "" then
	set wLog = Server.CreateObject("ADODB.Connection")
	wLog.Open Application("ConnStr")
	if Request.Form("chkHTML") = "YES" then
		myComment=Replace(Request.Form("txtComment"), "'", "''")
	else
		myComment=Replace(Replace(Request.Form("txtComment"), "'", "''"), vbCrLf, "<br>")
	end if
	entryType = Request.Form("txtEntryType")
	if entryType = "" then
		entryType = 1
	end if
	sqlCommand = "INSERT INTO tblComments (EntryID, EntryType, PosterName, PosterEMail, Comment) VALUES (" & Request.Form("txtEntryID") & "," & entryType & ",'" & Request.Form("txtPosterName") & "','" & Request.Form("txtPosterEMail") & "','" & myComment & "')"
	wLog.Execute sqlCommand
	wLog.close
	
end if
%>

<script language="javascript">
function doSubmit()
{
	if (document.frmWebLog.txtComment.value == "")
		{ alert ("Please fill in all fields!") }
	else
		{ document.frmWebLog.submit() }
}

function addSmiley()
{
	document.getElementById("txtComment").value += document.getElementById("lstSmiley").options(document.getElementById("lstSmiley").selectedIndex).value;
	document.getElementById("lstSmiley").selectedIndex = 0;
}
</script>

<link rel="stylesheet" type="text/css" href="normal.css">

</head>

<body>
<!--#include file="header.inc"-->
		<p class="PageTitle" style="margin-top:0px">eXpression - Post a Reply</p>
<form name="frmWebLog" id="frmWebLog" method="post" action="comment-post.asp?item=<%=Request("item")%>&type=<%=Request("type")%>">
  <%
  if Request.Form("txtComment") <> "" then
	Response.Write "<b>Your comment has been accepted!</b><br/><i>It may take a moment to appear on the site.</i>"
  end if
  %>
<p>
<table border="0" cellpadding="0">
  <tr>
    <td width="147"><b>Your Name</b>:</td>
    <td width="630">
    <%
    Response.Write Session("UserName")
    %>
    <input type="hidden" name="txtUserID" value="<%=Session("UserID")%>">
    </td>
  </tr>
  <tr>
    <td width="147" valign="top"><b>Your Comment</b>:
    <br>
	<br/>
    <input type="checkbox" name="chkHTML" value="YES">HTML?<br/><br/>
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
    </td>
    <td width="550"><textarea rows="18" name="txtComment" style="width:550"></textarea></td>
  </tr>
</table>
<table width="500" style="border-collapse: collapse" bordercolor="#111111" cellpadding="0" cellspacing="0"><tr><td>
<input type="hidden" name="txtEntryID" value="<%=Request("item")%>">
<input type="hidden" name="txtEntryType" value="<%=Request("Type")%>">
<input type="hidden" name="txtStyle" value="<%=Request("style")%>">
<input type="button" name="cmdSubmit" onClick="doSubmit()" value="Post">
</td><td>

</td></tr></table>
</form>
</font>
</body>

</html>
 
 
