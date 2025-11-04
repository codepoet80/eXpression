<%@ LANGUAGE = JScript %>
<HTML>
	<HEAD>
		<title>eXpression - Create Site</title>
		<% Response.CacheControl = "no-cache" %>
		<%
if (Session("LoggedIn") != "true")
	Response.Redirect("authenticate.asp?targetpage=createSite-1.asp")
%>
		<link rel="stylesheet" type="text/css" href="normal.css">
			<script>
	function calcSiteName()
	{
		if (document.getElementById("URL").value == "")
		{
			base = document.getElementById("SiteTitle").value;
			base = base.split(" ");
			base = base[0];
			base = base.replace("'", "");
			base = base.toLowerCase();
			serverRoot = "<%=Application("adminRoot")%>"
			serverRoot = serverRoot.replace("www", "");
			document.getElementById("URL").value = base + serverRoot;
		}
	}
			</script>
	</HEAD>
	<body>
		<!--#include file="headerJS.inc"-->
		<p class="PageTitle" style="margin-top:0px">eXpression - Create Site: Step 1</p>
		<form method="post" action="createSite-2.asp">
			<STRONG>Enter a name for your website</STRONG> : <input type="text" id="SiteTitle" name="SiteTitle" size="30" onchange="calcSiteName()"><br>
			This is the title people will see when they browse to your blog.<br>
			<br>
			<STRONG>Enter a short description for your site</STRONG> : <input type="text" name="Description" size="50"><br>
			This is an optional tagline for your blog.<br>
			<br>
			<STRONG>Enter the address for your site</STRONG> http://<input type="text" id="URL" name="URL" value="" size="35"><br>
			You can use an address similar to the default one or, if you have your own 
			domain name, you can enter that now. If you use your own domain name, please 
			ensure that it points to the same IP address as:
			<%=Application("adminRoot")%>
			<br>
			<br>
			<input type="checkbox" value="true" name="commercial"> Re-arrange the 
			site for commercial purposes.
			<p><input type="submit" value="Next Step >"></p>
		</form>
	</body>
</HTML>

 
 
