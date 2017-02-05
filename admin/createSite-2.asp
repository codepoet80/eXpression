<%@ LANGUAGE = JScript %>
<% Response.CacheControl = "no-cache" %>
<html>
<%
if (Session("LoggedIn") != "true")
	Response.Redirect("authenticate.asp?targetpage=createSite-1.asp")
%>
	<head>
		<title>eXpression - Create Site</title>
		<link rel="stylesheet" type="text/css" href="normal.css">
	</head>
	<script>
		function showPreview()
		{
			document.getElementById("imgPreview").src = "../styles/" + document.getElementById("cmbStyles").options[document.getElementById("cmbStyles").selectedIndex].value + ".jpg";
		}
	</script>
	<body onload="showPreview()">
<!--#include file="headerJS.inc"-->
		<p class="PageTitle" style="margin-top:0px">eXpression - Create Site: Step 2</p>
		<form method="post" action="createsite-3.asp">
			<b>Select a stylesheet:</b><br/>
			This defines the overall appearance of your site.<br/>&nbsp;<br/>
			<table><tr>
			<td valign="top">
			<select size="5" style="width:150px" onchange="showPreview()" id="cmbStyles" name="cmbStyles">
				<%
				var aItems = new Array();
				//Loop through all subdirectories
				var fso, f, fc, s;
				var currPath = Server.MapPath("../styles");
				
				fso = new ActiveXObject("Scripting.FileSystemObject");
				f = fso.GetFolder(currPath);
				fc = new Enumerator(f.Files);
				var first = 1;
				for (; !fc.atEnd(); fc.moveNext())
				{
					if (fc.item().type == "XSL Stylesheet")	
					{
						var currStyle = fc.item().name;
						currStyle = currStyle.split(".");
						currStyle = currStyle[0];
						Response.Write ("<option value='" + currStyle + "'");
						if (first == 1)
						{
							Response.Write (" selected ");
							first = 0;
						}
						Response.Write (">" + currStyle + "</option>");
					}
				}
				%>
				<option value="custom">Custom</option>
			</select>
			</td>
			<td>&nbsp;&nbsp;</td>
			<td valign="bottom">
				<img src="../images/none.jpg" height="184" width="250" id="imgPreview"/>
			</td>
			</tr></table>
			<p>
			<input type="hidden" name="SiteTitle" value="<%=Request("SiteTitle")%>"/>
			<input type="hidden" name="Description" value="<%=Request("Description")%>"/>
			<input type="hidden" name="URL" value="<%=Request("URL")%>"/>
			<input type="hidden" name="commercial" value="<%=Request("commercial")%>"/>
			<input type="button" value="&lt; Restart" onclick="document.location='createSite-1.asp'"/>
			<input type="submit" value="Next Step &gt;"/>
			</p>
		</form>
	</body>
</html>

 
 
