<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" 
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
<xsl:template match="/">
<html>
<head>
<script>
var picturePath = '\\expression\\site_<xsl:value-of select="//request/@blogID"/>\\published\\pictures';
var documentPath = '\\expression\\site_<xsl:value-of select="//request/@blogID"/>\\published\\downloads';
var showMenu;
function showSubMenu(id)
{
	try
	{
		if (document.getElementById("subMenu" + id).style.display != "block")
			document.getElementById("subMenu" + id).style.display = "block";
		else
			document.getElementById("subMenu" + id).style.display = "none";
	}
	catch(e)
	{
		//do nothing
	}
}
function initMenu()
{
	if (showMenu != null)
		showSubMenu(showMenu);
}
</script>
<title><xsl:value-of select="//eXpression/@site"/></title>
<LINK REL="stylesheet" TYPE="text/css">
	<xsl:attribute name="HREF">../../expression/schemes/<xsl:value-of select="//eXpression/@colorScheme"/></xsl:attribute>
</LINK>
<LINK REL="alternate" TYPE="application/rss+xml">
	<xsl:attribute name="TITLE"><xsl:value-of select="//eXpression/@site"/> RSS Feed</xsl:attribute>
	<xsl:attribute name="HREF">../../expression/expression.asmx/getBlogTransformed?blogID=<xsl:value-of select="//request/@blogID"/>&amp;topicID=<xsl:value-of select="//request/@topicID"/>&amp;startDate=&amp;entries=<xsl:value-of select="//request/@entries"/>&amp;style=styles/rssBlog.xsl&amp;contentType=XML&amp;privateKey=0</xsl:attribute>
</LINK>
<base target="_blank"/>
<xsl:if test="//request/@privateKey = '3'">
	<meta name="robots" content="noindex,nofollow"></meta>
