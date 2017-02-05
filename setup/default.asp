<%@ Language="JScript" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<html>
<%
	var fso, f, fc, s;
	var defaultURL = "";
	var found = false;

	//Banned IP Addresses
	if (Request.ServerVariables("REMOTE_ADDR") == "64.187.16.34")
	{
		Response.Redirect ("http://www.eff.org/~barlow/Declaration-Final.html");
	}
	
	fso = new ActiveXObject("Scripting.FileSystemObject");
	f = fso.GetFolder(Server.MapPath("./eXpression"));
	fc = new Enumerator(f.SubFolders);
	for (; !fc.atEnd(); fc.moveNext())
	{
	//Find XML file
		if (fso.FileExists((fc.item() + "/site.xml")))
		{
			//Read XML file
			var objXML = Server.CreateObject("Microsoft.XMLDOM");
			objXML.async = false;
			var vPath = fc.item() + "";
			var vPaths = vPath.split("\\");
			vPath = vPaths[vPaths.length-1];
			var checkLoad = objXML.load(fc.item() + "/site.xml");
			if (checkLoad)
			{
				var sections = objXML.selectSingleNode("//Site");
				var sectionPart = sections.getAttribute("BaseURL") + "";
				var sectionParts = sectionPart.split(",");
				var currURL = Request.ServerVariables("HTTP_HOST") + "";
				for (var s=0;s<sectionParts.length;s++)
				{
					if (!found)
					{
						//Response.Write ("<br>" + currURL.toLowerCase() + " == " + sectionParts[s].toLowerCase() + " - ");
						//Response.Write (currURL.toLowerCase() == sectionParts[s].toLowerCase());
						if (currURL.toLowerCase() == sectionParts[s].toLowerCase())
						{
							if (Request.ServerVariables("Query_String") != "")
							{
								if (sections.getAttribute("home") != "eXpression/expression.asmx/")
								{
									Response.Redirect("http://" + Request.ServerVariables("SERVER_NAME") + "/" + sections.getAttribute("home") + "" + Request.ServerVariables("Query_String"))
								}
								else
								{
									var xmlhttp = Server.CreateObject("MSXML2.ServerXMLHTTP");
									xmlhttp.open ("GET", "http://" + Request.ServerVariables("LOCAL_ADDR") + "/" + sections.getAttribute("home") + "" + Request.ServerVariables("Query_String"), false);
									xmlhttp.send();
									Response.Write (xmlhttp.responseText);
									found = true;
								}
							}
							else
							{
								if (sections.getAttribute("home") != "eXpression/expression.asmx/")
								{
									Response.Redirect("http://" + Request.ServerVariables("SERVER_NAME") + "/" + sections.getAttribute("home"))
								}
								else
								{
									var xmlhttp = Server.CreateObject("MSXML2.ServerXMLHTTP");
									if (sections.getAttribute("query") != null)
										xmlhttp.open ("GET", "http://" + Request.ServerVariables("LOCAL_ADDR") + "/" + sections.getAttribute("home") + "" + sections.getAttribute("query"), false);
									else
										xmlhttp.open ("GET", "http://" + Request.ServerVariables("LOCAL_ADDR") + "/" + sections.getAttribute("home"), false);
									xmlhttp.send();
									Response.Write (xmlhttp.responseText);
									found = true;
								}
							}
						}
					}
				}
			}
		}
	}

	if (!found)
	{
		//Replace with your default home page
		Response.Redirect("http://" + Application("adminRoot"))
	}
%>
</html>

 
 
