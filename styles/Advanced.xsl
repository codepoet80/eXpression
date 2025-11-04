<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" 
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
<xsl:template match="/">
<html>
<head>
<style>
	.SiteTitle	{  
				font-size:200%;
				line-height:1.2em;
				color:#AC9E98;
				text-transform:uppercase;
				letter-spacing:.2em;
				padding-top: 6px;
				}
	.SiteDesc	{
				font:110%/1.4em "Trebuchet MS",Trebuchet,Arial,Verdana,Sans-serif;
				text-transform:uppercase;
				letter-spacing:.2em;
				color:#777;
				padding-bottom: 25px;
				}
	h2	{
				font-weight:normal;font-family: Impact, Arial,Verdana,Sans-serif;
				font-size: 20px;
				line-height: 30px;
				text-transform:lowercase;
				color:#265080;
				border-bottom: 1px solid #494D56;
				}
	h3	{
				font-family: Arial, Verdana,Sans-serif;
				font-weight: bold;
				font-size: 14px;
				margin:.25em 0 0;
				color:#494D56;
				}
	.PostHeaderDate	{
				font-family: Verdana,Arial, Helvetica, sans-serif;
				font-size: 10px;
				text-transform: uppercase;
				color: #666;
				}
	h4	{
				font-weight:normal; font-size:11px;
				margin-top: 5px;
				margin-bottom:15px;
				padding-top: 10px;
				padding-bottom: 10px;
				color:#777;
				border-bottom: 1px dotted #bababa;
				}
	.h5		{
				text-align: right;
				font-size:11px;
				padding-top: 10px;
				padding-bottom: 10px;
				color:#777;
				}
	td			{
				font-family: Verdana, Arial, Helvetica, sans-serif;
				font-size: 70%;
				line-height: 16px;
				color: black;
				}
	.content	{
				padding-left: 10px;
				padding-right: 10px;
				padding-bottom: 10px;
				padding-top: 10px;
				}
	.menu		{
				background: #D8D8D8 url('../../expression/site_<xsl:value-of select="//request/@blogID"/>/images/menu-fadeback.jpg') repeat-y left;
				font-family: Verdana, Arial, Helvetica, sans-serif;
				font-size: 70%;
				color: #36394D;
				border-right:1px solid #000;
				border-top:1px solid #000;
				padding:10px;
				padding-top: 15px;
				line-height: 14px;
				}
	.menuBlock		{
				border-bottom: 1px solid #325246; padding-left: 2px;
				}
	.topMenuItem		{
				color: white; text-align:center;background-color:#466B9E;
				}

	.topMenuItemOn
				{
				background: color: #466B9E; text-align:center; background-color:#fff;
				}
	.topMenuItemOver
				{
				color: white; text-align:center; background-color:#265080;
				}
	.main		{
				border: 1px solid #000; height:100%;
				background-color: #FFFFFF;
				color: #666666;
				width: 640px;
				color: #666666;
				font-weight: normal;
				}
	Body		{
				background: #1A1F5C;
				margin-left: auto;
				margin-right: auto;
				margin-top: 14px;
				margin-bottom: 14px;
				
				}
	a			{
				text-decoration:none;
				color: #265080;
				}
	a:hover		{
				background-color: #265080;
				text-decoration: none;
				color: #fff;
				}
	p			{
				margin-top: 0;
				margin-bottom: 0;
				}
	.psThumb	{
				border: 1px solid gray; 
				height: 74; 
				width: 74; 
				margin: 5px;
				cursor: pointer;
				}
	.psThumb:hover	
				{
				border: 1px solid #585C8F; 
				}
