<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" 
xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
	<xsl:template match="/">
		<rss version="2.0">
			<channel>
				<title><xsl:value-of select="//eXpression/@site"/></title>
				<link><xsl:value-of select="//eXpression/@url"/></link>
				<description><xsl:value-of select="//eXpression/@sitedescription"/></description>
				<pubDate><xsl:value-of select="//eXpression/request/@startDate"/></pubDate>
				<generator>eXpression engine - www.expressionblogs.net</generator>
				<xsl:if test="//eXpression/@siteimage != ''">
					<image>
						<title><xsl:value-of select="//eXpression/@site"/></title> 
						<url><xsl:value-of select="//eXpression/@url"/>/<xsl:value-of select="//eXpression/@siteimage"/></url> 
						<link><xsl:value-of select="//eXpression/@url"/></link> 
						<height>60</height>
					</image>
				</xsl:if>
				<xsl:for-each select="//blogData">
					<item>
						<title><xsl:value-of select="EntryTitle"/></title>
						<link><xsl:value-of select="//eXpression/@url"/>?getBlogTransformed?blogID=<xsl:value-of select="//request/@blogID"/>&amp;topicID=<xsl:value-of select="TopicID"/>&amp;startDate=<xsl:value-of select="normalize-space(EntryDay)"/>%20<xsl:value-of select="normalize-space(Time)"/>&amp;entries=1&amp;style=&amp;contentType=HTML&amp;privateKey=<xsl:value-of select="//request/@privateKey"/></link>
						<description>
							<xsl:for-each select="dsImages/Image">
								<img align='left'><xsl:attribute name="src">../expression/show<xsl:value-of select="ImageType"/>.asp?imageid=<xsl:value-of select="ImageID"/></xsl:attribute></img>
							</xsl:for-each>
							<xsl:value-of select="EntryText"/>
						</description>				
						<author><xsl:value-of select="UserName"/></author>
						<category><xsl:value-of select="TopicName"/></category>
						<xsl:if test="AllowComments = '1'">
							<comments><xsl:value-of select="//eXpression/@url"/>?getBlogTransformed?blogID=<xsl:value-of select="//request/@blogID"/>&amp;topicID=<xsl:value-of select="TopicID"/>&amp;startDate=<xsl:value-of select="normalize-space(EntryDay)"/>%20<xsl:value-of select="normalize-space(Time)"/>&amp;entries=1&amp;style=&amp;contentType=HTML&amp;privateKey=<xsl:value-of select="//request/@privateKey"/></comments>
						</xsl:if>
						<guid isPermaLink="false"><xsl:value-of select="EntryID"/></guid>
						<pubDate><xsl:value-of select="EntryDate"/></pubDate>
					</item>
				</xsl:for-each>
			</channel>
		</rss>
	</xsl:template>
</xsl:stylesheet>