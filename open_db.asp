<%
'Connection object
set objConn = Server.CreateObject("ADODB.Connection")
objConn.Open "Driver={Microsoft Access Driver (*.mdb)};DBQ=" & Server.MapPath("levyt.mdb") 

'Recordset objects
set objRs=Server.CreateObject("ADODB.recordset") 
set objRs1=Server.CreateObject("ADODB.recordset") 
set objRs2=Server.CreateObject("ADODB.recordset") 
%>