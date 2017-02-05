<%
'Update Users Score
' Needs userid and returnpage in querystring
'
if Request.QueryString ("userid") <> "" then

	Response.Write "Calculating score...<br><br>"

	set rCounts = server.createobject("ADODB.Recordset")
	sqlCmd = "SELECT * FROM tblWebLog WHERE UserID <> ''"
	rCounts.open sqlCmd, Application("ConnStr")
	pcount = 0
	do while rCounts.eof = false
		pcount = pcount + 1
		rCounts.movenext
	loop
	set rCounts = nothing
	
	set rCounts = server.createobject("ADODB.Recordset")
	sqlCmd = "SELECT * FROM tblWebLog WHERE UserID = " & Request.QueryString("UserID")
	rCounts.open sqlCmd, Application("ConnStr")
	acount = 0
	do while rCounts.eof = false
		acount = acount + 1
		rCounts.movenext
	loop
	set rCounts = nothing

	set rCounts = server.createobject("ADODB.Recordset")
	sqlCmd = "SELECT * FROM tblComments WHERE UserID = " & Request.QueryString("UserID")
	rCounts.open sqlCmd, Application("ConnStr")
	ccount = 0
	do while rCounts.eof = false
		ccount = ccount + 1
		rCounts.movenext
	loop
	set rCounts = nothing
	
	set rCounts = server.createobject("ADODB.Recordset")
	sqlCmd = "SELECT Bio, Relationship FROM tblUsers Where UserID =" & Request.QueryString("UserID")
	rCounts.open sqlCmd, Application("ConnStr")
	bcount = 0
	if rCounts.eof = false then
		if rCounts("Bio") <> "" or rCounts("Relationship") <> "" then
			bcount = 1
		end if
	end if
	set rCounts = nothing
	
	if acount > 0 AND pcount > 0 and ccount > 0 then
		score = round(((acount / pcount) * 200) + ((ccount / pcount) * 100)) +  bcount * 15
	else
		score = 0 + bcount * 15
	end if
	
	set wScore = Server.CreateObject("ADODB.Connection")
	wScore.Open Application("ConnStr")
	sqlCommand = "Update tblUsers Set Score='"& score &"' WHERE UserID = " & Request.QueryString("UserID")
	wScore.Execute sqlCommand
	wScore.close
	
	Response.Write "Your score is: " & score & "<br>"
	
	urlparts = split(Request.QueryString, "returnpage=")
	returnpage = urlparts(ubound(urlparts))
	if returnpage <> "" then
		if Request.QueryString("item") <> "" then
			returnpage = returnpage & "?item=" & Request.QueryString("item")
			if Request.QueryString("type") <> "" then
				returnpage = returnpage & "&type=" & Request.QueryString("type")
			end if
		end if
		if Request.QueryString("topicid") <> "" then
			returnpage = returnpage & "?topicid=" & Request.QueryString("topicid")
		end if
		Response.Redirect(returnpage)
	end if
end if
%>
 
 
