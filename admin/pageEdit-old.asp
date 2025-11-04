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
<script type="text/javascript" src="common.js"></script>
<SCRIPT>
var currFile = "";

  function initPage()
  {
	document.getElementById("myEditor").contentWindow.document.designMode = "On";
	if (!document.all)
	{
		document.getElementById("cmdBold").disabled = true;
		document.getElementById("cmdItalic").disabled = true;
		document.getElementById("cmdUnderline").disabled = true;
		document.getElementById("cmdCut").disabled = true;
		document.getElementById("cmdCopy").disabled = true;
		document.getElementById("cmdPaste").disabled = true;
		document.getElementById("cmdLink").disabled = true;
		document.getElementById("cmdImage").disabled = true;
		document.getElementById("cmdToggle").disabled = true;
	}
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
  function doChange()
  {
	  if (document.getElementById("lstPages").options[document.getElementById("lstPages").options.selectedIndex].value != "null")
	  {
  		if (document.getElementById("lstPages").options[document.getElementById("lstPages").options.selectedIndex].value.indexOf("folder:") == 0)
		{
	  		newLoc="pageEdit.asp?folder=/" + replace(lstPages.options[lstPages.options.selectedIndex].value, "folder:", "");
	  		document.location=replace(newLoc, "=/", "=");
		}
		else
		{
	  		document.getElementById("myEditor").contentWindow.document.location = document.getElementById("lstPages").options[document.getElementById("lstPages").options.selectedIndex].value;
	 		//document.getElementById("myEditor").contentWindow.document.designMode = "On";	
		}
	}
  }
  function frmChange()
  {
  	document.getElementById("EditorValue").value = document.getElementById("myEditor").contentWindow.document.body.innerHTML;
  }
  
  function execICmd(cmd)
  {
    var tr = frames.myEditor.document.selection.createRange();
    tr.execCommand(cmd);
    tr.select();
    frames.myEditor.focus();
  }
  
  var chooseImage;
  function addImage() 
  { 
	chooseImage = window.open("image-list.asp?siteid=<%=Request("siteid")%>", "chooseImage", "height=260, width=580, menubar=no, resizable=yes, toolbar=no");
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

  function addLink() 
  { 
	var tr = frames.myEditor.document.selection.createRange();
	tr.execCommand('createlink'); 
  } 
  
  var viewMode = 1;
  var iHTML, iText;
  function toggleMode()
  {
	if (viewMode == 1)
	{
		iHTML = myEditor.document.body.innerHTML; 
		myEditor.document.body.innerText = iHTML;
		viewMode = 2;
	}
	else
	{
		iText = myEditor.document.body.innerText; 
		myEditor.document.body.innerHTML = iText; 
		viewMode = 1;
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
	if (viewMode != 1)
	{
		iText = myEditor.document.body.innerText; 
		myEditor.document.body.innerHTML = iText; 
		viewMode = 1;
	}
    document.getElementById("EditorValue").value = document.getElementById("myEditor").contentWindow.document.body.innerHTML;
    document.getElementById("FileName").value = document.getElementById("myEditor").contentWindow.document.location;
    document.getElementById("myEditor").disabled = true;
    document.getElementById("lstPages").disabled = true;
    document.getElementById("cmdSave").disabled = true;
    //document.frm.submit();
  }
  function checkChange()
  {
  	if (document.getElementById("EditorValue").value != document.getElementById("myEditor").contentWindow.document.body.innerHTML)
  		return true;
  	else
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
<button id="cmdSave" onclick="doSave()"><img src="../images/cmdSave.gif" alt="Save" height="16" width="16"></button> |&nbsp;
<button id="cmdBold" onclick="execICmd('Bold')"><img src="../images/cmdB.gif" alt="Bold" height="16" width="16"></button>
<button id="cmdItalic" onclick="execICmd('Italic')"><img src="../images/cmdI.gif" alt="Italic" height="16" width="16"></button>
<button id="cmdUnderline" onclick="execICmd('Underline')"><img src="../images/cmdU.gif" alt="Underline" height="16" width="16"></button>
|&nbsp;
<button id="cmdCut" onclick="execICmd('Cut')"><img src="../images/cmdCut.gif" alt="Cut" height="16" width="16"></button>
<button id="cmdCopy" onclick="execICmd('Copy')"><img src="../images/cmdCopy.gif" alt="Copy" height="16" width="16"></button>
<button id="cmdPaste" onclick="execICmd('Paste')"><img src="../images/cmdPaste.gif" alt="Paste" height="16" width="16"></button>
|
<button id="cmdLink" onclick="addLink()"><img src="../images/link.gif" alt="Add Link" height="16" width="16"></button>
<button id="cmdImage" onclick="addImage()"><img src="../images/image.gif" alt="Add Image" height="16" width="16"></button>
| <button id="cmdToggle" onclick="toggleMode()"><img src="../images/togglemode.gif" alt="Toggle Code"/></button>
</td></tr><tr><td height="100%" valign="top" style="height:100%;">
<IFRAME WIDTH=100% style="height:100%" ID="myEditor" onload="frmChange()" style="display:block"></IFRAME>
<p>
<form name="frm" id="frm" method="post" action="pageSave.asp?siteid=<%=Request("siteid")%>">
	<input id="FileName" name="FileName" type="text" style="display:none"></input>
	<input id="Folder" name="Folder" type="text" style="display:none" value="<%=Request("folder")%>"></input>
	<textarea id="EditorValue" name="EditorValue" style="display:none;"></textarea>
</form>
</td></tr></table>
</body>

</html>
 
 
