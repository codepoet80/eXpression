<%@ LANGUAGE = JScript %>
<% Response.CacheControl = "no-cache" %>
<html>
<%
if (Session("LoggedIn") != "true")
	Response.Redirect("authenticate.asp?targetpage=pageEdit.asp?siteID=" + Request("siteID"))
else
	{
	sqlCommand = "SELECT * FROM tblAdmins WHERE SiteID = " + Request("siteID") + " AND UserID = " + Session("UserID")
	var rs = Server.CreateObject("ADODB.Recordset")
	rs.open (sqlCommand, Application("ConnStr"))
	if (rs.eof)
		Response.Redirect("authenticate.asp?targetpage=weblog-approve.asp?siteID=" + Request("siteID"))
	}
var currSite = Request("SiteID")
%>

<%
currFolder = Request("folder") + ""
if (currFolder == "undefined")
	currFolder = ""
%>
<head>
<title>Page Editor</title>
<link rel="stylesheet" type="text/css" href="normal.css">
<script language="javascript" src="common.js"></script>
<script language="javascript" src="../../../jsobjects/jsUI-Global/common.js"></script>
<script language="javascript" src="../../../jsobjects/jsUI-Global/uiCommon.js"></script>
<script language="javascript" src="../../../jsobjects/jsUI-HTMLEdit/component.js"></script>
<script language="javascript" src="../../../jsobjects/jsUI-Toolbar/component.js"></script>
<script language="javascript" src="htmleditor.js"></script>
<SCRIPT>

var currFile = "";
function loadDoc()
{
	<%
	if (Request("file") != null && Request("file") != "")
	{
		Response.Write ("doChange();");
	}
	%>
}
  function changeSrc()
  {
  	  var changed = checkChange();
	  if (!changed)
	  {
	  	doChange();
	  }
	  else
	  {
	  	if (askSave())
	  	{
	  		doChange();
		}
	  }
  }
  var currLoc;
  function doChange()
  {
	  if (document.getElementById("lstPages").options[document.getElementById("lstPages").options.selectedIndex].value != "null")
	  {
  		//if (document.getElementById("lstPages").options[document.getElementById("lstPages").options.selectedIndex].value.indexOf("folder:") == 0)
		//{
	  	//	newLoc="pageEdit.asp?folder=/" + replace(lstPages.options[lstPages.options.selectedIndex].value, "folder:", "");
	  		//document.location=replace(newLoc, "=/", "=");
		//}
		//else
		//{
			currLoc = document.getElementById("lstPages").options[document.getElementById("lstPages").options.selectedIndex].value;
	  		currLoc = replace(currLoc, "../", "http://" + document.location.host + "/expression/");
	  		myeditor.loadHTMLFile(currLoc);
		//}
		}
  }
  function frmChange()
  {
  	document.getElementById("EditorValue").value = document.getElementById("myEditor").contentWindow.document.body.innerHTML;
  } 
  
  function setImg(imgPath)
  {
	if (chooseImage != null)
		chooseImage.window.close();

	if(imgPath != null) 
	{
		var tr = frames.myEditor.document.selection.createRange();
		tr.execCommand('insertimage', false, imgPath); 
	}
  }
  
  function askSave()
  {
	if (document.getElementById("myEditor").contentWindow.document.innerHTML == undefined)
		return true;
  	if (confirm("The contents of this page have not been saved!\nAre you sure you want to change pages?"))
  		return true;
  	else
  		return false;
  }
  function doSave()
  {
    document.getElementById("EditorValue").value = myeditor.getHTML();
    document.getElementById("FileName").value = currLoc;
    document.frm.submit();
  }
  function checkChange()
  {
  	//if (document.getElementById("EditorValue").value != document.getElementById("myEditor").contentWindow.document.body.innerHTML)
  	//	return true;
  	//else
  		return false;
  }

</SCRIPT>
</head>

<body onload="initPage()" marginheight="0" marginwidth="0" topmargin="0" leftmargin="0">
<p class="PageTitle">Edit Pages</p>
<table width="100%" height="90%" cellpadding="0" cellspacing="0" border="0">
<tr><td valign="top"><img src="../images/cmdOpen.gif" alt="Choose File to Open" height="16" width="16">
<select id="lstPages" name="lstPage" onChange="changeSrc()">
	<option selected value="null">Open Page</option>
<%
var aItems = new Array();
//Loop through all subdirectories
var fso, f, fc, s;
var currPath = Server.MapPath(".." + currFolder + "/site_" + Request("siteid"));
var currURL = "../site_" + Request("siteid");

	//Read XML file
	var objXML = Server.CreateObject("Microsoft.XMLDOM");
	objXML.async = false;
	var checkLoad = objXML.load(currPath + "/site.xml");
	if (checkLoad)
	{
		var items = objXML.selectNodes("//Links/add");
		for (var i=0;i<items.length;i++)
		{	
			if (items[i].getAttribute("key") != "../pictures")
			{
				if (items[i].getAttribute("key").indexOf("../") == -1)
				{
					var currValue = currURL + "/" + items[i].getAttribute("key");
					Response.Write ("<option ")
					if (currValue == Request("File"))
						Response.Write ("selected ");
					Response.Write ("value='" + currValue + "'>" + items[i].getAttribute("value") + "</option>")
				}
			}
		}
	}

%>
</select>&nbsp;
<button onclick="doSave()"><img src="editorImages/cmdSave.gif"></button>
<table border="0" cellpadding="0" cellspacing="0" style="width:100%; height:500" ID="Table1">
<tr>
<td id="cellTB" width="100%" style="background-color: buttonface; border-bottom: 1px solid threedshadow">
</td>
</tr>
<tr>
<td id="cellTB2" style="background-color:buttonface">
</td>
</tr>
<tr>
<td id="cellEdit" width="100%" height="100%" style="background-color: buttonface; border: 1px solid buttonface">
</td>
</tr>
</table>
<p>
<form name="frm" id="frm" method="post" action="pageSave.asp?siteid=<%=Request("siteid")%>">
	<input id="FileName" name="FileName" type="text" style="display:none"></input>
	<input id="Folder" name="Folder" type="text" style="display:none" value="<%=Request("folder")%>"></input>
	<textarea id="EditorValue" name="EditorValue" style="display:none;"></textarea>
</form>
</td></tr></table>
<script>
	setTimeout("loadDoc()", 800);;
</script>
</body>

</html>
 
 
