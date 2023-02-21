<!-- #include file="open_db.asp"-->
<%
'Estetään sivun luvaton käyttö
'if session("login")="" then - ei käy koska toteutuakseen lause vaatii session -tyyppisen login -nimisen muuttujan, jonka arvo on tyhjä
if not session("login")<>"" then
    response.Redirect("login.asp")
end if
if request("LisaaNappi")<>"" then
    Session("kustantaja_id")=Request("kustantaja_id")
    SqlStr="INSERT INTO kustantajat (kustantaja_id) VALUES ('"&request("kustantaja_id")&"')"
    objConn.Execute SqlStr
    Session("kustantaja_id")=""
    response.Redirect("lisaa.asp")
end if
%>

<html>
<head>
<title>Lisää Kustantaja</title>
<link rel="Stylesheet" type="text/css" href="screen.css" />
</head>
<body>
<form action="lisaa_kustantaja.asp" method="post">
<table border="0" width="100%">
<tr>
<td width="25%"></td>
<td width="25%" align="right">Kustantajan nimi:</td>
<td width="25%"><input type="text" name="kustantaja_id" size="35" value="<%=Session("kustantaja_id")%>" /></td>
<td width="25%"></td>
</tr>
<tr>
<td></td>
<td></td>
<td>
<input type="submit" value=" Lisää " name="LisaaNappi" />
<input type="button" value="Peruuta" onclick="history.back(-1)" />
</td>
<td class="error"><%=request("msg")%></td>
</tr>
</table>
</form>
</body>
</html>
<%objConn.Close%>