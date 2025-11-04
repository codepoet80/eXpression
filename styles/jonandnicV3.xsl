<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" 
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
<xsl:template match="/">
<head>
<LINK REL="alternate" TYPE="application/rss+xml">
	<xsl:attribute name="TITLE">
		<xsl:value-of select="//eXpression/@site"/> RSS Feed
	</xsl:attribute>
	<xsl:attribute name="HREF">
		../expression/expression.asmx/getBlogTransformed?blogID=<xsl:value-of select="//request/@blogID"/>&amp;topicID=<xsl:value-of select="//request/@topicID"/>&amp;startDate=&amp;entries=<xsl:value-of select="//request/@entries"/>&amp;style=styles/rssBlog.xsl&amp;contentType=XML&amp;privateKey=
	</xsl:attribute>
</LINK>
<style type="text/css">
	.SiteTitle	{font-family: Century Gothic, Arial; font-size: 20px; letter-spacing: 0.0pt; font-weight: bold; color: #31344A;}
	.PageTitle	{font-size:14px;width:200px;color:#31344A;font-weight:bold;}
	.PostHeader	{border-bottom:solid 1px #585C8F;font-size:14px;text-align:left;width:350px;color:#31344A;font-weight:bold;}
	.PostHeaderDate	{
			font-family: Verdana,Arial, Helvetica, sans-serif;
			font-size: 10px;
			text-transform: uppercase;
			color: #666;
			}
	.PostFooter	{font-size:11px;margin-top: 8px;margin-bottom:20px;color:gray;}
	.SiteDesc	{color: #31344A;font-weight:bold;}
	.menu		{border:1px solid #000;padding:10px;width:160px;margin:12px 15px 10px 0px;background-color:#eee;}
	.main		{margin:12px 15px 10px 10px; padding:15px; border: 1px solid #000;background-color:white;}
	Body		{margin-top:10px; margin-left:10px;font-family:Arial, Helvetica; font-size: 9pt;
				background: #ACB0BF url(/expression/site_1/images/blue-gradient.gif);background-repeat: repeat-x; background-attachment: fixed; background-position: left bottom;}
	TD			{font-family:arial,helvetica; font-size: 9pt;}
	a			{text-decoration:none; color: #585C8F;}
	a:hover		{background-color: #ACB0BF; text-decoration: none; color: #000000;}
	p			{ margin-top: 0; margin-bottom: 0;}
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
<title><xsl:value-of select="//eXpression/@site"/></title>
<script type="text/javascript">
	function openWindow(page)
	{
		window.open(page, "system", "width=570,scrollbars=yes,height=600,menubar=no,toolbar=no,resizable=yes");
	}
	var picturePath = '\\expression\\site_<xsl:value-of select="//request/@blogID"/>\\pictures';
</script>
<base target="_blank"/>
</head>
<body>
	<xsl:choose>
	<xsl:when test="//request/@topicID = ''">
		<div align="center" class="SiteTitle" style="cursor:pointer;float: right;border:1px solid #000; padding:9px;margin:12px 0px 10px 10px;background-color:#eeeeee;">
			<xsl:attribute name="onclick">document.location="?getWebPageTransformed?blogID=1&amp;page=about.htm&amp;style=&amp;contentType=HTML&amp;privateKey="</xsl:attribute>
			&amp;nbsp;<xsl:value-of select="//eXpression/@site"/>&amp;nbsp;<br/>
		<img><xsl:attribute name="src">../<xsl:value-of select="//eXpression/@siteimage"/></xsl:attribute></img>
		</div>
	</xsl:when>
	<xsl:otherwise>
		<div align="center" class="SiteTitle" style="cursor:pointer;float: right;border:1px solid #000; padding:9px;margin:12px 0px 10px 10px;background-color:#eeeeee;">
			<xsl:attribute name="onclick">document.location="?getBlogTransformed?blogID=<xsl:value-of select="//request/@blogID"/>&amp;topicID=<xsl:value-of select="TopicID"/>&amp;startDate=&amp;entries=<xsl:value-of select="MaxPerPage"/>&amp;style=<xsl:value-of select="//request/@style"/>&amp;contentType=HTML&amp;privateKey="</xsl:attribute>
			&amp;nbsp;<xsl:value-of select="//eXpression/@site"/>&amp;nbsp;<br/>
		</div>
	</xsl:otherwise>
	</xsl:choose>
	    
	<!--menu-->
	<div id="menu" class="menu" style="float:left;">		
		<p class="SiteDesc"><i><xsl:value-of select="//eXpression/@sitedescription"/></i></p><br/>
		<b>Topics</b>
	<br/><a target="_self"><xsl:attribute name="href">?getBlogTransformed?blogID=<xsl:value-of select="//request/@blogID"/>&amp;topicID=&amp;startDate=&amp;entries=10&amp;style=<xsl:value-of select="//request/@style"/>&amp;contentType=HTML&amp;privateKey=</xsl:attribute>Home</a>
		<xsl:for-each select="//tblTopics">
			<br/><a target="_self"><xsl:attribute name="href">?getBlogTransformed?blogID=<xsl:value-of select="//request/@blogID"/>&amp;topicID=<xsl:value-of select="TopicID"/>&amp;startDate=&amp;entries=<xsl:value-of select="MaxPerPage"/>&amp;style=<xsl:value-of select="//request/@style"/>&amp;contentType=HTML&amp;privateKey=0</xsl:attribute><xsl:value-of select="TopicName"/></a>
		</xsl:for-each>
		<br/><br/>
		<b>Content</b>
		<xsl:for-each select="//Links/Link">
			<xsl:sort select="@Pos"/>
			<br/>
			<a target="_self"><xsl:attribute name="href">?getWebPageTransformed?blogID=<xsl:value-of select="//request/@blogID"/>&amp;page=../pictures.htm&amp;style=<xsl:value-of select="//request/@style"/>&amp;contentType=HTML</xsl:attribute><xsl:value-of select="@Name"/></a>			
		</xsl:for-each>
		
		<br/>&amp;nbsp;<br/>
		
		<script type="text/javascript">
		google_ad_client = "pub-4539927151175539";
		google_ad_width = 120;
		google_ad_height = 240;
		google_ad_format = "120x240_as";
		google_ad_channel ="";
		google_ad_type = "text";
		google_color_border = "EEEEEE";
		google_color_bg = "EEEEEE";
		google_color_link = "585C8F";
		google_color_url = "585C8F";
		google_color_text = "000000";
		</script>
		<script type="text/javascript"
		src="http://pagead2.googlesyndication.com/pagead/show_ads.js">
		</script>
	</div>
		
	<div id="main" class="main">
		<xsl:choose>
			<xsl:when test="//eXpression/dsBlog">
				<xsl:if test="//request/@topicID != ''">
					<span class="PageTitle"><br/><xsl:value-of select="//blogData/TopicName"/><br/>&amp;nbsp;</span>
				</xsl:if>
				<xsl:if test="//request/@topicID = ''">
					<span class="PageTitle"><br/>Home<br/>&amp;nbsp;</span>
				</xsl:if>
				<br/>&amp;nbsp;<br/>
				<xsl:for-each select="//blogData">
					<table border='0' cellpadding='0' cellspacing='0'><tr><td class="PostHeader"><xsl:value-of select="EntryTitle"/><font style="color:gray"> - <xsl:value-of select="EntryDay"/></font></td></tr></table><br/>
					<xsl:for-each select="dsImages/Image">
						<img align='left' style='border-right: 5px solid white'><xsl:attribute name="src">../expression/show<xsl:value-of select="ImageType"/>.asp?imageid=<xsl:value-of select="ImageID"/></xsl:attribute></img>
					</xsl:for-each>
					<xsl:value-of select="EntryText"/>
					<p/>
					
					<p class="PostFooter">
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
					</p>
					
					<xsl:if test="AllowComments = '1'">
						<xsl:if test="//request/@entries = '1'">
							<table style="clear:left" border='0' cellpadding='0' cellspacing='0'><tr><td><span class="PostHeader">Comments</span></td></tr></table>
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
				<p class="PostFooter" align="right">
				<a target="_blank"><xsl:attribute name="href">http://<xsl:value-of select="//eXpression/@adminRoot"/>/expression/admin/weblog-post.asp?siteID=<xsl:value-of select="//request/@blogID"/>&amp;TopicID=<xsl:value-of select="//request/@topicID"/></xsl:attribute>Post Entry</a> | 
				<a><xsl:attribute name="href">http://<xsl:value-of select="//eXpression/@adminRoot"/>/expression/admin/?topicID=<xsl:value-of select="//request/@topicID"/>&amp;siteID=<xsl:value-of select="//request/@blogID"/></xsl:attribute>Manage Site (<xsl:value-of select="//eXpression/@unapprovedposts"/>)</a>
				<br/>
					<a target="_blank" href="http://www.expressionblogs.net">
					<img alt="Powered by eXpression" border="0">
						<xsl:attribute name="src">
							http://<xsl:value-of select="//eXpression/@adminRoot"/>/expression/images/expression.gif?siteid=<xsl:value-of select="//request/@blogID"/>
						</xsl:attribute>
					</img>
					</a>
				</p>
				<span class="PostFooter">
				<a target="_self"><xsl:attribute name="href">?getBlogTransformed?blogID=<xsl:value-of select="//request/@blogID"/>&amp;topicID=<xsl:value-of select="//request/@topicID"/>&amp;startDate=<xsl:value-of select="//request/@endDate"/>&amp;entries=<xsl:value-of select="//request/@entries"/>&amp;style=<xsl:value-of select="//request/@style"/>&amp;contentType=HTML&amp;privateKey=<xsl:value-of select="//request/@privateKey"/></xsl:attribute>Previous <xsl:value-of select="//request/@entries"/> </a> |
				<a target="_blank"><xsl:attribute name="href">../expression/expression.asmx/getBlogTransformed?blogID=<xsl:value-of select="//request/@blogID"/>&amp;topicID=<xsl:value-of select="//request/@topicID"/>&amp;startDate=&amp;entries=<xsl:value-of select="//request/@entries"/>&amp;style=styles/rssBlog.xsl&amp;contentType=XML&amp;privateKey=</xsl:attribute><img src="/expression/images/xml.gif" border="0" align="absmiddle"/></a>
				<p align="right">
				codepoet80 2004, <a href="http://creativecommons.org/licenses/by-nc/1.0/">Some Rights Reserved</a></p></span>
			</xsl:when>
			<xsl:when test="//eXpression/webPage">
				<br/>
				<xsl:value-of select="eXpression/webPage/pageData"/>
				<p align="right" class="PostFooter">
				<a href="http://creativecommons.org/licenses/by-nc/1.0/">Some Rights Reserved</a></p>
			</xsl:when>
		</xsl:choose>
	</div>
</body>
</xsl:template>
</xsl:stylesheet>