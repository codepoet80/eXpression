<html>
<%
if Request.Form("txtComment") <> "" then
	set wLog = Server.CreateObject("ADODB.Connection")
	wLog.Open Application("ConnStr")
	dim currUser
    'Look up existing users
        set wSet = Server.CreateObject("ADODB.Recordset")
	    sqlCommand = "SELECT UserID FROM tblUsers WHERE Email = '" & Request("txtPosterEMail") & "'"
	    wSet.open sqlCommand, Application("ConnStr")
        if wSet.eof = false then
            currUser = wSet(0)
            wSet.Close
        else
            wSet.Close
            ' if not exist create user
            sqlCommand = "INSERT INTO tblUsers (Username, Email) VALUES ('" & Request("txtPosterName") & "','" & Request("txtPosterEMail") & "')"
            wLog.Execute sqlCommand
            
            sqlCommand = "SELECT UserID FROM tblUsers WHERE Email = '" & Request("txtPosterEMail") & "'"
            wSet.open sqlCommand, Application("ConnStr")
            currUser = wSet(0)
        end if
    myComment=Replace(Replace(Request("txtComment"), "'", "''"), vbCrLf, "<br>")
	sqlCommand = "INSERT INTO tblComments (SiteID, EntryID, EntryType, UserID, Comment) VALUES (" & Request("SiteID") & "," & Request("EntryID") & "," & 1 & "," & currUser & ",'" & myComment & "')"
	wLog.Execute sqlCommand
	wLog.close
	
end if
%>
</html>
 
 
