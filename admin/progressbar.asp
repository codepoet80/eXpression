<%@EnableSessionState=False%>
<html>
<head>
<title>Progress...</title>
<meta http-equiv="expires" content="Tue, 01 Jan 1981 01:00:00 GMT">
<meta http-equiv=refresh content="2,progressbar.asp?ID=<%=Request.QueryString("ID")%>">

<%
On Error Resume Next
Set theProgress = Server.CreateObject("ABCUpload4.XProgress")
theProgress.ID = Request.QueryString("ID")
%>

<script language="javascript">
<!--
if (<% =theProgress.PercentDone %> == 100) top.close();
if (!window.opener) top.close();
//-->
</script>
</head>
<body bgcolor="#E5E5E5">

<table border="0" width="100%">
  <tr>
    <td><font face="Verdana, Arial, Helvetica, sans-serif" size="2"><b>Uploading:</b></font></td>
  </tr>
  <tr bgcolor="#808080">
    <td>
      <table border="0" width="<%=theProgress.PercentDone%>%" cellspacing="1" bgcolor="#2A2A7E">
        <tr>
          <td><font size="1">&nbsp;</font></td>
        </tr>
      </table>
    </td>
  </tr>
  <tr>
    <td>
      <table border="0" width="100%">
        <tr>
          <td><font face="Verdana, Arial, Helvetica, sans-serif" size="1">Estimated time left:</font></td>
          <td><font face="Verdana, Arial, Helvetica, sans-serif" size="1">
          	<%=Int(theProgress.SecondsLeft / 60)%> min  
		<%=theProgress.SecondsLeft Mod 60%> secs 
		(<%=Round(theProgress.BytesDone / 1024, 1)%> KB of 
		<%=Round(theProgress.BytesTotal / 1024, 1)%> KB uploaded)</font></td>
        </tr>
        <tr>
          <td><font face="Verdana, Arial, Helvetica, sans-serif" size="1">
		Transfer Rate:</font></td>
          <td><font face="Verdana, Arial, Helvetica, sans-serif" size="1">
		<%=Round(theProgress.BytesPerSecond/1024, 1)%> KB/sec</font></td>
        </tr>
        <tr>
          <td><font face="Verdana, Arial, Helvetica, sans-serif" size="1">Information:</font></td>
          <td><font face="Verdana, Arial, Helvetica, sans-serif" size="1"><%=theProgress.Note%></font></td>
        </tr>
      </table>
    </td>
  </tr>
  <tr></tr>
</table>

</body>
</html>

 
 
