<!-- #include file="open_db.asp"-->
<%
'Estet‰‰n sivun luvaton k‰yttˆ
'if session("login")="" then - ei k‰y koska toteutuakseen lause vaatii session -tyyppisen login -nimisen muuttujan, jonka arvo on tyhj‰
if not session("login")<>"" then
    response.Redirect("login.asp")
end if
if request("LisaaNappi")<>"" then
    Session("artisti_id")=Request("artisti_id")
    SqlStr="INSERT INTO artistit (artisti_id) VALUES ('"&request("artisti_id")&"')"
    objConn.Execute SqlStr
    Session("artisti_id")=""
    response.Redirect("lisaa.asp")
end if
%>

<html>
<head>
<title>Lis‰‰ Artisti</title>
<link rel="Stylesheet" type="text/css" href="screen.css" />
</head>
<body>
<%Response.Write(Now())%>
<form action="lisaa_artisti.asp" method="post">
<table border="0" width="100%">
<tr>
<td width="25%"></td>
<td width="25%" align="right">Artistin nimi:</td>
<td width="25%"><input type="text" name="artisti_id" size="35" value="<%=Session("artisti_id")%>" /></td>
<td width="25%"></td>
</tr>
<tr>
<td></td>
<td></td>
<td>
<input type="submit" value=" Lis‰‰ " name="LisaaNappi" />
<input type="button" value="Peruuta" onclick="history.back(-1)" />
</td>
<td class="error"><%=request("msg")%></td>
</tr>
</table>
</form>

<br />

</body>
</html>
<%objConn.Close%>