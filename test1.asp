<HTML>
   <HEAD>
   <TITLE>All Authors</TITLE>
   </HEAD>
   <BODY BGCOLOR="#FFFFFF">

   <% Set OBJdbConnection = Server.CreateObject("ADODB.Connection")
   OBJdbConnection.ConnectionTimeout = Session("ConnectionTimeout")
   OBJdbConnection.CommandTimeout = Session("CommandTimeout")
   OBJdbConnection.Open Session("ConnectionString")
   Set SQLStmt = Server.CreateObject("ADODB.Command")
   Set RS = Server.CreateObject ("ADODB.Recordset")
   %>

   <p>
   <table border="0" bordercolor="#000000">
   <%
   SQLStmt.CommandText = "select * from levyt"
   SQLStmt.CommandType = 1
   Set SQLStmt.ActiveConnection = OBJdbConnection
   RS.Open SQLStmt

   Do While Not RS.EOF
   %>
   <TR>
      <TD Width = 150 ALIGN=LEFT>
         <FONT SIZE=+1>
         <%= RS("artisti_id") %>
         </FONT></TD>
      <TD></TD>
         <TD Width = 150 ALIGN=LEFT>
         <FONT SIZE=+1>
         <%= RS("au_lname")  %>
         </FONT></TD>
      <TD Width = 150 ALIGN=LEFT>
         <FONT SIZE=+1>
         <%= RS("au_fname")  %>
         </FONT></TD>
      <TD Width = 150 ALIGN=LEFT>
         <FONT SIZE=+1>
         <%= RS("phone")  %>
         </FONT></TD>
   </TR>
   <%
   RS.MoveNext
   Loop
   %>
   </table>
   <hr>
   <p>
   </BODY>
   <% OBJdbConnection.Close
   Set OBJdbConnection = Nothing
   %>
   </HTML>				