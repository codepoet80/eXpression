<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" 
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
<xsl:template match="/">
<html>
<head>
<style>
	.SiteTitleCell	{ line-height:1.2em;
				color:#ccc;
				letter-spacing:.2em; background-color:#335577;
				border: 8px solid #112233; padding:14px;}
	h1 {
				color: #fff;
				font:bold 210%/45px Helvetica,Arial,Verdana,Sans-serif;
				}
	.SiteDesc	{  margin: 0;
				padding: 12px 0 0 20px;
				font-family: "Trebuchet MS",Trebuchet,Arial,Verdana,Sans-serif;
				font-size: 14px;
				text-transform:uppercase;
				letter-spacing:.2em;
				color:#fff;
				}
	h2		{  font:bold 18/1.4em "Trebuchet MS",Trebuchet,Arial,Verdana,Sans-serif;
				text-transform:uppercase;
				letter-spacing:.2em;
				color:#335577;
				}
	h3		{  margin:.25em 0 0;
				padding:4px 18px 4px;
				font-size:148%;
				font-weight:bold;
				line-height:1.4em;
				color:#558866;}
	.PostHeaderDate	{
		font-family:arial,helvetica; font-size: 9pt;
		text-transform: uppercase;
		color: #558866; font-weight:bold;
		}
	.PostFooter	{border-top: 1px dashed #bbbb99; font-family: "Trebuchet MS",Trebuchet,Verdana,Arial,Sans-serif;font-size:11px; font-weight:bold; padding-left: 18px; background-color:white; padding-bottom: 8px; padding-top:8px; color:#666666;}

	.menu		{
				width: 210px;
				padding: 15px;
				color: #080D54;
				border: 8px solid #112233;
				background-color:#558866;
				}
	.menuBlock	{
				border-bottom: 1px dotted #ffffff;
				}
	.menuItem	{
				color: white;
				}
	.main		{width: 550px; margin:12px 15px 10px 10px; padding:16px; border: 8px solid #112233;background-color:#eeeecc;}
	Body		{
				margin: 0;
				padding: 0;
				text-align: center;
				min-width: 760px;
				background: #112233;
				font-family: helvetica, arial, verdana, "trebuchet ms", sans-serif;
				color: #4a4a4a;
				}
	TD		{font-family:tahoma,arial,helvetica; font-size: 13px;}
	a		{
			text-decoration:none; color: #334477;
			font-weight: bold;
			}

	a:hover {
			color: #226699; text-decoration:none; background-color: white;
			}
	p		{ margin-top: 0; margin-bottom: 0 }
	.psThumb	{
				border: 1px solid gray; 
				height: 74; 
				width: 74; 
				margin: 5px;
				cursor: pointer;
				}
	.psThumb:hover	
				{
				border: 1px solid #226699; 
				}

</style>
<script>
var picturePath = '\\expression\\site_<xsl:value-of select="//request/@blogID"/>\\pictures';
</script>
<title><xsl:value-of select="//eXpression/@site"/></title>
<LINK REL="alternate" TYPE="application/rss+xml">
	<xsl:attribute name="TITLE">
		<xsl:value-of select="//eXpression/@site"/> RSS Feed
	</xsl:attribute>
	<xsl:attribute name="HREF">
		../expression/expression.asmx/getBlogTransformed?blogID=<xsl:value-of select="//request/@blogID"/>&amp;topicID=<xsl:value-of select="//request/@topicID"/>&amp;startDate=&amp;entries=<xsl:value-of select="//request/@entries"/>&amp;style=styles/rssBlog.xsl&amp;contentType=XML&amp;privateKey=
	</xsl:attribute>
</LINK>
<base target="_blank"/>
</head>
<body>
	<table align="center" width="760" cellspacing="0">
	<tr>
	<td class="SiteTitleCell" valign="top">
		<h1><xsl:value-of select="//eXpression/@site"/>
		<xsl:if test="//eXpression/@sitedescription != ''">
			<br/><span class="SiteDesc"><i><xsl:value-of select="//eXpression/@sitedescription"/></i></span>
		</xsl:if>
		</h1>
	</td></tr>
	</table>
	<table align="center" width="760" cellspacing="0">
	<tr>
	<td valign="top" class="main">
		<xsl:choose>
			<xsl:when test="//eXpression/dsBlog">
				<xsl:if test="//request/@topicID != ''">
					<h2><xsl:value-of select="//blogData/TopicName"/></h2>
				</xsl:if>
				<xsl:if test="//request/@topicID = ''">
					<h2>Home</h2>
				</xsl:if>
				<xsl:for-each select="//blogData">
					<table style="clear:left;border:1px dashed #bbbb99" border='0' width="100%" cellpadding='0' cellspacing='2'><tr><td>
					<h3><xsl:value-of select="EntryTitle"/> - <span class="PostHeaderDate"><xsl:value-of select="EntryDay"/></span></h3>
					</td></tr>
					<tr><td style="padding-left:18px;padding-right:18px">
					<xsl:for-each select="dsImages/Image">
						<a target="_blank">
							<xsl:attribute name="href">../../expression/showImage.asp?imageID=<xsl:value-of select="ImageID"/></xsl:attribute>
							<img align='center' border="0" style="border: 1px solid #bbbb99; margin: 2px"><xsl:attribute name="src">../../expression/expression.asmx/getImageData?pathType=DB&amp;amp;imageID=<xsl:value-of select="ImageID"/>&amp;amp;width=0&amp;amp;height=248</xsl:attribute></img>
						</a>
						<br/>
					</xsl:for-each>
					
					<xsl:value-of select="EntryText"/><br/>&amp;nbsp;
					</td></tr><tr><td class="PostFooter">
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
					</td></tr></table>
					
					<xsl:if test="AllowComments = '1'">
						<xsl:if test="//request/@entries = '1'">
							<br/>
							<table style="clear:left;border:0px solid #bbbb99" width="100%" border='0' cellpadding='0' cellspacing='2'><tr><td>
							<h2>Comments</h2>
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
							<a><xsl:attribute name="href">http://<xsl:value-of select="//eXpression/@adminRoot"/>/expression/admin/comment-post.asp?type=1&amp;item=<xsl:value-of select="EntryID"/></xsl:attribute>Post New Comment</a>
							<br/>&amp;nbsp;
							</div>
							</td></tr></table>
						</xsl:if>
					</xsl:if>
				<p/>&amp;nbsp;<p/>&amp;nbsp;
				</xsl:for-each>
				
			</xsl:when>
			<xsl:when test="//eXpression/webPage">
				<xsl:value-of select="eXpression/webPage/pageData"/>
			</xsl:when>
		</xsl:choose>
	</td>
	<td valign="top">
		<div class="menu">
		<b>Content</b>
		<div class="menuBlock">
		
		<xsl:if test="//request/@topicID = '' and //request/@page = ''">
				<br/>Home<br/>
		</xsl:if>
		<xsl:if test="//request/@topicID != '' or //request/@page != ''">
				<br/><a target="_self" class="menuItem"><xsl:attribute name="href">?getBlogTransformed?blogID=<xsl:value-of select="//request/@blogID"/>&amp;topicID=&amp;startDate=&amp;entries=10&amp;style=<xsl:value-of select="//request/@style"/>&amp;contentType=HTML&amp;privateKey=</xsl:attribute>Home</a><br/>
		</xsl:if>
		
		<xsl:for-each select="//Links/Link">
			<xsl:sort select="@Pos"/>
			<xsl:if test="@HREF != //request/@page">
				<a target="_self" class="menuItem"><xsl:attribute name="href">?getWebPageTransformed?blogID=<xsl:value-of select="//request/@blogID"/>&amp;page=<xsl:value-of select="@HREF"/>&amp;style=<xsl:value-of select="//request/@style"/>&amp;contentType=HTML</xsl:attribute>
					<xsl:value-of select="@Name"/>
				</a>
			</xsl:if>
			<xsl:if test="@HREF = //request/@page">
				<xsl:value-of select="@Name"/>
			</xsl:if>
			<br/>
		
			<xsl:if test="Link">
				<div>
					<xsl:attribute name="id">subMenu<xsl:value-of select="@HREF"/></xsl:attribute>
					<xsl:attribute name="style">display:none</xsl:attribute>
					<xsl:if test="@HREF = //request/@page">
						<xsl:attribute name="style">display:block</xsl:attribute>
					</xsl:if>
					<xsl:for-each select="Link">
						<xsl:if test="@HREF = //request/@page">
							<xsl:attribute name="style">display:block</xsl:attribute>
						</xsl:if>
						
					</xsl:for-each>
					
					<xsl:for-each select="Link">
						<xsl:if test="@HREF != //request/@page">
							&amp;nbsp;&amp;nbsp;&amp;nbsp;<a target="_self" class="menuItem"><xsl:attribute name="href">?getWebPageTransformed?blogID=<xsl:value-of select="//request/@blogID"/>&amp;page=<xsl:value-of select="@HREF"/>&amp;style=<xsl:value-of select="//request/@style"/>&amp;contentType=HTML</xsl:attribute><xsl:value-of select="@Name"/></a>
						</xsl:if>
						<xsl:if test="@HREF = //request/@page">
							&amp;nbsp;&amp;nbsp;&amp;nbsp;<xsl:value-of select="@Name"/>
						</xsl:if>
						<br/>
					</xsl:for-each>
				</div>
			</xsl:if>
		</xsl:for-each>
		<br/>
		</div>
		<br/>
		<b>Topics</b>
		<div class="menuBlock">
		<xsl:for-each select="//tblTopics">
			<xsl:if test="TopicID != //request/@topicID">
				<br/><a target="_self" class="menuItem"><xsl:attribute name="href">?getBlogTransformed?blogID=<xsl:value-of select="//request/@blogID"/>&amp;topicID=<xsl:value-of select="TopicID"/>&amp;startDate=&amp;entries=<xsl:value-of select="MaxPerPage"/>&amp;style=<xsl:value-of select="//request/@style"/>&amp;contentType=HTML&amp;privateKey=<xsl:value-of select="//request/@privateKey"/></xsl:attribute><xsl:value-of select="TopicName"/></a>
			</xsl:if>
			<xsl:if test="TopicID = //request/@topicID">
				<br/><xsl:value-of select="TopicName"/>
			</xsl:if>
		</xsl:for-each>
		<br/>&amp;nbsp;
		</div>
		
		<xsl:if test="//eXpression/dsBlog">
			<br/>
			<b>Site</b>
			<div class="menuBlock">
				<br/>
				<a target="_blank" class="menuItem"><xsl:attribute name="href">http://<xsl:value-of select="//eXpression/@adminRoot"/>/expression/admin/weblog-post.asp?siteID=<xsl:value-of select="//request/@blogID"/>&amp;TopicID=<xsl:value-of select="//request/@topicID"/></xsl:attribute>Post Entry</a><br/>
				<a class="menuItem"><xsl:attribute name="href">http://<xsl:value-of select="//eXpression/@adminRoot"/>/expression/admin/?topicID=<xsl:value-of select="//request/@topicID"/>&amp;siteID=<xsl:value-of select="//request/@blogID"/></xsl:attribute>Manage Site (<xsl:value-of select="//eXpression/@unapprovedposts"/>)</a><br/>
				<a target="_blank" class="menuItem"><xsl:attribute name="href">../expression/expression.asmx/getBlogTransformed?blogID=<xsl:value-of select="//request/@blogID"/>&amp;topicID=<xsl:value-of select="//request/@topicID"/>&amp;startDate=&amp;entries=<xsl:value-of select="//request/@entries"/>&amp;style=styles/rssBlog.xsl&amp;contentType=XML&amp;privatekey=0</xsl:attribute>RSS Feed</a><br/>
				<a target="_self" class="menuItem"><xsl:attribute name="href">?getBlogTransformed?blogID=<xsl:value-of select="//request/@blogID"/>&amp;topicID=<xsl:value-of select="//request/@topicID"/>&amp;startDate=<xsl:value-of select="//request/@endDate"/>&amp;entries=<xsl:value-of select="//request/@entries"/>&amp;style=<xsl:value-of select="//request/@style"/>&amp;contentType=HTML&amp;privateKey=<xsl:value-of select="//request/@privateKey"/></xsl:attribute>&amp;lt;&amp;lt; Previous <xsl:value-of select="//request/@entries"/></a><br/>
				<br/>
			</div>
		</xsl:if>
		
				<br/>
		<a target="_blank" href="http://www.expressionblogs.net">
		<img alt="Powered by eXpression" border="0">
			<xsl:attribute name="src">
				http://<xsl:value-of select="//eXpression/@adminRoot"/>/expression/images/expression.gif?siteid=<xsl:value-of select="//request/@blogID"/>
			</xsl:attribute>
		</img>
		</a>
		</div>
		<div class="menu" style="background-color: 223344;">
		<script type="text/javascript">
		google_ad_client = "pub-4539927151175539";
		google_ad_width = 120;
		google_ad_height = 240;
		google_ad_format = "120x240_as";
		google_ad_channel ="";
		google_ad_type = "text";
		google_color_border = "223344";
		google_color_bg = "223344";
		google_color_link = "226699";
		google_color_url = "008000";
		google_color_text = "6F6F6F";
		</script>
		<script type="text/javascript"
		src="http://pagead2.googlesyndication.com/pagead/show_ads.js">
		</script>
		</div>
	</td>
	
	</tr>
	<tr>
	<td colspan="3">
			
	</td>
	</tr>
	</table>
</body>
</html>
</xsl:template>
</xsl:stylesheet>