</style>
<script>
var picturePath = '\\expression\\site_<xsl:value-of select="//request/@blogID"/>\\pictures';
</script>
<title><xsl:value-of select="//eXpression/@site"/>
</title>
<LINK REL="alternate" TYPE="application/rss+xml">
	<xsl:attribute name="TITLE"><xsl:value-of select="//eXpression/@site"/> RSS Feed</xsl:attribute>
	<xsl:attribute name="HREF">../expression/expression.asmx/getBlogTransformed?blogID=<xsl:value-of select="//request/@blogID"/>&amp;topicID=<xsl:value-of select="//request/@topicID"/>&amp;startDate=&amp;entries=<xsl:value-of select="//request/@entries"/>&amp;style=styles/rssBlog.xsl&amp;contentType=XML&amp;privateKey=</xsl:attribute>
</LINK>
<base target="_blank"/>
<script>
	var oldClass;
	function menuOver(cell)
	{
		oldClass = cell.className;
		cell.className="topMenuItemOver";
	}
	
	function menuOut(cell)
	{
		cell.className=oldClass;
	}
	
	function menuClick(href)
	{
		if (href != "home")
			document.location = "?getWebPageTransformed?blogID=<xsl:value-of select="//request/@blogID"/>&amp;amp;page=" + href + "&amp;amp;style=<xsl:value-of select="//request/@style"/>&amp;amp;contentType=HTML";
		else
			document.location = "http://" + document.location.host;
	}
	
	function menuClickTopic(href)
	{
		if (href != "home")
			document.location = "?getBlogTransformed?blogID=<xsl:value-of select="//request/@blogID"/>&amp;amp;TopicID=" + href + "&amp;amp;startDate=&amp;amp;entries=10&amp;amp;style=&amp;amp;contentType=HTML&amp;amp;privateKey=";
		else
			document.location = "http://" + document.location.host;
	}
