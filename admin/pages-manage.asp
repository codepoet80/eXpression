<%@ LANGUAGE = JScript %>
<% Response.CacheControl = "no-cache" %>
<html>
<%
if (Session("LoggedIn") != "true")
	Response.Redirect("authenticate.asp?targetpage=pages-manage.asp?siteID=" + Request("siteID"))
else
	{
	sqlCommand = "SELECT * FROM tblAdmins WHERE SiteID = " + Request("siteID") + " AND UserID = " + Session("UserID")
	var rs = Server.CreateObject("ADODB.Recordset")
	rs.open (sqlCommand, Application("ConnStr"))
	if (rs.eof)
		Response.Redirect("authenticate.asp?targetpage=pages-manage?siteID=" + Request("siteID"))
	}
var currSite = Request("SiteID")
%>

<head>
<title><%=Application("SiteName")%>: Manage Pages</title>
<link rel="stylesheet" type="text/css" href="normal.css">
<script>
function initPage()
{
if (!document.all)
	{
	document.getElementById("up").disabled = true;  
	document.getElementById("down").disabled = true;  
	}
}

function doUp()
{
	if (frmTopics.pages.selectedIndex > 0)
	{
		frmTopics.pages.options[frmTopics.pages.selectedIndex].swapNode(frmTopics.pages.options[frmTopics.pages.selectedIndex-1])
		saveOrder();
		doSave();
	}
}

function doDown()
{
	if (frmTopics.pages.selectedIndex < frmTopics.pages.options.length-1)
	{
		frmTopics.pages.options[frmTopics.pages.selectedIndex].swapNode(frmTopics.pages.options[frmTopics.pages.selectedIndex+1])
		saveOrder();
		doSave();
	}
}

function saveOrder()
{
	frmTopics.newname.value = "";
	for (var i=0;i<frmTopics.pages.options.length;i++)
	{
		frmTopics.newname.value += "<add pos=\"" + (i+1) + "\" value=\"" + frmTopics.pages.options(i).text + "\" key=\"" + frmTopics.pages.options(i).value + "\"/>";
	}
	return i+1;
}

function doRename()
{
	var newName;
	newName = prompt("Enter the name for the page '" + frmTopics.pages.options(frmTopics.pages.selectedIndex).text + "':", frmTopics.pages.options(frmTopics.pages.selectedIndex).text);
	if (newName != null)
	{
		frmTopics.pages.options(frmTopics.pages.selectedIndex).text = newName;
		saveOrder();
		doSave();
	}
}

function doNew()
{
	var newName, newFile;
	newName = prompt("Enter the title for the new page:");
	if (!document.getElementById("newPS").checked)
		newFile = calcPageName(newName) + ".htm";
	else
		newFile = "../pictures.htm";
	newPos = saveOrder();
	frmTopics.newname.value += "<add pos=\"NEW\" value=\"" + newName + "\" key=\"" + newFile + "\"/>";
	doSave();
}

function doDelete()
{
	frmTopics.action.value="delete";
	if (confirm("Are you sure you want to do this?!\nDeleting a page cannot be undone and all it's content will be lost!!"))
	{
		frmTopics.pages.options(frmTopics.pages.selectedIndex).value = "DELETE";
		saveOrder();
		doSave();
	}
}

function doSave()
{
	frmTopics.newname.value = "<Links>" + frmTopics.newname.value + "</Links>";
	frmTopics.action.value = "save";
	frmTopics.submit();
}

function calcPageName(pageName)
{
	base = pageName;
	base = base.split(" ");
	base = base[0];
	base = base.replace("'", "");
	base = base.toLowerCase();
	return base;
}

</script>
</head>
<%
	//open xml file
	//remove all link nodes
	//add new link nodes
	if (Request("action") == "save")
	{
		var objXML = Server.CreateObject("Microsoft.XMLDOM");
		objXML.async = false;
		var currPath = Server.MapPath("../site_" + Request("siteid"));
		var checkLoad = objXML.load(currPath + "/site.xml");
		if (checkLoad)
		{
			oSelection = objXML.selectNodes("//Links/add");
   			oSelection.removeAll();
   			oSelection = objXML.selectSingleNode("//Links");
   			
   			var objXML2 = Server.CreateObject("Microsoft.XMLDOM");
			objXML2.async = false;
			checkLoad = objXML2.loadXML(Request("newname"));
			if (checkLoad)
			{
				newNodes = objXML2.selectNodes("//add");
				for (var i=0;i<newNodes.length;i++)
				{
					if (newNodes(i).getAttribute("key") == "DELETE")
					{
						//do nothing
					}
					else if (newNodes(i).getAttribute("pos") == "NEW")
					{
						//create in file system
						var fso = new ActiveXObject("Scripting.FileSystemObject");
						var ts = fso.OpenTextFile(currPath + "/" + newNodes(i).getAttribute("key"),2,true);
						ts.WriteLine("<h2>" + newNodes(i).getAttribute("value") + "</h2><p>");
						ts.Close();
					
						newNodes(i).setAttribute("pos", i+1);
						oSelection.appendChild(newNodes(i));
					}
					else
					{
						oSelection.appendChild(newNodes(i));
					}
				}
			}
		}
		objXML.save(currPath + "/site.xml");
	}
%>
<body class="PageBody" onload="initPage()">

   <p class="PageTitle">
    Manage Pages
	</p>
	<form name="frmTopics" method="post" action="pages-manage.asp?siteid=<%=Request("siteID")%>">
	<table><tr><td valign="top"><b>Pages</b>:</td>
	<td>
	<select id="pages" name="pages" size="4">
    <%
	//Loop through all subdirectories
	var currPath = Server.MapPath("../site_" + Request("siteid"));
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
				Response.Write ("<option ")
				Response.Write ("value='" + items[i].getAttribute("key") + "'>")
				if (items[i].getAttribute("key") == "../pictures.htm")
				{
					Response.Write ("(P)");
				}
				if (items[i].getAttribute("key") == "../files.htm")
				{
					Response.Write ("(F)");
				}
				Response.Write (items[i].getAttribute("value") + "</option>")
			}
		}
	%>
    </select>
    </td>
    <td>
    <input type="button" id="up" name="up" value="Up" onclick="doUp()" style="width:50px"><br/>
    <input type="button" id="down" name="down" value="Down" onclick="doDown()" style="width:50px">
    </td>
    </tr></table>
    <p/>
    <input type="button" name="rename" value="Rename" onclick="doRename()">
    <input type="button" name="delete" value="Delete" onclick="doDelete()">
    <br/>
    <input type="button" name="new" value="New" onclick="doNew()">
    <%
var fs=new ActiveXObject("Scripting.FileSystemObject");
if (fs.FileExists(Server.MapPath("photoshare-manage.asp")))
{
%>
	<input type="checkbox" name="newPS" id="newPS" value="yes"> Create as PhotoShare Album (P)
<%
}
%>
    
    <input type="hidden" name="action">
    <input type="hidden" name="newname">
    </form>
</body>

</html>
 
 