</xsl:if>
</head>
<body onload="initMenu()">
	<table align="center" border="0" height="100%" style="width:755px;" id="mainTable">
	<tr>
	<td valign="top" class="content">
		<div>
		<xsl:if test="//eXpression/@siteimage != ''">
			<xsl:if test="//request/@page != 'expression.htm' and //request/@page != 'expression-servers.htm'">
				<div align="center"><img border="0" style="cursor:pointer;" onclick="document.location='https://github.com/codepoet80'">
					<xsl:attribute name="alt">
						<xsl:value-of select="//eXpression/@site"/> - <xsl:value-of select="//eXpression/@sitedescription"/>
					</xsl:attribute>
					<xsl:attribute name="src">
						../<xsl:value-of select="//eXpression/@siteimage"/>
					</xsl:attribute>
				</img></div>
			</xsl:if>
		</xsl:if>
		<xsl:if test="//eXpression/@siteimage = ''">
			<H1 align="center">
				<xsl:value-of select="//eXpression/@site"/>
			
			<div class="SiteDesc">
				<xsl:value-of select="//eXpression/@sitedescription"/>
			</div></H1>
		</xsl:if>
		</div>
		<xsl:choose>
			<xsl:when test="//eXpression/dsBlog">
				<xsl:if test="//request/@topicID != ''">
					<H2><xsl:value-of select="//blogData/TopicName"/></H2>
				</xsl:if>
				<xsl:if test="//request/@topicID = ''">
					<H2>Home</H2>
				</xsl:if>
				<xsl:for-each select="//blogData">
					<table style="clear:left" border='0' cellpadding='0' cellspacing='0'><tr><td>
						<H3><xsl:value-of select="EntryTitle"/></H3>
						<span class="H3Date"><xsl:value-of select="EntryDay"/></span>
					</td></tr></table>
					&amp;nbsp;<br/>
					<xsl:for-each select="dsImages/Image">
						<img align='left' style="border: 1px solid #bbbb99; margin: 2px"><xsl:attribute name="src">../../expression/show<xsl:value-of select="ImageType"/>.asp?imageid=<xsl:value-of select="ImageID"/></xsl:attribute></img>
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
							<table style="clear:left" border='0' cellpadding='0' cellspacing='0'><tr><td><H3>Comments</H3></td></tr></table>
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
							<a><xsl:attribute name="href">http://<xsl:value-of select="//eXpression/@adminRoot"/>/expression/admin/comment-post.asp?type=1&amp;siteid=<xsl:value-of select="//request/@blogID"/>&amp;item=<xsl:value-of select="EntryID"/></xsl:attribute>Post New Comment</a>
							<br/>&amp;nbsp;
							</div>
							<br/>
						</xsl:if>
					</xsl:if>
					
				</xsl:for-each>
				<table width="100%" cellpadding="0" cellspacing="0" border="0"><tr><td valign="top">
				<br/>
				<a target="_blank"><xsl:attribute name="href">../expression/expression.asmx/getBlogTransformed?blogID=<xsl:value-of select="//request/@blogID"/>&amp;topicID=<xsl:value-of select="//request/@topicID"/>&amp;startDate=&amp;entries=<xsl:value-of select="//request/@entries"/>&amp;style=styles/rssBlog.xsl&amp;contentType=XML&amp;privatekey=0</xsl:attribute><img src="../../expression/images/rss.gif" align="absmiddle" border="0"/></a><br/>
				</td><td>
				<h5>
					<a href="https://github.com/codepoet80">codepoet80</a>, 2002-2005<br/><A href="http://creativecommons.org/licenses/by-nc/1.0/">Some Rights Reserved</A>
				</h5>
				</td>
				</tr></table>
			</xsl:when>
			<xsl:when test="//eXpression/webPage">
				<xsl:value-of select="eXpression/webPage/pageData"/>
			</xsl:when>
		</xsl:choose>
	</td>
	<td valign="top" style="width:160px;" class="menu">
		<b>Content</b>
		<div class="menuBlock">
		
		<xsl:if test="//request/@topicID = '' and //request/@page = ''">
				<br/><i>Home</i><br/>
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
				<i><xsl:value-of select="@Name"/></i>
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
							&amp;nbsp;&amp;nbsp;&amp;nbsp;<i><xsl:value-of select="@Name"/></i>
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
				<br/><a target="_self"><xsl:attribute name="href">?getBlogTransformed?blogID=<xsl:value-of select="//request/@blogID"/>&amp;topicID=<xsl:value-of select="TopicID"/>&amp;startDate=&amp;entries=<xsl:value-of select="MaxPerPage"/>&amp;style=<xsl:value-of select="//request/@style"/>&amp;contentType=HTML&amp;privateKey=<xsl:value-of select="CategoryID"/></xsl:attribute><xsl:value-of select="TopicName"/></a>
			</xsl:if>
			<xsl:if test="TopicID = //request/@topicID">
				<br/><i><xsl:value-of select="TopicName"/></i>
			</xsl:if>
		</xsl:for-each>
		<br/>&amp;nbsp;
		</div>
		<br/>
		
		<xsl:if test="//request/@topicID = ''">
		
		<xsl:for-each select="//Feeds/Feed">
			<b><a>
				<xsl:attribute name="href">
					<xsl:value-of select="link"/>
				</xsl:attribute>
			<xsl:value-of select="@Name"/></a></b>
			<div style="font-size: 10px; padding-left: 2px; padding-top:4px;"><i><xsl:value-of select="description"/></i></div><br/>
			<div class="menuBlock">
				<table cellpadding="0" cellspacing="0" border="0">
				<xsl:for-each select="item">
					<xsl:if test="../generator='PhotoShare'">
							<a>
							<xsl:attribute name="href">
								<xsl:value-of select="link"/>
							</xsl:attribute>
								<img align='center' border="0" class="psStreamImg">
								<xsl:attribute name="alt">
									<xsl:value-of select="title"/>
								</xsl:attribute>
								<xsl:attribute name="src">../../expression/expression.asmx/getImageData?pathType=FS&amp;amp;imageID=<xsl:value-of select="guid"/>&amp;amp;width=0&amp;amp;height=100</xsl:attribute>
							</img>
							</a>
					</xsl:if>
					<xsl:if test="../generator!='PhotoShare' or not(../generator)">
						<tr>
						<td valign="top"> - </td><td valign="top" style="padding-left: 3px; font-size:10px;"> <a>
						<xsl:attribute name="href">
							<xsl:value-of select="link"/>
						</xsl:attribute>
						<xsl:attribute name="title">
							<xsl:value-of select="description"/>
						</xsl:attribute>
						<xsl:value-of select="title"/>
						</a></td></tr>
					</xsl:if>
				</xsl:for-each>
				</table>
				<br/>
			</div>
			<br/>
		</xsl:for-each>
	
		</xsl:if>
		
		<xsl:if test="//eXpression/dsBlog">
			<b>Site</b>
			<div class="menuBlock">
				<br/>
				<a target="_blank"><xsl:attribute name="href">http://<xsl:value-of select="//eXpression/@adminRoot"/>/expression/admin/weblog-post.asp?siteID=<xsl:value-of select="//request/@blogID"/>&amp;TopicID=<xsl:value-of select="//request/@topicID"/></xsl:attribute>Post Entry</a><br/>
				<a><xsl:attribute name="href">http://<xsl:value-of select="//eXpression/@adminRoot"/>/AppCentral/appcentral.htm?profile=webApps/eXpressionAdmin&amp;siteID=<xsl:value-of select="//request/@blogID"/></xsl:attribute>Manage Site (<xsl:value-of select="//eXpression/@unapprovedposts"/>)</a><br/>
				<a target="_blank"><xsl:attribute name="href">../expression/expression.asmx/getBlogTransformed?blogID=<xsl:value-of select="//request/@blogID"/>&amp;topicID=<xsl:value-of select="//request/@topicID"/>&amp;startDate=&amp;entries=<xsl:value-of select="//request/@entries"/>&amp;style=styles/rssBlog.xsl&amp;contentType=XML&amp;privatekey=0</xsl:attribute>RSS Feed</a><br/>
				<a target="_self"><xsl:attribute name="href">?getBlogTransformed?blogID=<xsl:value-of select="//request/@blogID"/>&amp;topicID=<xsl:value-of select="//request/@topicID"/>&amp;startDate=<xsl:value-of select="//request/@endDate"/>&amp;entries=<xsl:value-of select="//request/@entries"/>&amp;style=<xsl:value-of select="//request/@style"/>&amp;contentType=HTML&amp;privateKey=<xsl:value-of select="//request/@privateKey"/></xsl:attribute>&amp;lt;&amp;lt; Previous <xsl:value-of select="//request/@entries"/></a><br/>
				<br/>
			</div>
		</xsl:if>

		<br/>
		<a href="http://www.spreadfirefox.com/?q=affiliates&amp;amp;id=28200&amp;amp;t=82"><img border="0" alt="Get Firefox!" title="Get Firefox!" src="http://www.spreadfirefox.com/community/images/affiliates/Buttons/80x15/white_1.gif"/></a>
		<br/>&amp;nbsp;<br/>
		<a target="_blank" href="https://github.com/codepoet80.net">
			<img alt="Powered by eXpression" border="0">
				<xsl:attribute name="src">
					/expression/images/expression.gif?siteid=<xsl:value-of select="//request/@blogID"/>
				</xsl:attribute>
			</img>
		</a>
		
	</td>
	</tr>
	</table>
</body>
</html>
</xsl:template>
</xsl:stylesheet>

