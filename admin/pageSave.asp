<% Response.CacheControl = "no-cache" %>
<html>
<%
currFile = Request("FileName")
currFile = replace(currFile, "%20", " ")
currFile = replace(currFile, "%23", "#")
currFile = replace(currFile, "%2B", "+")
currFile = replace(currFile, "%27", "'")
currFile = replace(currFile, "%26", "&")
	
Response.Write currFile & "<br>"
fileParts = Split(currFile, "/")
i = 0
currFile = "../"
do while i < ubound(fileParts) + 1
	if i>3 then	'number of dirs deep
		currFile = currFile & fileParts(i)
		if i < ubound(fileParts) then
			currFile = currFile & "/"
		end if
	end if
	i=i+1
loop
Response.Write (currFile) & "<br>"
Response.Write Server.MapPath(currFile) & "<br>"
Response.Write Request("EditorValue")

Const ForReading = 1, ForWriting = 2
Dim fso, f
Set fso = CreateObject("Scripting.FileSystemObject")
Response.Write (Server.MapPath(currFile))
Set f = fso.OpenTextFile(Server.MapPath(currFile), ForWriting, True)
f.Write Request("EditorValue")
f.Close

redir = "pageEdit.asp?file=" & currFile
if Request("Folder") <> "" then
	redir = redir & "&folder=" & Request("Folder")
end if
redir = redir & "&siteid=" + Request("siteid")
Response.Redirect(redir)
%>
</html>
 
 
