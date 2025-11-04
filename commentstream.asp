<%

response.ContentType="text/xml"
response.Write("<?xml version='1.0' encoding='ISO-8859-1'?>")
%>
<rss version="2.0">
<channel>
	<title>Comment Feed</title>
<%

set rComments = Server.CreateObject("ADODB.Recordset")
sqlCommand = "SELECT     TOP 50 dbo.tblComments.Comment, dbo.tblUsers.UserName, dbo.tblWebLog.EntryTitle, dbo.tblWebLog.EntryTime, dbo.tblTopics.TopicName, dbo.tblTopics.Active " &_
"FROM         dbo.tblComments INNER JOIN " &_
"                      dbo.tblUsers ON dbo.tblComments.UserID = dbo.tblUsers.UserID INNER JOIN " &_
"                      dbo.tblWebLog ON dbo.tblComments.EntryID = dbo.tblWebLog.EntryID INNER JOIN " &_
"                      dbo.tblTopics ON dbo.tblWebLog.TopicID = dbo.tblTopics.TopicID " &_
"WHERE     (dbo.tblTopics.Active = 1) " &_
"ORDER BY dbo.tblWebLog.EntryTime DESC, dbo.tblComments.CommentID DESC"
rComments.open sqlCommand, Application("ConnStr")
%>

<%
do while rComments.eof = false
%>
	<item>
<%
	Response.Write "<title>" & Server.HTMLEncode(rComments("EntryTitle")) & "</title>" & vbCrLf
	Response.Write "<description>" & vbCrLf
	Response.Write Server.HTMLEncode(rComments("Comment")) & vbCrLf
	Response.Write "</description>" & vbCrLf
	Response.Write "<author>" & rComments("UserName") & "</author>" & vbCrLf
	Response.Write "<category>" & Server.HTMLEncode(rComments("TopicName")) & "</category>" & vbCrLf
	Response.Write "<pubDate>" & rComments("EntryTime") & "</pubDate>" & vbCrLf

	rComments.movenext
%>
	</item>
<%
loop
%>

</channel>
</rss>
 
 
