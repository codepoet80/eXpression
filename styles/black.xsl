<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" 
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
<xsl:template match="/">
<html>
<head>
<style>
	h1	{  font-size:200%;
				line-height:1.2em;
				color:#ccc;
				text-transform:uppercase;
				letter-spacing:.2em;}
	h2	{  font:bold 18/1.4em "Trebuchet MS",Trebuchet,Arial,Verdana,Sans-serif;
				text-transform:uppercase;
				letter-spacing:.2em;
				color:#777;}
	.PostHeaderDate { font-size: 12px; font-weight: bold;color:#777; }
	h3	{  margin:.25em 0 0;
				padding:0 0 4px;
				font-size:140%;
				font-weight:bold;
				line-height:1.4em;
				color:#EE0000;}
	h4	{font-size:11px;margin-top: 8px;margin-bottom:20px;padding-bottom: 15px;border-bottom:1px dotted white;color:gray;}
	h5		{font-size:11px;margin-top: 8px;margin-bottom:20px;padding-bottom: 15px;color:gray;}
	.SiteDesc	{  margin:5 px 5px;
				padding:10 0px 0px;
				font:110%/1.4em "Trebuchet MS",Trebuchet,Arial,Verdana,Sans-serif;
				text-transform:uppercase;
				letter-spacing:.2em;
				color:#777;
				}
	.menu		{border:1px solid #000;padding:10px;width:160px;margin:12px 15px 10px 0px;background-color:#eee}
	.main		{margin:12px 15px 10px 10px; padding:15px; border: 1px solid #000;background-color:white}
	Body		{margin-top:10px; margin-left:10px;background-color:#000000;color:white;font-family:arial,helvetica; font-size: 9pt;}
	TD		{font-family:arial,helvetica; font-size: 9pt;}
	a		{text-decoration:none; color: #ffffff}
	a:hover	{background-color: white; text-decoration: none; color: #000000}
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
				border: 1px solid #585C8F; 
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
	<table align="center" width="80%">
	<tr><td colspan="3" style="border:1px dotted white; background-color:#1f1f1f" align="center">
		<br/>
		<h1><xsl:value-of select="//eXpression/@site"/></h1>
		<p class="SiteDesc"><i><xsl:value-of select="//eXpression/@sitedescription"/></i></p><br/>
	</td></tr>
	<tr><td colspan="3">&amp;nbsp;</td></tr>
	<tr>
	<td valign="top" width="100%">
		<xsl:choose>
			<xsl:when test="//eXpression/dsBlog">
				<xsl:if test="//request/@topicID != ''">
					<h2><xsl:value-of select="//blogData/TopicName"/></h2>
				</xsl:if>
				<xsl:if test="//request/@topicID = ''">
					<h2>Home</h2>
				</xsl:if>
				<xsl:for-each select="//blogData">
					<table style="clear:left" border='0' cellpadding='0' cellspacing='0'><tr><td><h3><xsl:value-of select="EntryTitle"/></h3><xsl:value-of select="EntryDay"/><br/>&amp;nbsp;</td></tr></table>
					
					<xsl:for-each select="dsImages/Image">
						<img align='left'><xsl:attribute name="src">../expression/show<xsl:value-of select="ImageType"/>.asp?imageid=<xsl:value-of select="ImageID"/></xsl:attribute></img>
					</xsl:for-each>
					
					<xsl:value-of select="EntryText"/>
					
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
							<a><xsl:attribute name="href">http://<xsl:value-of select="//eXpression/@adminRoot"/>/expression/admin/comment-post.asp?type=1&amp;item=<xsl:value-of select="EntryID"/></xsl:attribute>Post New Comment</a>
							<br/>&amp;nbsp;
							</div>
							<br/>
						</xsl:if>
					</xsl:if>
				</xsl:for-each>
				<br/>
			</xsl:when>
			<xsl:when test="//eXpression/webPage">
				<xsl:value-of select="eXpression/webPage/pageData"/>
			</xsl:when>
		</xsl:choose>
	</td>
	<td width="25"></td>
	<td valign="top" width="150">
	<b>Content</b>
		<div class="menuBlock">
		
		<xsl:if test="//request/@topicID = '' and //request/@page = ''">
				<br/>Home<br/>
		</xsl:if>
		<xsl:if test="//request/@topicID != '' or //request/@page != ''">
				<br/><a target="_self"><xsl:attribute name="href">?getBlogTransformed?blogID=<xsl:value-of select="//request/@blogID"/>&amp;topicID=&amp;startDate=&amp;entries=10&amp;style=<xsl:value-of select="//request/@style"/>&amp;contentType=HTML&amp;privateKey=</xsl:attribute>Home</a><br/>
		</xsl:if>
		
		<xsl:for-each select="//Links/Link">
			<xsl:sort select="@Pos"/>
			<xsl:if test="@HREF != //request/@page">
				<a target="_self"><xsl:attribute name="href">?getWebPageTransformed?blogID=<xsl:value-of select="//request/@blogID"/>&amp;page=<xsl:value-of select="@HREF"/>&amp;style=<xsl:value-of select="//request/@style"/>&amp;contentType=HTML</xsl:attribute>
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
							&amp;nbsp;&amp;nbsp;&amp;nbsp;<a target="_self"><xsl:attribute name="href">?getWebPageTransformed?blogID=<xsl:value-of select="//request/@blogID"/>&amp;page=<xsl:value-of select="@HREF"/>&amp;style=<xsl:value-of select="//request/@style"/>&amp;contentType=HTML</xsl:attribute><xsl:value-of select="@Name"/></a>
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
				<br/><a target="_self"><xsl:attribute name="href">?getBlogTransformed?blogID=<xsl:value-of select="//request/@blogID"/>&amp;topicID=<xsl:value-of select="TopicID"/>&amp;startDate=&amp;entries=<xsl:value-of select="MaxPerPage"/>&amp;style=<xsl:value-of select="//request/@style"/>&amp;contentType=HTML&amp;privateKey=<xsl:value-of select="//request/@privateKey"/></xsl:attribute><xsl:value-of select="TopicName"/></a>
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
				<a target="_blank"><xsl:attribute name="href">http://<xsl:value-of select="//eXpression/@adminRoot"/>/expression/admin/?/expression/admin/weblog-post.asp?siteID=<xsl:value-of select="//request/@blogID"/>&amp;TopicID=<xsl:value-of select="//request/@topicID"/></xsl:attribute>Post Entry</a><br/>
				<a><xsl:attribute name="href">http://<xsl:value-of select="//eXpression/@adminRoot"/>/expression/admin/?topicID=<xsl:value-of select="//request/@topicID"/>&amp;siteID=<xsl:value-of select="//request/@blogID"/></xsl:attribute>Manage Site (<xsl:value-of select="//eXpression/@unapprovedposts"/>)</a><br/>
				<a target="_blank"><xsl:attribute name="href">../expression/expression.asmx/getBlogTransformed?blogID=<xsl:value-of select="//request/@blogID"/>&amp;topicID=<xsl:value-of select="//request/@topicID"/>&amp;startDate=&amp;entries=<xsl:value-of select="//request/@entries"/>&amp;style=styles/rssBlog.xsl&amp;contentType=XML&amp;privatekey=0</xsl:attribute>RSS Feed</a><br/>
				<a target="_self"><xsl:attribute name="href">?getBlogTransformed?blogID=<xsl:value-of select="//request/@blogID"/>&amp;topicID=<xsl:value-of select="//request/@topicID"/>&amp;startDate=<xsl:value-of select="//request/@endDate"/>&amp;entries=<xsl:value-of select="//request/@entries"/>&amp;style=<xsl:value-of select="//request/@style"/>&amp;contentType=HTML&amp;privateKey=<xsl:value-of select="//request/@privateKey"/></xsl:attribute>&amp;lt;&amp;lt; Previous <xsl:value-of select="//request/@entries"/></a><br/>
				<br/>
			</div>
		</xsl:if>
		<br/>&amp;nbsp;<br/>
		<script type="text/javascript">
		google_ad_client = "pub-4539927151175539";
		google_ad_width = 120;
		google_ad_height = 240;
		google_ad_format = "120x240_as";
		google_ad_channel ="";
		google_ad_type = "text";
		google_color_border = "333333";
		google_color_bg = "000000";
		google_color_link = "FFFFFF";
		google_color_url = "999999";
		google_color_text = "CCCCCC";
		</script>
		<script type="text/javascript"
		src="http://pagead2.googlesyndication.com/pagead/show_ads.js">
		</script>
	</td>
	
	</tr>
	<tr>
	<td colspan="3">
			<xsl:if test="//eXpression/dsBlog">
				<h5>
				<a target="_blank"><xsl:attribute name="href">http://<xsl:value-of select="//eXpression/@adminRoot"/>/expression/admin/weblog-post.asp?siteID=<xsl:value-of select="//request/@blogID"/>&amp;TopicID=<xsl:value-of select="//request/@topicID"/></xsl:attribute>Post Entry</a> | 
				<a><xsl:attribute name="href">http://<xsl:value-of select="//eXpression/@adminRoot"/>/expression/admin/?topicID=<xsl:value-of select="//request/@topicID"/>&amp;siteID=<xsl:value-of select="//request/@blogID"/></xsl:attribute>Manage Site (<xsl:value-of select="//eXpression/@unapprovedposts"/>)</a>
				<br/>
				<a target="_self"><xsl:attribute name="href">?getBlogTransformed?blogID=<xsl:value-of select="//request/@blogID"/>&amp;topicID=<xsl:value-of select="//request/@topicID"/>&amp;startDate=<xsl:value-of select="//request/@endDate"/>&amp;entries=<xsl:value-of select="//request/@entries"/>&amp;style=<xsl:value-of select="//request/@style"/>&amp;contentType=HTML&amp;privateKey=<xsl:value-of select="//request/@privateKey"/></xsl:attribute>Previous <xsl:value-of select="//request/@entries"/> </a> |
				<a target="_blank"><xsl:attribute name="href">../expression/expression.asmx/getBlogTransformed?blogID=<xsl:value-of select="//request/@blogID"/>&amp;topicID=<xsl:value-of select="//request/@topicID"/>&amp;startDate=&amp;entries=<xsl:value-of select="//request/@entries"/>&amp;style=styles/rssBlog.xsl&amp;contentType=XML&amp;privatekey=0</xsl:attribute><img src="/expression/images/xml.gif" border="0" align="absmiddle"/></a>
				</h5>
			</xsl:if>
	</td>
	</tr>
	</table>
</body>
</html>
</xsl:template>
</xsl:stylesheet>

