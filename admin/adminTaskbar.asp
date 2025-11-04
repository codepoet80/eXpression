<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<html>
<head>
<title>eXpression Admin</title>
<script language="javascript" src="../../jsObjects/jsUI-Global/common.js"></script>
<script language="javascript" src="../../jsObjects/jsUI-Global/uiCommon.js"></script>
<script language="javascript" src="../../jsObjects/jsUI-Taskbar/component.js"></script>
<script>
	var mybar = new Object();
	function initPage()
	{	
		mybar = taskbarNew("mybar", "default", document.getElementById("cellTest"));
		mybar.taskClick = tskClick;
		mybar.createFolder("folderSite", "Advanced");
		mybar.createFolder("folderDocuments", "Files");
		mybar.createFolder("folderPosts", "Posts");
		mybar.createFolder("folderInstructions", "User Manuals");
		mybar.createTask("site-settings.asp?", "Site Settings", "../images/sitesettings.gif", "folderSite");
		mybar.createTask("templates-edit.asp?", "Edit Template", "../images/template.gif", "folderSite");
		mybar.createTask("user-list.asp?frame=yes&", "User List", "../images/Users.gif", "folderSite");
		mybar.createTask("reports.asp?", "Site Reports", "../images/Reports.gif", "folderSite");
		mybar.createTask("../usermanuals/PhotoShareUpload.pdf?", "PhotoShare Uploading", "../images/icoPdf.gif", "folderInstructions");
<%
currPath = Server.MapPath("../site_" + Request("siteid"))
set objXML = Server.CreateObject("Microsoft.XMLDOM")
objXML.async = false
checkLoad = objXML.load(currPath + "/site.xml")
if checkLoad = true then
	set site = objXML.selectSingleNode("//Site")
	if site.getAttribute("type") = "commercial" then
	%>	
		mybar.createTask("weblog-post.asp?frame=yes&", "Create New Post", "../images/posts.gif", "folderPosts");
		mybar.createTask("weblog-approve.asp?", "Manage Posts", "../images/editposts.gif", "folderPosts");
		mybar.createTask("topics-manage.asp?", "Manage Topics", "../images/topics.gif", "folderPosts");
		mybar.createTask("pages-manage.asp?", "Manage Pages", "../images/managedocuments.gif", "folderDocuments");
		mybar.createTask("pageEdit.asp?", "Edit Pages", "../images/editdocuments.gif", "folderDocuments");
		mybar.createTask("image-upload.asp?", "Manage Pictures", "../images/pictures.gif", "folderDocuments");
		mybar.createTask("file-upload.asp?", "Manage Files", "../images/files.gif", "folderDocuments");
		mybar.createTask("photoshare-manage.asp?", "PhotoShare Albums", "../images/photoshare-icon.gif", "folderDocuments");
	<%
	else
	%>
		mybar.createTask("pages-manage.asp?", "Manage Pages", "../images/managedocuments.gif", "folderDocuments");
		mybar.createTask("pageEdit.asp?", "Edit Pages", "../images/editdocuments.gif", "folderDocuments");
		mybar.createTask("image-upload.asp?", "Manage Pictures", "../images/pictures.gif", "folderDocuments");
		mybar.createTask("file-upload.asp?", "Manage Files", "../images/files.gif", "folderDocuments");
		mybar.createTask("photoshare-manage.asp?", "PhotoShare Albums", "../images/photoshare-icon.gif", "folderDocuments");
		mybar.createTask("weblog-post.asp?frame=yes&", "Create New Post", "../images/posts.gif", "folderPosts");
		mybar.createTask("weblog-approve.asp?", "Manage Posts", "../images/editposts.gif", "folderPosts");
		mybar.createTask("topics-manage.asp?", "Manage Topics", "../images/topics.gif", "folderPosts");
	<%
	end if
end if
%>



		//fillTaskbar();
	}
	function tskClick(taskID)
	{
		window.parent.view.document.location=taskID + "siteid=<%=Request("siteid")%>&topicid=<%=Request("topicid")%>"		
	}
	function doresize()
	{	
		try
		{
			mybar.taskbarResize();
		}
		catch(e)
		{
			//
		}
	}
</script>
</head>
<body onresize="doresize()" onload="initPage()" topmargin="0" leftmargin="0" rightmargin="0" bottommargin="0" marginwidth="0" marginheight="0" >
<table width="100%" height="100%" border="0" cellpadding="0" cellspacing="0">
<tr>
<td id="cellTest" style="width:100%"></td>
</tr></table>


</body>
</html>

 
 
