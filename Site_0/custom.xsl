<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" 
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
<xsl:template match="/">
<html>
<head>
<title><xsl:value-of select="//eXpression/@site"/></title>
<script>
	function openWindow(page)
	{
		window.open(page, "system", "width=570,scrollbars=yes,height=600,menubar=no,toolbar=no,resizable=yes");
	}
</script>
<style>
.PageTitle	{font-family: Century Gothic, Arial; font-size: 22px; letter-spacing: 0.0pt; font-weight: bold; color: #31344A}
.TopicHeader{font-size:14px;margin-top:15px;width:200px;margin-bottom:10px;color:#31344A;font-weight:bold}
.PostHeader	{font-size:14px;text-align:left;margin-top:10px;margin-bottom:5px;color:#2A2A7E;font-weight:bold; padding-bottom:10px;}
.PostFooter	{font-size:11px;margin-top:5px;margin-bottom:20px;color:gray;}
.SiteDesc	{color: #31344A;font-weight:bold;}
.menu		{border:1px solid #000;padding:10px;width:160px;margin:12px 15px 10px 0px;background-color:#eee}
.main		{margin:12px 15px 10px 10px; padding:15px; border: 1px solid #000;background-color:white}
Body		{margin-top:10px; margin-left:10px;background-color:#E5E5E5;filter:progid:DXImageTransform.Microsoft.Gradient(GradientType=0, StartColorStr='#E5E5E5', EndColorStr='#FFFFFF');font-family:arial,helvetica; font-size: 9pt;}
a			{text-decoration:none; color: #2A2A7E}
a:hover		{background-color: #2A2A7E; text-decoration: none; color: #fff}
</style>
<base target="_blank"/>
</head>
<body>
		<div id="main" class="main">
		<xsl:choose>
			<xsl:when test="//eXpression/dsBlog">
				<xsl:for-each select="//blogData">
					<table style="clear:left" border='0' cellpadding='0' cellspacing='0'><tr><td class="PostHeader"><xsl:value-of select="EntryTitle"/> - <span class="PostFooter"><xsl:value-of select="EntryDay"/></span></td></tr></table>
					
					<xsl:for-each select="dsImages/Image">
						<img align='left'><xsl:attribute name="src">../../expression/show<xsl:value-of select="ImageType"/>.asp?imageid=<xsl:value-of select="ImageID"/></xsl:attribute></img>
					</xsl:for-each>
					
					<xsl:value-of select="EntryText"/>
					
					<p class="PostFooter">
					- posted by <xsl:value-of select="UserName"/> @ <xsl:value-of select="Time"/>
					<xsl:if test="//request/@topicID = ''">
						| <xsl:value-of select="TopicName"/> 
					</xsl:if>
					
					<xsl:if test="//request/@entries != '1'">
						| <a target="_self"><xsl:attribute name="href">../../expression/expression.asmx/getBlogTransformed?blogID=<xsl:value-of select="//request/@blogID"/>&amp;topicID=<xsl:value-of select="TopicID"/>&amp;startDate=<xsl:value-of select="normalize-space(EntryDay)"/>%20<xsl:value-of select="normalize-space(Time)"/>&amp;entries=1&amp;style=<xsl:value-of select="//request/@style"/>&amp;contentType=HTML&amp;privateKey=<xsl:value-of select="//request/@privateKey"/></xsl:attribute>Link and Comments (<xsl:value-of select="@CommentCount"/>)</a>
					</xsl:if>
					</p>
											
					<xsl:if test="//request/@entries = '1'">
						<table style="clear:left" border='0' cellpadding='0' cellspacing='0'><tr><td><span class="PostHeader">Comments</span></td></tr></table>
						<xsl:for-each select="dsComments/commentData">
							<b><i><xsl:value-of select="UserName"/></i> wrote...</b><br/>
							<xsl:value-of select="Comment"/><br/><br/>
						</xsl:for-each>
						<a><xsl:attribute name="href">http://<xsl:value-of select="//eXpression/@adminRoot"/>/expression/admin/comment-post.asp?type=1&amp;item=<xsl:value-of select="EntryID"/></xsl:attribute>Post New Comment</a>
					</xsl:if>
				</xsl:for-each>
				<br/>
				<p class="PostFooter" align="right">
				<br/><a href="http://www.expressionblogs.net"><img src="../../expression/images/expression.gif" alt="Powered by eXpression" border="0"/></a>
				</p>
				<span class="PostFooter">
				<a target="_self"><xsl:attribute name="href">?getBlogTransformed?blogID=<xsl:value-of select="//request/@blogID"/>&amp;topicID=<xsl:value-of select="//request/@topicID"/>&amp;startDate=<xsl:value-of select="//request/@endDate"/>&amp;entries=<xsl:value-of select="//request/@entries"/>&amp;style=<xsl:value-of select="//request/@style"/>&amp;contentType=HTML</xsl:attribute>Previous <xsl:value-of select="//request/@entries"/> </a> |
				<a target="_blank"><xsl:attribute name="href">../../expression/expression.asmx/getBlogTransformed?blogID=<xsl:value-of select="//request/@blogID"/>&amp;topicID=<xsl:value-of select="//request/@topicID"/>&amp;startDate=&amp;entries=<xsl:value-of select="//request/@entries"/>&amp;style=styles/rssBlog.xsl&amp;contentType=XML&amp;privatekey=0</xsl:attribute><img src="../../expression/images/xml.gif" border="0" align="absmiddle"/></a><br/>
				</span>
			</xsl:when>
			<xsl:when test="//eXpression/webPage">
				<xsl:value-of select="eXpression/webPage/pageData"/>
				<p align="right" class="PostFooter">
				</p>
			</xsl:when>
		</xsl:choose>
		</div>
		
</body>
</html>
</xsl:template>
</xsl:stylesheet>