</script>
</head>
<body>
	<div align="center">
	<table border="0" class="main" height="100%" cellspacing="0" cellpadding="0" >
	<tr>
		<td class="menu">
			<xsl:attribute name="style">height:234;width:125;background-image: url('../<xsl:value-of select="//eXpression/@siteimage"/>');</xsl:attribute>
			&amp;nbsp;
		</td>
		<td valign="bottom" class="topMenuItem">
			<xsl:attribute name="style">
				<xsl:if test="//request/@page != '../pictures.htm' and //request/@page != '../files.htm'">
					<xsl:if test="//eXpression/webPage">background-color:#56617D;padding-bottom:10px; background-image: url('../expression/site_<xsl:value-of select="//request/@blogID"/>/images/<xsl:value-of select="//request/@page"/>.jpg');background-repeat:no-repeat;</xsl:if>
					<xsl:if test="//eXpression/dsBlog">background-color:#56617D;padding-bottom:10px; background-image: url('../expression/site_<xsl:value-of select="//request/@blogID"/>/images/discuss.jpg');background-repeat:no-repeat;</xsl:if>
				</xsl:if>
				<xsl:if test="//request/@page = '../pictures.htm'">background-color:#56617D;padding-bottom:10px; background-image: url('../expression/site_<xsl:value-of select="//request/@blogID"/>/images/files.htm.jpg');background-repeat:no-repeat;</xsl:if>
			</xsl:attribute>
			<table border="0" cellpadding="0" cellspacing="2" width="100%">
				<tr>
					
					<xsl:for-each select="//Links/Link">
						<xsl:sort select="@Pos"/>
						<xsl:if test="@HREF = 'topic'">
							<td onmouseover="menuOver(this)" onmouseout="menuOut(this)" style="cursor:pointer">
								<xsl:attribute name="class"><xsl:if test="@TopicID != //eXpression/webPage">topMenuItem</xsl:if><xsl:if test="//eXpression/dsBlog">topMenuItemOn</xsl:if></xsl:attribute>
								<xsl:attribute name="width"><xsl:value-of select="(1 div count(//Links/Link)) * 100"/>%</xsl:attribute>
								<xsl:attribute name="onclick">menuClickTopic('<xsl:value-of select="@TopicID"/>')</xsl:attribute>
								<xsl:value-of select="@Name"/>
							</td>
						</xsl:if>
						<xsl:if test="@HREF != 'topic'">
							<td onmouseover="menuOver(this)" onmouseout="menuOut(this)" style="cursor:pointer">
								<xsl:attribute name="class"><xsl:if test="@HREF != //request/@page">topMenuItem</xsl:if><xsl:if test="@HREF = //request/@page">topMenuItemOn</xsl:if></xsl:attribute>
								<xsl:attribute name="width"><xsl:value-of select="(1 div count(//Links/Link)) * 100"/>%</xsl:attribute>
								<xsl:attribute name="onclick">menuClick('<xsl:value-of select="@HREF"/>')</xsl:attribute>
								<xsl:value-of select="@Name"/>
							</td>
						</xsl:if>
					</xsl:for-each>	
				</tr>
			</table>
		</td>
	</tr>
	<tr>
	<td valign="top" class="menu" height="100%">
		<xsl:if test="//eXpression/dsBlog">
			<b>Discussion Tools</b>
			<div class="menuBlock">
				<br/>
				<a target="_blank"><xsl:attribute name="href">http://<xsl:value-of select="//eXpression/@adminRoot"/>/expression/admin/weblog-post.asp?siteID=<xsl:value-of select="//request/@blogID"/>&amp;TopicID=<xsl:value-of select="//request/@topicID"/></xsl:attribute>Post Entry</a><br/>
				<a><xsl:attribute name="href">http://<xsl:value-of select="//eXpression/@adminRoot"/>/expression/admin/?topicID=<xsl:value-of select="//request/@topicID"/>&amp;siteID=<xsl:value-of select="//request/@blogID"/></xsl:attribute>Manage Site (<xsl:value-of select="//eXpression/@unapprovedposts"/>)</a><br/>
				<a target="_blank"><xsl:attribute name="href">../expression/expression.asmx/getBlogTransformed?blogID=<xsl:value-of select="//request/@blogID"/>&amp;topicID=<xsl:value-of select="//request/@topicID"/>&amp;startDate=&amp;entries=<xsl:value-of select="//request/@entries"/>&amp;style=styles/rssBlog.xsl&amp;contentType=XML&amp;privatekey=0</xsl:attribute>RSS Feed</a><br/>
				<a target="_self"><xsl:attribute name="href">?getBlogTransformed?blogID=<xsl:value-of select="//request/@blogID"/>&amp;topicID=<xsl:value-of select="//request/@topicID"/>&amp;startDate=<xsl:value-of select="//request/@endDate"/>&amp;entries=<xsl:value-of select="//request/@entries"/>&amp;style=<xsl:value-of select="//request/@style"/>&amp;contentType=HTML&amp;privateKey=<xsl:value-of select="//request/@privateKey"/></xsl:attribute>&amp;lt;&amp;lt; Previous <xsl:value-of select="//request/@entries"/></a><br/>
				<br/>
			</div>
			<br/>
		</xsl:if>
		<xsl:if test="//eXpression/webPage">
			<b>Links</b>
			<div class="menuBlock">
				<br/>
				<xsl:for-each select="//Bookmarks/Link">
					<xsl:sort select="@Pos"/>	
					<a target="_self"><xsl:attribute name="href"><xsl:value-of select="@HREF"/></xsl:attribute><xsl:value-of select="@Name"/></a><br/>
				</xsl:for-each>
				<br/>
			</div>
			<br/>
		</xsl:if>
		<img alt="Powered by eXpression" border="0" style="cursor:pointer">
			<xsl:attribute name="src">
				http://<xsl:value-of select="//eXpression/@adminRoot"/>/expression/images/expression.gif?siteid=<xsl:value-of select="//request/@blogID"/>
			</xsl:attribute>
			<xsl:attribute name="onclick">
				window.open("http://www.expressionblogs.net")
			</xsl:attribute>
		</img>
		<br/>&amp;nbsp;<br/>
		
	</td>
	<td valign="top" class="content">
		
		<xsl:choose>
			<xsl:when test="//eXpression/dsBlog">
			
				<xsl:if test="//request/@topicID != ''">
					<h2><xsl:value-of select="//blogData/TopicName"/></h2>
				</xsl:if>
				<xsl:if test="//request/@topicID = ''">
					<h2>News</h2>
				</xsl:if>
				<xsl:for-each select="//blogData">
					<table style="clear:left; margin-top: 0px; padding-bottom:12px;" border='0' cellpadding='0' cellspacing='0'><tr><td>
						<h3><xsl:value-of select="EntryTitle"/>&amp;nbsp;<span class="PostHeaderDate"><xsl:value-of select="EntryDay"/></span></h3>
					</td></tr></table>
					<xsl:for-each select="dsImages/Image">
						<img align='left'><xsl:attribute name="src">../expression/show<xsl:value-of select="ImageType"/>.asp?imageid=<xsl:value-of select="ImageID"/></xsl:attribute></img>
					</xsl:for-each>
					<span><xsl:value-of select="EntryText"/></span>
					<h4>
					- posted by 
					<a>
						<xsl:attribute name="href">http://<xsl:value-of select="//eXpression/@adminRoot"/>/expression/admin/user-view.asp?userid=<xsl:value-of select="UserID"/></xsl:attribute>
						<xsl:value-of select="UserName"/>
					</a>
					 @ <xsl:value-of select="Time"/>
					<xsl:if test="//request/@topicID = ''">
						| <xsl:value-of select="TopicName"/> 
					</xsl:if>
					
					<xsl:if test="//request/@entries != '1'">
						| <a target="_self"><xsl:attribute name="href">?getBlogTransformed?blogID=<xsl:value-of select="//request/@blogID"/>&amp;topicID=<xsl:value-of select="TopicID"/>&amp;startDate=<xsl:value-of select="normalize-space(EntryDay)"/>%20<xsl:value-of select="normalize-space(Time)"/>&amp;entries=1&amp;style=<xsl:value-of select="//request/@style"/>&amp;contentType=HTML&amp;privateKey=<xsl:value-of select="//request/@privateKey"/></xsl:attribute>
						<xsl:if test="AllowComments = '1'">
							Link and Comments (<xsl:value-of select="@CommentCount"/>)
						</xsl:if>
						<xsl:if test="AllowComments = '0'">
							Link
						</xsl:if>
						</a>
					</xsl:if>
					</h4>
					
					<xsl:if test="AllowComments = '1'">
						<xsl:if test="//request/@entries = '1'">
							<table style="clear:left" border='0' cellpadding='0' cellspacing='0'><tr><td><h3>Comments</h3></td></tr></table>
							<br/>
							<div class="MenuBlock">
							<xsl:for-each select="dsComments/commentData">
									<b>
									<a>
										<xsl:attribute name="href">http://<xsl:value-of select="//eXpression/@adminRoot"/>/expression/admin/user-view.asp?userid=<xsl:value-of select="UserID"/></xsl:attribute>
										<xsl:value-of select="UserName"/>
									</a>
									 wrote...</b>
									<br/>
								<xsl:value-of select="Comment"/><br/><br/>
							</xsl:for-each>
							<a><xsl:attribute name="href">http://<xsl:value-of select="//eXpression/@adminRoot"/>/?type=1&amp;item=<xsl:value-of select="EntryID"/></xsl:attribute>Post New Comment</a>
							<br/>&amp;nbsp;
							</div>
							<br/>
						</xsl:if>
					</xsl:if>
				</xsl:for-each>
			</xsl:when>
			<xsl:when test="//eXpression/webPage">
				<xsl:value-of select="eXpression/webPage/pageData"/>
			</xsl:when>
		</xsl:choose>
	</td>
	
	</tr>
	</table>
	</div>
</body>
</html>
</xsl:template>
</xsl:stylesheet>