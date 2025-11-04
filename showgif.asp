<%
'Step 1: Read in the entryid from the query string
Dim EntryID

if Request("type")="user" then
	UserID = Request.QueryString("EntryID")
	strSQL = "SELECT Image, iType FROM tblWebLogImages WHERE ImageID = " & Request("ImageID") & " AND Loc='Users'"
else
	EntryID = Request.QueryString("EntryID")
	strSQL = "SELECT Image, iType FROM tblWebLogImages WHERE iType = 'gif' AND ImageID = " & Request("ImageID")
end if

'Step 2: grab the picture from the database
Dim objConn, objRS, strSQL
Set objConn = Server.CreateObject("ADODB.Connection")
objConn.Open Application("ConnStr")
Set objRS = Server.CreateObject("ADODB.Recordset")
objRS.Open strSQL, objConn

Response.ContentType = "image/gif"
Response.BinaryWrite objRS("Image")

'Clean up...
objRS.Close
Set objRS = Nothing
 
objConn.Close
Set objConn = Nothing
%>
 
 
